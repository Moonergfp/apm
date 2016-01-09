package apm.modules.message.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import apm.common.core.Page;
import apm.common.service.BaseService;
import apm.common.utils.StringUtils;

import apm.modules.message.entity.Message;
import apm.modules.message.dao.MessageDao;
import apm.modules.program.dao.PublishProgramDao;
import apm.modules.program.entity.Program;
import apm.modules.sys.support.Users;
import apm.modules.terminal.dao.TerminalDao;

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
 * 消息实体类Service
 * @author gfp
 * @version 2015-09-08
 */
@Service
@Transactional(readOnly = true)
public class MessageService extends BaseService<MessageDao, Message> {

	//注入其他的Dao层或本层
	@Autowired
	private MessageDao messageDao;
	@Autowired
	TerminalDao terminalDao;
	@Autowired
	PublishProgramDao publishProgramDao;
	//查找所有消息实体类(未删除)的记录
	public List<Message> findAll() {
		return dao.findAll();
	}
	
	//消息实体类列表多条件查询，分页
	public Page<Message> find(Page<Message> page, Message message) {
		System.out.println(message);
		DetachedCriteria dc = dao.createDetachedCriteria();
		if(message != null){
			List<String> tIds = null; //终端ids
			List<String> pIds = new ArrayList<String>();
			//获取存在该终端
			if(StringUtils.isNotBlank(message.gettName())){
				tIds = terminalDao.findIdByName("%" + message.gettName() + "%");
			}
			
			//获取发布列表id
			if(tIds != null && tIds.size() > 0){
				for(String str : tIds){
					if(StringUtils.isNotBlank(str)){
						pIds.addAll(publishProgramDao.findByTerminalId("%" + str + "%"));
					}
				}
			}
			
			if(pIds != null && pIds.size() > 0){
				dc.add(Restrictions.in("id", pIds));
			}
			
			if (StringUtils.isNotEmpty(message.getName())){
				dc.add(Restrictions.like("name", "%"+message.getName()+"%"));
			}
			
			if(StringUtils.isNotBlank(message.getType())){
				if("0".equals(message.getType())){
					dc.add(Restrictions.eq("createBy.id", Users.currentUser().getId()));
				}
			}
		}
		dc.add(Restrictions.eq(Program.DEL_FLAG, Program.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("createDate"));
		return dao.find(page, dc);
	}
	
	//保存消息实体类信息
	@Transactional(readOnly = false)
	public void save(Message message) {
		dao.clear();
		dao.save(message);
	}
	
	//删除消息实体类信息：逻辑删除 、通过ID号删除
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
	public Page<Message> search(Page<Message> page, String q){
		
		// 设置查询条件
		BooleanQuery query = dao.getFullTextQuery(q, "name");
		//System.out.println(query);
		// 设置过滤条件
		BooleanQuery queryFilter = dao.getFullTextQuery(new BooleanClause(
				new TermQuery(new Term(Message.DEL_FLAG, String.valueOf(Message.DEL_FLAG_NORMAL))), Occur.MUST));
		//System.out.println(queryFilter);
		// 设置排序
		Sort sort = new Sort();
		// 全文检索
		dao.search(page, query, queryFilter, sort);
		// 关键字高亮
		dao.keywordsHighlight(query, page.getList(), "name");
		
		return page;
	}
	
}
