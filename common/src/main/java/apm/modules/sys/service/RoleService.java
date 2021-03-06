/**
 * Copyright &copy; 2012-2013 Zaric All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package apm.modules.sys.service;


import java.util.List;
import java.util.Set;

import apm.common.service.BaseService;
import apm.common.utils.StringUtils;
import apm.modules.sys.dao.OfficeDao;
import apm.modules.sys.dao.RoleDao;
import apm.modules.sys.dao.UserDao;
import apm.modules.sys.entity.Role;
import apm.modules.sys.entity.User;
import apm.modules.sys.security.SystemAuthorizingRealm;
import apm.modules.sys.support.Users;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.sql.JoinType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;


/**
 * 系统管理，安全相关实体的管理类,包括用户、角色、菜单.
 * @author resite
 * @version 2013-4-19
 */
@Service
@Transactional(readOnly = true)
public class RoleService extends BaseService<RoleDao, Role> {
	
	@Autowired
	private SystemAuthorizingRealm systemRealm;

	@Autowired
	private UserDao userDao;
	@Autowired
	private OfficeDao officeDao;

	public Role findRoleByName(String name) {
		return dao.findByName(name);
	}
	
	public Role getRole(String id){
		return dao.findOne(id);
	}
	
	public List<Role> findAllRole(){
		//1.查询“开发者总部”规定的5种角色
		List<Role> rs = dao.findDefineRoles();
		
		//2.查询当前机构所拥有的角色
		User user = Users.currentUser();
		DetachedCriteria dc = dao.createDetachedCriteria();
		dc.createAlias("office", "office");
		dc.createAlias("userList", "userList", JoinType.LEFT_OUTER_JOIN);
		dc.add(dataScopeFilter(user, "office", "userList"));	//过滤掉不是该用户数据权限范围内的权限
		dc.add(Restrictions.eq(Role.DEL_FLAG, Role.DEL_FLAG_NORMAL));
		dc.addOrder(Order.asc("office.code")).addOrder(Order.asc("name"));
		
		List<Role> rs2 = dao.find(dc);
		for(int i = 0 ; i < rs2.size(); i++ ){	//去重复
			Role r = rs2.get(i);
			if(!rs.contains(r)){
				rs.add(r);
			}
		}
		return rs;
	}

	@Transactional(readOnly = false)
	public void saveRole(Role role) {
		/*if (StringUtils.isEmpty(role.getOffice().getId())) {
			role.setOffice(officeDao.findOne("1"));
		}else {
			role.setOffice(officeDao.findOne(role.getOffice().getId()));
		}*/
		User user = Users.currentUser();
		if (StringUtils.isEmpty(role.getOffice().getId())) {
//			role.setOffice(officeDao.findOne("1"));
			role.setOffice(user.getCompany());			//将角色设置为当前用户的机构
		}else {
			role.setOffice(officeDao.findOne(role.getOffice().getId()));
		}
		dao.clear();
		dao.save(role);
		systemRealm.clearAllCachedAuthorizationInfo();
	}

	@Transactional(readOnly = false)
	public void deleteRole(String id) {
		dao.deleteById(id);
		systemRealm.clearAllCachedAuthorizationInfo();
	}
	
	@Transactional(readOnly = false)
	public Boolean outUserInRole(Role role, String userId) {
		User user = userDao.findOne(userId);
		List<String> roleIds = user.getRoleIdList();
		Set<Role> roles = user.getRoleList();
		// 
		if (roleIds.contains(role.getId())) {
			roles.remove(role);
			userDao.save(user);
			systemRealm.clearAllCachedAuthorizationInfo();
			return true;
		}
		return false;
	}
	
	@Transactional(readOnly = false)
	public User assignUserToRole(Role role, String userId) {
		User user = userDao.findOne(userId);
		Set<Role> roles = user.getRoleList();
		// 该用户已存在该角色中
		if (roles.contains(role)) {
			return null;
		}
		user.getRoleList().add(role);
		userDao.save(user);
		systemRealm.clearAllCachedAuthorizationInfo();
		return user;
	}
	
}