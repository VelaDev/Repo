package com.demo.dao;

import java.util.List;

import com.demo.bean.OrdersBean;
import com.demo.model.Orders;

public interface OrdersDaoInt {
	
	public String makeOrder(OrdersBean orders);
	public String updateOrder(OrdersBean order);
	public List<Orders> getAllOrders();
	public List<Orders> getApprovedOrdersByTechnicianName(String userName);
	public List<Orders> getOpenOrders();
	public Orders getOrder(String orderNum);
	public List<Orders> getAllOrders(String orderedBy);

}
