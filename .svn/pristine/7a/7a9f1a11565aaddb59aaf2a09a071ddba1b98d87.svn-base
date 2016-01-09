package apm.modules.program.entity;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import apm.common.core.BaseEntity;
import apm.modules.sys.entity.Office;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;


/**
 * 节目实体类Entity
 * @author gfp
 * @version 2015-08-17
 */
@Entity
@Table(name = "tbl_program")//数据库表
@DynamicInsert @DynamicUpdate//可生成动态SQL语句，作用于修改插入或修改
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)//缓存策略
public class Program extends BaseEntity {
	
	@Override
	public String toString() {
		return "Program [name=" + name + ", playTime=" + playTime + ", office="
				+ office + ", ratio=" + ratio + ", advertiserId="
				+ advertiserId + ", editHtml=" + editHtml + ", preHtml="
				+ preHtml + ", type=" + type + ", tName=" + tName + ", id="
				+ id + "]";
	}
	private static final long serialVersionUID = 1L;
	
	private String name;//节目名
	private Integer playTime;//节目时长
	private Office office;//机构ID
	private String ratio;//分辨率
	private String advertiserId; //广告商
	private String editHtml; //编辑html
	private String preHtml; //预览html
	
	@Transient
	private String type = "1"; //节目类型: '1' 默认机构节目 '0' 我的节目
	@Transient
	private String tName; // 终端名
	public String getAdvertiserId() {
		return advertiserId;
	}
	public void setAdvertiserId(String advertiserId) {
		this.advertiserId = advertiserId;
	}
	@Transient
	public String gettName() {
		return tName;
	}
	public void settName(String tName) {
		this.tName = tName;
	}
	@Transient
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getEditHtml() {
		return editHtml;
	}
	public void setEditHtml(String editHtml) {
		this.editHtml = editHtml;
	}
	public String getPreHtml() {
		return preHtml;
	}
	public void setPreHtml(String preHtml) {
		this.preHtml = preHtml;
	}
	public String getName() {
			return name;
	}
	public void setName(String name) {
			this.name = name;
	}

	@Column(name = "play_time", length = 6, nullable = false)
	public Integer getPlayTime() {
		return playTime;
	}

	public void setPlayTime(Integer playTime) {
		this.playTime = playTime;
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

	@Column(name = "ratio", length = 10, nullable = false)
	public String getRatio() {
			return ratio;
	}
	public void setRatio(String ratio) {
			this.ratio = ratio;
	}
}


