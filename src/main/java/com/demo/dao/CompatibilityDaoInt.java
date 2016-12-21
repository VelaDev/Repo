package com.demo.dao;

import java.util.List;

import com.demo.bean.CompatibilityBean;
import com.demo.model.Compatibility;

public interface CompatibilityDaoInt {
	
	String saveCompitability(CompatibilityBean compatibility );
	List<Compatibility> compitabilityList();
	List<Compatibility> compitabilityList(String parNumber);

}
