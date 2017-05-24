package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.BootStockDaoInt;
import com.demo.model.BootStock;
import com.demo.service.BootStockInt;

@Service("bootStockService")
public class BootStockService implements BootStockInt{
	
	@Autowired
	private BootStockDaoInt bootStockDaoInt;

	@Override
	public List<BootStock> getAllOrders() {
		return bootStockDaoInt.getAllOrders();
		
	}

	@Override
	public List<BootStock> getAllOrders(String technician) {
		
		return bootStockDaoInt.getAllOrders(technician);
	}

	@Override
	public List<BootStock> getAllOrders(String technician, int ticketRecordID) {
		
		return bootStockDaoInt.getAllOrders(technician, ticketRecordID);
	}

}
