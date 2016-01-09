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

import apm.modules.program.entity.PublishProgramTimeSettings;


/**
 * 发布节目时间段实体类DAO接口
 * @author gfp
 * @version 2015-09-06
 */
@Repository
public interface PublishProgramTimeSettingsDao extends  PublishProgramTimeSettingsDaoCustom, JpaDao<PublishProgramTimeSettings> {
	
	//查找所有发布节目时间段实体类(未删除)的记录
	@Query("from PublishProgramTimeSettings where delFlag = '" + PublishProgramTimeSettings.DEL_FLAG_NORMAL + "'")
	public List<PublishProgramTimeSettings> findAll();	
	
	//删除发布节目时间段实体类信息：逻辑删除 、通过ID号删除
	@Modifying
	@Query("update PublishProgramTimeSettings set delFlag='" + PublishProgramTimeSettings.DEL_FLAG_DELETE + "' where id = ?1")
	public int deleteById(String id);

	@Query("from PublishProgramTimeSettings where delFlag = '" + PublishProgramTimeSettings.DEL_FLAG_NORMAL + "' and id in (?1)")
	public List<PublishProgramTimeSettings> findByIds(List<String> pubTimeIds);
	
}

/**
 * 发布节目时间段实体类DAO 自定义接口
 * @author gfp
 * @version 2015-09-06
 */
interface PublishProgramTimeSettingsDaoCustom extends Dao<PublishProgramTimeSettings> {

}

/**
 * 发布节目时间段实体类DAO 自定义接口实现
 * @author gfp
 * @version 2015-09-06
 */
@Repository
class PublishProgramTimeSettingsDaoImpl extends DaoImpl<PublishProgramTimeSettings> implements PublishProgramTimeSettingsDaoCustom {
	
	//用于自定义实现数据库查询方法
	@PersistenceContext
	private EntityManager entityManager;
}