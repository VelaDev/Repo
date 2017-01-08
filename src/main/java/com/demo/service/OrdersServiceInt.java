package com.demo.service;

import java.util.List;

import com.demo.bean.OrdersBean;
import com.demo.model.Order;

public interface OrdersServiceInt {
	public String makeOrder(Order order);
	public String updateOrder(OrdersBean order);
	public List<Order> getAllOrders();
	public List<Order> getApprovedOrdersByTechnicianName(String userName);
	public List<Order> getOpenOrders();
	public Order getOrder(String orderNum);
	public List<Order> getAllOrders(String orderedBy);
	public String prepareOrderMaking(OrdersBean order);

}
