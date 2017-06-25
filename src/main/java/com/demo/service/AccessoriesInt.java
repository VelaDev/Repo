package com.demo.service;

import java.util.List;
import java.util.Set;

import com.demo.model.Accessories;

public interface AccessoriesInt {
	String saveAccessories(List<Accessories> accessories);
	String updateAccessories(List<Accessories> accessories);
	List<Accessories> getAccessoriesByDeviceSerial(String serialNo);
	Accessories getAccessories(String serialNo);
	List<String> getAccessoriesList(String deviceSerialNumber);

}
