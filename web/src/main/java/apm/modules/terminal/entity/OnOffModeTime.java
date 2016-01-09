package apm.modules.terminal.entity;

/**
 *开关机时间
 */
public class OnOffModeTime {
	private String stime;	//起始时间
	private String etime;	//结束时间
	private String checked;//开关，是否打开
	private String week; //星期字段  1-7
	public OnOffModeTime(){}

	public String getStime() {
		return stime;
	}

	public void setStime(String stime) {
		this.stime = stime;
	}

	public String getEtime() {
		return etime;
	}

	public void setEtime(String etime) {
		this.etime = etime;
	}

	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public String getWeek() {
		return week;
	}

	public void setWeek(String week) {
		this.week = week;
	}

	@Override
	public String toString() {
		return "OnOffModeTime [stime=" + stime + ", etime=" + etime
				+ ", checked=" + checked + "]";
	}
}
