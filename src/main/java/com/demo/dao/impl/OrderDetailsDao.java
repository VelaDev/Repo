package com.demo.dao.impl;


import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.OrderDetailsDaoInt;
import com.demo.model.OrderDetails;

@Repository("orderDetailsDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class OrderDetailsDao implements OrderDetailsDaoInt{

	
	@Autowired
	SessionFactory sessionFactory;
	
	private String retMessage = null;
	@Override
	public String saveOrderDetails(List<OrderDetails> orderDetails) {
		try{

	        for(OrderDetails orders:orderDetails){
		         sessionFactory.getCurrentSession().saveOrUpdate(orders);
		         retMessage ="OK";
	            }
	}catch (Exception e) {
			retMessage = e.getMessage();
		}
	return retMessage;
	}

}
