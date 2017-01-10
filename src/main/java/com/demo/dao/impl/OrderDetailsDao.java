package com.demo.dao.impl;


import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.OrderDetailsDaoInt;
import com.demo.model.OrdersHeader;
import com.demo.model.OrderDetails;

@Repository("orderDetailsDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class OrderDetailsDao implements OrderDetailsDaoInt{

	
	@Autowired
	SessionFactory sessionFactory;
	
	private String retMessage = null;
	
	private List<OrderDetails> orders = null;
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
	@Override
	public List<OrderDetails> getOrderDetailsByOrderNum(String orderNum) {
		ArrayList<OrderDetails> pendingList = new ArrayList<OrderDetails>();
		try{
			orders = getAllOrderDetails();
			 for(OrderDetails order:orders){
				 if(order.getOrdersHeader().getOrderNum().equalsIgnoreCase(orderNum)){
					 pendingList.add(order);
				 }
			 }
		}catch(Exception e){
			
		}
		return pendingList;
	}
	@Override
	public List<OrderDetails> getAllOrderDetails() {
		
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(OrderDetails.class);
		return (List<OrderDetails>)criteria.list();
	}
	@Override
	public List<OrderDetails> getOrderDetailsByTechnician(String email) {
		ArrayList<OrderDetails> pendingList = new ArrayList<OrderDetails>();
		try{
			orders = getAllOrderDetails();
			
			 for(OrderDetails order:orders){
				 if(order.getOrdersHeader().getEmployee().getEmail().equalsIgnoreCase(email)){
					 pendingList.add(order);
				 }
			 }
		}catch(Exception e){
			
		}
		return pendingList;
	}

}
