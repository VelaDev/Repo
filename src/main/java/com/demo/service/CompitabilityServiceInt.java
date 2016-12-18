package com.demo.service;

import java.util.List;

import com.demo.model.Compitability;

public interface CompitabilityServiceInt {

	String saveCompitability(Compitability compitability );
	List<Compitability> compitabilityList();
	List<Compitability> compitabilityList(String parNumber);
}
