package com.demo.dao;

import java.util.List;
import java.util.Set;

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
    List<Tickets> getAllAcknowledgedTickets();	
	List<Tickets> getAllTakenTickets();	
	
	List<Tickets> getAllClosedTickets();
	List<Tickets> getAllClosedTickets(String startDate,String endDate);
	List<Tickets> getAllClosedTickets(String startDate,String endDate, String technicianEmail);
	List<Tickets> getAllEscalatedTickets(String startDate,String endDate);
	List<Tickets> getAllEscalatedTickets(String startDate,String endDate,String technicianEmail);
	List<Tickets> getAllBridgedTickets(String startDate,String endDate);
	List<Tickets> getAllBridgedTickets(String startDate,String endDate,String technicianEmail);
	List<Tickets> getAllAwaitingSparesTickets(String startDate,String endDate);
	List<Tickets> getAllAwaitingSparesTickets(String startDate,String endDate,String technicianEmail);
	List<Tickets> getAllOpenTickets(String startDate,String endDate);
	List<Tickets> getAllOpenTickets(String startDate,String endDate,String technicianEmail);
	
	List<Tickets> getAllBridgedTickets();
	List<Tickets> getAllResolvedTickets();
	List<Tickets> getAssignedCallsToTechnician();
	List<Tickets> getAssignedCallsToTechnician(String username);
	List<Tickets> getAllEmployees(String searchName);
	List<PieChart> ticketsResults();
	String updateTicket(TicketsBean ticket);
	
    int ticketCountForTechnician(String technicianEmail);
    List<Tickets> getOpenTicketsForTechnician(String technicianEmail);
    int countEscalatedTickets();
    int countClosedTickets();
    int countBridgedTickets();
    int countOpenTickets();
    int countAwaitingSparesTickets();
    int countResolvedTickets();
    int countAcknowledgedTickets();	
	int countTakenTickets();
    
    int countEscalatedTickets(String technicianEmail);
    int countClosedTickets(String technicianEmail);
    int countBridgedTickets(String technicianEmail);
    int countOpenTickets(String technicianEmail);
    int countAwaitingSparesTickets(String technicianEmail);
    int countResolvedTickets(String technicianEmail);
    int countAcknowledgedTickets(String technicianEmail);	
	int countTakenTickets(String technicianEmail);
    
    List<Tickets> getAllOpenTickets(String technicianEmail);
	List<Tickets> getAllEscalatedTickets(String technicianEmail);
	List<Tickets> getAllAwaitingSpares(String technicianEmail);
	List<Tickets> getAllClosedTickets(String technicianEmail);
	List<Tickets> getAllBridgedTickets(String technicianEmail);
	List<Tickets> getAllResolvedTickets(String technicianEmail);
	List<Tickets> getAllAcknowledgedTickets(String technicianEmail);	
	List<Tickets> getAllTakenTickets(String technicianEmail);	
	List<Tickets> getAwaitingSparesTickets();
	List<Tickets> getLastFourteenDaysTickets();
	
	
	/*void calculateSLAHours();
	void resolveToClosedTicketUpdate();
	void updateSLA(Tickets tickets);*/
	
	
    
	

}
