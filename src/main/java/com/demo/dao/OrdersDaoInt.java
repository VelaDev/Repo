package com.demo.dao;

import java.util.List;

import com.demo.bean.OrdersBean;
import com.demo.model.OrderHeader;

public interface OrdersDaoInt {
	
	public String makeOrder(OrderHeader orderHeader);
	public String updateOrder(OrdersBean order);
	public List<OrderHeader> getAllOrders();
	public List<OrderHeader> getApprovedOrdersByTechnicianName(String userName);
	public List<OrderHeader> getOpenOrders();
	public OrderHeader getOrder(Integer recordID);
	public List<OrderHeader> getAllOrders(String orderedBy);
	public String prepareOrderMaking(OrdersBean order);
	public List<OrderHeader> pendingOrders();
	public String approveOrder(Integer recordID);
	public List<OrderHeader>pendingOrders(String approveName);
	public int pendingOrdersCount(String approveName);
	public String approveShipment(Integer recordID);
	public List<OrderHeader> shippedOrders();
	public List<OrderHeader> shippedOrders(String technicianEmail);
	public String declineOrder(String orderNum,String reasonForeclined);
	public int technicianOrdersCount(String technicianName);

}
