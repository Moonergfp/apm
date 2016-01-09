package apm.common.utils;

import apm.modules.fileManage.service.FileInfosaService;
import apm.modules.fileManage.service.FileManagerService;
import apm.modules.sys.dao.OfficeDao;
import apm.modules.sys.dao.RoleDao;
import apm.modules.sys.service.DictService;
import apm.modules.sys.service.MenuService;
import apm.modules.sys.service.OfficeService;
import apm.modules.sys.service.RoleService;
import apm.modules.sys.service.UserService;


/**
 * 实例化   需要其它类继承其便可引用
 * @author wq
 *
 */
public class ApmInstance {
	
    public static RoleService roleService = SpringContextHolder.getBean(RoleService.class);
    public static FileManagerService fileManagerService = SpringContextHolder.getBean(FileManagerService.class);
    public static FileInfosaService fileInfosaService = SpringContextHolder.getBean(FileInfosaService.class);
    public static UserService userService = SpringContextHolder.getBean(UserService.class);
    public static RoleDao roleDao = SpringContextHolder.getBean(RoleDao.class);
    public static OfficeDao officeDao = SpringContextHolder.getBean(OfficeDao.class);
    public static OfficeService officeService = SpringContextHolder.getBean(OfficeService.class);
    public static MenuService menuService = SpringContextHolder.getBean(MenuService.class);
    public static DictService dictService = SpringContextHolder.getBean(DictService.class);
}
