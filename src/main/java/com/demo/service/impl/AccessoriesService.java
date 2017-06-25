package com.demo.service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.AccessoriesDaoInt;
import com.demo.model.Accessories;
import com.demo.service.AccessoriesInt;


@Service("accessoriesService")
public class AccessoriesService implements AccessoriesInt{
	
	@Autowired
	private AccessoriesDaoInt accessoriesDaoInt;
	private String retMessage = null;

	@Override
	public String saveAccessories(List<Accessories> accessories) {
		
		retMessage = accessoriesDaoInt.saveAccessories(accessories);
		return retMessage;
	}

	@Override
	public String updateAccessories(List<Accessories> accessories) {
		retMessage = accessoriesDaoInt.updateAccessories(accessories);
		return retMessage;
	}

	@Override
	public List<Accessories> getAccessoriesByDeviceSerial(String serialNo) {
		
		return accessoriesDaoInt.getAccessoriesByDeviceSerial(serialNo);
	}

	@Override
	public Accessories getAccessories(String serialNo) {
		// TODO Auto-generated method stub
		return accessoriesDaoInt.getAccessories(serialNo);
	}

	@Override
	public List<String> getAccessoriesList(String deviceSerialNumber) {
		return accessoriesDaoInt.getAccessoriesList(deviceSerialNumber);
	}

}
