package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.ProductDaoInt;
import com.demo.model.Accessories;
import com.demo.model.Product;
import com.demo.service.ProductServiceInt;

@Service("productService")
public class ProductService implements ProductServiceInt {
	
	@Autowired
	private ProductDaoInt productDAO;
	private String retMessage = null;

	@Override
	public String saveProduct(Product product) {
		retMessage =productDAO.saveProduct(product);
		return retMessage;
		
	}

	@Override
	public Product getProductBySerialNumber(String serialNumber) {
		
		return productDAO.getProductBySerialNumbuer(serialNumber);
	}

	@Override
	public List<Product> getProductList() {
		return productDAO.getProductList();
	}

	@Override
	public List<Product> getProductListByClientName(String clientName) {
		return productDAO.getProductListByClientName(clientName);
	}

	@Override
	public List<Accessories> accessories(Product product) {
		// TODO Auto-generated method stub
		return productDAO.accessories(product);
	}

	@Override
	public String updateProduct(Product product) {
		retMessage = productDAO.updateProduct(product);
		return retMessage;
	}

}
