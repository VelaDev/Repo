package com.demo.service;

import java.util.List;

import com.demo.model.Accessories;
import com.demo.model.Device;

public interface DeviceServiceInt {
	
	String saveProduct(Device device);
	Device getProductBySerialNumber(String serialNumber);
	List<Device> getProductList();
	List<Device> getProductListByClientName(String clientName);
	List<Accessories> accessories(Device device);
	String updateProduct(Device device);

}
