package com.demo.dao;

import java.util.List;

import com.demo.model.Accessories;

public interface AccessoriesDaoInt {
	
	String saveAccessories(List<Accessories> accessories);
	String updateAccessories(List<Accessories> accessories);
	List<Accessories> getAccessoriesByDeviceSerial(String serialNo);
	String removeAccessory(String serialNo);
	Accessories getAccessories(String serialNo);
	

}
