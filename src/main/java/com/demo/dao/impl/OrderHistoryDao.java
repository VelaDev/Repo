package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.OrderHistoryDaoInt;
import com.demo.dao.OrdersDaoInt;
import com.demo.model.OrderHeader;
import com.demo.model.OrderHistory;


@Repository("orderHistoryDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class OrderHistoryDao implements OrderHistoryDaoInt{

	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private OrdersDaoInt daoInt;
	
	
	private OrderHistory orderHistory = null;
	private OrderHeader orderHeader = null;
	@Override
	public void insetOrderHistory(OrderHeader order) {
		orderHistory = new OrderHistory();
		try{
			
			orderHistory.setOrderNum(order.getOrderNum());
			orderHistory.setOrderStatus(order.getStatus());
			
			if(order.getDateApproved() != null){
				orderHistory.setStatusDateTime(order.getDateApproved());
			}else if(order.getDateOrdered() != null){
				orderHistory.setStatusDateTime(order.getDateOrdered());
			}
			else if(order.getShippingDate() != null){
				orderHistory.setStatusDateTime(""+order.getShippingDate());
			}
			else if(order.getOrderReceivedDateTime() != null){
				orderHistory.setStatusDateTime(""+order.getOrderReceivedDateTime());
			}
			
			sessionFactory.getCurrentSession().save(orderHistory);
		}catch(Exception e){
			e.getMessage();
		}
		
	}

	@Override
	public List<OrderHistory> getAllOrderHistoryByOrderNumber(int recordID) {
		List<OrderHistory> newList = null;
		try{
			orderHeader = daoInt.getOrder(recordID);
			List<OrderHistory> list = getAllOrderHistoryByOrderNumber();
			 newList = new ArrayList<OrderHistory>();
			for(OrderHistory orderHistory:list){
				if(orderHistory.getOrderNum().equalsIgnoreCase(orderHeader.getOrderNum())){
					newList.add(orderHistory);
				}
			}
			
		}catch(Exception e){
			e.getMessage();
		}
		return newList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrderHistory> getAllOrderHistoryByOrderNumber() {
		
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				OrderHistory.class);
		return (List<OrderHistory>) criteria.list();
	}

}
