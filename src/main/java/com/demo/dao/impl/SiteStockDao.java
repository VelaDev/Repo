package com.demo.dao.impl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.SiteStocDaoInt;
import com.demo.model.OrderDetails;
import com.demo.model.SiteStock;
@Repository("siteStockDao")
@Transactional(propagation=Propagation.REQUIRED)
public class SiteStockDao implements SiteStocDaoInt {
	
	@Autowired
	private SessionFactory sessionFactory;
	private SiteStock siteStock;

	@Override
	public void saveSiteStock(List<OrderDetails> detailsDaos) {
		try {
			for(OrderDetails stock:detailsDaos){
				siteStock = new SiteStock();
				siteStock.setCustomerName(stock.getOrderHeader().getCustomer().getCustomerName());
				siteStock.setItemDescription(stock.getItemDescription());
				siteStock.setItemType(stock.getStockType());
				siteStock.setLocation(stock.getLocation());
				siteStock.setPartNumber(stock.getPartNumber());
				siteStock.setQuantity(stock.getQuantity());
				siteStock.setRecordID(stock.getOrderDertailNumber());
				siteStock.setTechnicianEmail(stock.getTechnician());
				siteStock.setTechnicianName(stock.getTechnician());
				
				sessionFactory.getCurrentSession().saveOrUpdate(siteStock);
			}

		} catch (Exception exception) {
			exception.getMessage();

		}
	}
}
