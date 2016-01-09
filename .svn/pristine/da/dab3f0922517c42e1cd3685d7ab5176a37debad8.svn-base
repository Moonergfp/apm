package apm.generate;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

import apm.common.utils.PropertiesLoader;

import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.DefaultResourceLoader;

/** 
 * @author 何堂冬
 * @date 2014-08-23 下午9:57:12 
 */
public class Tool {

	
	public static String dealWith(String resourcesPaths) throws IOException {
		
		PropertiesLoader properties = new PropertiesLoader(resourcesPaths);
		properties.getProperties();
		String[] nameC = properties.getValue("nameC").split(",");
		String[] nameE = properties.getValue("nameE").split(",");
		String[] javaType = properties.getValue("javaType").split(",");
		//String[] tableType = properties.getValue("tableType").split(",");
		String[] length = properties.getValue("length").split(",");
		String[] nullAble = properties.getValue("nullAble").split(",");
		
		System.out.println("nameC=="+nameC.length+" nameE==="+nameE.length+" javaType=="+javaType.length+" length==="+length.length+"  ullAble==="+nullAble.length);
		int t = nameC.length;
		if((nameE.length !=t || javaType.length !=t || length.length !=t || nullAble.length !=t)){
			return "出错了，长度不匹配，温馨提示：\n请检查code.properties设置的字段是否对称  \n请检查设置的值中是否包含了“,”";
		}
		
		//将设置的字段中包含有Mysql关键字重命名或返回 load-》load_key
		for (int i = 0; i < nameE.length; i++) {
			String newName = checkandreName(nameE[i]);
			if(newName!=null&&!("".equals(newName))){
				nameE[i] = newName;
			}
		}
		
		StringBuffer columns = new StringBuffer();
		StringBuffer getAndSet = new StringBuffer();
		try {
			for (int i = 0; i < nullAble.length; i++) {
				String dataName = nameE[i];
				String upName = "";
				if(dataName.indexOf("_")!=-1){
					String[] data = dataName.split("_");
					for (int j = 0; j < data.length; j++) {
						if(j==0){
							dataName = data[j];
						}else{
							dataName = dataName+data[j].replaceFirst(data[j].substring(0, 1), data[j].substring(0, 1).toUpperCase());
						}
					}
					upName = dataName.replaceFirst(dataName.substring(0, 1), dataName.substring(0, 1).toUpperCase());
				}else{
					upName = nameE[i].replaceFirst(nameE[i].substring(0, 1), nameE[i].substring(0, 1).toUpperCase());
				}
				
				String leng = "0".equals(length[i])?"":"length = "+length[i]+",";
				//String def = "0".equals(tableType[i])?"":"columnDefinition = \""+tableType[i]+"\",";
				
				columns.append("private "+javaType[i]+" "+dataName+";//"+nameC[i]+"\n	");
				
				getAndSet.append("@Column(name = \""+nameE[i]+"\", "+leng+" nullable = "+nullAble[i]+")"+"\n");
				getAndSet.append("	public "+javaType[i]+" get"+upName+"() {"+"\n"+"			return "+dataName+";"+"\n"+"	}"+"\n");
				getAndSet.append("	public void set"+upName+"("+javaType[i]+" "+dataName+") {"+"\n"+"			this."+dataName+" = "+dataName+";"+"\n"+"	}"+"\n\n	");
				
			}
			
		} catch (Exception e) {
			System.err.println("出错了，温馨提示：\n请检查code.properties设置的字段是否对称  \n请检查设置的值中是否包含了“,”");
			e.printStackTrace();
		}
		
		return columns.toString()+"##"+getAndSet.toString();
	}
	
	public static String checkandreName(String nameE) throws IOException { 
		String newName = "";
		// 获取文件分隔符
		String separator = File.separator;
		// 获取工程路径
		File projectPath = new DefaultResourceLoader().getResource("").getFile();
		while(!new File(projectPath.getPath()+separator+"src"+separator+"main").exists()){
			projectPath = projectPath.getParentFile();
		}
		String filePath = StringUtils.replace(projectPath+"/src/main/java/apm/generate/", "/", separator);
		String mySqlKeyPath=filePath+"mySqlkey.txt";
		File file =new File(mySqlKeyPath);
		BufferedReader bufReader =null;
		try {
			//把文件读到StringBuffer中缓存起来
			bufReader = new BufferedReader(
					new InputStreamReader(new FileInputStream(file)));
			String tmp = null;
			while ((tmp = bufReader.readLine()) != null) {
				if(nameE.equalsIgnoreCase(tmp)){
					newName = nameE+"_key";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(bufReader!=null){
				bufReader.close();
			}
		}
		return newName;
	}
}
