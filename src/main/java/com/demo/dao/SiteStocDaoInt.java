package com.demo.dao;

import java.util.List;

import com.demo.model.OrderDetails;
import com.demo.model.SiteStock;

public interface SiteStocDaoInt {
	
	void saveSiteStock(List<OrderDetails> detailsDaos);
	List<SiteStock> getAllOrders();
	List<SiteStock> getOrdersForCustomer(String customerName);
	List<SiteStock> getOrdersByTechnician(String technician);
	List<SiteStock> getOrdersForCustomer(String customerName,Long ticketID);
	SiteStock getSiteStock(String partNumber);
	SiteStock getSiteStock(String partNumber,String customerName);
	int countSiteStock();
	List<SiteStock> getTonerForCustomer(String customerName);
	List<SiteStock> getPartsForCustomer(String customerName);
	int countTonerForCustomer(String customerName);
	int countPartsForCustomer(String customerName);
	List<SiteStock> getAllSiteStock();

}
