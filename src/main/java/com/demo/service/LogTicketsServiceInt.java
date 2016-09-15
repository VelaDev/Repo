package com.demo.service;

import java.util.List;




import com.demo.model.Tickets;

public interface LogTicketsServiceInt {
	
	String logTicket(Tickets tickets);
	Tickets getLoggedTicketByTicketNumber(String ticketNumber);
	List<Tickets> getAllLoggedTickets();
	List<Tickets> getAllOpenTickets();
	List<Tickets> getAssignedCallsToTechnician();
	List<Tickets> getAssignedCallsToTechnician(String username);
	void updateTicket(Tickets ticket);
	List<Tickets> getAllEmployees(String searchName);

}
