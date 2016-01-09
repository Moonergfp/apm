package apm.modules.terminal.dao;

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

import apm.modules.terminal.entity.TerminalSettings;


/**
 * 终端设置实体类DAO接口
 * @author gfp
 * @version 2015-08-17
 */
@Repository
public interface TerminalSettingsDao extends  TerminalSettingsDaoCustom, JpaDao<TerminalSettings> {
	
	//查找所有终端设置实体类(未删除)的记录
	@Query("from TerminalSettings where delFlag = '" + TerminalSettings.DEL_FLAG_NORMAL + "'")
	public List<TerminalSettings> findAll();	
	
	//删除终端设置实体类信息：逻辑删除 、通过ID号删除
	@Modifying
	@Query("update TerminalSettings set delFlag='" + TerminalSettings.DEL_FLAG_DELETE + "' where id = ?1")
	public int deleteById(String id);

	//查找终端的工作时间（开关机）设置
	@Query("from TerminalSettings where delFlag = '" + TerminalSettings.DEL_FLAG_NORMAL + "' and id = ?1 and modeFlag = ?2 order by createDate asc")
	public List<TerminalSettings> findWorkTimes(String id, String switchMode);
	//查找终端的工作时间（开关机）设置
	@Query("from TerminalSettings where delFlag = '" + TerminalSettings.DEL_FLAG_NORMAL + "' and id = ?1 and modeFlag = ?2 and weekFlag = ?3 order by createDate asc")
	public List<TerminalSettings> findWorkTimes(String id, String switchMode,String week);
	//删除多个终端的工作时间
	@Modifying
	@Query("delete from TerminalSettings where terminal.id in ?1 and modeFlag is not null")
	public int deleteWorkdTimes(List<String> terminalIds);
	@Modifying
	@Query("delete from TerminalSettings where terminal.id in ?1 and fixedTime is not null")
	public void deleteScreenShootTimes(List<String> terminalIds);
	//查找终端定时截图时间
	@Query("from TerminalSettings where terminal.id = ?1  and fixedTime is not null order by fixedTime")
	public List<TerminalSettings> findScreenShootTimes(String terminalId);
	
	
}

/**
 * 终端设置实体类DAO 自定义接口
 * @author gfp
 * @version 2015-08-17
 */
interface TerminalSettingsDaoCustom extends Dao<TerminalSettings> {

}

/**
 * 终端设置实体类DAO 自定义接口实现
 * @author gfp
 * @version 2015-08-17
 */
@Repository
class TerminalSettingsDaoImpl extends DaoImpl<TerminalSettings> implements TerminalSettingsDaoCustom {
	
	//用于自定义实现数据库查询方法
	@PersistenceContext
	private EntityManager entityManager;
}