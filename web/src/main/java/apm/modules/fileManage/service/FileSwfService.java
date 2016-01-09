package apm.modules.fileManage.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import apm.common.service.BaseService;
import apm.modules.fileManage.dao.FileSwfDao;
import apm.modules.fileManage.entity.FileSwf;
/**
 * @author wq
 * @date 2013-8-30 上午10:30:21
 */
@Service
@Transactional(readOnly = true)
public class FileSwfService  extends BaseService<FileSwfDao, FileSwf> {
	 
}
