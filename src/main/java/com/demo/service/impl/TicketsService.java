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
	public Tickets getLoggedTicketByTicketNumber(Long ticketNumber) {
		
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

	@Override
	public int countResolvedTickets() {
		return logTicketsDAO.countResolvedTickets();
	}

	@Override
	public int countEscalatedTickets(String technicianEmail) {
		return logTicketsDAO.countEscalatedTickets(technicianEmail);
	}

	@Override
	public int countClosedTickets(String technicianEmail) {
		return logTicketsDAO.countClosedTickets(technicianEmail);
	}

	@Override
	public int countBridgedTickets(String technicianEmail) {
		
		return logTicketsDAO.countBridgedTickets(technicianEmail);
	}

	@Override
	public int countOpenTickets(String technicianEmail) {
		return logTicketsDAO.countOpenTickets(technicianEmail);
	}

	@Override
	public int countAwaitingSparesTickets(String technicianEmail) {
		return logTicketsDAO.countAwaitingSparesTickets(technicianEmail);
	}

	@Override
	public int countResolvedTickets(String technicianEmail) {
		return logTicketsDAO.countResolvedTickets(technicianEmail);
	}

	@Override
	public List<Tickets> getAllOpenTickets(String technicianEmail) {
		return logTicketsDAO.getAllOpenTickets(technicianEmail);
	}

	@Override
	public List<Tickets> getAllEscalatedTickets(String technicianEmail) {
		return logTicketsDAO.getAllEscalatedTickets(technicianEmail);
	}

	@Override
	public List<Tickets> getAllAwaitingSpares(String technicianEmail) {
		return logTicketsDAO.getAllAwaitingSpares(technicianEmail);
	}

	@Override
	public List<Tickets> getAllClosedTickets(String technicianEmail) {
		return logTicketsDAO.getAllClosedTickets(technicianEmail);
	}

	@Override
	public List<Tickets> getAllBridgedTickets(String technicianEmail) {
		
		return logTicketsDAO.getAllBridgedTickets(technicianEmail);
	}

	@Override
	public List<Tickets> getAllResolvedTickets(String technicianEmail) {
		
		return logTicketsDAO.getAllResolvedTickets(technicianEmail);
	}

	@Override
	public List<Tickets> getAllResolvedTickets() {
		return logTicketsDAO.getAllResolvedTickets();
	}

	@Override
	public List<Tickets> getAllClosedTickets(String startDate, String endDate) {
		return logTicketsDAO.getAllClosedTickets(startDate, endDate);
	}

	@Override
	public List<Tickets> getAllEscalatedTickets(String startDate, String endDate) {
		return logTicketsDAO.getAllEscalatedTickets(startDate, endDate);
	}

	@Override
	public List<Tickets> getAllBridgedTickets(String startDate, String endDate) {
		return logTicketsDAO.getAllBridgedTickets( startDate,endDate);
	}

	@Override
	public List<Tickets> getAllAwaitingSparesTickets(String startDate,
			String endDate) {
		
		return logTicketsDAO.getAllAwaitingSparesTickets(startDate, endDate);
	}

	@Override
	public List<Tickets> getAllOpenTickets(String startDate, String endDate) {
		return logTicketsDAO.getAllOpenTickets(startDate,endDate);
	}

	@Override
	public List<Tickets> getAllClosedTickets(String startDate, String endDate,
			String technicianEmail) {
		return logTicketsDAO.getAllClosedTickets(startDate, endDate, technicianEmail);
	}

	@Override
	public List<Tickets> getAllEscalatedTickets(String startDate,
			String endDate, String technicianEmail) {
		return logTicketsDAO.getAllEscalatedTickets(startDate, endDate, technicianEmail);
	}

	@Override
	public List<Tickets> getAllBridgedTickets(String startDate, String endDate,
			String technicianEmail) {
		return logTicketsDAO.getAllBridgedTickets(startDate, endDate, technicianEmail);
	}

	@Override
	public List<Tickets> getAllAwaitingSparesTickets(String startDate,
			String endDate, String technicianEmail) {
		return logTicketsDAO.getAllAwaitingSparesTickets(startDate, endDate, technicianEmail);
	}

	@Override
	public List<Tickets> getAllOpenTickets(String startDate, String endDate,
			String technicianEmail) {
		return logTicketsDAO.getAllOpenTickets(startDate, endDate, technicianEmail);
	}

	@Override
	public List<Tickets> getLastFourteenDaysTickets() {
		return logTicketsDAO.getLastFourteenDaysTickets();
	}

	@Override
	public List<Tickets> getAllAcknowledgedTickets() {
		return logTicketsDAO.getAllAcknowledgedTickets();
	}

	@Override
	public List<Tickets> getAllTakenTickets() {
		return logTicketsDAO.getAllTakenTickets();
	}

	@Override
	public List<Tickets> getAllAcknowledgedTickets(String technicianEmail) {
		return logTicketsDAO.getAllAcknowledgedTickets(technicianEmail);
	}

	@Override
	public List<Tickets> getAllTakenTickets(String technicianEmail) {
		return logTicketsDAO.getAllTakenTickets(technicianEmail);
	}

	@Override
	public int countAcknowledgedTickets() {
		return logTicketsDAO.countAcknowledgedTickets();
	}

	@Override
	public int countTakenTickets() {
		return logTicketsDAO.countTakenTickets();
	}

	@Override
	public int countAcknowledgedTickets(String technicianEmail) {
		return logTicketsDAO.countAcknowledgedTickets(technicianEmail);
	}

	@Override
	public int countTakenTickets(String technicianEmail) {
		return logTicketsDAO.countTakenTickets(technicianEmail);
	}

	@Override
	public int getTicketCount(String status, String dateRange,
			String technicianEmail, String customer, Long ticketNumber) {
		return logTicketsDAO.getTicketCount(status, dateRange, technicianEmail, customer, ticketNumber);
	}

	@Override
	public List<Tickets> getTicketListByStatus(String status, String dateRange,
			String technicianEmail, String customer, Long ticketNumber) {
		return logTicketsDAO.getTicketListByStatus(status, dateRange, technicianEmail, customer, ticketNumber);
	}

	@Override
	public List<Tickets> getTicketListByCustomerName(String customer) {
		return logTicketsDAO.getTicketListByCustomerName(customer);
	}

	@Override
	public List<Tickets> getTicketListByDateRange(String dateRange) {
		return logTicketsDAO.getTicketListByDateRange(dateRange);
	}

	@Override
	public List<Tickets> getTicketListByTechnicianEmail(String technicianEmail) {
		return logTicketsDAO.getTicketListByTechnicianEmail(technicianEmail);
	}

	@Override
	public String[] getTicketNumbers() {
		// TODO Auto-generated method stub
		return logTicketsDAO.getTicketNumbers();
	}

	@Override
	public List<Tickets> searchTicketByTicketNumber(Long ticketNumber) {
		return logTicketsDAO.searchTicketByTicketNumber(ticketNumber);
	}

	@Override
	public List<Tickets> getFourteenDaysTicketsForTech(String technicianEmail) {
		return logTicketsDAO.getFourteenDaysTicketsForTech(technicianEmail);
	}

	@Override
	public int getTicketCountForTechnician(String status, String dateRange,
			String technicianEmail, String customer, Long ticketNumber) {
		return logTicketsDAO.getTicketCountForTechnician(status, dateRange, technicianEmail, customer, ticketNumber);
	}

	@Override
	public List<Tickets> getTicketListByStatusForTech(String status,
			String dateRange, String technicianEmail, String customer,
			Long ticketNumber) {
		return logTicketsDAO.getTicketListByStatusForTech(status, dateRange, technicianEmail, customer, ticketNumber);
	}

	@Override
	public List<Tickets> getTicketListByCustomerNameForTech(String customer,
			String technicianEmail) {
		return logTicketsDAO.getTicketListByCustomerNameForTech(customer, technicianEmail);
	}

	@Override
	public List<Tickets> searchByTicketNumberForTech(Long ticketNumber,
			String technicianEmail) {
		return logTicketsDAO.searchByTicketNumberForTech(ticketNumber, technicianEmail);
	}

	@Override
	public String[] getTicketNumbersForTech(String technicianEmail) {
		return logTicketsDAO.getTicketNumbersForTech(technicianEmail);
	}

	@Override
	public String performTicketAction(TicketsBean ticketsBean) {
		retMessage =logTicketsDAO.performTicketAction(ticketsBean);
		return retMessage;
		
	}

	@Override
	public List<Tickets> getTicketByDateAndCustomer(String selecteDate,
			String customerName, String technicianEmai) {
		return logTicketsDAO.getTicketByDateAndCustomer(selecteDate, customerName, technicianEmai);
	}

	@Override
	public List<Tickets> getTicketByDateAndCustomerForManager(
			String selecteDate, String customerName, String technicianEmai) {
	
		return logTicketsDAO.getTicketByDateAndCustomerForManager(selecteDate, customerName, technicianEmai);
	}
	
	

}
