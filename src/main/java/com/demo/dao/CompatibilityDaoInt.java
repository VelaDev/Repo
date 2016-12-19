package com.demo.dao;

import java.util.List;

import com.demo.model.Compatibility;

public interface CompatibilityDaoInt {
	
	String saveCompitability(Compatibility compatibility );
	List<Compatibility> compitabilityList();
	List<Compatibility> compitabilityList(String parNumber);

}
