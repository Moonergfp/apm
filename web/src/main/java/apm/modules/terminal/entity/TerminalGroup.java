package apm.modules.terminal.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.annotations.Where;

import com.fasterxml.jackson.annotation.JsonIgnore;

import apm.common.core.BaseEntity;
import apm.modules.sys.entity.Office;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.google.common.collect.Lists;


/**
 * 终端分组实体类Entity
 * @author gfp
 * @version 2015-08-17
 */
@Entity
@Table(name = "tbl_terminal_group")//数据库表
@DynamicInsert @DynamicUpdate//可生成动态SQL语句，作用于修改插入或修改
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)//缓存策略
public class TerminalGroup extends BaseEntity {
	
	private static final long serialVersionUID = 1L;
	
	private Office office;//所属机构
	private String name;//分组名
	private List<Terminal> terminals = Lists.newArrayList();
	
	@Transient
	private int terminalNum; //该终端分组下含有的终端数
	
	public TerminalGroup() {}

	public TerminalGroup(String id) {
		this();
		this.id = id;
	}

	@ManyToOne
	@JoinColumn(name="tenand_id")
	@JsonIgnore
	@NotNull
	public Office getOffice() {
			return office;
	}
	public void setOffice(Office office) {
			this.office = office;
	}

	@Column(name = "group_name", length = 50, nullable = false)
	public String getName() {
			return name;
	}
	public void setName(String name) {
			this.name = name;
	}

	/**
	 * @return the terminalNum
	 */
	@Transient
	public int getTerminalNum() {
		return terminalNum;
	}

	/**
	 * @param terminalNum the terminalNum to set
	 */
	@Transient
	public void setTerminalNum(int terminalNum) {
		this.terminalNum = terminalNum;
	}

	@JsonManagedReference
	@OneToMany(cascade = {CascadeType.PERSIST,CascadeType.MERGE,CascadeType.REMOVE},fetch=FetchType.LAZY,mappedBy="terminalGroup")
	@Where(clause="del_flag='"+DEL_FLAG_NORMAL+"'")
	@OrderBy(value="createDate")
	@JsonIgnore
	public List<Terminal> getTerminals() {
		return terminals;
	}	

	public void setTerminals(List<Terminal> terminals) {
		this.terminals = terminals;
	}

	@Override	
	public String toString() {
		return "TerminalGroup [office=" + office + ", name=" + name + "]";
	}	
}
