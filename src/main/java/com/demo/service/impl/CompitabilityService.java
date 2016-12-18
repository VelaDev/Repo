package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.CompitabilityDaoInt;
import com.demo.model.Compitability;
import com.demo.service.CompitabilityServiceInt;


@Service("compitabilityService")
public class CompitabilityService implements CompitabilityServiceInt {

	@Autowired
	private CompitabilityDaoInt compitabilityDaoInt;
	private String retMessage = null;
	@Override
	public String saveCompitability(Compitability compitability) {
		
		retMessage = compitabilityDaoInt.saveCompitability(compitability);
		return retMessage;
	}

	@Override
	public List<Compitability> compitabilityList() {

		return compitabilityDaoInt.compitabilityList();
	}

	@Override
	public List<Compitability> compitabilityList(String parNumber) {
		return compitabilityDaoInt.compitabilityList(parNumber);
	}

}
