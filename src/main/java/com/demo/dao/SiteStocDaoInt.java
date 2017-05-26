package com.demo.dao;

import java.util.List;

import com.demo.model.OrderDetails;
import com.demo.model.SiteStock;

public interface SiteStocDaoInt {
	
	void saveSiteStock(List<OrderDetails> detailsDaos);
	List<SiteStock> getAllOrders();
	List<SiteStock> getOrdersForCustomer(String customerName);
	List<SiteStock> getOrdersByTechnician(String technician);
	List<SiteStock> getOrdersForCustomer(String customerName,int ticketID);
	SiteStock getSiteStock(String partNumber);

}
