package com.demo.service;

import java.util.List;

import com.demo.model.OrderDetails;

public interface OrderDetailsInt {
	List<OrderDetails> getOrderDetailsByOrderNum(String orderNum);
	List<OrderDetails> getAllOrderDetails();
	List<OrderDetails> getOrderDetailsByTechnician(String email);
	List<OrderDetails> getAllAvailableOrderDetails(String technician);

}
