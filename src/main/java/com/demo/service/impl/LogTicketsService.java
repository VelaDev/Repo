package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.LogTicketsDaoInt;
import com.demo.model.Tickets;
import com.demo.service.LogTicketsServiceInt;

@Service("logTicketsService")
@Transactional
public class LogTicketsService implements LogTicketsServiceInt{
	
	@Autowired
	private LogTicketsDaoInt logTicketsDAO;
	private String retMessage ="";

	@Override
	public String logTicket(Tickets tickets) {

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
	public void updateTicket(Tickets ticket) {
		logTicketsDAO.updateTicket(ticket);
		
	}

	@Override
	public List<Tickets> getAllEmployees(String searchName) {
		
		return logTicketsDAO.getAllEmployees(searchName);
	}

}
