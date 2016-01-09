/** 
 * Project Name:apm-web 
 * File Name:TerminalUpgradeDao.java 
 * Package Name:apm.modules.terminal.dao 
 * Date:2015年8月25日下午11:42:22 
 * Copyright (c) 2015, wuhuachuan712@163.com All Rights Reserved. 
 * 
 */   
      
package apm.modules.terminal.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import apm.common.core.Dao;
import apm.common.core.DaoImpl;
import apm.common.core.JpaDao;
import apm.modules.sys.entity.Office;
import apm.modules.sys.support.Users;
import apm.modules.terminal.entity.Terminal;

/** 
 * ClassName: TerminalUpgradeDao <br/> 
 * Reason: TODO 在线升级DAO层. <br/> 
 * date: 2015年8月25日 下午11:42:22 <br/> 
 * 
 * @author whc 
 * @version  1.0
 * @since JDK 1.8 
 */
@Repository
public interface TerminalUpgradeDao extends  TerminalUpgradeDaoCustom, JpaDao<Terminal> {
}
  
/**
 * 
 * ClassName: TerminalUpgradeDaoCustom <br/> 
 * Reason: TODO 在线升级DAO层自定义接口. <br/> 
 * date: 2015年8月25日 下午11:45:10 <br/> 
 * 
 * @author whc 
 * @version  1.0
 * @since JDK 1.8
 */
interface TerminalUpgradeDaoCustom extends Dao<Terminal> {
}

/**
 * 
 * ClassName: TerminalUpgradeDaoImpl <br/> 
 * Reason: TODO 在线升级DAO层自定义接口实现类. <br/> 
 * date: 2015年8月25日 下午11:46:12 <br/> 
 * 
 * @author whc 
 * @version  1.0
 * @since JDK 1.8
 */
@Repository(value = "TerminalUpgradeDaoImpl")
class TerminalUpgradeDaoImpl extends DaoImpl<Terminal> implements TerminalUpgradeDaoCustom {
	
	//用于自定义实现数据库查询方法
	@PersistenceContext
	private EntityManager entityManager;
}