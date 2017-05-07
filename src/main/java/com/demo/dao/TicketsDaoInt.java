package com.demo.dao;

import java.util.List;

import com.demo.bean.PieChart;
import com.demo.bean.TicketsBean;
import com.demo.model.Tickets;

public interface TicketsDaoInt {
	
	String logTicket(TicketsBean tickets);
	Tickets getLoggedTicketsByTicketNumber(int ticketNumber);
	List<Tickets> getAllLoggedTickets();
	List<Tickets> getAllLoggedTickets(String startDate);
	List<Tickets> getAllLoggedTickets(String startDate, String endDate);
	List<Tickets> getAllOpenTickets();
	List<Tickets> getAllEscalatedTickets();
	List<Tickets> getAllAwaitingSpares();
	List<Tickets> getAllClosedTickets();
	List<Tickets> getAllBridgedTickets();
	List<Tickets> getAllResolvedTickets();
	List<Tickets> getAssignedCallsToTechnician();
	List<Tickets> getAssignedCallsToTechnician(String username);
	List<Tickets> getAllEmployees(String searchName);
	List<PieChart> ticketsResults();
	void calculateSLAHours();
	String updateTicket(TicketsBean ticket);
	void updateSLA(Tickets tickets);
	
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
	
	void resolveToClosedUpdate();
    
	

}
