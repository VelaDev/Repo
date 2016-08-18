package com.demo.dao;

import java.util.List;

import com.demo.model.Accessories;
import com.demo.model.Product;

public interface ProductDaoInt {
	
	void saveProduct(Product product);
	Product getProductBySerialNumbuer(String serialNumber);
	List<Product> getProductList();
	List<Product> getProductListByClientName(String clientName);
	List<Accessories> accessories(String serialNumber);
	

}
