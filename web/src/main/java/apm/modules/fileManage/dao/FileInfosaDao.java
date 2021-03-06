package apm.modules.fileManage.dao;

import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import apm.common.core.Dao;
import apm.common.core.DaoImpl;
import apm.common.core.JpaDao;
import apm.modules.fileManage.entity.FileInfosa;

/**
 * @author wq
 * @date 2013-8-30 上午10:29:46
 */
public interface FileInfosaDao extends FileInfosaDaoCustom, JpaDao<FileInfosa> {
	//通过文件路径查找文件实体信息
	@Query("from FileInfosa where path = ?1 and delFlag = '"+ FileInfosa.DEL_FLAG_NORMAL + "'")
	public  FileInfosa  findByPathO(String filePath);
		
	//查找终端截图
	@Query("from FileInfosa where type = ?1 and delFlag = '"+ FileInfosa.DEL_FLAG_NORMAL + "' and path like ?2 and createDate>= ?3 order by createDate desc")
	public List<FileInfosa> findScreenShoot(String dicValue, String terminalId,Date date);
	//查找终端所有截图
	@Query("from FileInfosa where type = ?1 and delFlag = '"+ FileInfosa.DEL_FLAG_NORMAL + "' and path like ?2 order by createDate desc")
	public List<FileInfosa> findScreenShoot(String dicValue, String terminalId);
	//通过treeId查找文件路径
	@Query("from FileInfosa where treeId = ?1 and delFlag = '"
			+ FileInfosa.DEL_FLAG_NORMAL + "'")
	public List<FileInfosa> findByTreeId(String treeId);
	
	//通过treeId查找文件路径
	@Query("select path from FileInfosa where treeId = ?1 and delFlag = '"
			+ FileInfosa.DEL_FLAG_NORMAL + "'")
	public List<String> findByTreeIdPpt(String treeId);
	
	//通过treeId查找文件id
	@Query("select id from FileInfosa where treeId = ?1 and delFlag = '" + FileInfosa.DEL_FLAG_NORMAL + "'")
	public List<String> findIdByTreeIdPpt(String treeId);
}

/**
 * DAO自定义接口
 */
interface FileInfosaDaoCustom extends Dao<FileInfosa> {
	public List<FileInfosa> getFirstVedio(int start, int size, String type);
	
	/** 
	 * getTerminalNewestVersion:得到系统公共升级包 的最新版本. <br/> 
	 * 
	 * @author whc 
	 * @param type
	 * @param string 
	 * @since JDK 1.8 
	 */  
	public FileInfosa getTerminalNewestSysVersion(String type);
}

/**
 * DAO自定义接口实现
 */
@Repository
class FileInfosaDaoImpl extends DaoImpl<FileInfosa> implements FileInfosaDaoCustom {
	
	@PersistenceContext
	private EntityManager entityManager;
	@Override
	public List<FileInfosa> getFirstVedio(int start, int size, String type) {
		// TODO Auto-generated method stub
		String hql = "select f from FileInfosa as f where f.delFlag = 1 and f.type = ? order by f.updateDate desc";
		javax.persistence.Query query = entityManager.createQuery(hql);
		query.setParameter(1, type);
		query.setFirstResult(start);
		query.setMaxResults(size);
		return query.getResultList();
	}
	
	/** 
	 * TODO 得到系统公共升级包 的最新版本.
	 * @see apm.modules.fileManage.dao.FileInfosaDaoCustom#getTerminalNewestSysVersion(java.lang.String) 
	 */ 
	@Override
	public FileInfosa getTerminalNewestSysVersion(String type) {
		
		String sql = "from FileInfosa where delFlag = '1' and type = ?1 order by createDate desc" ;
		javax.persistence.Query query = entityManager.createQuery(sql);
				
		query.setMaxResults(1);
		query.setParameter(1, type);
				
		Object result =  null;
		try{
			result = query.getSingleResult();
		} catch (javax.persistence.NoResultException e){
			return null;
		}
		return (FileInfosa) result;
	}
}
