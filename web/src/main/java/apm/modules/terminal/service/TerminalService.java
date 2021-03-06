package apm.modules.terminal.service;

import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import org.apache.lucene.index.Term;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.TermQuery;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import apm.common.core.Page;
import apm.common.service.BaseService;
import apm.common.utils.ApmUtils;
import apm.common.utils.StringUtils;
import apm.modules.fileManage.entity.FileInfosa;
import apm.modules.fileManage.service.FileInfosaService;
import apm.modules.sys.support.Users;
import apm.modules.terminal.dao.TerminalDao;
import apm.modules.terminal.entity.Terminal;
import apm.modules.terminal.entity.TerminalGroup;

/**
 * 终端实体类Service
 * @author gfp
 * @version 2015-08-17
 */
@Service
@Transactional(readOnly = true)
public class TerminalService extends BaseService<TerminalDao, Terminal> {

	//注入其他的Dao层或本层
	@Autowired
	private TerminalDao terminalDao;
	//注入其他的Service层或本层
	@Autowired
	private TerminalGroupService terminalGroupService;
	@Autowired
	private FileInfosaService fileInfosaService;
	
	//查找所有终端实体类(未删除)的记录
	public List<Terminal> findAll() {
		return dao.findAll();
	}
	
	//通过机构id查找所有终端
	public List<Terminal> findAll(String tenandId){
		return dao.findAll(tenandId);
	}
	
	//终端实体类列表多条件查询，分页
	public Page<Terminal> find(Page<Terminal> page, Terminal terminal) {
		DetachedCriteria dc = dao.createDetachedCriteria();
		
		if (StringUtils.isNotEmpty(terminal.getRemarks())){
			dc.add(Restrictions.like("remarks", "%"+terminal.getRemarks()+"%"));
		}
		dc.add(Restrictions.eq("office", Users.currentUser().getCompany()));
		dc.add(Restrictions.eq("terminalGroup", terminal.getTerminalGroup()));
		dc.add(Restrictions.eq(Terminal.DEL_FLAG, Terminal.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("id"));
		return terminalDao.find(page, dc);
	}
	
	//保存终端实体类信息
	@Transactional(readOnly = false)
	public void save(Terminal terminal) {
		dao.clear();
		dao.save(terminal);
	}
	
	//删除终端实体类信息：逻辑删除 、通过ID号删除
	@Transactional(readOnly = false)
	public void delete(String id) {
		dao.deleteById(id);
	}
	
	@Transactional(readOnly = false)
	public List<String> findIdByName(String name){
		return dao.findIdByName(name);
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
	public Page<Terminal> search(Page<Terminal> page, String q){
		
		// 设置查询条件
		BooleanQuery query = dao.getFullTextQuery(q, "name");
		// 设置过滤条件
		BooleanQuery queryFilter = dao.getFullTextQuery(new BooleanClause(
				new TermQuery(new Term(Terminal.DEL_FLAG, String.valueOf(Terminal.DEL_FLAG_NORMAL))), Occur.MUST));
		// 设置排序
		Sort sort = new Sort();
		// 全文检索
		dao.search(page, query, queryFilter, sort);
		// 关键字高亮
		dao.keywordsHighlight(query, page.getList(), "name");
		
		return page;
	}
	
	/** 
	 * getUnDividedGroupList:得到未分组的终端信息. <br/> 
	 * 
	 * @author whc 
	 * @return 
	 * @since JDK 1.8 
	 */  
	public TerminalGroup getUnDividedGroup(
			List<TerminalGroup> terminalGroupList) {
		
		Iterator<TerminalGroup> it = terminalGroupList.iterator();
		while(it.hasNext()){
			TerminalGroup terminalGroup= it.next();
			
			if(terminalGroup.getName().equals("未分组")){
				return terminalGroup;
			}
		}
		
		return null;
	}

	/** 
	 * getTotalNum:得到总共有多少个终端  <br/> 
	 * 
	 * @author whc 
	 * @param terminalGroupList
	 * @return 1.0
	 * @since JDK 1.8 
	 */  
	public int getTotalNum(List<TerminalGroup> terminalGroupList) {

		int num = 0;
		Iterator<TerminalGroup> it = terminalGroupList.iterator();
		while(it.hasNext()){
			num = num + it.next().getTerminalNum();
		}
		return num;
	}

	/** 
	 * getTerminalGroupList:得到终端分组信息（每个组有多少个终端）. <br/> 
	 * 
	 * @author whc 
	 * @return 
	 * @since JDK 1.8 
	 */  
	public List<TerminalGroup> getTerminalGroupList() {
		List<TerminalGroup> terminalGroupList = terminalGroupService.findAll(Users.currentUser().getCompany().getId());
		
		Iterator<TerminalGroup> it = terminalGroupList.iterator();
		String companyId = Users.currentUser().getCompany().getId();
		
		while(it.hasNext()){
			TerminalGroup terminalGroup = it.next();
			
			terminalGroup.setTerminalNum((int)terminalGroupService.count(
					companyId, terminalGroup.getId()));
		}
		
		return terminalGroupList;
	}

	


	/** 
	 * transferTerminal:终端拖拽功能，用于转存终端. <br/> 
	 * 
	 * @author whc 
	 * @param ids
	 * @return -1 表示出错 1 表示OK
	 * @param groupId 
	 * @since JDK 1.8 
	 */  
	@Transactional
	public int transferTerminal(String[] ids, String groupId) {
		
		//1. 查找出该分组
		TerminalGroup terminalGroup = terminalGroupService.findById(groupId);
		if(terminalGroup == null) return -1;
		
		//2.查找出这些分组
		List<Terminal> terminalList = new LinkedList<Terminal>();		
		for(int i = 0; i < ids.length; ++i){
			Terminal terminal = terminalDao.findOne(ids[i]);
			if(terminal == null) return -1;
			terminalList.add(terminal);
		}
		//3. 为终端设置新的分组
		for(int i = 0; i < ids.length; ++i){
			terminalList.get(i).setTerminalGroup(terminalGroup);
		}
		
		return 1;
	}

	public List<Terminal> findByIds(List<String> tIds) {
		if(tIds == null || tIds.size() == 0){
			return null;
		}
		return dao.findByIds(tIds);
	}
}
