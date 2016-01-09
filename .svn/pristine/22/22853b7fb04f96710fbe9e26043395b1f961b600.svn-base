package apm.modules.fileManage.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.search.annotations.Analyzer;
import org.hibernate.search.annotations.Indexed;
import org.wltea.analyzer.lucene.IKAnalyzer;
import apm.common.core.TreeEntity;
import apm.common.utils.StringUtils;
/**
 * 文件目录管理类
 * @author wq
 *
 */
@Entity
@Table(name = "tbl_file_manage")
@DynamicInsert @DynamicUpdate
@Indexed @Analyzer(impl = IKAnalyzer.class)
public class FileManager extends TreeEntity<FileManager>{
	
		@Override
	public String toString() {
		return "FileManager [path=" + path + ", parent=" + parent
				+ ", parentIds=" + parentIds + ", id=" + id + "]";
	}

		private static final long serialVersionUID = 1L;
		private String path;//目录路径
		//private String tenandId; //公司id
		/*public String getTenandId() {
			return tenandId;
		}
		public void setTenandId(String tenandId) {
			this.tenandId = tenandId;
		}*/

		@Transient
		private Boolean childNodeFlag;//标识目录下是否有文件或者子目录
		@Transient
		private Boolean isCatalogFlag;//判断是文件还是目录
		
		@Transient
		public Boolean getChildNodeFlag() {
			return childNodeFlag;
		}
		@Transient
		public void setChildNodeFlag(Boolean childNodeFlag) {
			this.childNodeFlag = childNodeFlag;
		}
		
		@Transient
		public Boolean getIsCatalogFlag() {
			return isCatalogFlag;
		}
		@Transient
		public void setIsCatalogFlag(Boolean isCatalogFlag) {
			this.isCatalogFlag = isCatalogFlag;
		}
		public FileManager(){
			super();
			this.sort = 30;
		}
		
		public FileManager(String id){
			this();
			this.id = id;
		}

		@Transient
		public boolean isRoot(){
			return isRoot(this.id);
		}
		
		@Transient
		public static boolean isRoot(String id){
			return StringUtils.isNotEmpty(id) && id.equals("1");
		}

		public String getPath() {
			return path;
		}

		public void setPath(String path) {
			this.path = path;
		}
	}
