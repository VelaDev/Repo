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
import com.demo.model.OrderDetails;
import com.demo.model.OrdersHeader;

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
	@SuppressWarnings("unchecked")
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
	@Override
	public List<OrderDetails> getAllAvailableOrderDetails(String technician) {
		ArrayList<OrderDetails> availableOrders = new ArrayList<OrderDetails>();
		try{
			orders = getAllOrderDetails();
			for(OrderDetails availableOrds:orders){
				if(availableOrds.getOrdersHeader().getStatus().equalsIgnoreCase("Approved")&& availableOrds.getTechnician().equalsIgnoreCase(technician)){
					availableOrders.add(availableOrds);
				}
			}
			
		}catch(Exception e){
			
		}
		
		return availableOrders;
	}
	public String incrementStockAvailability(List<OrderDetails> availableStock){
		OrderDetails orderDetails = null;
		int tempQuantity = 0;
		try{
			  for(OrderDetails details:availableStock){
				  orderDetails = getOrderDetails(details.getOrderDertailNumber());
				  
				  if(details.getOrderDertailNumber()==orderDetails.getOrderDertailNumber()){
					  tempQuantity =  orderDetails.getQuantity() + details.getQuantity();
					  orderDetails.setQuantity(tempQuantity);
					  sessionFactory.getCurrentSession().update(orderDetails);
					  retMessage = "OK";
				  }
			}
		}catch(Exception e){
			
		}
		return retMessage;
	}
	private OrderDetails getOrderDetails(int orderDertailNumber){
		return (OrderDetails) sessionFactory.getCurrentSession().get(OrderDetails.class, orderDertailNumber);
	}
}
