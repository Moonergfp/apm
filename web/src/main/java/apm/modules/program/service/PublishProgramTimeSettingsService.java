package apm.modules.program.service;

import java.util.Date;
import java.util.List;

import apm.common.core.Page;
import apm.common.service.BaseService;
import apm.common.utils.StringUtils;

import apm.modules.program.entity.PublishProgramTimeSettings;
import apm.modules.program.dao.PublishProgramTimeSettingsDao;

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
 * 发布节目时间段实体类Service
 * @author gfp
 * @version 2015-09-06
 */
@Service
@Transactional(readOnly = true)
public class PublishProgramTimeSettingsService extends BaseService<PublishProgramTimeSettingsDao, PublishProgramTimeSettings> {

	//注入其他的Dao层或本层
	@Autowired
	private PublishProgramTimeSettingsDao publishProgramTimeSettingsDao;
	
	//查找所有发布节目时间段实体类(未删除)的记录
	public List<PublishProgramTimeSettings> findAll() {
		return dao.findAll();
	}
	
	//发布节目时间段实体类列表多条件查询，分页
	public Page<PublishProgramTimeSettings> find(Page<PublishProgramTimeSettings> page, PublishProgramTimeSettings publishProgramTimeSettings) {
		DetachedCriteria dc = dao.createDetachedCriteria();
		if (StringUtils.isNotEmpty(publishProgramTimeSettings.getRemarks())){
			dc.add(Restrictions.like("remarks", "%"+publishProgramTimeSettings.getRemarks()+"%"));
		}
		dc.add(Restrictions.eq(PublishProgramTimeSettings.DEL_FLAG, PublishProgramTimeSettings.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("id"));
		return publishProgramTimeSettingsDao.find(page, dc);
	}
	
	//保存发布节目时间段实体类信息
	@Transactional(readOnly = false)
	public void save(PublishProgramTimeSettings publishProgramTimeSettings) {
		dao.clear();
		dao.save(publishProgramTimeSettings);
	}
	
	//删除发布节目时间段实体类信息：逻辑删除 、通过ID号删除
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
	public Page<PublishProgramTimeSettings> search(Page<PublishProgramTimeSettings> page, String q){
		
		// 设置查询条件
		BooleanQuery query = dao.getFullTextQuery(q, "name");
		//System.out.println(query);
		// 设置过滤条件
		BooleanQuery queryFilter = dao.getFullTextQuery(new BooleanClause(
				new TermQuery(new Term(PublishProgramTimeSettings.DEL_FLAG, String.valueOf(PublishProgramTimeSettings.DEL_FLAG_NORMAL))), Occur.MUST));
		//System.out.println(queryFilter);
		// 设置排序
		Sort sort = new Sort();
		// 全文检索
		dao.search(page, query, queryFilter, sort);
		// 关键字高亮
		dao.keywordsHighlight(query, page.getList(), "name");
		
		return page;
	}

	public List<PublishProgramTimeSettings> findByIds(List<String> pubTimeIds) {
		if(pubTimeIds == null || pubTimeIds.size() == 0){
			return null;
		}
		return dao.findByIds(pubTimeIds);
	}
	
}
