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
	public int ticketCountForTechnician(String technicianEmail) {
		return logTicketsDAO.ticketCountForTechnician(technicianEmail);
	}

	@Override
	public List<Tickets> getOpenTicketsForTechnician(String technicianEmail) {
		
		return logTicketsDAO.getOpenTicketsForTechnician(technicianEmail);
	}

	@Override
	public int countEscalatedTickets() {
		return logTicketsDAO.countEscalatedTickets();
	}

	@Override
	public int countClosedTickets() {
		return logTicketsDAO.countClosedTickets();
	}

	@Override
	public int countBridgedTickets() {

		return logTicketsDAO.countBridgedTickets();
	}

	@Override
	public int countOpenTickets() {
	
		return logTicketsDAO.countOpenTickets();
	}

	@Override
	public int countAwaitingSparesTickets() {
		
		return logTicketsDAO.countAwaitingSparesTickets();
	}
	
	@Override
	public List<Tickets> getAllEscalatedTickets() {
		
		return logTicketsDAO.getAllEscalatedTickets();
	}

	@Override
	public List<Tickets> getAllAwaitingSpares() {
		
		return logTicketsDAO.getAllAwaitingSpares();
	}

	@Override
	public List<Tickets> getAllClosedTickets() {
		
		return logTicketsDAO.getAllClosedTickets();
	}

	@Override
	public List<Tickets> getAllBridgedTickets() {
		
		return logTicketsDAO.getAllBridgedTickets();
	}
}
