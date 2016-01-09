package apm.modules.fileManage.web;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.security.MessageDigest;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import sun.misc.BASE64Encoder;
import apm.common.config.Global;
import apm.common.utils.ApmUtils;
import apm.modules.fileManage.entity.FileInfosa;
import apm.modules.fileManage.entity.FileManager;
/***
 * 
 * @author wq 上传文件、下载文件的过滤器
 */
public class FileFilter implements Filter {

	/**
	 * 生成24位的md5字符串,用于文件防盗链
	 * 
	 * @param targetStr
	 * @return
	 */
	private static String getMd5(String targetStr) {
		String str = null;
		MessageDigest md5;
		try {
			md5 = MessageDigest.getInstance("MD5");
			BASE64Encoder base64en = new BASE64Encoder();
			// 加密后的字符串
			str = base64en.encode(md5.digest(targetStr.getBytes("iso-8859-1")));
		} catch (Exception e) {
			e.printStackTrace();
		}
		str = str.substring(0, str.length() - 2);// java会多两个==号
		if (str.contains("+")) {// 不知道什么原因导致的，openssl生成的是‘-’号，而java生成'+'号
			str = str.replaceAll("[+]", "\\-");
		}
		if (str.contains("/")) {// ，openssl生成的是‘_’号，而java生成'/'号,而/不能出现在地址栏中，如果用urlencoding就不会出现/
			str = str.replaceAll("/", "_");
		}
		return str;
	}

	/**
	 * 文件下载重定向
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		//根据请求uri去获取文件
		String uri = req.getRequestURI();
		//转成utf-8
		uri = URLDecoder.decode(uri, "utf-8");
		//顶级目录
		FileManager f0 = ApmUtils.fileManagerService.findFirstFileId();
		//文件管理目录
		FileManager f1 = ApmUtils.fileManagerService.findFileManagerByPIds("0,"+f0.getId()+",");
		//取出apm_file之后的路径(包括apm_file)
		String prePath =  f1.getName() + uri.split(f1.getName())[1];
		String p =  req.getSession().getServletContext().getRealPath("/") + File.separator + prePath;
		File pF = new File(p.replace("/", File.separator).replace("\\", File.separator));
		if(!pF.exists()){
			//设置过期时间为10s, 以秒为单位(nginx规则), 超过该时间时则路径无效
			long e = System.currentTimeMillis()/1000 + 10;
			//MD5唯一值校验, 文件防盗链
			//去掉 '空格' 和  '#' '%'以及存在问题的特殊字符,用下划线代替
			prePath = prePath.replace(" ", "_").replace("#", "_").replace("%", "_").replace("`", "_").replace(",", "_").replace("，", "_").replace("&", "_").replace("\\", "/");
			String[] strs = prePath.split("/");
			String fileName = strs[strs.length-1];	//获取文件名
			String  s = "lango-/p/files" + fileName + e;
			//求出在文件服务器中的路径,未包括文件名
			String path = prePath.split("/" + fileName)[0];
//				String respUrl = Global.getServerIp() + "/p/files?st=" + getMd5(s) + "&e=" + e + "&fname="+ name + "&fpath=" + path;
			String respUrl = Global.getServerIp() + "/p/files?st=" + getMd5(s) + "&e=" + e + "&fname="+ fileName + "&fpath=" + path;
			resp.sendRedirect(URLDecoder.decode(respUrl, "utf-8"));
			return ;
		}
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}
