package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.OrdersBean;
import com.demo.dao.OrdersDaoInt;
import com.demo.model.Orders;
import com.demo.service.OrdersServiceInt;

@Service("odersService")
@Transactional
public class OrdersService implements OrdersServiceInt{
	
	@Autowired
	private OrdersDaoInt ordersDAO;
	private String retMessage = null;

	@Override
	public String makeOrder(OrdersBean orders) {
		try{
			retMessage = ordersDAO.makeOrder(orders);
		}
		catch(Exception e){}
		return retMessage;
	}

	@Override
	public String updateOrder(OrdersBean order) {
		
		return retMessage= ordersDAO.updateOrder(order);
	}

	@Override
	public List<Orders> getAllOrders() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Orders> getApprovedOrdersByTechnicianName(String userName) {
		
		return ordersDAO.getApprovedOrdersByTechnicianName(userName);
	}

	@Override
	public List<Orders> getOpenOrders() {
		return ordersDAO.getOpenOrders();
	}

	@Override
	public Orders getOrder(String orderNum) {
	
		return ordersDAO.getOrder(orderNum);
	}

	@Override
	public List<Orders> getAllOrders(String orderedBy) {
		return ordersDAO.getAllOrders(orderedBy);
	}

	@Override
	public String prepareOrderMaking(OrdersBean order) {
		return ordersDAO.prepareOrderMaking(order);
	}


}
