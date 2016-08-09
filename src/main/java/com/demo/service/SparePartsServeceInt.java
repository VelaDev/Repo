package com.demo.service;


import com.demo.model.Parts;

public interface SparePartsServeceInt {
	public String saveSpareparts(Parts spareParts);
	public Parts getSparePartBySerial(String serialNum);

}
