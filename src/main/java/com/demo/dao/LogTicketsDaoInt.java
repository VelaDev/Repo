package com.demo.dao;

import java.util.List;

import com.demo.model.Tickets;

public interface LogTicketsDaoInt {
	
	String logTicket(Tickets tickets);
	Tickets getLoggedTicketsByTicketNumber(String ticketNumber);
	List<Tickets> getAllLoggedTickets();
	List<Tickets> getAllOpenTickets();
	List<Tickets> getAssignedCallsToTechnician();
	List<Tickets> getAssignedCallsToTechnician(String username);
	void calculateSLAHours();
	void updateTicket(Tickets ticket);
	void updateSLA(Tickets tickets);
	List<Tickets> getAllEmployees(String searchName);

}
