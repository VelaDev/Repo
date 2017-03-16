package com.demo.service;

import java.util.List;

import com.demo.bean.OrdersBean;
import com.demo.model.OrdersHeader;

public interface OrdersServiceInt {
	public String makeOrder(OrdersHeader ordersHeader);
	public String updateOrder(OrdersBean order);
	public List<OrdersHeader> getAllOrders();
	public List<OrdersHeader> getApprovedOrdersByTechnicianName(String userName);
	public List<OrdersHeader> getOpenOrders();
	public OrdersHeader getOrder(Integer recordID);
	public List<OrdersHeader> getAllOrders(String orderedBy);
	public String prepareOrderMaking(OrdersBean order);
	public List<OrdersHeader> pendingOrders();
	public String approveOrder(Integer recordID);
	public List<OrdersHeader> pendingOrders(String approveName);

}
