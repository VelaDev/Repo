package com.demo.service;

import java.util.List;

import com.demo.model.Compatibility;

public interface CompatibilityServiceInt {

	String saveCompitability(Compatibility compatibility );
	List<Compatibility> compitabilityList();
	List<Compatibility> compitabilityList(String parNumber);
}
