package apm.modules.terminal.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import apm.common.core.BaseEntity;
import apm.common.utils.excel.annotation.ExcelField;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;


/**
 * 终端设置实体类Entity
 * @author gfp
 * @version 2015-08-17
 */
@Entity
@Table(name = "tbl_teminal_settings")//数据库表
@DynamicInsert @DynamicUpdate//可生成动态SQL语句，作用于修改插入或修改
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)//缓存策略
public class TerminalSettings extends BaseEntity {
	
	private static final long serialVersionUID = 1L;
	
	private Terminal terminal;//终端ID
	private String fixedTime;//定时截屏时间
	private String onOffSTime;//起始时间
	private String onOffETime;//结束时间
	private String modeFlag;//开关模式（0：常开，1：定时）
	private String weekFlag;//星期字段（1-7表示星期日到星期六）
	private String lightNumber;//亮度（0~100）
	private String voiceNumber;//音量（0~100）
	
	
	public TerminalSettings() {}

	public TerminalSettings(String id) {
		this();
		this.id = id;
	}
	@ManyToOne
	@JoinColumn(name="terminal_id")
	@NotNull
	public Terminal getTerminal() {
			return terminal;
	}
	public void setTerminal(Terminal terminal) {
			this.terminal = terminal;
	}

	@Column(name = "fixed_time",  nullable = true)
	public String getFixedTime() {
			return fixedTime;
	}
	public void setFixedTime(String fixedTime) {
			this.fixedTime = fixedTime;
	}

	@Column(name = "on_off_stime",  nullable = true)
	public String getOnOffSTime() {
			return onOffSTime;
	}
	public void setOnOffSTime(String onOffSTime) {
			this.onOffSTime = onOffSTime;
	}

	@Column(name = "on_off_etime",  nullable = true)
	public String getOnOffETime() {
			return onOffETime;
	}
	public void setOnOffETime(String onOffETime) {
			this.onOffETime = onOffETime;
	}

	@Column(name = "mode_flag", length = 1, nullable = true)
	public String getModeFlag() {
			return modeFlag;
	}
	public void setModeFlag(String modeFlag) {
			this.modeFlag = modeFlag;
	}

	@Column(name = "week_flag", length = 1, nullable = true)
	public String getWeekFlag() {
			return weekFlag;
	}
	public void setWeekFlag(String weekFlag) {
			this.weekFlag = weekFlag;
	}

	@Column(name = "light_number", length = 3, nullable = true)
	public String getLightNumber() {
			return lightNumber;
	}
	public void setLightNumber(String lightNumber) {
			this.lightNumber = lightNumber;
	}

	@Column(name = "voice_number", length = 3, nullable = true)
	public String getVoiceNumber() {
			return voiceNumber;
	}
	public void setVoiceNumber(String voiceNumber) {
			this.voiceNumber = voiceNumber;
	}

	@Override
	public String toString() {
		return "TerminalSettings [terminal=" + terminal + ", fixedTime="
				+ fixedTime + ", delFlag=" + delFlag + "]";
	}
}


