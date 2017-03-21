package com.demo.dao;

import java.util.List;

import com.demo.bean.PieChart;
import com.demo.bean.TicketsBean;
import com.demo.model.Tickets;

public interface TicketsDaoInt {
	
	String logTicket(TicketsBean tickets);
	Tickets getLoggedTicketsByTicketNumber(String ticketNumber);
	List<Tickets> getAllLoggedTickets();
	List<Tickets> getAllLoggedTickets(Integer offset, Integer maxResults);
	List<Tickets> getAllLoggedTickets(String startDate);
	List<Tickets> getAllLoggedTickets(String startDate, String endDate);
	List<Tickets> getAllOpenTickets();
	List<Tickets> getAssignedCallsToTechnician();
	List<Tickets> getAssignedCallsToTechnician(String username);
	void calculateSLAHours();
	String updateTicket(TicketsBean ticket);
	void updateSLA(Tickets tickets);
	List<Tickets> getAllEmployees(String searchName);
	List<PieChart> ticketsResults();
	Integer count();
	

}
