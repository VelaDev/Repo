package com.demo.dao;

import java.util.List;

import com.demo.model.TicketHistory;
import com.demo.model.Tickets;

public interface TicketHistoryDaoInt {
	void insertTicketHistory(Tickets ticket);
	List<TicketHistory> getHistoryByTicketNumber(int ticketNumber);

}
