package com.demo.dao;

import java.util.List;

import com.demo.model.OrderDetails;

public interface OrderDetailsDaoInt {
	
	String saveOrderDetails(List<OrderDetails> orderDetails);
	List<OrderDetails> getOrderDetailsByOrderNum(Integer recordID);
	List<OrderDetails> getOrderDetailsByOrderNum(String key,Integer recordID);
	List<OrderDetails> getAllOrderDetails();
	List<OrderDetails> getAllAvailableOrderDetails(String technician);
	List<OrderDetails> getOrderDetailsByTechnician(String email);
	String incrementStockAvailability(List<OrderDetails> orderDetails);
	List<OrderDetails> getAllBootStockOrders();
	List<OrderDetails> getAllSiteStockOrders();
}
