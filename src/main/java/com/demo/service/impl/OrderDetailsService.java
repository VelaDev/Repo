package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.OrderDetailsDaoInt;
import com.demo.model.OrderDetails;
import com.demo.service.OrderDetailsInt;

@Service("orderDetailsService")
@Transactional
public class OrderDetailsService implements OrderDetailsInt{
	
	@Autowired
	private OrderDetailsDaoInt orderDetailsDaoInt;

	@Override
	public List<OrderDetails> getOrderDetailsByOrderNum(Integer recordID) {
		
		return orderDetailsDaoInt.getOrderDetailsByOrderNum(recordID);
	}

	@Override
	public List<OrderDetails> getAllOrderDetails() {
		
		return orderDetailsDaoInt.getAllOrderDetails();
	}

	@Override
	public List<OrderDetails> getOrderDetailsByTechnician(String email) {
		
		return orderDetailsDaoInt.getOrderDetailsByTechnician(email);
	}

	@Override
	public List<OrderDetails> getAllAvailableOrderDetails(String technician) {
		return orderDetailsDaoInt.getAllAvailableOrderDetails(technician);
	}

	@Override
	public List<OrderDetails> getOrderDetailsByOrderNum(String key,
			Integer recordID) {
		
		return orderDetailsDaoInt.getOrderDetailsByOrderNum(key, recordID);
	}

}
