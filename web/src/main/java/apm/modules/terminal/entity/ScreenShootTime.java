package apm.modules.terminal.entity;

/**
 *截屏时间 
 */
public class ScreenShootTime {
	private String time;
	private String checked;
	
	public ScreenShootTime(){}
	public ScreenShootTime(String time, String checked) {
		super();
		this.time = time;
		this.checked = checked;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getChecked() {
		return checked;
	}
	public void setChecked(String checked) {
		this.checked = checked;
	}
	@Override
	public String toString() {
		return "ScreenShootTime [time=" + time + ", checked=" + checked + "]";
	}
	
	
}
