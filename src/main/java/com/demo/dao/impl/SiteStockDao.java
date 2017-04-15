package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.SiteStocDaoInt;
import com.demo.model.BootStock;
import com.demo.model.OrderDetails;
import com.demo.model.SiteStock;
@Repository("siteStockDao")
@Transactional(propagation=Propagation.REQUIRED)
public class SiteStockDao implements SiteStocDaoInt {
	
	@Autowired
	private SessionFactory sessionFactory;
	private SiteStock siteStock;
	
	List<SiteStock> sitetStockList = null;
	List<SiteStock> siteStocks = null;

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

	@Override
	public List<SiteStock> getAllOrders() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				SiteStock.class);
		return (List<SiteStock>) criteria.list();
	}

	@Override
	public List<SiteStock> getOrdersForCustomer(String customerName) {
		sitetStockList = new ArrayList<SiteStock>();
		try{
			siteStocks = getAllOrders();
			 for(SiteStock stock:siteStocks){
				 if(stock.getCustomerName().equalsIgnoreCase(customerName)){
					 sitetStockList.add(stock);
				 }
			 }
		}catch(Exception e){
			
		}
		return sitetStockList;
	}

	@Override
	public List<SiteStock> getOrdersByTechnician(String technicianName) {
		sitetStockList = new ArrayList<SiteStock>();
		try{
			siteStocks = getAllOrders();
			 for(SiteStock site:siteStocks){
				 String name = site.getTechnicianName();
				 if(name.equalsIgnoreCase(technicianName)){
					 sitetStockList.add(site);
				 }
			 }
		}catch(Exception e){
			e.getMessage();
		}
		return sitetStockList;
	}
}
