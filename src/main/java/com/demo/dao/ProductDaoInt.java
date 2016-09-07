package com.demo.dao;

import java.util.List;

import com.demo.model.Accessories;
import com.demo.model.Product;

public interface ProductDaoInt {
	
	String saveProduct(Product product);
	Product getProductBySerialNumbuer(String serialNumber);
	List<Product> getProductList();
	List<Product> getProductListByClientName(String clientName);
	List<Accessories> accessories(Product product);
	String updateProduct(Product product);
	

}
