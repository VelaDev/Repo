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
import com.demo.model.BootStock;
import com.demo.model.SiteStock;
import com.demo.model.HOStock;
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
	public List<SiteStock> getAllSiteStock() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				SiteStock.class);
		return (List<SiteStock>) criteria.list();
	}
	
	
	@Override
	public void saveSiteStock(List<OrderDetails> detailsDaos) {
		try {
			for(OrderDetails stock:detailsDaos){
		      siteStock = getSiteStock(stock.getPartNumber());
				 if(siteStock != null && stock.getPartNumber().equalsIgnoreCase(siteStock.getPartNumber())){
					 int incrementQuantity = stock.getQuantity() + siteStock.getQuantity();
					 siteStock.setCompatibleDevice(stock.getCompatibleDevice());
					 siteStock.setQuantity(incrementQuantity);
					 sessionFactory.getCurrentSession().update(siteStock);
		
					 
				 }else{
					 siteStock = new SiteStock();
						siteStock.setCustomerName(stock.getOrderHeader().getCustomer().getCustomerName());
						siteStock.setItemDescription(stock.getItemDescription());
						siteStock.setItemType(stock.getItemType());
						siteStock.setLocation(stock.getLocation());
						siteStock.setPartNumber(stock.getPartNumber());
						siteStock.setQuantity(stock.getQuantity());
						siteStock.setCompatibleDevice(stock.getCompatibleDevice());
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
			Long ticketID) {
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
	
	
	@Override
	public int countSiteStock() {
//		List<SiteStock> tempSiteList = new ArrayList<SiteStock>();
		int siteCount = 0;
		try{
			List<SiteStock> tempSiteList = getAllSiteStock();
			for(SiteStock stock:tempSiteList){
				if(stock.getQuantity()> 0){
					siteCount = siteCount + stock.getQuantity();
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
		return siteCount;
	}
	
	
	@Override
	public int countPartsForCustomer(String customerName) {
		List<SiteStock> tempSiteList = new ArrayList<SiteStock>();
		int bootCount = 0;
		try{
			
			tempSiteList = getPartsForCustomer(customerName);
		
			System.out.println("Customer 3 " + customerName + tempSiteList.size());
			for(SiteStock stock:tempSiteList){
				if(stock.getCustomerName() != null){
					System.out.println("Customer 2 " + stock.getCustomerName());
					bootCount = bootCount + stock.getQuantity();
					System.err.println("The Quantiry is " + stock.getItemType());
					
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
		return bootCount;
	}
	
	@Override
	public List<SiteStock> getPartsForCustomer(String customerName) {
 		List<SiteStock> currentList = new ArrayList<SiteStock>();
		int bootCount = 0;
		try{
			List<SiteStock> tempBootList = getAllSiteStock();
			for(SiteStock stock:tempBootList){
				if(stock.getItemType().equalsIgnoreCase("Part") && stock.getCustomerName().equalsIgnoreCase(customerName)){
					currentList.add(stock);
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
		return currentList;
	}
	
	
	@Override
	public int countTonerForCustomer(String customerName) {
//		List<SiteStock> tempSiteList = new ArrayList<SiteStock>();
		int bootCount = 0;
		try{
			List<SiteStock> tempBootList = getTonerForCustomer(customerName);
			for(SiteStock stock:tempBootList){
				if(stock.getItemType().equalsIgnoreCase("Toner") && stock.getCustomerName().equalsIgnoreCase(customerName)){
					bootCount = bootCount + stock.getQuantity();
					System.err.println("The Quantiry is " + stock.getQuantity());
					
				}
			}
		}catch(Exception e){
			e.getMessage();
		}

		return bootCount;
	}
	
	@Override
	public List<SiteStock> getTonerForCustomer(String customerName) {
 		List<SiteStock> currentList = new ArrayList<SiteStock>();
		int bootCount = 0;
		try{
			List<SiteStock> tempBootList = getAllSiteStock();
			for(SiteStock stock:tempBootList){
				if(stock.getItemType().equalsIgnoreCase("Toner") && stock.getCustomerName().equalsIgnoreCase(customerName)){
					currentList.add(stock);
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
		return currentList;
	}
	
	
}
