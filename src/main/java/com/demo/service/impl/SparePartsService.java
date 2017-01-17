package com.demo.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.SparePartsDaoInt;
import com.demo.model.Spare;
import com.demo.service.SparePartsServeceInt;

@Service("sparePartsService")
public class SparePartsService implements SparePartsServeceInt{

	@Autowired
	private SparePartsDaoInt sparePartsDAO;
	
	private String retMessage = null;
	
	
	@Override
	public String saveSpareparts(Spare spareParts) {
		
		retMessage =sparePartsDAO.saveSpareparts(spareParts);
	    return retMessage;
	}


	@Override
	public Spare getSparePartBySerial(String serialNum) {
		
		return sparePartsDAO.getSparePartBySerial(serialNum);
	}


	@Override
	public List<Spare> getAllSpareParts() {
		return sparePartsDAO.getAllSpareParts();
	}

}
