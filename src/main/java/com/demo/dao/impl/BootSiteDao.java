package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.BootStockDaoInt;
import com.demo.model.BootStock;
import com.demo.model.OrderDetails;


@Repository("bootStockDao")
@Transactional(propagation=Propagation.REQUIRED)
public class BootSiteDao implements BootStockDaoInt{

	@Autowired
	private SessionFactory sessionFactory;
	
	private BootStock bootStock;
	List<BootStock> bootStockList = null;
	List<BootStock> bootStocks = null;
	
	@Override
	public void saveBootStock(List<OrderDetails> detailsDaos) {
		System.out.println("We here");
		try{
			
			for(OrderDetails stock:detailsDaos){
				bootStock = new BootStock();
				bootStock.setItemDescription(stock.getItemDescription());
				bootStock.setItemType(stock.getPartType());
				bootStock.setPartNumber(stock.getPartNumber());
				bootStock.setQuantity(stock.getQuantity());
				bootStock.setRecordID(stock.getOrderDertailNumber());
				bootStock.setTechnicianEmail(stock.getTechnician());
				bootStock.setTechnicianName(stock.getTechnician());
				
				sessionFactory.getCurrentSession().saveOrUpdate(bootStock);
			}
			
		}catch(Exception exception){
			exception.getMessage();
		}
		
	}
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
			 for(BootStock stock:bootStocks){
				 if(stock.getTechnicianName().equalsIgnoreCase(technician)){
					 bootStockList.add(stock);
				 }
			 }
		}catch(Exception e){
			
		}
		return bootStockList;
	}

}
