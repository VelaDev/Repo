package com.demo.dao;

import java.util.List;

import com.demo.model.Compitability;

public interface CompitabilityDaoInt {
	
	String saveCompitability(Compitability compitability );
	List<Compitability> compitabilityList();
	List<Compitability> compitabilityList(String parNumber);

}