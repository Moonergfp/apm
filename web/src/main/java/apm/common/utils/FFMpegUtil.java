package apm.common.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import apm.common.config.Global;

/**
 * FFMpegUntil
 * <p>
 * Title: FFMpeg工具类
 * </p>
 * <p>
 * Description: 本类封装FFMpeg对视频的操作
 * </p>
 * <p>
 * Date: 2015-09-06
 * </p>
 * <p>
 * Copyright: Copyright (c) 2010
 * </p>
 * <p>
 * Company: novel-supertv.com
 * </p>
 * 
 * @author wq
 * @version 1.0
 */
public class FFMpegUtil{

	private static int runtime = 0;
	private static String ffmpegUri = Global.getConfig("FFMPEG_PATH");// ffmpeg地址
	
	private static List<String> cmd = new ArrayList<String>();
	private static boolean isSupported;
	private enum FFMpegUtilStatus {
		Empty, CheckingFile, GettingRuntime
	};

	private static FFMpegUtilStatus status = FFMpegUtilStatus.Empty;
	/**
	 * 获取视频时长
	 * 
	 * @return
	 */
	public static int getRuntime(String originFileUri) {
		runtime = 0;
		status = FFMpegUtilStatus.GettingRuntime;
		cmd.clear();
		cmd.add(ffmpegUri);
		cmd.add("-i");
		cmd.add(originFileUri);
	    exec(cmd);
	    System.out.println(runtime);
		return runtime;
	}

	/**
	 * 检测文件是否是支持的格式 将检测视频文件本身，而不是扩展名
	 * 
	 * @return
	 */
	public boolean isSupported(String originFileUri) {
		isSupported = false;
		status = FFMpegUtilStatus.CheckingFile;
		cmd.clear();
		cmd.add(ffmpegUri);
		cmd.add("-i");
		cmd.add(originFileUri);
		cmd.add("Duration: (.*?), start: (.*?), bitrate: (\\d*) kb\\/s");
		exec(cmd);
		return isSupported;
	}

	/**
	 * 生成视频截图
	 * 
	 * @param imageSavePath
	 *            截图文件保存全路径
	 * @param screenSize
	 *            截图大小 如640x480
	 */
	public static boolean makeScreenCut(String imageSavePath, String screenSize, String originFileUri) {
		File file = new File(originFileUri);
		if (!file.exists()) {
			System.out.println("路径[" + originFileUri + "]对应的视频文件不存在!");
			return false;
		}
		cmd.clear();
		cmd.add(ffmpegUri);
		cmd.add("-i");
		cmd.add(originFileUri);
		cmd.add("-y");
		cmd.add("-f");
		cmd.add("image2");
		cmd.add("-ss");
		cmd.add("2");
		cmd.add("-t");
		cmd.add("0.001");
		cmd.add("-s");
		cmd.add(screenSize);
		cmd.add(imageSavePath);
		exec(cmd);
		return true;
	}

	public static void dealString(String str) {
		System.out.println("str ---------"+str);
		switch (status) {
		case Empty:
			break;
		case CheckingFile: {
			if (-1 != str.indexOf("Metadata:"))
				 isSupported = true;
			break;
		}
		case GettingRuntime: {
			if(str.contains("Duration")){
				System.out.println("时间:"+str.substring(str.indexOf(":")+1,str.indexOf(",")));
				String tStr = str.substring(str.indexOf(":")+1,str.indexOf(","));
				SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
				try {
					//获取秒数
					Calendar cal = Calendar.getInstance();
					System.out.println(sdf.parse(tStr));
					cal.setTime(sdf.parse(tStr));
					runtime = (cal.get(Calendar.HOUR) * 3600) + (cal.get(Calendar.MINUTE) * 60) + cal.get(Calendar.SECOND);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			Matcher m = Pattern.compile("Duration").matcher(str);
			while (m.find()) {
				String msg = m.group();
				System.out.println("msg ------"+msg);
				msg = msg.replace("Duration: ", "");
				//runtime = TimeUtil.runtimeToSecond(msg);
			}
			break;
		 }
		}// switch
	}
	
	 /** 
     * 执行指令 
     * @param cmd 执行指令 
     * @param getter 指令返回处理接口，若为null则不处理输出 
     */  
     public static  void exec(List<String> cmd){  
        try {  
            ProcessBuilder builder = new ProcessBuilder();    
            builder.command(cmd);  
            builder.redirectErrorStream(true);  
            Process proc = builder.start();  
            BufferedReader stdout = new BufferedReader(  
                    new InputStreamReader(proc.getInputStream()));  
            String line;  
            while ((line = stdout.readLine()) != null) {  
                     dealString(line);  
            }  
            proc.waitFor();     
            stdout.close();  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
}