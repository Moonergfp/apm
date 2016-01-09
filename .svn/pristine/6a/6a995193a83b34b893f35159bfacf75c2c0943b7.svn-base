package apm.modules.sys.interceptor;

import org.aspectj.lang.ProceedingJoinPoint;

/** 
 * @author htd
 * @date 2014-3-18 上午10:07:23 
 */
public class LoggerIoc{
	private static String conClassName;
	private static String conMethodName;
	private static String serClassName;
	private static String serMethodName;
	public static String getConClassName() {
		return conClassName;
	}

	public static String getConMethodName() {
		return conMethodName;
	}

	public static String getSerClassName() {
		return serClassName;
	}

	public static String getSerMethodName() {
		return serMethodName;
	}
		//环绕通知
		public Object controller(ProceedingJoinPoint pjp) throws Throwable{
			//获取当前执行的controller的类
			String className = pjp.getTarget().getClass().getName();
			if (className!=null) {
				conClassName = className;
			}
			//获取当前执行的方法名
			String methodName = pjp.getSignature().getName();//方法名
			if (methodName!=null) {
				conMethodName = methodName;
			}
			//根据className.methodName去opt.properties
			//文件获取操作名
			String key = className+"."+methodName;
			Object obj =  pjp.proceed();//执行目标方法
			return obj;
		}
		
		//环绕通知
		public Object service(ProceedingJoinPoint pjp) throws Throwable{
			//获得service层的类
			String className = pjp.getTarget().getClass().getName();
			if (className!=null) {
				serClassName = className;
			}
			
			//获取当前执行的方法名
			String methodName = pjp.getSignature().getName();//方法名
			if (methodName!=null) {
				serMethodName = methodName;
			}
			
			Object obj =  pjp.proceed();//执行目标方法
			return obj;
		}
		
}
