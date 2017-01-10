package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.OrdersBean;
import com.demo.dao.OrdersDaoInt;
import com.demo.model.OrdersHeader;
import com.demo.service.OrdersServiceInt;

@Service("odersService")
@Transactional
public class OrdersService implements OrdersServiceInt{
	
	@Autowired
	private OrdersDaoInt ordersDAO;
	private String retMessage = null;

	@Override
	public String makeOrder(OrdersHeader ordersHeader) {
		try{
			retMessage = ordersDAO.makeOrder(ordersHeader);
		}
		catch(Exception e){}
		return retMessage;
	}

	@Override
	public String updateOrder(OrdersBean order) {
		
		return retMessage= ordersDAO.updateOrder(order);
	}

	@Override
	public List<OrdersHeader> getAllOrders() {
		return ordersDAO.getAllOrders();
	}

	@Override
	public List<OrdersHeader> getApprovedOrdersByTechnicianName(String userName) {
		
		return ordersDAO.getApprovedOrdersByTechnicianName(userName);
	}

	@Override
	public List<OrdersHeader> getOpenOrders() {
		return ordersDAO.getOpenOrders();
	}

	@Override
	public OrdersHeader getOrder(String orderNum) {
	
		return ordersDAO.getOrder(orderNum);
	}

	@Override
	public List<OrdersHeader> getAllOrders(String orderedBy) {
		return ordersDAO.getAllOrders(orderedBy);
	}

	@Override
	public String prepareOrderMaking(OrdersBean order) {
		return ordersDAO.prepareOrderMaking(order);
	}

	@Override
	public List<OrdersHeader> pendingOrders() {
		return ordersDAO.pendingOrders();
	}

	@Override
	public String approveOrder(String orderNum) {
		return ordersDAO.approveOrder(orderNum);
	}


}
