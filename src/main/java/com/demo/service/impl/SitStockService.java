package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.SiteStocDaoInt;
import com.demo.model.SiteStock;
import com.demo.service.SiteStockInt;

@Service("siteStockService")
public class SitStockService implements SiteStockInt{

	@Autowired
	private SiteStocDaoInt siteStock;
	@Override
	public List<SiteStock> getAllOrders() {
		return siteStock.getAllOrders();
	}
	@Override
	public List<SiteStock> getOrdersForCustomer(String customerName) {
		return siteStock.getOrdersForCustomer(customerName);
	}
	@Override
	public List<SiteStock> getOrdersByTechnician(String technician) {
		return siteStock.getOrdersByTechnician(technician);
	}
	@Override
	public List<SiteStock> getOrdersForCustomer(String customerName,
			int ticketID) {
		
		return siteStock.getOrdersForCustomer(customerName, ticketID);
	}

}
