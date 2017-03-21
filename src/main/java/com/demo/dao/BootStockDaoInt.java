package com.demo.dao;

import java.util.List;

import com.demo.model.OrderDetails;

public interface BootStockDaoInt {
	
	void saveBootStock(List<OrderDetails> detailsDaos);

}
