package com.demo.service;

import java.util.List;

import com.demo.bean.PieChart;
import com.demo.bean.TicketsBean;
import com.demo.model.Tickets;

public interface TicketsServiceInt {

	String logTicket(TicketsBean tickets);

	Tickets getLoggedTicketByTicketNumber(int ticketNumber);

	List<Tickets> getAllLoggedTickets();

	List<Tickets> getAllOpenTickets();

	List<Tickets> getAllEscalatedTickets();

	List<Tickets> getAllAwaitingSpares();

	List<Tickets> getAllClosedTickets();
	List<Tickets> getAllResolvedTickets();

	List<Tickets> getAllBridgedTickets();

	List<Tickets> getAssignedCallsToTechnician();

	List<Tickets> getAssignedCallsToTechnician(String username);
	List<Tickets> getAllClosedTickets(String startDate,String endDate);
	List<Tickets> getAllEscalatedTickets(String startDate,String endDate);
	List<Tickets> getAllBridgedTickets(String startDate,String endDate);
	List<Tickets> getAllAwaitingSparesTickets(String startDate,String endDate);
	List<Tickets> getAllOpenTickets(String startDate,String endDate);

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

	int countResolvedTickets();

	int countEscalatedTickets(String technicianEmail);

	int countClosedTickets(String technicianEmail);

	int countBridgedTickets(String technicianEmail);

	int countOpenTickets(String technicianEmail);

	int countAwaitingSparesTickets(String technicianEmail);

	int countResolvedTickets(String technicianEmail);
	
	List<Tickets> getAllOpenTickets(String technicianEmail);
	List<Tickets> getAllEscalatedTickets(String technicianEmail);
	List<Tickets> getAllAwaitingSpares(String technicianEmail);
	List<Tickets> getAllClosedTickets(String technicianEmail);
	List<Tickets> getAllBridgedTickets(String technicianEmail);
	List<Tickets> getAllResolvedTickets(String technicianEmail);
	
	List<Tickets> getAllClosedTickets(String startDate,String endDate, String technicianEmail);
	List<Tickets> getAllEscalatedTickets(String startDate,String endDate,String technicianEmail);
	List<Tickets> getAllBridgedTickets(String startDate,String endDate,String technicianEmail);
	List<Tickets> getAllAwaitingSparesTickets(String startDate,String endDate,String technicianEmail);
	List<Tickets> getAllOpenTickets(String startDate,String endDate,String technicianEmail);

}
