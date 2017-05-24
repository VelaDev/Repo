package com.demo.dao.impl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.OrderHistoryDaoInt;
import com.demo.model.OrderHeader;
import com.demo.model.OrderHistory;


@Repository("orderHistoryDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class OrderHistoryDao implements OrderHistoryDaoInt{

	@Autowired
	private SessionFactory sessionFactory;
	
	
	OrderHistory orderHistory = null;
	@Override
	public void insetOrderHistory(OrderHeader order) {
		orderHistory = new OrderHistory();
		try{
			
			orderHistory.setOrderNum(order.getOrderNum());
			orderHistory.setComments(order.getComments());
			orderHistory.setOrderStatus(order.getStatus());
			if(order.getDateApproved() != null){
				orderHistory.setDateOrdered(order.getDateApproved());
			}else if(order.getDateOrdered() != null){
				orderHistory.setDateOrdered(order.getDateOrdered());
			}
			else if(order.getShippingDate() != null){
				orderHistory.setDateOrdered(""+order.getShippingDate());
			}
//			else if(order.getOrderReceivedDate() != null){
//				orderHistory.setDateOrdered(""+order.getOrderReceivedDate());
//			}
			
			sessionFactory.getCurrentSession().save(orderHistory);
		}catch(Exception e){
			e.getMessage();
		}
		
	}

	@Override
	public List<OrderHistory> getAllOrderHistoryByOrderNumber(String orderNumber) {
		// TODO Auto-generated method stub
		return null;
	}

}
