package com.demo.service;


import java.util.List;

import com.demo.model.Spare;

public interface SparePartsServeceInt {
	public String saveSpareparts(Spare spareParts);
	public Spare getSparePartBySerial(String serialNum);
	public List<Spare> getAllSpareParts();

}
