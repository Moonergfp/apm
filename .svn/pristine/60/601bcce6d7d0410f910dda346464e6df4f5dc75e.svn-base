package apm.modules.message.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import apm.common.core.BaseEntity;
import apm.common.utils.excel.annotation.ExcelField;
import apm.modules.sys.entity.Office;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;


/**
 * 消息实体类Entity
 * @author gfp
 * @version 2015-09-08
 */
@Entity
@Table(name = "tbl_message")//数据库表
@DynamicInsert @DynamicUpdate//可生成动态SQL语句，作用于修改插入或修改
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)//缓存策略
public class Message extends BaseEntity {
	
	private static final long serialVersionUID = 1L;
	
	private String name;				//消息名
	private String content;				//消息体
	private String playSpeed;			//播放速度
	private Office office;				//机构ID
	private String advertiserId; 		//广告商
	private Integer playTime;           //消息时长
	
	public Message() {}

	public Message(String id) {
		this();
		this.id = id;
	}

	private String tName; //终端名字
	private String type = "1"; //节目类型: '1' 默认机构消息 '0' 我的消息
	@Transient
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Integer getPlayTime() {
		return playTime;
	}

	public void setPlayTime(Integer playTime) {
		this.playTime = playTime;
	}
	@Override
	public String toString() {
		return "Message [name=" + name + ", content=" + content
				+ ", playSpeed=" + playSpeed + ", office=" + office
				+ ", advertiserId=" + advertiserId + ", tName=" + tName
				+ ", type=" + type + ", id=" + id + "]";
	}

	@Transient
	public String gettName() {
		return tName;
	}

	public void settName(String tName) {
		this.tName = tName;
	}

	@Column(name = "name", length = 30, nullable = false)
	public String getName() {
			return name;
	}
	public void setName(String name) {
			this.name = name;
	}
	public String getAdvertiserId() {
		return advertiserId;
	}

	public void setAdvertiserId(String advertiserId) {
		this.advertiserId = advertiserId;
	}
	@Column(name = "content", length = 255, nullable = false)
	public String getContent() {
			return content;
	}
	public void setContent(String content) {
			this.content = content;
	}

	@Column(name = "playSpeed", length = 1, nullable = false)
	public String getPlaySpeed() {
			return playSpeed;
	}
	public void setPlaySpeed(String playSpeed) {
			this.playSpeed = playSpeed;
	}

	@ManyToOne
	@JoinColumn(name="tenand_id")
	@NotNull
	public Office getOffice() {
		return office;
	}
	public void setOffice(Office office) {
		this.office = office;
	}
}


