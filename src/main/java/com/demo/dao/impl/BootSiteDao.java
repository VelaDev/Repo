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

import com.demo.dao.BootStockDaoInt;
import com.demo.dao.TicketsDaoInt;
import com.demo.model.BootStock;
import com.demo.model.HOStock;
import com.demo.model.OrderDetails;
import com.demo.model.SiteStock;
import com.demo.model.Tickets;


@Repository("bootStockDao")
@Transactional(propagation=Propagation.REQUIRED)
public class BootSiteDao implements BootStockDaoInt{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Autowired
	private TicketsDaoInt ticketsDaoInt;
	
	private BootStock bootStock;
	List<BootStock> bootStockList = null;
	List<BootStock> bootStocks = null;
	
	@Override
	public List<BootStock> getAllBootStock() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				BootStock.class);
		return (List<BootStock>) criteria.list();
	}
	
	
	@Override
	public void saveBootStock(List<OrderDetails> detailsDaos) {
		try{
			
			for(OrderDetails stock:detailsDaos){
				bootStock = getBootStock(stock.getPartNumber());
					if(bootStock !=null && stock.getPartNumber().equalsIgnoreCase(bootStock.getPartNumber())){
						int incrementQuantity = stock.getQuantity()+ bootStock.getQuantity();
						bootStock.setQuantity(incrementQuantity);
						sessionFactory.getCurrentSession().update(bootStock);
					}else{
						bootStock = new BootStock();
						bootStock.setItemDescription(stock.getItemDescription());
						bootStock.setItemType(stock.getItemType());
						bootStock.setPartNumber(stock.getPartNumber());
						bootStock.setQuantity(stock.getQuantity());
						bootStock.setTechnicianEmail(stock.getTechnician());
						bootStock.setTechnicianName(stock.getTechnician());
						bootStock.setCompatibleDevice(stock.getCompatibleDevice());
						
						sessionFactory.getCurrentSession().saveOrUpdate(bootStock);
					}
				}
			
		}catch(Exception exception){
			exception.getMessage();
		}
		
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<BootStock> getAllOrders() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				BootStock.class);
		return (List<BootStock>) criteria.list();
	}
	@Override
	public List<BootStock> getAllOrders(String technician) {
		
		bootStockList = new ArrayList<BootStock>();
		try{
			bootStocks = getAllOrders();
			 for(BootStock boot:bootStocks){
				 String name = boot.getTechnicianName();
				 if(name.equalsIgnoreCase(technician)&& boot.getQuantity()>0){
					 bootStockList.add(boot);
				 }
			 }
		}catch(Exception e){
			
		}
		return bootStockList;
	}
	@Override
	public void updateBootStock(BootStock bootStock) {
		try{
			sessionFactory.getCurrentSession().update(bootStock);
		}catch(Exception e){
			e.getMessage();
		}
		
	}
	@Override
	public List<BootStock> getAllOrders(String technician, Long ticketRecordID) {
		Tickets ticket = ticketsDaoInt
				.getLoggedTicketsByTicketNumber(ticketRecordID);
		String tempDeviceModelNumber = ticket.getDevice().getModelNumber();
		List<String> spare = null;
		bootStockList = new ArrayList<BootStock>();
		try {
			bootStocks = getAllOrders();
			for (BootStock boot : bootStocks) {
				String name = boot.getTechnicianName();
				if (name.equalsIgnoreCase(technician) && boot.getQuantity() > 0) {
					spare = new ArrayList<String>(Arrays.asList(boot
							.getCompatibleDevice().split("/")));
					for (int i = 0; i < spare.size(); i++) {
						if (spare.get(i)
								.equalsIgnoreCase(tempDeviceModelNumber)) {
							 bootStockList.add(boot);
						}
					}
				}
			}
		} catch (Exception e) {

		}
		return bootStockList;
	}
	@Override
	public BootStock getBootStock(String partNumber) {
		return (BootStock) sessionFactory.getCurrentSession().get(BootStock.class, partNumber);
	}
	@Override
	public BootStock getBootStock(String partNumber, String technicianName) {
		BootStock localStock = null;
		try{
			List<BootStock> boot = getAllOrders(technicianName);
			for(BootStock tempStock:boot){
				if(tempStock.getPartNumber().equalsIgnoreCase(partNumber)){
					localStock= tempStock;
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
		return localStock;
	}
	
	@Override
	public int countBootStock() {
//		List<SiteStock> tempSiteList = new ArrayList<SiteStock>();
		int bootCount = 0;
		try{
			List<BootStock> tempBootList = getAllBootStock();
			for(BootStock stock:tempBootList){
				if(stock.getQuantity()> 0){
					bootCount = bootCount + stock.getQuantity();
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
		return bootCount;
	}
	
	@Override
	public int countPartsForTechnician(String technicianName) {
//		List<SiteStock> tempSiteList = new ArrayList<SiteStock>();
		int bootCount = 0;
		try{
			List<BootStock> tempBootList = getAllBootStock();
			for(BootStock stock:tempBootList){
				if(stock.getItemType().equalsIgnoreCase("Part") && stock.getTechnicianName().equalsIgnoreCase(technicianName)){
					bootCount = bootCount + stock.getQuantity();				
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
	
		return bootCount;
	}
	
	@Override
	public List<BootStock> getAllBootStockByTechnician(String technicianName) {
 		List<BootStock> currentList = new ArrayList<BootStock>();
 		List<BootStock> tempBootList = new ArrayList<BootStock>();
		int bootCount = 0;
		try{
			currentList = getAllBootStock();
			System.err.println("The technicianName is " + technicianName);
			System.err.println("The count is new " + getAllBootStock().size());
			for(BootStock stock:tempBootList){
				if(stock.getTechnicianEmail().equalsIgnoreCase(technicianName)){
					currentList.add(stock);
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
		return currentList;
	}
	
	
	@Override
	public List<BootStock> getPartsForTechnician(String technicianName) {
 		List<BootStock> currentList = new ArrayList<BootStock>();
		int bootCount = 0;
		try{
			List<BootStock> tempBootList = getAllBootStock();
			for(BootStock stock:tempBootList){
				if(stock.getItemType().equalsIgnoreCase("Part") && stock.getTechnicianName().equalsIgnoreCase(technicianName)){
					currentList.add(stock);
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
		return currentList;
	}
	
	
	@Override
	public int countTonerForTechnician(String technicianName) {
//		List<SiteStock> tempSiteList = new ArrayList<SiteStock>();
		int bootCount = 0;
		try{
			List<BootStock> tempBootList = getAllBootStock();
			for(BootStock stock:tempBootList){
				if(stock.getItemType().equalsIgnoreCase("Toner") && stock.getTechnicianName().equalsIgnoreCase(technicianName)){
					bootCount = bootCount + stock.getQuantity();
					System.err.println("The Quantiry is " + stock.getQuantity());
					
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
		System.err.println("The technicianName is " + technicianName);
		System.err.println("The count is " + bootCount);
		return bootCount;
	}
	
	@Override
	public List<BootStock> getTonerForTechnician(String technicianName) {
 		List<BootStock> currentList = new ArrayList<BootStock>();
		int bootCount = 0;
		try{
			List<BootStock> tempBootList = getAllBootStock();
			for(BootStock stock:tempBootList){
				if(stock.getItemType().equalsIgnoreCase("Toner") && stock.getTechnicianName().equalsIgnoreCase(technicianName)){
					currentList.add(stock);
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
		return currentList;
	}
	

}
