package ${packageName}.${moduleName}.dao${subModuleName};

import java.util.Date;
import java.util.List; 

import apm.common.core.Dao;
import apm.common.core.DaoImpl;
import apm.common.core.JpaDao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import ${packageName}.${moduleName}.entity${subModuleName}.${ClassName};


/**
 * ${functionName}DAO接口
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Repository
public interface ${ClassName}Dao extends  ${ClassName}DaoCustom, JpaDao<${ClassName}> {
	
	//查找所有${functionName}(未删除)的记录
	@Query("from ${ClassName} where delFlag = '" + ${ClassName}.DEL_FLAG_NORMAL + "'")
	public List<${ClassName}> findAll();	
	
	//删除${functionName}信息：逻辑删除 、通过ID号删除
	@Modifying
	@Query("update ${ClassName} set delFlag='" + ${ClassName}.DEL_FLAG_DELETE + "' where id = ?1")
	public int deleteById(String id);
	
}

/**
 * ${functionName}DAO 自定义接口
 * @author ${classAuthor}
 * @version ${classVersion}
 */
interface ${ClassName}DaoCustom extends Dao<${ClassName}> {

}

/**
 * ${functionName}DAO 自定义接口实现
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Repository
class ${ClassName}DaoImpl extends DaoImpl<${ClassName}> implements ${ClassName}DaoCustom {
	
	//用于自定义实现数据库查询方法
	@PersistenceContext
	private EntityManager entityManager;
}