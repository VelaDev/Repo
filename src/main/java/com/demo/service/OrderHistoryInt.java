package com.demo.service;

import java.util.List;

import com.demo.model.OrderHistory;

public interface OrderHistoryInt {
	List<OrderHistory> getAllOrderHistoryByOrderNumber(int recordID);
	List<OrderHistory> getAllOrderHistoryTicketNumber(int ticketNumber);

}
