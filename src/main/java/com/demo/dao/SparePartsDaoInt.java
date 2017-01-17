package com.demo.dao;


import java.util.List;

import com.demo.model.Spare;

public interface SparePartsDaoInt {
	
	public String saveSpareparts(Spare spareParts);
	public Spare getSparePartBySerial(String serialNum);
	public String updateSpareParts(Spare spareParts);
	public List<Spare> getAllSpareParts();

}
