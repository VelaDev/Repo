package com.demo.service;

import java.util.List;

import com.demo.model.BootStock;

public interface BootStockInt {
	
	List<BootStock> getAllOrders();
	List<BootStock> getAllOrders(String technician,int ticketRecordID);
	List<BootStock> getAllOrders(String technician);

}
