package com.demo.service;

import java.util.List;

import com.demo.model.Accessories;
import com.demo.model.Product;

public interface ProductServiceInt {
	
	void saveProduct(Product product);
	Product getProductBySerialNumber(String serialNumber);
	List<Product> getProductList();
	List<Product> getProductListByClientName(String clientName);
	List<Accessories> accessories(Product product);
	String updateProduct(Product product);

}
