package apm.modules.fileManage.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.ContentBody;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
/**
 * 与文件服务器交互的操作
 * 
 * @author hx
 *
 */
public class FileSystemUtil {
	/***
	 * 上传文件到文件服务器
	 * @param urlString
	 *            访问文件服务器的路径
	 * @param file
	 *            要上传的文件
	 * @return
	 */
	public static String uploadFile(String urlString, File file) {
		HttpClient httpClient = new DefaultHttpClient();
		String result = null;
		try {
			HttpPost httpPost = new HttpPost(urlString);
			MultipartEntity mpEntity = new MultipartEntity();
			ContentBody cbFBody = new FileBody(file,
					"application/octet-stream", "utf-8");
			mpEntity.addPart("file", cbFBody);
			httpPost.setEntity(mpEntity);
			HttpResponse response = httpClient.execute(httpPost);
			result = EntityUtils.toString(response.getEntity(), "utf-8");
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			httpClient.getConnectionManager().shutdown();
		}
		if ("success".equals(result)) {
			file.delete();
		}	
		return result;
	}

	/**
	 * 从服务器下载文件
	 * 
	 * @param urlString
	 * @return
	 */
	public static InputStream downloadFile(String urlString) {
		HttpClient httpClient = new DefaultHttpClient();
		HttpGet httpGet = new HttpGet(urlString);
		InputStream in = null;
		try {
			HttpResponse response = httpClient.execute(httpGet);
			if (response.getStatusLine().getStatusCode() == 200) {
				HttpEntity entity = response.getEntity();
				in = entity.getContent();
			}
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return in;
	}
}
