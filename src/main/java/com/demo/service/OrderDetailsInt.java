package com.demo.service;

import java.util.List;

import com.demo.model.OrderDetails;

public interface OrderDetailsInt {
	List<OrderDetails> getOrderDetailsByOrderNum(Integer recordID);
	List<OrderDetails> getAllOrderDetails();
	List<OrderDetails> getOrderDetailsByTechnician(String email);
	List<OrderDetails> getAllAvailableOrderDetails(String technician);
	List<OrderDetails> getOrderDetailsByOrderNum(String key,Integer recordID);

}
