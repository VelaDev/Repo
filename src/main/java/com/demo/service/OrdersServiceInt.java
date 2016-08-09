package com.demo.service;

import java.util.List;

import com.demo.model.Orders;

public interface OrdersServiceInt {
	public String makeOrder(Orders orders);
	public String updateOrder(Orders order);
	public List<Orders> getAllOrders();
	public List<Orders> getApprovedOrders();
	public List<Orders> getOpenOrders();
	public Orders getOrder(String orderNum);

}
