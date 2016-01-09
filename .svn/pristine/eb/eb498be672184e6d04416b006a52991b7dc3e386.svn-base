package apm.modules.terminal.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.lucene.index.Term;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.TermQuery;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.mapping.Array;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;

import freemarker.template.utility.StringUtil;

import apm.common.core.Page;
import apm.common.service.BaseService;
import apm.common.utils.ApmUtils;
import apm.common.utils.DateUtils;
import apm.common.utils.JSONUtils;
import apm.common.utils.SeveralTimeComparator;
import apm.common.utils.StringUtils;
import apm.modules.fileManage.entity.FileInfosa;
import apm.modules.fileManage.entity.FileManager;
import apm.modules.fileManage.service.FileInfosaService;
import apm.modules.sys.support.Users;
import apm.modules.terminal.dao.TerminalSettingsDao;
import apm.modules.terminal.entity.MsgModel;
import apm.modules.terminal.entity.NettyCommand;
import apm.modules.terminal.entity.OnOffModeTime;
import apm.modules.terminal.entity.ScreenShootTime;
import apm.modules.terminal.entity.Terminal;
import apm.modules.terminal.entity.TerminalInfo;
import apm.modules.terminal.entity.TerminalSettings;

/**
 * 终端设置实体类Service
 * @author gfp
 * @version 2015-08-17
 */
@Service
@Transactional(readOnly = true)
public class TerminalSettingsService extends BaseService<TerminalSettingsDao, TerminalSettings> {

	//注入其他的Dao层或本层
	@Autowired
	private TerminalSettingsDao terminalSettingsDao;
	@Autowired
	private TerminalService terminalService;
	@Autowired
	private FileInfosaService fileInfosaService;
	
	//查找所有终端设置实体类(未删除)的记录
	public List<TerminalSettings> findAll() {
		return dao.findAll();
	}
	
