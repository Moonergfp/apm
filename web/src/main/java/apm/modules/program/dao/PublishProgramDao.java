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

import apm.modules.program.entity.PublishProgram;


/**
 * 节目发布实体类DAO接口
 * @author gfp
 * @version 2015-09-06
 */
@Repository
public interface PublishProgramDao extends  PublishProgramDaoCustom, JpaDao<PublishProgram> {
	
	//查找所有节目发布实体类(未删除)的记录
	@Query("from PublishProgram where delFlag = '" + PublishProgram.DEL_FLAG_NORMAL + "'")
	public List<PublishProgram> findAll();	
	
	//删除节目发布实体类信息：逻辑删除 、通过ID号删除
	@Modifying
	@Query("update PublishProgram set delFlag='" + PublishProgram.DEL_FLAG_DELETE + "' where id = ?1")
	public int deleteById(String id);

	@Query("from PublishProgram where delFlag = '" + PublishProgram.DEL_FLAG_NORMAL + "' and office.id=?1")
	public List<PublishProgram> findPubPros(String cId);
	
	@Query("select id from PublishProgram where delFlag = '"+ PublishProgram.DEL_FLAG_NORMAL+"' and terminalIds like ?1")
	public List<String> findByTerminalId(String id);
}

/**
 * 节目发布实体类DAO 自定义接口
 * @author gfp
 * @version 2015-09-06
 */
interface PublishProgramDaoCustom extends Dao<PublishProgram> {

}

/**
 * 节目发布实体类DAO 自定义接口实现
 * @author gfp
 * @version 2015-09-06
 */
@Repository
class PublishProgramDaoImpl extends DaoImpl<PublishProgram> implements PublishProgramDaoCustom {
	
	//用于自定义实现数据库查询方法
	@PersistenceContext
	private EntityManager entityManager;
}