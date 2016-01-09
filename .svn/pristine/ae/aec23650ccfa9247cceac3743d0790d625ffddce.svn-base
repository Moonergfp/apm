package apm.modules.program.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import apm.common.core.BaseEntity;


/**
 * 发布节目时间段实体类Entity
 * @author gfp
 * @version 2015-09-06
 */
@Entity
@Table(name = "tbl_publish_program_time_settings")//数据库表
@DynamicInsert @DynamicUpdate//可生成动态SQL语句，作用于修改插入或修改
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)//缓存策略
public class PublishProgramTimeSettings extends BaseEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String sSegment;	//开始日期段如2015-9-10
	private String eSegment;	//结束日期段如2015-9-20
	private String timeSegment;//时间段（4对起始结束时间段,每一对用逗号隔开）如07:10,08:20,09:10,20:05
	private List<String> times;//时间段零临时变量 格式：["08:10~09:20","10:10~12:30"...]
	
	public PublishProgramTimeSettings() {}

	public PublishProgramTimeSettings(String id) {
		this();
		this.id = id;
	}

	@Column(name = "s_segment", length = 25, nullable = false)
	public String getsSegment() {
		return sSegment;
	}

	public void setsSegment(String sSegment) {
		this.sSegment = sSegment;
	}

	@Column(name = "e_segment", length = 25, nullable = false)
	public String geteSegment() {
		return eSegment;
	}

	public void seteSegment(String eSegment) {
		this.eSegment = eSegment;
	}


	@Column(name = "time_segment", length = 255, nullable = false)
	public String getTimeSegment() {
			return timeSegment;
	}
	public void setTimeSegment(String timeSegment) {
			this.timeSegment = timeSegment;
	}

	@Transient
	public List<String> getTimes() {
		return times;
	}

	public void setTimes(List<String> times) {
		this.times = times;
	}
	
	
}


