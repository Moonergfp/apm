package apm.modules.fileManage.dao;

import org.springframework.stereotype.Repository;
import apm.common.core.Dao;
import apm.common.core.DaoImpl;
import apm.common.core.JpaDao;
import apm.modules.fileManage.entity.FileSwf;

/**
 * @author wq
 * @date 2013-8-30 上午10:29:46
 */
public interface FileSwfDao extends FileSwfDaoCustom, JpaDao<FileSwf> {
 
}

/**
 * DAO自定义接口
 */
interface FileSwfDaoCustom extends Dao<FileSwf> {

}

/**
 * DAO自定义接口实现
 */
@Repository
class FileSwfDaoImpl extends DaoImpl<FileSwf> implements FileSwfDaoCustom {

}
