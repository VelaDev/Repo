package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.OrdersBean;
import com.demo.dao.OrdersDaoInt;
import com.demo.model.OrderHeader;
import com.demo.service.OrdersServiceInt;

@Service("odersService")
@Transactional
public class OrdersService implements OrdersServiceInt{
	
	@Autowired
	private OrdersDaoInt ordersDAO;
	private String retMessage = null;

	@Override
	public String makeOrder(OrderHeader orderHeader) {
		try{
			retMessage = ordersDAO.makeOrder(orderHeader);
		}
		catch(Exception e){}
		return retMessage;
	}

	@Override
	public String updateOrder(OrdersBean order) {
		
		return retMessage= ordersDAO.updateOrder(order);
	}

	@Override
	public List<OrderHeader> getAllOrders() {
		return ordersDAO.getAllOrders();
	}

	@Override
	public List<OrderHeader> getApprovedOrdersByTechnicianName(String userName) {
		
		return ordersDAO.getApprovedOrdersByTechnicianName(userName);
	}

	@Override
	public List<OrderHeader> getOpenOrders() {
		return ordersDAO.getOpenOrders();
	}

	@Override
	public OrderHeader getOrder(Integer recordID) {
	
		return ordersDAO.getOrder(recordID);
	}

	@Override
	public List<OrderHeader> getAllOrders(String orderedBy) {
		return ordersDAO.getAllOrders(orderedBy);
	}

	@Override
	public String prepareOrderMaking(OrdersBean order) {
		return ordersDAO.prepareOrderMaking(order);
	}

	@Override
	public List<OrderHeader> pendingOrders() {
		return ordersDAO.pendingOrders();
	}

	@Override
	public String approveOrder(Integer recordID) {
		return ordersDAO.approveOrder(recordID);
	}

	@Override
	public List<OrderHeader> pendingOrders(String approveName) {
		return ordersDAO.pendingOrders(approveName);
	}

	@Override
	public void approveShipment(Integer recordID) {
		ordersDAO.approveShipment(recordID);
		
	}

	@Override
	public List<OrderHeader> shippedOrders() {

		return ordersDAO.shippedOrders();
	}

	@Override
	public List<OrderHeader> shippedOrders(String technicianEmail) {
		return ordersDAO.shippedOrders(technicianEmail);
	}

	@Override
	public String declineOrder(String orderNum,String reasonForeclined) {
		return ordersDAO.declineOrder(orderNum,reasonForeclined);
	}

	@Override
	public int pendingOrdersCount(String approveName) {

		return ordersDAO.pendingOrdersCount(approveName);
	}

	@Override
	public int technicianOrdersCount(String technicianName) {
		
		return ordersDAO.technicianOrdersCount(technicianName);
	}


}
