package com.demo.reports;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.demo.model.OrderDetails;
import com.demo.service.OrderDetailsInt;



public class DeliveryReport {
	
	@Autowired
	private OrderDetailsInt detailsInt;

	public List<OrderDetails> gettOrders(String key,String orderNumber){
		
		List <OrderDetails> list = detailsInt.getOrderDetailsByOrderNum("orders",orderNumber);
		return list;
	}
}
