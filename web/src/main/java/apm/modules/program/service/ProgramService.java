package apm.modules.program.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import apm.common.core.Page;
import apm.common.service.BaseService;
import apm.common.utils.Md5Utils;
import apm.common.utils.StringUtils;

import apm.modules.program.entity.Program;
import apm.modules.program.dao.ProgramDao;
import apm.modules.program.dao.PublishProgramDao;
import apm.modules.sys.support.Users;
import apm.modules.terminal.dao.TerminalDao;

import org.apache.lucene.index.Term;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.TermQuery;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 节目实体类Service
 * @author gfp
 * @version 2015-08-17
 */
@Service
@Transactional(readOnly = true)
public class ProgramService extends BaseService<ProgramDao, Program> {

	//注入其他的Dao层或本层
	@Autowired
	private ProgramDao programDao;
	@Autowired
	PublishProgramDao publishProgramDao;
	@Autowired
	TerminalDao terminalDao;
	//查找所有节目实体类(未删除)的记录
	public List<Program> findAll() {
		return dao.findAll();
	}
	
	//节目实体类列表多条件查询，分页
	public Page<Program> find(Page<Program> page, Program program) {
		System.out.println(program);
		DetachedCriteria dc = dao.createDetachedCriteria();
		if(program != null){
			List<String> tIds = null; //终端ids
			List<String> pIds = new ArrayList<String>();
			//获取存在该终端
			if(StringUtils.isNotBlank(program.gettName())){
				tIds = terminalDao.findIdByName("%" + program.gettName() + "%");
			}
			
			//获取发布列表id
			if(tIds != null && tIds.size() > 0){
				for(String str : tIds){
					if(StringUtils.isNotBlank(str)){
						pIds.addAll(publishProgramDao.findByTerminalId("%" + str + "%"));
					}
				}
			}
			
			if(pIds != null && pIds.size() > 0){
				dc.add(Restrictions.in("id", pIds));
			}
			
			if (StringUtils.isNotEmpty(program.getName())){
				dc.add(Restrictions.like("name", "%"+program.getName()+"%"));
			}
			
			if(StringUtils.isNotBlank(program.getType())){
				if("0".equals(program.getType())){
					dc.add(Restrictions.eq("createBy.id", Users.currentUser().getId()));
				}
			}
		}
		dc.add(Restrictions.eq(Program.DEL_FLAG, Program.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("createDate"));
		return dao.find(page, dc);
	}
	
	//保存节目实体类信息
	@Transactional(readOnly = false)
	public void save(Program program) {
		dao.clear();
		dao.save(program);
	}
	
	//删除节目实体类信息：逻辑删除 、通过ID号删除
	@Transactional(readOnly = false)
	public void delete(String id) {
		dao.deleteById(id);
	}
	 
	//保存节目
	@Transactional(readOnly = false)
	public Program saveProgram(HttpServletRequest req, Program program){
		 /*//节目名
		 String pName = req.getParameter("pName");
		 //广告商
		 String ad = req.getParameter("advertiser");*/
		 //宽
		 String width = req.getParameter("width"); 
		 //高
		 String height = req.getParameter("height");
		/* //保存一份完整的html代码,方便下次重新编辑
		 String reEditHtml = req.getParameter("saveDom"); */
		 //预览的所有场景,按得到的顺序进行通过用节目名的MD5为切割符来保存
		 String [] preHtml = req.getParameterValues("htmlInput");
		 //System.out.println("reEditHtml ------" + reEditHtml);
		 //System.out.println("preHtml ------" + preHtml);
		 StringBuilder sb = new StringBuilder();
		 sb.setLength(0);
		 if(preHtml != null && preHtml.length > 0){
			 //节目名的MD5值
			 String splitMd5 = Md5Utils.hash(program.getName());
			 //System.out.println(splitMd5);
			 for(String str : preHtml){
				 sb.append(sb.length() == 0?str : splitMd5 + str);
			 }
		 }
		 //System.out.println("preHtml2 ---------"+sb.toString());
		/* Program p = new Program();
		 p.setAdvertiserId(ad);
		 p.setName(pName);
		 p.setEditHtml(reEditHtml);
		 p.setPreHtml(sb.toString());
		 */
		 //预览
		 program.setPreHtml(sb.toString());
		 program.setOffice(Users.currentUser().getOffice());
		 program.setRatio(width + "*" + height);
		 return dao.save(program);
	}
}
