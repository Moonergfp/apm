package apm.generate;


/** 
 * @author 何堂冬
 * @date 2014-6-5 下午9:57:12 
 */
public class Parameters {
	
	public static void main(String[] args) throws Exception {
		Generate generate  = new Generate();
		// ========== ↓↓↓↓↓↓ 执行前请修改参数，谨慎执行。↓↓↓↓↓↓ ====================
		// 主要提供基本功能模块代码生成。
		// 目录生成结构：{packageName}/{moduleName}/{dao,entity,service,web}/{subModuleName}/{className}
		// 当然此处必须满足的是JAVA代码存放的模块名必须和JSP页面存放的包名相同，如果不同需手动调整。
		
		String packageName = "apm.modules";//保存在包名
		String moduleName = "powerSource";			//模块名，例：test
		String className = "MyUser";			// 类名，例：test
		String classAuthor = "gfp";			// 类作者，例：ThinkGem
		String functionName = "测试用户类";			//功能名，例：用户
		String tableName ="tbl_power_test_report";//对应的表名
		String flag = "";//指定要生成的文件 多文件用,隔开   entity,dao,service,controler,list,form 空默认生成全部
		//处理实体的相关字段，返回一个字符串
		String columns =  Tool.dealWith("code.properties");
		if(columns.indexOf("出错了，长度不匹配")!=-1){
			System.out.println(columns.substring(5, columns.length()));
		}else{
			System.out.println("entity:\n"+columns);
			generate.parameters(packageName, moduleName, className, classAuthor, functionName,tableName,columns,flag);
		}
	}
	
}
