/** 
 * Project Name:apm-web 
 * File Name:TerminalUpgradeService.java 
 * Package Name:apm.modules.terminal.service 
 * Date:2015年8月25日下午11:39:02 
 * Copyright (c) 2015, wuhuachuan712@163.com All Rights Reserved. 
 * 
 */   
      
package apm.modules.terminal.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import apm.common.service.BaseService;
import apm.modules.sys.entity.Office;
import apm.modules.sys.service.OfficeService;
import apm.modules.sys.support.Users;
import apm.modules.terminal.dao.TerminalUpgradeDao;
import apm.modules.terminal.entity.Terminal;

/** 
 * ClassName: TerminalUpgradeService <br/> 
 * Reason: TODO 在线升级模块服务层. <br/> 
 * date: 2015年8月25日 下午11:39:02 <br/> 
 * 
 * @author whc 
 * @version  1.0
 * @since JDK 1.8 
 */
@Service
@Transactional(readOnly = true)
public class TerminalUpgradeService extends BaseService<TerminalUpgradeDao, Terminal> {

	//注入其他的Dao层或本层
	@Autowired
	private TerminalUpgradeDao terminalUpgradeDao;
	
	@Autowired
	private OfficeService officeService;
}
  