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
	public List<OrderDetails> getOrderDetailsByOrderNum(String orderNum) {
		
		return orderDetailsDaoInt.getOrderDetailsByOrderNum(orderNum);
	}

	@Override
	public List<OrderDetails> getAllOrderDetails() {
		
		return orderDetailsDaoInt.getAllOrderDetails();
	}

}
