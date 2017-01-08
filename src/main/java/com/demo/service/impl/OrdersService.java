package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.OrdersBean;
import com.demo.dao.OrdersDaoInt;
import com.demo.model.Order;
import com.demo.service.OrdersServiceInt;

@Service("odersService")
@Transactional
public class OrdersService implements OrdersServiceInt{
	
	@Autowired
	private OrdersDaoInt ordersDAO;
	private String retMessage = null;

	@Override
	public String makeOrder(Order order) {
		try{
			retMessage = ordersDAO.makeOrder(order);
		}
		catch(Exception e){}
		return retMessage;
	}

	@Override
	public String updateOrder(OrdersBean order) {
		
		return retMessage= ordersDAO.updateOrder(order);
	}

	@Override
	public List<Order> getAllOrders() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Order> getApprovedOrdersByTechnicianName(String userName) {
		
		return ordersDAO.getApprovedOrdersByTechnicianName(userName);
	}

	@Override
	public List<Order> getOpenOrders() {
		return ordersDAO.getOpenOrders();
	}

	@Override
	public Order getOrder(String orderNum) {
	
		return ordersDAO.getOrder(orderNum);
	}

	@Override
	public List<Order> getAllOrders(String orderedBy) {
		return ordersDAO.getAllOrders(orderedBy);
	}

	@Override
	public String prepareOrderMaking(OrdersBean order) {
		return ordersDAO.prepareOrderMaking(order);
	}


}
