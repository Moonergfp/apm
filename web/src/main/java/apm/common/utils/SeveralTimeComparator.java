package apm.common.utils;

import java.util.Comparator;

import apm.modules.terminal.entity.OnOffModeTime;

/**
 * 多个起始时间-结束时间比较器
 * @author admin
 *
 */
public class SeveralTimeComparator implements Comparator{
	
	private boolean flag;
	public int compare(Object o1, Object o2) {
		if(o1 instanceof OnOffModeTime && o2 instanceof OnOffModeTime){
			OnOffModeTime t1 = (OnOffModeTime)o1;
			OnOffModeTime t2 = (OnOffModeTime)o2;
			return t1.getStime().compareTo(t2.getStime());
		}
		
		return 0;
	}

}
