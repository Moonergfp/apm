package apm.modules.program.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import apm.common.core.BaseEntity;
import apm.common.utils.StringUtils;
import apm.modules.message.entity.Message;
import apm.modules.sys.entity.Office;
import apm.modules.sys.entity.User;
import apm.modules.terminal.entity.Terminal;


/**
 * 节目发布实体类Entity
 * @author gfp
 * @version 2015-09-06
 */
@Entity
@Table(name = "tbl_publish_program")//数据库表
@DynamicInsert @DynamicUpdate//可生成动态SQL语句，作用于修改插入或修改
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)//缓存策略
public class PublishProgram extends BaseEntity {
	
	@Override
	public String toString() {
		return "PublishProgram [program=" + program + ", messageId="
				+ messageId + ", checkUser=" + checkUser + ", checkStatus="
				+ checkStatus + ", terminalIds=" + terminalIds
				+ ", timeSettings=" + timeSettings + ", terminals=" + terminals
				+ ", tName=" + tName + ", count=" + count + ", type=" + type
				+ ", id=" + id + "]";
	}


	private static final long serialVersionUID = 1L;
	
	private Program program;			//节目
	private Message messageId;            //消息
	private User publishUser;			//发布人
	private User checkUser;				//审核人
	private Office office;				//所属机构
	private String checkStatus;			//审核状态（0：审核中，1：已审核，2：发布成功，3：发布失败，4：审核未通过）
	private String playTimes;			//播放时间段 用逗号隔开如（id1,id2,id3）
	private String terminalIds;			//发布终端 用逗号隔开（tid1,tid2,tid3）
	private String advertiserId;        //广告商
	
	public PublishProgram() {}
	public PublishProgram(String id) {
		this();
		this.id = id;
	}
	
	
	private List<PublishProgramTimeSettings> timeSettings; 
	private List<Terminal> terminals;
	private String tName; // 终端名
	private int count = 0; // 终端个数
	private String type;  //类型： message , program
	
	@Transient
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Transient
	public int getCount() {
		if(StringUtils.isNotBlank(terminalIds)){
			String [] str = terminalIds.split(",");
			for(String st : str){
				if(StringUtils.isNotBlank(st)){
					count ++ ;
				}
			}
		}
		return  count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	@Transient
	public String gettName() {
		return tName;
	}
	public void settName(String tName) {
		this.tName = tName;
	}
	@ManyToOne
	@JoinColumn(name = "message_id")
	public Message getMessageId() {
		return messageId;
	}
	public void setMessageId(Message messageId) {
		this.messageId = messageId;
	}
	public String getAdvertiserId() {
		return advertiserId;
	}
	public void setAdvertiserId(String advertiserId) {
		this.advertiserId = advertiserId;
	}
	@ManyToOne
	@JoinColumn(name = "program_id")
	public Program getProgram() {
			return program;
	}
	public void setProgram(Program program) {
			this.program = program;
	}
	@ManyToOne
	@JoinColumn(name = "publish_user_id", nullable = false)
	public User getPublishUser() {
			return publishUser;
	}
	public void setPublishUser(User publishUser) {
			this.publishUser = publishUser;
	}
	@ManyToOne
	@JoinColumn(name = "check_user_id", nullable = true)
	public User getCheckUser() {
			return checkUser;
	}
	public void setCheckUser(User checkUser) {
			this.checkUser = checkUser;
	}

	@ManyToOne
	@JoinColumn(name = "tenand_id", nullable = false)
	public Office getOffice() {
			return office;
	}
	public void setOffice(Office office) {
			this.office = office;
	}
	@Column(name = "check_status", length = 1, nullable = false)
	public String getCheckStatus() {
			return checkStatus;
	}
	public void setCheckStatus(String checkStatus) {
			this.checkStatus = checkStatus;
	}

	@Column(name = "playtimes_ids", length = 255, nullable = false)
	public String getPlayTimes() {
			return playTimes;
	}
	public void setPlayTimes(String playTimes) {
			this.playTimes = playTimes;
	}

	@Lob
	@Column(name = "terminal_ids",  nullable = false,columnDefinition="TEXT")
	public String getTerminalIds() {
		return terminalIds;
	}

	public void setTerminalIds(String terminalIds) {
		this.terminalIds = terminalIds;
	}

	@Transient
	public List<Terminal> getTerminals() {
		return terminals;
	}
	public void setTerminals(List<Terminal> terminals) {
		this.terminals = terminals;
	}
	@Transient
	public List<PublishProgramTimeSettings> getTimeSettings() {
		return timeSettings;
	}
	public void setTimeSettings(List<PublishProgramTimeSettings> timeSettings) {
		this.timeSettings = timeSettings;
	}
}


