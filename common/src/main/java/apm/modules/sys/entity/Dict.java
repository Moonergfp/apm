/**
 * Copyright &copy; 2012-2013 Zaric All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package apm.modules.sys.entity;


import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import apm.common.core.BaseEntity;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.validator.constraints.Length;


/**
 * 字典Entity
 * <p>@author zhangzuoqiang
 * @version 2013-05-15
 */
@Entity
@Table(name = "sys_dict")
@DynamicInsert @DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Dict extends BaseEntity {

	private static final long serialVersionUID = 1L;

	private String label;	// 标签名
	private String value;	// 数据值
	private String type;	// 类型
	private String description;// 描述
	private Integer sort;	// 排序

	//中文名。某些键值是英文，前台显示的时候需要中文
	//Ps:在素材管理的类别中需要到该字段
	@Transient
	private String chineseName; 
	
	//判断是否有子文件夹
	//Ps:在素材管理的类别中需要到该字段
	@Transient
	private boolean hasSubFolder; 
	
	
	
	
	public Dict() {
		super();
	}
	
	public Dict(String id) {
		this();
		this.id = id;
	}
	
	@Length(min=1, max=100)
	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}
	
	@Length(min=1, max=100)
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Length(min=1, max=100)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Length(min=0, max=100)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@NotNull
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	/**
	 * @return the chineseName
	 */
	@Transient
	public String getChineseName() {
		return chineseName;
	}

	/**
	 * @param chineseName the chineseName to set
	 */
	@Transient
	public void setChineseName(String chineseName) {
		this.chineseName = chineseName;
	}

	/**
	 * @return the hasSubFolder
	 */
	@Transient
	public boolean isHasSubFolder() {
		return hasSubFolder;
	}

	/**
	 * @param hasSubFolder the hasSubFolder to set
	 */
	@Transient
	public void setHasSubFolder(boolean hasSubFolder) {
		this.hasSubFolder = hasSubFolder;
	}
	
}