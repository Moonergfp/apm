package apm.modules.terminal.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import apm.common.core.Dao;
import apm.common.core.DaoImpl;
import apm.common.core.JpaDao;
import apm.modules.terminal.entity.Terminal;


/**
 * 终端实体类DAO接口
 * @author gfp
 * @version 2015-08-17
 */
@Repository
public interface TerminalDao extends  TerminalDaoCustom, JpaDao<Terminal> {
	
	//删除终端实体类信息：逻辑删除 、通过ID号删除
	@Modifying
	@Query("update Terminal set delFlag='" + Terminal.DEL_FLAG_DELETE + "' where id = ?1")
	public int deleteById(String id);
	
	@Query("select count(*) from Terminal where delFlag = '" + Terminal.DEL_FLAG_NORMAL + "' and tenand_id = :tenand_id and group_id = :group_id")
	public long count(@Param(value = "tenand_id") String tenand_id,@Param(value = "group_id")String group_id);

	@Query("from Terminal where delFlag = '" + Terminal.DEL_FLAG_NORMAL + "' and office.id=?1")
	public List<Terminal> findAll(String id);

	@Query("from Terminal  where delFlag = '" + Terminal.DEL_FLAG_NORMAL + "' and id in (?1)")
	public List<Terminal> findByIds(List<String> tIds);

	@Query("select id from Terminal where delFlag = '"+Terminal.DEL_FLAG_NORMAL+"' and name like ?1")
	public List<String> findIdByName(String name);
}

/**
 * 终端实体类DAO 自定义接口
 * @author gfp
 * @version 2015-08-17
 */
interface TerminalDaoCustom extends Dao<Terminal> {

}

/**
 * 终端实体类DAO 自定义接口实现
 * @author gfp
 * @version 2015-08-17
 */
@Repository
class TerminalDaoImpl extends DaoImpl<Terminal> implements TerminalDaoCustom {
	
	//用于自定义实现数据库查询方法
	@PersistenceContext
	private EntityManager entityManager;
}