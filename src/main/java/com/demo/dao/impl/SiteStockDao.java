package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.SiteStocDaoInt;
import com.demo.dao.TicketsDaoInt;
import com.demo.model.OrderDetails;
import com.demo.model.SiteStock;
import com.demo.model.Tickets;
@Repository("siteStockDao")
@Transactional(propagation=Propagation.REQUIRED)
public class SiteStockDao implements SiteStocDaoInt {
	
	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private TicketsDaoInt ticketsDaoInt;
	private SiteStock siteStock;
	
	List<SiteStock> sitetStockList = null;
	List<SiteStock> siteStocks = null;

	@Override
	public void saveSiteStock(List<OrderDetails> detailsDaos) {
		try {
			for(OrderDetails stock:detailsDaos){
		      siteStock = getSiteStock(stock.getPartNumber());
				 if(siteStock != null && stock.getPartNumber().equalsIgnoreCase(siteStock.getPartNumber())){
					 int incrementQuantity = stock.getQuantity() + siteStock.getQuantity();
					 siteStock.setQuantity(incrementQuantity);
					 sessionFactory.getCurrentSession().update(siteStock);
		
					 
				 }else{
					 siteStock = new SiteStock();
						siteStock.setCustomerName(stock.getOrderHeader().getCustomer().getCustomerName());
						siteStock.setItemDescription(stock.getItemDescription());
						siteStock.setItemType(stock.getStockType());
						siteStock.setLocation(stock.getLocation());
						siteStock.setPartNumber(stock.getPartNumber());
						siteStock.setQuantity(stock.getQuantity());
						siteStock.setTechnicianEmail(stock.getTechnician());
						siteStock.setTechnicianName(stock.getTechnician());
						
						sessionFactory.getCurrentSession().saveOrUpdate(siteStock);
				 }
			 }
		} catch (Exception exception) {
			exception.getMessage();

		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<SiteStock> getAllOrders() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(SiteStock.class);
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

	@Override
	public List<SiteStock> getOrdersForCustomer(String customerName,
			int ticketID) {
		Tickets ticket = ticketsDaoInt.getLoggedTicketsByTicketNumber(ticketID);
		
		String tempDeviceModelNumber = ticket.getDevice().getModelNumber();
		
		List<String> spare = null;
		sitetStockList = new ArrayList<SiteStock>();
		try{
			siteStocks = getAllOrders();
			 for(SiteStock stock:siteStocks){
				 if(stock.getCustomerName().equalsIgnoreCase(customerName) && stock.getQuantity()>0){
					 
					 spare = new ArrayList<String>(Arrays.asList(stock
								.getCompatibleDevice().split("/")));
						for (int i = 0; i < spare.size(); i++) {
							if (spare.get(i)
									.equalsIgnoreCase(tempDeviceModelNumber)) {
								sitetStockList.add(stock);
							}
						}
				 }
			 }
		}catch(Exception e){
			
		}
		return sitetStockList;
	}

	@Override
	public SiteStock getSiteStock(String partNumber) {
		return (SiteStock) sessionFactory.getCurrentSession().get(SiteStock.class, partNumber);
	}

	@Override
	public SiteStock getSiteStock(String partNumber, String customerName) {
		SiteStock localtemp = null;
		List<SiteStock> siteStock = getOrdersForCustomer(customerName);
		for(SiteStock stock:siteStock){
			if(stock.getPartNumber().equalsIgnoreCase(partNumber)){
				localtemp=stock;
			}
		}
		return localtemp;
	}
}
