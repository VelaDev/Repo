package com.demo.dao;

import java.util.List;

import com.demo.model.BootStock;
import com.demo.model.OrderDetails;

public interface BootStockDaoInt {
	
	void saveBootStock(List<OrderDetails> detailsDaos);
	List<BootStock> getAllOrders();
	List<BootStock> getAllOrders(String technician);
	void updateBootStock(BootStock bootStock);
	List<BootStock> getAllOrders(String technician, int ticketRecordID);

}
