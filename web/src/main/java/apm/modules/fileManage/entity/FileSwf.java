package apm.modules.fileManage.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import apm.common.core.BaseEntity;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.search.annotations.Analyzer;
import org.hibernate.search.annotations.Indexed;
import org.wltea.analyzer.lucene.IKAnalyzer;

/**
 * 文件swf
 * @author wq
 *
 */
@Entity
@Table(name = "tbl_file_swf")
@DynamicInsert @DynamicUpdate
@Indexed @Analyzer(impl = IKAnalyzer.class)
public class FileSwf extends BaseEntity{
		private static final long serialVersionUID = 1L;
		private String name;		//swf文件名
		private String path;		//路径
		public FileSwf() {
		}
		public FileSwf(String id){
			this();
			this.id = id;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getPath() {
			return path;
		}
		public void setPath(String path) {
			this.path = path;
		}
	}
