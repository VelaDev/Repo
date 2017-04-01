package com.demo.service;

import java.util.List;

import com.demo.model.SiteStock;

public interface SiteStockInt {
	List<SiteStock> getAllOrders();
	List<SiteStock> getAllOrders(String technician);
}
