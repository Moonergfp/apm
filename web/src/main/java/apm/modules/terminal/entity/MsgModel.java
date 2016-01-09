package apm.modules.terminal.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import apm.common.core.BaseEntity;
import apm.modules.sys.entity.Office;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;


/**
 * 向netty发送的数据模型
 * @author gfp
 * @version 2015-08-17
 */
public class MsgModel{
	private static final long serialVersionUID = 1L;
	//消息类型
	private String msgType;
	//消息来源
	private String from;
	//消息到达的目的
	private String to;
	//在传输文件的时候，记录文件名
	private String fileName;
	//保留字段
	private String reserve;
	//消息内容或者文件内容
	private byte[] data;
	
	public MsgModel(String msgType, String from, String to, String fileName,
			String reserve, byte[] data) {
		super();
		this.msgType = msgType;
		this.from = from;
		this.to = to;
		this.fileName = fileName;
		this.reserve = reserve;
		this.data = data;
	}
	public MsgModel(){}
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getReserve() {
		return reserve;
	}
	public void setReserve(String reserve) {
		this.reserve = reserve;
	}
	public byte[] getData() {
		return data;
	}
	public void setData(byte[] data) {
		this.data = data;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
}


