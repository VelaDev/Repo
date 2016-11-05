package com.demo.service;

import java.util.List;

import com.demo.bean.DeviceBean;
import com.demo.bean.ProductBean;
import com.demo.model.Accessories;
import com.demo.model.Device;

public interface DeviceServiceInt {
	
	String saveDevice(Device device);
	Device getDeviceBySerialNumber(String serialNumber);
	List<Device> getDeviceList();
	List<Device> getDeviceListByClientName(String clientName);
	List<Accessories> accessories(Device device);
	String updateDevice(Device device);
	String prepareDeviceData(DeviceBean deviceBean);
	DeviceBean getAccessoriesForUpdate(String serialNumber);
	

}
