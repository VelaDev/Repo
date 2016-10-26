package com.demo.dao;

import java.util.List;

import com.demo.bean.DeviceBean;
import com.demo.bean.ProductBean;
import com.demo.model.Accessories;
import com.demo.model.Device;

public interface DeviceDaoInt {
	
	String saveDevice(Device device);
	Device getDeviceBySerialNumbuer(String serialNumber);
	List<Device> getDeviceList();
	List<Device> getDeviceListByClientName(String clientName);
	List<Accessories> accessories(Device device);
	String updateDevice(Device device);
	String prepareDeviceData(DeviceBean deviceBean);
	ProductBean getAccessoriesForUpdate(String serialNumber);
	

}
