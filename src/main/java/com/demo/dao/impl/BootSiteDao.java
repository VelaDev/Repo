package com.demo.dao.impl;

import java.util.List;

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
	@Override
	public void saveBootStock(List<OrderDetails> detailsDaos) {
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
				
				sessionFactory.getCurrentSession().saveOrUpdate(detailsDaos);
			}
			
		}catch(Exception exception){
			exception.getMessage();
		}
		
	}

}
