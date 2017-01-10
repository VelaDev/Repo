package com.demo.dao;

import java.util.List;

import com.demo.bean.OrdersBean;
import com.demo.model.OrdersHeader;

public interface OrdersDaoInt {
	
	public String makeOrder(OrdersHeader ordersHeader);
	public String updateOrder(OrdersBean order);
	public List<OrdersHeader> getAllOrders();
	public List<OrdersHeader> getApprovedOrdersByTechnicianName(String userName);
	public List<OrdersHeader> getOpenOrders();
	public OrdersHeader getOrder(String orderNum);
	public List<OrdersHeader> getAllOrders(String orderedBy);
	public String prepareOrderMaking(OrdersBean order);
	public List<OrdersHeader> pendingOrders();
	public String approveOrder(String orderNum);

}
