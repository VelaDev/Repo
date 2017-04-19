package com.demo.service;

import java.util.List;

import com.demo.bean.PieChart;
import com.demo.bean.TicketsBean;
import com.demo.model.Tickets;

public interface TicketsServiceInt {

	String logTicket(TicketsBean tickets);

	Tickets getLoggedTicketByTicketNumber(String ticketNumber);

	List<Tickets> getAllLoggedTickets();

	List<Tickets> getAllOpenTickets();

	List<Tickets> getAssignedCallsToTechnician();

	List<Tickets> getAssignedCallsToTechnician(String username);

	String updateTicket(TicketsBean ticket);

	List<Tickets> getAllEmployees(String searchName);

	List<PieChart> ticketsResults();

	int ticketCountForTechnician(String technicianEmail);

	List<Tickets> getOpenTicketsForTechnician(String technicianEmail);

	int countEscalatedTickets();

	int countClosedTickets();

	int countBridgedTickets();

	int countOpenTickets();

	int countAwaitingSparesTickets();

}
