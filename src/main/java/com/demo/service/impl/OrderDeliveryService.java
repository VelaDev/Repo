package com.demo.service.impl;



import javax.transaction.Transactional;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.OrderReportsDaoInt;
import com.demo.service.OrderDeliveryServiceInt;


@Service("orderDelivery")
@Transactional
public class OrderDeliveryService implements OrderDeliveryServiceInt{


	@Autowired
	private OrderReportsDaoInt reportsDaoInt;
	@Override
	public void createPdf(Integer recordID){
		reportsDaoInt.createPdf(recordID);
		
	}
}
