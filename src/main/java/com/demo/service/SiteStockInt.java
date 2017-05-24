package com.demo.service;

import java.util.List;

import com.demo.model.SiteStock;

public interface SiteStockInt {
	List<SiteStock> getAllOrders();
	List<SiteStock> getOrdersForCustomer(String customerName);
	List<SiteStock> getOrdersByTechnician(String technician);
	List<SiteStock> getOrdersForCustomer(String customerName,int ticketID);
}
