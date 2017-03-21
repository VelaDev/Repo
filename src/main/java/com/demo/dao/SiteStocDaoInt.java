package com.demo.dao;

import java.util.List;

import com.demo.model.OrderDetails;

public interface SiteStocDaoInt {
	
	void saveSiteStock(List<OrderDetails> detailsDaos);

}
