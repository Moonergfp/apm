package apm.modules.program.dao;

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

import apm.modules.program.entity.Program;


/**
 * 节目实体类DAO接口
 * @author gfp
 * @version 2015-08-17
 */
@Repository
public interface ProgramDao extends  ProgramDaoCustom, JpaDao<Program> {
	
	//查找所有节目实体类(未删除)的记录
	@Query("from Program where delFlag = '" + Program.DEL_FLAG_NORMAL + "'")
	public List<Program> findAll();	
	
	//删除节目实体类信息：逻辑删除 、通过ID号删除
	@Modifying
	@Query("update Program set delFlag='" + Program.DEL_FLAG_DELETE + "' where id = ?1")
	public int deleteById(String id);
	
}

/**
 * 节目实体类DAO 自定义接口
 * @author gfp
 * @version 2015-08-17
 */
interface ProgramDaoCustom extends Dao<Program> {

}

/**
 * 节目实体类DAO 自定义接口实现
 * @author gfp
 * @version 2015-08-17
 */
@Repository
class ProgramDaoImpl extends DaoImpl<Program> implements ProgramDaoCustom {
	
	//用于自定义实现数据库查询方法
	@PersistenceContext
	private EntityManager entityManager;
}