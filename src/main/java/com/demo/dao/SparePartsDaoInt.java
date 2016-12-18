package com.demo.dao;


import com.demo.model.Spare;

public interface SparePartsDaoInt {
	
	public String saveSpareparts(Spare spareParts);
	public Spare getSparePartBySerial(String serialNum);
	public String updateSpareParts(Spare spareParts);

}
