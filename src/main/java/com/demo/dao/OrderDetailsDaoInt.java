package com.demo.dao;

import java.util.List;

import com.demo.model.OrderDetails;

public interface OrderDetailsDaoInt {
	
	String saveOrderDetails(List<OrderDetails> orderDetails);
	List<OrderDetails> getOrderDetailsByOrderNum(String orderNum);
	List<OrderDetails> getAllOrderDetails();
	List<OrderDetails> getAllAvailableOrderDetails(String technician);
	List<OrderDetails> getOrderDetailsByTechnician(String email);
}
