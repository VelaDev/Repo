package com.demo.dao;


import com.demo.model.Parts;

public interface SparePartsDaoInt {
	
	public String saveSpareparts(Parts spareParts);
	public Parts getSparePartBySerial(String serialNum);
	public String updateSpareParts(Parts spareParts);

}
