package com.demo.service;


import com.demo.model.Spare;

public interface SparePartsServeceInt {
	public String saveSpareparts(Spare spareParts);
	public Spare getSparePartBySerial(String serialNum);

}