	//终端设置实体类列表多条件查询，分页
	public Page<TerminalSettings> find(Page<TerminalSettings> page, TerminalSettings terminalSettings) {
		DetachedCriteria dc = dao.createDetachedCriteria();
		if (StringUtils.isNotEmpty(terminalSettings.getRemarks())){
			dc.add(Restrictions.like("remarks", "%"+terminalSettings.getRemarks()+"%"));
		}
		dc.add(Restrictions.eq(TerminalSettings.DEL_FLAG, TerminalSettings.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("id"));
		return terminalSettingsDao.find(page, dc);
	}
	
	//保存终端设置实体类信息
	@Transactional(readOnly = false)
	public void save(TerminalSettings terminalSettings) {
		dao.clear();
		dao.save(terminalSettings);
	}
	
	//删除终端设置实体类信息：逻辑删除 、通过ID号删除
	@Transactional(readOnly = false)
	public void delete(String id) {
		dao.deleteById(id);
	}
	
	/**
	 * 更新索引
	 */
	public void createIndex(){
		dao.createIndex();
	}
	
	/**
	 * 全文检索  
	 */
	public Page<TerminalSettings> search(Page<TerminalSettings> page, String q){
		
		// 设置查询条件
		BooleanQuery query = dao.getFullTextQuery(q, "name");
		//System.out.println(query);
		// 设置过滤条件
		BooleanQuery queryFilter = dao.getFullTextQuery(new BooleanClause(
				new TermQuery(new Term(TerminalSettings.DEL_FLAG, String.valueOf(TerminalSettings.DEL_FLAG_NORMAL))), Occur.MUST));
		//System.out.println(queryFilter);
		// 设置排序
		Sort sort = new Sort();
		// 全文检索
		dao.search(page, query, queryFilter, sort);
		// 关键字高亮
		dao.keywordsHighlight(query, page.getList(), "name");
		
		return page;
	}

	/**
	 * 设置终端音量
	 * @param terminalSettings
	 * @throws Exception 
	 */
	public void sendVoiceReq2Netty(TerminalSettings terminalSettings) throws Exception {
		//1.修改数据库中音量值
		
		save(terminalSettings);
		//2.向netty发送命令
		MsgModel msg = new MsgModel("100","192.168.1.122","192.168.1.122","","",terminalSettings.getVoiceNumber().getBytes());
		String json = JSONUtils.obj2json(msg);
		MsgModel result=  ApmUtils.httpNeetyRequest(json);
	}
	
	
	/**
	 * 设置终端开机/关机/重启命令
	 * @param terminalSettings
	 * @throws Exception 
	 */
	@Transactional(rollbackFor=Exception.class)
	public String sendTerminalStatusReq2Netty(Terminal terminal,String type){
		//1.修改数据库中音量值
		Terminal t = terminalService.get(terminal.getId());
		t.setStatus(terminal.getStatus());
		terminalService.save(t);
		//2.向netty发送命令
		MsgModel msg = null;
		if(String.valueOf(NettyCommand.SEND_MSG_SHUTDOWN_TERMINAL).equals(type)){  //关机
			msg = new MsgModel(String.valueOf(NettyCommand.SEND_MSG_SHUTDOWN_TERMINAL),"192.168.1.122",terminal.getName(),"","","".getBytes());
		}else if(String.valueOf(NettyCommand.SEND_MSG_RESTART_TERMINAL).equals(type)){  //重启
			msg = new MsgModel(String.valueOf(NettyCommand.SEND_MSG_RESTART_TERMINAL),"192.168.1.122",terminal.getName(),"","","".getBytes());
		}else if(String.valueOf(NettyCommand.SEND_MSG_START_TERMINAL).equals(type)){  //开机
			msg = new MsgModel(String.valueOf(NettyCommand.SEND_MSG_START_TERMINAL),"192.168.1.122",terminal.getName(),"","","".getBytes());
		}
		MsgModel result = null;
		try{
			String json = JSONUtils.obj2json(msg);
			result = ApmUtils.httpNeetyRequest(json);
		}catch(Exception e){
			e.printStackTrace();
			return "failed";
		}
		return new String(result.getData());
	}
	
	/**
	 * 向终端发送截屏指令
	 * @param terminal
	 * @throws Exception 
	 */
	public String sendScreenShootReq2Netty(Terminal terminal) throws Exception {
		terminal = terminalService.get(terminal.getId());	//获取终端
		MsgModel msg = new MsgModel(String.valueOf(NettyCommand.SEND_MSG_REQUEST_CAPTURE),"192.168.1.122",terminal.getName(),"","","".getBytes());//建立消息模型
		String json = JSONUtils.obj2json(msg);
		MsgModel result = ApmUtils.httpNeetyRequest(json);
		return new String(result.getData());
	}

	/**
	 * 向netty请求终端的信息
	 * @param terminal
	 * @return 返回TerminalInfo对象
	 * @throws Exception 
	 */
	public TerminalInfo sendTerminalInfoReq2Netty(Terminal terminal) throws Exception {
		if(terminal == null || terminal.getId() == null){	//获取任意一个终端
			terminal = terminalService.findAll(Users.currentUser().getCompany().getId()).get(0);
		}else{
			terminal = terminalService.get(terminal.getId());	//获取终端
		}
		MsgModel msg = new MsgModel(String.valueOf(NettyCommand.SEND_MSG_REQUEST_TERMINALINFO),"192.168.1.122",terminal.getName(),"","","".getBytes());//建立消息模型
		String json = JSONUtils.obj2json(msg);
		TerminalInfo info = null;
		try{
			MsgModel result = ApmUtils.httpNeetyRequest(json);
			info = JSONUtils.json2pojo(new String(result.getData()), TerminalInfo.class);
			if(info != null){
				if("0".equals(info.getStatus())){
					info.setStatus("离线");
				}else if("1".equals(info.getStatus())){
					info.setStatus("在线");
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("连接netty出错！！");
			return null;
		}
		return info;
	}
	
	/**
	 * 获取终端当天工作时间
	 * @param terminal
	 * @return
	 */
	public List<String> findWorkTime(Terminal terminal) {
		List<String> times = Lists.newArrayList();
		//1.termnal开关模式
		SimpleDateFormat sft = new SimpleDateFormat("HH:mm");
		String onOffMode = terminal.getOnOffModeFlag();	//开关模式
		String switchMode = terminal.getSwitchModeFlag();	//开关定时模式
		if("0".equals(onOffMode)){			//每天
			if("0".equals(switchMode)){			//常开00
				Calendar todayStart = Calendar.getInstance();  
		        todayStart.set(Calendar.HOUR_OF_DAY, 0);  
		        todayStart.set(Calendar.MINUTE, 0);  
		        todayStart.set(Calendar.SECOND, 0);  
		        todayStart.set(Calendar.MILLISECOND, 0);  
		        Date s = todayStart.getTime();
		        
		        Calendar todayEnd = Calendar.getInstance();  
		        todayEnd.set(Calendar.HOUR_OF_DAY, 23);  
		        todayEnd.set(Calendar.MINUTE, 59);  
		        todayEnd.set(Calendar.SECOND, 59);  
		        todayEnd.set(Calendar.MILLISECOND, 999);   
		        Date e = todayEnd.getTime();
				times.add(sft.format(s)+"-" + sft.format(e));
			}else if("1".equals(switchMode)){		//定时01
				List<TerminalSettings> settings = dao.findWorkTimes(terminal.getId(),switchMode);
				if(settings != null){
					for(int i = 0 ; i < settings.size() ; i+=2){
						times.add(sft.format(sft.format(settings.get(i).getOnOffSTime()) +"-" +sft.format(settings.get(i).getOnOffETime())));//起始时间
					}
				}
			}
		}else if("1".equals(onOffMode)){	//星期模式
			if("1".equals(switchMode)){			//定时11
				int week =  Calendar.getInstance().get(Calendar.DAY_OF_WEEK); //获取星期字段
				List<TerminalSettings> settings = dao.findWorkTimes(terminal.getId(),switchMode,String.valueOf(week));//获取当天的星期模式下的工作时间
				if(settings != null){
					for(int i = 0 ; i < settings.size() ; i+=2){
						times.add(sft.format(sft.format(settings.get(i).getOnOffSTime()) +"-" +sft.format(settings.get(i).getOnOffETime())));//起始时间
					}
				}
			}
		}
		return times;
	}

	/**
	 *获取终端所有截图
	 * @param terminal
	 */
	public List<FileInfosa>  findScreenShoots(Terminal terminal) {
		System.out.println("==========获取终端所有截屏===========");
		String dicValue = ApmUtils.getDictValue("screen_shoot");
		List<FileInfosa> fs = fileInfosaService.findScreenShoot(dicValue,"%" + terminal.getId() + "%");
		for(int i = 0 ; i < fs.size(); i++){
			FileInfosa f =fs.get(i);
			f.setPath(ApmUtils.downLoadPath(f.getPath()));
		}
		return fs;
	}
	
	/**
	 * 获取终端截屏
	 * @param terminalId
	 * @return
	 */
	public String getScreenShoot(String terminalId,String time) {
		System.out.println("==========获取实时截屏===========");
		String dicValue = ApmUtils.getDictValue("screen_shoot");
		Date date = new Date(Long.valueOf(time));
		List<FileInfosa> fs = fileInfosaService.findScreenShoot(dicValue,"%" + terminalId + "%",date);
		if(fs.size() == 0){
			return null;
		}
		FileInfosa f = fs.get(0); //最新截屏
		return ApmUtils.downLoadPath(f.getPath());
	}
	
	/**
	 * 查询终端截屏时间
	 * @param terminalId
	 * @return
	 */
	public List<TerminalSettings> findScreenShootTimes(String terminalId){
		return dao.findScreenShootTimes(terminalId);
	}
	
	/**
	 * 保存并更改终端截屏时间
	 * @param ss截屏时间
	 * @param terminalIds 终端ID集合
	 * @param 是否定时截屏
	 * @throws Exception 
	 */
	@Transactional(rollbackFor=Exception.class)
	public String saveScreenShootTimes(List<ScreenShootTime> ss,List<String> terminalIds) throws Exception{
		List<TerminalSettings> settings = new ArrayList<>();//所有设置
		if(terminalIds != null && terminalIds.size() > 0){
			if(!validScreenTime(ss)){	//校验截屏时间并排序
				return "failed";
			}
			for(String id : terminalIds){
				Terminal t = terminalService.get(id);
				for(ScreenShootTime time : ss){
					TerminalSettings s = new TerminalSettings();
					s.setDelFlag(time.getChecked());
					s.setFixedTime(time.getTime());
					s.setTerminal(t);
					settings.add(s);
				}
			}
		}
		if(settings.size() == 0){
			return "failed";
		}
		dao.deleteScreenShootTimes(terminalIds);//删除原值
		dao.save(settings);
		/*for(String id : terminalIds){
			List<TerminalSettings> settings = dao.findScreenShootTimes(id);
			int i = 0 ;
			int len = settings.size();
			for(; i < ss.size() ; i++){
				ScreenShootTime time = ss.get(i);
				if(i>len-1){  //直接插入
					if(StringUtils.isNotEmpty(time.getTime()) && StringUtils.isNotEmpty(time.getChecked())){
						TerminalSettings setting  = new TerminalSettings();
						setting.setFixedTime(time.getTime());
						setting.setTerminal(terminalService.get(terminalIds.get(0)));
						dao.save(setting);
					}
					continue;
				}
				TerminalSettings setting = settings.get(i);
				if(StringUtils.isNotEmpty(time.getTime())){
					if(!setting.getFixedTime().equals(time.getTime())){  //时间不同
						setting.setFixedTime(time.getTime());
					}
					if(StringUtils.isNotEmpty(time.getChecked()) && TerminalSettings.DEL_FLAG_DELETE.equals(setting.getDelFlag())){//checked : 0 （ 选中-删除标志)
						setting.setDelFlag(TerminalSettings.DEL_FLAG_NORMAL);
					}else if(StringUtils.isEmpty(time.getChecked()) && TerminalSettings.DEL_FLAG_NORMAL.equals(setting.getDelFlag())){ //null : 1 (不选中-未删除标志)
						setting.setDelFlag(TerminalSettings.DEL_FLAG_DELETE);
					}
					dao.save(setting);  //修改截屏时间
				}
			}
		}
		settings = dao.findScreenShootTimes(id);
		StringBuffer times = new StringBuffer();
		for(TerminalSettings tmp : settings){
			if(tmp.getDelFlag().equals(TerminalSettings.DEL_FLAG_NORMAL)){
				times.append(tmp.getFixedTime());
			}
		}
		MsgModel model = new MsgModel(String.valueOf(NettyCommand.SEND_MSG_SCREENSHOOT_TIMES_TERMINAL),"192.168.1.122","192.168.1.122","","",times.toString().getBytes());
		MsgModel result = ApmUtils.httpNeetyRequest(JSONUtils.obj2json(model));
		
		return new String(result.getData());*/
		return "ok";
	}

	/**
	 * 保存开关机时间
	 * @param terminalIds 终端ID
	 * @param mode 开关机模式 （0：每天，1：星期模式）
	 * @param modeSwitch 开关机控制（0：常开，1：定时）
	 * @param workTimes 每天模式下的时间
	 * @param times 	星期模式下的时间
	 * @return
	 */
	@Transactional(rollbackFor=Exception.class)
	public String saveOnOffModeTimes(List<String> terminalIds,String mode, String modeSwitch,
			List<OnOffModeTime> everyDayModeWorkTimes, List<List<OnOffModeTime>> weekModeWorkTimes) {
		List<TerminalSettings> settings = new ArrayList<>();
		if(terminalIds != null && terminalIds.size() > 0){
			for(String id : terminalIds){
				Terminal t = terminalService.get(id);
				if("0".equals(mode) && "0".equals(modeSwitch)){						//00(每天-常开)  mode_flag = 0
						TerminalSettings stmp = new TerminalSettings();
						stmp.setModeFlag(modeSwitch);
						stmp.setTerminal(t);
						settings.add(stmp);
				}else if("0".equals(mode) && "1".equals(modeSwitch)){				//01(每天-定时)  mode_flag = 1 && week_flag = null
					//1.校验工作时间并排序
					if(!validWorkTime(everyDayModeWorkTimes)){
						return "failed";
					}
					for(OnOffModeTime time : everyDayModeWorkTimes){
						String st = time.getStime();
						String et = time.getEtime();
						String checked = time.getChecked();
						if(StringUtils.isNotEmpty(st) && StringUtils.isNotEmpty(et) && st.compareTo(et) < 0){
							TerminalSettings stmp = new TerminalSettings();
							stmp.setDelFlag(checked);
							stmp.setOnOffSTime(st);
							stmp.setOnOffETime(et);
							stmp.setModeFlag(modeSwitch);
							stmp.setTerminal(t);
							settings.add(stmp);
						}
					}
				}else if("1".equals(mode) && "1".equals(modeSwitch)){				//11（星期模式-定时）mode_flag = 1 && week_flag =1-7
					if(weekModeWorkTimes == null || weekModeWorkTimes.size() == 0){
						return "failed";
					}
					for(List<OnOffModeTime> workTimes : weekModeWorkTimes){		//星期一到星期日一次校验保存
						//1.校验工作时间并排序
						if(!validWorkTime(workTimes)){
							return "failed";
						}
						for(OnOffModeTime time : workTimes){
							String st = time.getStime();
							String et = time.getEtime();
							String checked = time.getChecked();
							if(StringUtils.isNotEmpty(st) && StringUtils.isNotEmpty(et) && st.compareTo(et) < 0){
								TerminalSettings stmp = new TerminalSettings();
								stmp.setDelFlag(checked);
								stmp.setOnOffSTime(st);
								stmp.setOnOffETime(et);
								stmp.setModeFlag(modeSwitch);
								stmp.setWeekFlag(time.getWeek());
								stmp.setTerminal(t);
								settings.add(stmp);
							}
						}
					}
				}
			}
		}
		if(settings.size() == 0){
			System.out.println("没有值");
			return "failed";
		}
		//删除选中的所有终端工作时间设置
		dao.deleteWorkdTimes(terminalIds);
		dao.save(settings);
		//向netty发送定时开关机命令
		return "ok";
	}
	
	/**
	 * 校验时间,去掉空的起始时间并且排序
	 * @return
	 */
	public boolean validWorkTime(List<OnOffModeTime> workTimes){
		if(workTimes == null){
			return false;
		}
		//1.判断是否有空,2个时间都为空，则在集合中删除
		Iterator<OnOffModeTime> it = workTimes.iterator();
		while(it.hasNext()){
			OnOffModeTime time = it.next();
			String st = time.getStime();
			String et = time.getEtime();
			String checked = time.getChecked();
			if(("1".equals(checked))&&((StringUtils.isEmpty(st) && !StringUtils.isEmpty(et))
					||(!StringUtils.isEmpty(st)&& StringUtils.isEmpty(et)) 
					||(StringUtils.isNotEmpty(st)&& StringUtils.isNotEmpty(et) && st.compareTo(et) == 0))){  //2者有一个为空且是打开状态
				System.out.println("（存在空的时间或者前后时间一样）并且打开状态");
				return false;
			}else if(("0".equals(time.getChecked()))&&(StringUtils.isEmpty(time.getStime()) || StringUtils.isEmpty(time.getEtime())
					||(StringUtils.isNotEmpty(st)&& StringUtils.isNotEmpty(et) && st.compareTo(et) == 0))){  //关闭状态且（2个时间任意一个为空或两个时间相等）
				it.remove();
			}
		}
		//2.判断2个时间是否有交叉
		for(int i = 0 ; i < workTimes.size() ; i++){
			for(int j = i+1 ; j < workTimes.size() ; j++){
				OnOffModeTime time1 = workTimes.get(i);
				OnOffModeTime time2 = workTimes.get(j);
				String s1 = time1.getStime();
				String e1 = time1.getEtime();
				String s2 = time2.getStime();
				String e2 = time2.getEtime();
				if(("1".equals(time1.getChecked()) && "1".equals(time2.getChecked()))&&((s2.compareTo(s1) >= 0 && s2.compareTo(e1) < 0 )|| (e2.compareTo(s1) > 0 && e2.compareTo(e1) <= 0)
						||(s1.compareTo(s2) >= 0 && s1.compareTo(e2) < 0 )|| (e1.compareTo(s2) > 0 && e1.compareTo(e2)<=0))){  //两段时间都打开多个起始时间有交叉 (t1<= t2<e1 || t1<e2<=e1)||    t2<= t1<e2 || t2<e1<=e2)||                                           
					System.out.println("时间有交叉并且时间都打开");
					return false;
				}
			}
		}
		//3.排序
		Collections.sort(workTimes, new SeveralTimeComparator());
		return true;
	}
	
	
	/**
	 * 校验定时截屏时间
	 * @param ss
	 * @return
	 */
	private boolean validScreenTime(List<ScreenShootTime> ss) {
		if(ss == null || ss.size() == 0){
			return false;
		}
		//判断是否有空则在集合中删除
		Iterator<ScreenShootTime> it = ss.iterator();
		while(it.hasNext()){
			ScreenShootTime time = it.next();
			if(StringUtils.isEmpty(time.getTime())){
				it.remove();
			}
		}
		if(ss.size() == 0){
			return false;
		}
		return true;
	}

}
