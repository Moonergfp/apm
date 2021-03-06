package apm.modules.program.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import apm.common.core.Page;
import apm.common.service.BaseService;
import apm.common.utils.StringUtils;

import apm.modules.program.entity.PublishProgram;
import apm.modules.program.entity.PublishProgramTimeSettings;
import apm.modules.program.dao.PublishProgramDao;
import apm.modules.sys.support.Users;
import apm.modules.terminal.entity.Terminal;
import apm.modules.terminal.service.TerminalService;

import org.apache.lucene.index.Term;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.TermQuery;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 节目发布实体类Service
 * @author gfp
 * @version 2015-09-06
 */
@Service
@Transactional(readOnly = true)
public class PublishProgramService extends BaseService<PublishProgramDao, PublishProgram> {

	//注入其他的Dao层或本层
	@Autowired
	private PublishProgramDao publishProgramDao;
	@Autowired
	private TerminalService terminalService;
	@Autowired
	private PublishProgramTimeSettingsService publishProgramTimeSettingsService;
	
	//查找所有节目发布实体类(未删除)的记录
	public List<PublishProgram> findAll() {
		return dao.findAll();
	}
	
	//节目发布实体类列表多条件查询，分页
	public Page<PublishProgram> find(Page<PublishProgram> page, PublishProgram publishProgram) {
		System.out.println(publishProgram);
		DetachedCriteria dc = dao.createDetachedCriteria();
		boolean flag = false; //需要在用到的地方进行声明,否则会查不到数据
		boolean pFlag = false;
		if(publishProgram != null){
			List<String> tIds = null; //终端ids
			List<String> pIds = new ArrayList<String>();
			//获取存在该终端
			if(StringUtils.isNotBlank(publishProgram.gettName())){
				tIds = terminalService.findIdByName("%" + publishProgram.gettName() + "%");
			}
			//获取发布列表id
			if(tIds != null && tIds.size() > 0){
				for(String str : tIds){
					if(StringUtils.isNotBlank(str)){
						pIds.addAll(dao.findByTerminalId("%" + str + "%"));
					}
				}
			}
			System.out.println(pIds.toString());
			if(pIds != null && pIds.size() > 0){
				dc.add(Restrictions.in("id", pIds));
			}
			
			if (publishProgram.getProgram() != null){
				pFlag = true;
				dc.createAlias("program", "program");
				if(StringUtils.isNotBlank(publishProgram.getProgram().getName())){
					dc.add(Restrictions.like("program.name", "%"+publishProgram.getProgram().getName()+"%"));
				}
				if(StringUtils.isNotBlank(publishProgram.getProgram().getId())){
					dc.add(Restrictions.eq("program.id", publishProgram.getProgram().getId()));
				}
			}
			
			if(publishProgram.getMessageId() != null){
				flag = true;
				dc.createAlias("messageId", "messageId");  
				if(StringUtils.isNotBlank(publishProgram.getMessageId().getName())){
					dc.add(Restrictions.like("messageId.name", "%"+publishProgram.getMessageId().getName()+"%"));
				}
				if(StringUtils.isNotBlank(publishProgram.getMessageId().getId())){
					dc.add(Restrictions.eq("messageId.id", publishProgram.getMessageId().getId()));
				}
			}
			//判断类型,message 或   program
			 if("message".equals(publishProgram.getType())){
				 if(!flag){
					 dc.createAlias("messageId", "messageId"); 
				 } 
				 dc.add(Restrictions.isNotNull("messageId.id"));
			}else{
				if(!pFlag){
					dc.createAlias("program", "program");
				}
				dc.add(Restrictions.isNotNull("program.id"));
			} 
			 
		}
		System.out.println(dc);
		dc.add(Restrictions.eq(PublishProgram.DEL_FLAG, PublishProgram.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("createDate"));
		page = publishProgramDao.find(page, dc);
		if(page != null && page.getList() != null && page.getList().size() > 0){
			for(PublishProgram pp : page.getList()){
				//1.设置终端
				String terminalIds = pp.getTerminalIds();
				List<String> tIds = Arrays.asList(terminalIds.split(","));
				pp.setTerminals(terminalService.findByIds(tIds));
			}
		}
		return page;
	}
	
	public List<String> findByTerminalId(String id){
		return dao.findByTerminalId(id);
	}
	
	//保存节目发布实体类信息
	@Transactional(readOnly = false)
	public void save(PublishProgram publishProgram) {
		dao.clear();
		dao.save(publishProgram);
	}
	
	//删除节目发布实体类信息：逻辑删除 、通过ID号删除
	@Transactional(readOnly = false)
	public void delete(String id) {
		dao.deleteById(id);
	}
	
	/**
	 * 更新索引
	 */
	public void createIndex(){
		dao.createIndex();
	}
	
	/**
	 * 全文检索  
	 */
	public Page<PublishProgram> search(Page<PublishProgram> page, String q){
		
		// 设置查询条件
		BooleanQuery query = dao.getFullTextQuery(q, "name");
		//System.out.println(query);
		// 设置过滤条件
		BooleanQuery queryFilter = dao.getFullTextQuery(new BooleanClause(
				new TermQuery(new Term(PublishProgram.DEL_FLAG, String.valueOf(PublishProgram.DEL_FLAG_NORMAL))), Occur.MUST));
		//System.out.println(queryFilter);
		// 设置排序
		Sort sort = new Sort();
		// 全文检索
		dao.search(page, query, queryFilter, sort);
		// 关键字高亮
		dao.keywordsHighlight(query, page.getList(), "name");
		
		return page;
	}

	/**
	 * 查询审核节目
	 * @param publishProgram 
	 * @param page 
	 * @param publishProgram 
	 * @return
	 */
	public Page<PublishProgram> findPubPros(Page<PublishProgram> page, PublishProgram publishProgram) {
		String cId = Users.currentUser().getCompany().getId();
		DetachedCriteria dc = dao.createDetachedCriteria();
		dc.createAlias("office", "office");
		dc.createAlias("program", "program");
		dc.add(Restrictions.eq(PublishProgram.DEL_FLAG, PublishProgram.DEL_FLAG_NORMAL))
			.add(Restrictions.eq("office.id",cId));
		if(publishProgram != null){
			if(publishProgram.getOffice()!= null && StringUtils.isNotEmpty(publishProgram.getOffice().getName())){
				dc.add(Restrictions.like("office.name","%"+publishProgram.getOffice().getName()+"%"));
			}
			if(publishProgram.getProgram()!= null && StringUtils.isNotEmpty(publishProgram.getProgram().getName())){
				dc.add(Restrictions.like("program.name","%"+publishProgram.getProgram().getName()+"%"));
			}
			if(StringUtils.isNotEmpty(publishProgram.getCheckStatus())){
				String status = publishProgram.getCheckStatus();
				if(!("-1".equals(status))){
					dc.add(Restrictions.eq("checkStatus",status));
				}
			}
		}
		dc.addOrder(Order.desc("createDate"));
		page = publishProgramDao.find(page, dc);
		List<PublishProgram> pubPros = page.getList();
		for(int i =  0 ; i < pubPros.size() ; i++){
			PublishProgram pubPro = pubPros.get(i);
			//1.设置终端
			String terminalIds = pubPro.getTerminalIds();
			List<String> tIds = Arrays.asList(terminalIds.split(","));
			pubPro.setTerminals(terminalService.findByIds(tIds));
			//2.设置日期时间段
			String settingIds = pubPro.getPlayTimes();
			List<String> pubTimeIds = Arrays.asList(settingIds.split(","));
			List<PublishProgramTimeSettings> pubTimes = publishProgramTimeSettingsService.findByIds(pubTimeIds);
			if(pubTimes!= null && pubTimes.size() > 0){
				for(int j = 0 ;  j < pubTimes.size() ; j++){
					String timeSegment =  pubTimes.get(j).getTimeSegment();//时间段
					List<String> ts = Arrays.asList(timeSegment.split(","));
					List<String> ls = new ArrayList<>();
					for(int k = 0 ; k < ts.size() ; k+=2){
						ls.add(ts.get(k) + "~"+ts.get(k+1));
					}
					 pubTimes.get(j).setTimes(ls);
				}
			}
			pubPro.setTimeSettings(pubTimes);
		}
//		return pubPros;
		return page;
	}

	/**
	 * 审核节目发布
	 * @param programId
	 */
	@Transactional(readOnly = true)
	public void checkPubPro(PublishProgram pubPro) {
		//1.修改数据库表记录
		dao.saveAndFlush(pubPro);
		//2.向终端发送节目
	}
}
