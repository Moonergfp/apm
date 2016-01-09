package apm.modules.terminal.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import apm.common.core.BaseEntity;
import apm.modules.program.entity.Program;
import apm.modules.sys.entity.Office;

import com.fasterxml.jackson.annotation.JsonIgnore;


/**
 * 终端实体类Entity
 * @author gfp
 * @version 2015-08-17
 */
@Entity
@Table(name = "tbl_terminal")//数据库表
@DynamicInsert @DynamicUpdate//可生成动态SQL语句，作用于修改插入或修改
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)//缓存策略
public class Terminal extends BaseEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String name;//终端名
	private String status;//状态(0：离线，1：在线)
	private String ratio;//分辨率
	private String ip;//ip地址
	private String systemVersion;//系统版本
	private TerminalGroup terminalGroup;//所属分组
	private Office office;//所属机构
	private String realFlag;//是否实时截图
	private String fixedFlag;//是否定时截图
	private String onOffModeFlag;//开关机模式（0：每天，1：星期模式 ） 默认每天
	private String switchModeFlag;//定时开关模式（0:常开，1：定时） 默认常开
	private String voiceFlag;//音量模式（0：常开，1：定时）
	private String lightFlag;//亮度模式（0：常开，1：定时）
	private String softVersion;//apk版本
	private String terminalVersion; //终端型号
	private List<Program> programs;
	public Terminal() {}

	public Terminal(String id) {
		this();
		this.id = id;
	}

	@Column(name = "terminal_name", length = 30, nullable = false)
	public String getName() {
			return name;
	}
	public void setName(String name) {
			this.name = name;
	}

	@Column(name = "status", length = 1, nullable = false)
	public String getStatus() {
			return status;
	}
	public void setStatus(String status) {
			this.status = status;
	}

	@Column(name = "ratio", length = 10, nullable = false)
	public String getRatio() {
			return ratio;
	}
	public void setRatio(String ratio) {
			this.ratio = ratio;
	}

	@Column(name = "ip", length = 15, nullable = true)
	public String getIp() {
			return ip;
	}
	public void setIp(String ip) {
			this.ip = ip;
	}

	@Column(name = "system_version", length = 20, nullable = false)
	public String getSystemVersion() {
			return systemVersion;
	}
	public void setSystemVersion(String systemVersion) {
			this.systemVersion = systemVersion;
	}

	@JsonIgnore
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="group_id")
	@NotNull
	public TerminalGroup getTerminalGroup() {
		return terminalGroup;
	}

	public void setTerminalGroup(TerminalGroup terminalGroup) {
		this.terminalGroup = terminalGroup;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="tenand_id")
	@NotNull
	@JsonIgnore
	public Office getOffice() {
			return office;
	}
	public void setOffice(Office office) {
			this.office = office;
	}

	@Column(name = "real_time_flag", length = 1, nullable = false)
	public String getRealFlag() {
			return realFlag;
	}
	public void setRealFlag(String realFlag) {
			this.realFlag = realFlag;
	}

	@Column(name = "fixed_time_flag", length = 1, nullable = false)
	public String getFixedFlag() {
			return fixedFlag;
	}
	public void setFixedFlag(String fixedFlag) {
			this.fixedFlag = fixedFlag;
	}

	@Column(name = "on_off_mode_flag", length = 1, nullable = false)
	public String getOnOffModeFlag() {
			return onOffModeFlag;
	}
	public void setOnOffModeFlag(String onOffModeFlag) {
			this.onOffModeFlag = onOffModeFlag;
	}

	@Column(name = "voice_flag", length = 1, nullable = false)
	public String getVoiceFlag() {
			return voiceFlag;
	}
	public void setVoiceFlag(String voiceFlag) {
			this.voiceFlag = voiceFlag;
	}

	@Column(name = "light_flag", length = 1, nullable = false)
	public String getLightFlag() {
			return lightFlag;
	}
	public void setLightFlag(String lightFlag) {
			this.lightFlag = lightFlag;
	}

	@Column(name = "soft_version", length = 20, nullable = false)
	public String getSoftVersion() {
			return softVersion;
	}
	public void setSoftVersion(String softVersion) {
			this.softVersion = softVersion;
	}

	/**
	 * @return the terminalVersion
	 */
	public String getTerminalVersion() {
		return terminalVersion;
	}

	/**
	 * @param terminalVersion the terminalVersion to set
	 */
	public void setTerminalVersion(String terminalVersion) {
		this.terminalVersion = terminalVersion;
	}

	@Column(name = "switch_mode_flag", length = 1, nullable = false)
	public String getSwitchModeFlag() {
		return switchModeFlag;
	}

	public void setSwitchModeFlag(String switchModeFlag) {
		this.switchModeFlag = switchModeFlag;
	}
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(name="tbl_terminal_publish_program_mapping",joinColumns=@JoinColumn(name="terminalid"),
            inverseJoinColumns=@JoinColumn(name="publish_programid"))
	@JsonIgnore
	public List<Program> getPrograms() {
		return programs;
	}

	public void setPrograms(List<Program> programs) {
		this.programs = programs;
	}

	@Override
	public String toString() {
		return "Terminal [name=" + name + ", status=" + status + "]";
	}
}


