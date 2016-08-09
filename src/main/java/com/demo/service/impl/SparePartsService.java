package com.demo.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.SparePartsDaoInt;
import com.demo.model.Parts;
import com.demo.service.SparePartsServeceInt;

@Service("sparePartsService")
public class SparePartsService implements SparePartsServeceInt{

	@Autowired
	private SparePartsDaoInt sparePartsDAO;
	
	private String retMessage = null;
	
	
	@Override
	public String saveSpareparts(Parts spareParts) {
		
		retMessage =sparePartsDAO.saveSpareparts(spareParts);
	    return retMessage;
	}


	@Override
	public Parts getSparePartBySerial(String serialNum) {
		
		return sparePartsDAO.getSparePartBySerial(serialNum);
	}

}
