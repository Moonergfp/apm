package ${packageName}.${moduleName}.service${subModuleName};

import java.util.Date;
import java.util.List;

import apm.common.core.Page;
import apm.common.service.BaseService;
import apm.common.utils.StringUtils;

import ${packageName}.${moduleName}.entity${subModuleName}.${ClassName};
import ${packageName}.${moduleName}.dao${subModuleName}.${ClassName}Dao;

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
 * ${functionName}Service
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Service
@Transactional(readOnly = true)
public class ${ClassName}Service extends BaseService<${ClassName}Dao, ${ClassName}> {

	//注入其他的Dao层或本层
	@Autowired
	private ${ClassName}Dao ${className}Dao;
	
	//查找所有${functionName}(未删除)的记录
	public List<${ClassName}> findAll() {
		return dao.findAll();
	}
	
	//${functionName}列表多条件查询，分页
	public Page<${ClassName}> find(Page<${ClassName}> page, ${ClassName} ${className}) {
		DetachedCriteria dc = dao.createDetachedCriteria();
		if (StringUtils.isNotEmpty(${className}.getRemarks())){
			dc.add(Restrictions.like("remarks", "%"+${className}.getRemarks()+"%"));
		}
		dc.add(Restrictions.eq(${ClassName}.DEL_FLAG, ${ClassName}.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("id"));
		return ${className}Dao.find(page, dc);
	}
	
	//保存${functionName}信息
	@Transactional(readOnly = false)
	public void save(${ClassName} ${className}) {
		dao.clear();
		dao.save(${className});
	}
	
	//删除${functionName}信息：逻辑删除 、通过ID号删除
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
	public Page<${ClassName}> search(Page<${ClassName}> page, String q){
		
		// 设置查询条件
		BooleanQuery query = dao.getFullTextQuery(q, "name");
		//System.out.println(query);
		// 设置过滤条件
		BooleanQuery queryFilter = dao.getFullTextQuery(new BooleanClause(
				new TermQuery(new Term(${ClassName}.DEL_FLAG, String.valueOf(${ClassName}.DEL_FLAG_NORMAL))), Occur.MUST));
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
