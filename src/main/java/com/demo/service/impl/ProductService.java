package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.ProductDaoInt;
import com.demo.model.Accessories;
import com.demo.model.Device;
import com.demo.service.DeviceServiceInt;

@Service("productService")
public class ProductService implements DeviceServiceInt {
	
	@Autowired
	private ProductDaoInt productDAO;
	private String retMessage = null;

	@Override
	public String saveProduct(Device device) {
		retMessage =productDAO.saveProduct(device);
		return retMessage;
		
	}

	@Override
	public Device getProductBySerialNumber(String serialNumber) {
		
		return productDAO.getProductBySerialNumbuer(serialNumber);
	}

	@Override
	public List<Device> getProductList() {
		return productDAO.getProductList();
	}

	@Override
	public List<Device> getProductListByClientName(String clientName) {
		return productDAO.getProductListByClientName(clientName);
	}

	@Override
	public List<Accessories> accessories(Device device) {
		// TODO Auto-generated method stub
		return productDAO.accessories(device);
	}

	@Override
	public String updateProduct(Device device) {
		retMessage = productDAO.updateProduct(device);
		return retMessage;
	}

}
