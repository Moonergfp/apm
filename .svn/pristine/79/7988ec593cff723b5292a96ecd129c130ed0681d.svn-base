package apm.modules.terminal.dao;

import java.util.Date;
import java.util.List; 

import apm.common.core.Dao;
import apm.common.core.DaoImpl;
import apm.common.core.JpaDao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import apm.modules.terminal.entity.Terminal;
import apm.modules.terminal.entity.TerminalGroup;


/**
 * 终端分组实体类DAO接口
 * @author gfp
 * @version 2015-08-17
 */
@Repository
public interface TerminalGroupDao extends  TerminalGroupDaoCustom, JpaDao<TerminalGroup> {
	
	//查找所有终端分组实体类(未删除)的记录
	@Query("from TerminalGroup where delFlag = '" + TerminalGroup.DEL_FLAG_NORMAL + "'" + "and tenand_id = :tenand_id order by create_date desc")
	public List<TerminalGroup> findAll(@Param(value = "tenand_id") String tenand_id);	
	
	//删除终端分组实体类信息：逻辑删除 、通过ID号删除
	@Modifying
	@Query("update TerminalGroup set delFlag='" + TerminalGroup.DEL_FLAG_DELETE + "' where id = ?1")
	public int deleteById(String id);
	
	//根据分组名字和公司查找特定的分组
	@Query("from TerminalGroup where delFlag = '" + TerminalGroup.DEL_FLAG_NORMAL + "'" + "and tenand_id = :tenand_id and name = :name")
	public TerminalGroup findByNameAndTenand_id(@Param(value = "name")String name, @Param(value = "tenand_id")String tenand_id);
	
	//根据 ID 查找特定的分组
	@Query("from TerminalGroup where delFlag = '" + Terminal.DEL_FLAG_NORMAL + "'" + "and id = :id")
	public TerminalGroup findById(@Param(value = "id")String id);
}

/**
 * 终端分组实体类DAO 自定义接口
 * @author gfp
 * @version 2015-08-17
 */
interface TerminalGroupDaoCustom extends Dao<TerminalGroup> {

}

/**
 * 终端分组实体类DAO 自定义接口实现
 * @author gfp
 * @version 2015-08-17
 */
@Repository
class TerminalGroupDaoImpl extends DaoImpl<TerminalGroup> implements TerminalGroupDaoCustom {
	
	//用于自定义实现数据库查询方法
	@PersistenceContext
	private EntityManager entityManager;
}