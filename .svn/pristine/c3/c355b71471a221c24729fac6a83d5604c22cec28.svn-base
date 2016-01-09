package ${packageName}.${moduleName}.entity${subModuleName};

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import apm.common.core.BaseEntity;
import apm.common.utils.excel.annotation.ExcelField;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;


/**
 * ${functionName}Entity
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Entity
@Table(name = "${tableName}")//数据库表
@DynamicInsert @DynamicUpdate//可生成动态SQL语句，作用于修改插入或修改
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)//缓存策略
public class ${ClassName} extends BaseEntity {
	
	private static final long serialVersionUID = 1L;
	
	${columnContent}
	
	public ${ClassName}() {}

	public ${ClassName}(String id) {
		this();
		this.id = id;
	}

	${entityContent}
}


