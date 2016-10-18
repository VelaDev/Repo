package com.demo.dao.impl;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.TicketHistoryDaoInt;
import com.demo.model.Accessories;
import com.demo.model.TicketHistory;
import com.demo.model.Tickets;

@Repository("ticketHistoryDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class TicketHistoryDao implements TicketHistoryDaoInt{

	
	@Autowired
	private SessionFactory sessionFactory;
	
	private TicketHistory ticketHistory=null;
	
	DateFormat dateFormat = null;
	Date date = null;
	
	List<TicketHistory> ticketHistoryList = null;
	ArrayList<?> aList = null;
	ArrayList list = null;
	
	@Override
	public void insertTicketHistory(Tickets ticket) {
		ticketHistory = new TicketHistory();
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		try{
			
			  ticketHistory.setTicketNumber(ticket.getTicketNumber());
			  ticketHistory.setComment(ticket.getComments());
			  ticketHistory.setEscalatedDate(dateFormat.format(date));
			  ticketHistory.setEscalatedReason(ticket.getEscalateReason());
			  ticketHistory.setSolution(ticket.getSolution());
			  sessionFactory.getCurrentSession().save(ticketHistory);
			
		}catch(Exception e){
			e.getMessage();
		}
		
		
	}

	@Override
	public List<TicketHistory> getHistoryByTicketNumber(String ticketNumber) {
		
try{
			
		    aList = new ArrayList<Object>();
		     ticketHistoryList = new ArrayList<TicketHistory>();
			Criteria criteria = sessionFactory.getCurrentSession().createCriteria(TicketHistory.class);
			aList.addAll(criteria.list());
			for (Object ticket : aList) {
				if (ticket instanceof TicketHistory) {
					if (((TicketHistory)ticket).getTicketNumber().equalsIgnoreCase(ticketNumber)) {
						ticketHistoryList.add((TicketHistory) ticket);
						
					}
				}
			}
	}catch(Exception ex){
		return null;
	}
		return ticketHistoryList;
	}
}
