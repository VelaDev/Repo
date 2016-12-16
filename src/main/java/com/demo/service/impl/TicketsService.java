package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.PieChart;
import com.demo.bean.TicketsBean;
import com.demo.dao.TicketsDaoInt;
import com.demo.model.Tickets;
import com.demo.service.TicketsServiceInt;

@Service("logTicketsService")
@Transactional
public class TicketsService implements TicketsServiceInt{
	
	@Autowired
	private TicketsDaoInt logTicketsDAO;
	private String retMessage ="";

	@Override
	public String logTicket(TicketsBean tickets) {

		retMessage =logTicketsDAO.logTicket(tickets);
		return retMessage;
		
	}

	@Override
	public Tickets getLoggedTicketByTicketNumber(String ticketNumber) {
		
		return logTicketsDAO.getLoggedTicketsByTicketNumber(ticketNumber);
	}

	@Override
	public List<Tickets> getAllLoggedTickets() {
		
		return logTicketsDAO.getAllLoggedTickets();
	}

	@Override
	public List<Tickets> getAllOpenTickets() {
		return logTicketsDAO.getAllOpenTickets();
	}

	@Override
	public List<Tickets> getAssignedCallsToTechnician() {
		
		return logTicketsDAO.getAssignedCallsToTechnician();
	}

	@Override
	public List<Tickets> getAssignedCallsToTechnician(String username) {
		return logTicketsDAO.getAssignedCallsToTechnician(username);
	}

	@Override
	public String updateTicket(TicketsBean ticket) {
		retMessage =logTicketsDAO.updateTicket(ticket);
		return retMessage;
		
	}

	@Override
	public List<Tickets> getAllEmployees(String searchName) {
		
		return logTicketsDAO.getAllEmployees(searchName);
	}

	@Override
	public List<PieChart> ticketsResults() {
		return logTicketsDAO.ticketsResults();
	}

	@Override
	public List<Tickets> getAllLoggedTickets(Integer offset, Integer maxResults) {
		return logTicketsDAO.getAllLoggedTickets(offset, maxResults);
	}

	@Override
	public Integer count() {
		
		return logTicketsDAO.count();
	}

}
