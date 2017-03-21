package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.bean.DeviceBean;
import com.demo.dao.DeviceDaoInt;
import com.demo.model.Accessories;
import com.demo.model.Device;
import com.demo.model.Employee;
import com.demo.service.DeviceServiceInt;


//Device
@Service("productService")
public class DeviceService implements DeviceServiceInt {
	
	@Autowired
	private DeviceDaoInt deviceDAO;
	private String retMessage = null;

	@Override
	public String saveDevice(Device device) {
		retMessage =deviceDAO.saveDevice(device);
		return retMessage;
		
	}

	@Override
	public Device getDeviceBySerialNumber(String serialNumber) {
		
		return deviceDAO.getDeviceBySerialNumbuer(serialNumber);
	}

	@Override
	public List<Device> getDeviceList() {
		return deviceDAO.getDeviceList();
	}

	@Override
	public List<Device> getDeviceListByClientName(String clientName) {
		return deviceDAO.getDeviceListByClientName(clientName);
	}

	@Override
	public List<Accessories> accessories(Device device) {
		// TODO Auto-generated method stub
		return deviceDAO.accessories(device);
	}

	@Override
	public String updateDevice(Device device) {
		retMessage = deviceDAO.updateDevice(device);
		return retMessage;
	}

	@Override
	public String prepareDeviceData(DeviceBean deviceBean) {
		retMessage = deviceDAO.prepareDeviceData(deviceBean);
		return retMessage;
	}

	@Override
	public DeviceBean getAccessoriesForUpdate(String serialNumber) {
		
		return deviceDAO.getAccessoriesForUpdate(serialNumber);
	}

	@Override
	public Integer count() {
		return deviceDAO.count();
	}

	@Override
	public List<Device> getAllEmployees(Integer offset, Integer maxResults,String clientName) {
		
		return deviceDAO.getDeviceList(offset, maxResults,clientName);
	}

	@Override
	public String[] getSerials() {
		return deviceDAO.getSerials();
	}

}
