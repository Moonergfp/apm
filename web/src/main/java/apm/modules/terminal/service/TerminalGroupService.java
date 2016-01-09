package apm.modules.terminal.service;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import apm.common.core.Page;
import apm.common.service.BaseService;
import apm.common.utils.StringUtils;

import apm.modules.terminal.entity.TerminalGroup;
import apm.modules.sys.support.Users;
import apm.modules.terminal.dao.TerminalDao;
import apm.modules.terminal.dao.TerminalGroupDao;

import org.apache.lucene.index.Term;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.TermQuery;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 终端分组实体类Service
 * @author gfp
 * @version 2015-08-17
 */
@Service
@Transactional(readOnly = true)
public class TerminalGroupService extends BaseService<TerminalGroupDao, TerminalGroup> {

	//注入其他的Dao层或本层
	@Autowired
	private TerminalGroupDao terminalGroupDao;
	
	//注入其他的Dao层或本层
	@Autowired
	private TerminalDao terminalDao;
	
	
	//查找所有节目实体类(未删除)的记录
	public List<TerminalGroup> findAll(String tenand_id) {
		return terminalGroupDao.findAll(tenand_id);
	}
	
	/**
	 * 
	 * find:终端分组列表多条件查询，分页. <br/> 
	 *
	 * @author whc 
	 * @param page
	 * @param terminalGroup
	 * @return 
	 * @since JDK 1.8
	 */
	public Page<TerminalGroup> find(Page<TerminalGroup> page, TerminalGroup terminalGroup) {
		DetachedCriteria dc = dao.createDetachedCriteria();
		
		//该分组属于该公司下的
		String companyId = Users.currentUser().getCompany().getId();
		dc.add(Restrictions.eq("tenand_id", companyId));
		
		if (StringUtils.isNotEmpty(terminalGroup.getRemarks())){
			dc.add(Restrictions.like("remarks", "%"+terminalGroup.getRemarks()+"%"));
		}
		dc.add(Restrictions.eq(TerminalGroup.DEL_FLAG, TerminalGroup.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("id"));
		return terminalGroupDao.find(page, dc);
	}
	
	//保存终端分组实体类信息
	@Transactional(readOnly = false)
	public void save(TerminalGroup terminalGroup) {
		dao.clear();
		dao.save(terminalGroup);
	}
	//保存终端分组实体类信息
	@Transactional(readOnly = false)
	public TerminalGroup saveAndReturnSavedEntity(TerminalGroup terminalGroup) {
		dao.clear();
		return dao.save(terminalGroup);
	}
		
	
	//删除终端分组实体类信息：逻辑删除 、通过ID号删除
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
	public Page<TerminalGroup> search(Page<TerminalGroup> page, String q){
		
		// 设置查询条件
		BooleanQuery query = dao.getFullTextQuery(q, "name");
		//System.out.println(query);
		// 设置过滤条件
		BooleanQuery queryFilter = dao.getFullTextQuery(new BooleanClause(
				new TermQuery(new Term(TerminalGroup.DEL_FLAG, String.valueOf(TerminalGroup.DEL_FLAG_NORMAL))), Occur.MUST));
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
	 * 
	 * TODO 返回该终端分组下有多少个终端. 
	 * @see apm.common.service.BaseService#count()
	 */
	public long count(String tenand_id,String groud_id){
		return terminalDao.count(tenand_id,groud_id);
	}

	/** 
	 * newGroupNameIsExist:查找该分组名字是否已经存在. <br/> 
	 * 
	 * @author whc 
	 * @param newGroupName
	 * @return 如果相同，那么返回相同的实体的id。
	 * 			因为如果是修改状态，可能是自己修改自己，需要返回给前台特定的信息。
	 * 			此时就需要根据 是否有这个 id 判断是新建还是自己修改自己。
	 * @since JDK 1.8 
	 */  
	public String newGroupNameIsExist(String newGroupName) {
		List<TerminalGroup> terminalGroups =  terminalGroupDao.findAll(Users.currentUser().getCompany().getId());
		
		Iterator<TerminalGroup> it = terminalGroups.iterator();
		TerminalGroup terminalGroup = null;
		
		while(it.hasNext()){
			terminalGroup = it.next();
			//名字相关并不能代表后续不可以新建。
			//如果是新建状态，那么只判断名字是否相同
			//如果是修改状态，那么名字相同，id 也相同的话，也就是自己修改自己
			if(terminalGroup.getName().equals(newGroupName) )
					return terminalGroup.getId();
		}
		
		return "";
	}

	/** 
	 * findByNameAndTenand_id:根据名字和公司查找特定的分组. <br/> 
	 * 
	 * @author whc 
	 * @param string
	 * @param id
	 * @return 
	 * @since JDK 1.8 
	 */  
	public TerminalGroup findByNameAndTenand_id(String name, String tenand_id) {
		return terminalGroupDao.findByNameAndTenand_id(name, tenand_id); 
	}

	/** 
	 * findById:根据 ID 找到分组. <br/> 
	 * 
	 * @author whc 
	 * @param id
	 * @return 
	 * @since JDK 1.8 
	 */  
	public TerminalGroup findById(String id) {
		return terminalGroupDao.findById(id);
	}
	

	/** 
	 * removeUnDivideGroup:(这里用一句话描述这个方法的作用). <br/> 
	 *  去除未分组这一项（因为未分组需要置顶显示，其他分组需要按创建时间顺序来进行排序，
		而，未分组此时可能会排不到前面，所以单独抽出）
	 * @author whc 
	 * @param terminalGroupList 
	 * @since JDK 1.8 
	 */  
	public TerminalGroup removeUnDivideGroup(List<TerminalGroup> terminalGroupList) {
		TerminalGroup _terminalGroup = null;
		Iterator<TerminalGroup> it = terminalGroupList.iterator();
		
		while(it.hasNext()){
			_terminalGroup = it.next();
			if(_terminalGroup.getName().equals("未分组")){
				it.remove();
				break;
			}
		}
		
		return _terminalGroup;
	}
}
