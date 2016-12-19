package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.CompatibilityDaoInt;
import com.demo.model.Compatibility;
import com.demo.service.CompatibilityServiceInt;


@Service("compitabilityService")
public class CompatibilityService implements CompatibilityServiceInt {

	@Autowired
	private CompatibilityDaoInt compatibilityDaoInt;
	private String retMessage = null;
	@Override
	public String saveCompitability(Compatibility compatibility) {
		
		retMessage = compatibilityDaoInt.saveCompitability(compatibility);
		return retMessage;
	}

	@Override
	public List<Compatibility> compitabilityList() {

		return compatibilityDaoInt.compitabilityList();
	}

	@Override
	public List<Compatibility> compitabilityList(String parNumber) {
		return compatibilityDaoInt.compitabilityList(parNumber);
	}

}
