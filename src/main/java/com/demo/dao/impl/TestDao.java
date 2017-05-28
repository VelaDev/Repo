package com.demo.dao.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.TestDaoSs;
import com.demo.dao.TicketHistoryDaoInt;
import com.demo.model.Tickets;


@Repository("LogTicketsDAOTest")
@Transactional(propagation = Propagation.REQUIRED)
public class TestDao implements TestDaoSs {
	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private TicketHistoryDaoInt historyDaoInt;
	
	Calendar cal = Calendar.getInstance();
	DateFormat dateFormat = null;
	Date date = null;
	private Date currentDate = null;
	private SimpleDateFormat myFormat = null;
	private List<Tickets> ticketList = null;
	ArrayList<Tickets> aList = null;
	
	public List<Tickets> getAllLoggedTickets() {

		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Tickets.class);
		return (List<Tickets>)criteria.list(); 
	}

	@Scheduled(fixedRate = 600000)
	@Override
	public void calculateSLAHours() {

		long day =0,diff=0;
		try {
			Calendar cal = Calendar.getInstance();
			dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			String currentDate =  dateFormat.format(cal.getTime());
			
			Date systemDate = dateFormat.parse(currentDate);
			List<Tickets> openTickets = getAllOpenTickets();
			
			for (Tickets openTicket : openTickets) {
				
				String loggedTimeTicket = openTicket.getDateTime();
				Date loggedTicketDate = dateFormat.parse(loggedTimeTicket);
				
				diff =systemDate.getTime()- loggedTicketDate.getTime();
	            day = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
	           
	              long hour = TimeUnit.HOURS.convert(diff, TimeUnit.MILLISECONDS);

				if(hour >=1 && hour< 4){
					
					openTicket.setComments("System update");
					openTicket.setOneHourFlag(true);
					updateSLA(openTicket);
					/*JavaMail.oneHourReminder(openTicket,
							mails);*/
					
				} else if (hour>=4) {
					openTicket.setStatus("SLA Bridged");
					openTicket.setFourHourFlag(true);
					openTicket.setComments("System update");
					updateSLA(openTicket);
					historyDaoInt.insertTicketHistory(openTicket);
					/*JavaMail.fourHourReminder(openTicket,mails
							);*/
				}
			}
		} catch (Exception e) {
			e.getMessage();
		}
	}
	public List<Tickets> getAllOpenTickets() {
	    List<Tickets>aList = new ArrayList<Tickets>();
		try{
			ticketList = getAllLoggedTickets();
			for(Tickets ticket:ticketList){
				if((ticket.getStatus().equalsIgnoreCase("Open")&& ticket.isOneHourFlag()==false)){
					aList.add(ticket);
				}else if((ticket.getStatus().equalsIgnoreCase("Open")&& ticket.isOneHourFlag()==true && ticket.isFourHourFlag()==false)){
					aList.add(ticket);
				}
			}
		}catch(Exception exception){
			exception.getMessage();
		}
		
		return aList;
	}
	@Transactional
	@Scheduled(fixedRate = 60000)
	@Override
	public void resolveToClosedTicketUpdate() {
		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		Calendar cal = Calendar.getInstance();
	    String date1 =  myFormat.format(cal.getTime());
	    String date2= null;
	    Date secondDate =null;
	    try{
	    	List<Tickets> ticketList = getResolvedTickets();
	    	currentDate = myFormat.parse(date1);
	    	
	    	for(Tickets ticket:ticketList){
	    		date2 = ticket.getDateResolved();
	    		currentDate= myFormat.parse(date1);
	    		secondDate= myFormat.parse(date2);
	    		long difference = currentDate.getTime()- secondDate.getTime();
	    		// 86400 is equal to 24 hrs
	    		if(difference > 86400){
	    			
	    			ticket.setStatus("Closed");
	    			sessionFactory.getCurrentSession().update(ticket);
	    			historyDaoInt.insertTicketHistory(ticket);
	    		}
	    		
	    	}
	    	
	    }catch(Exception e){
	    	e.getMessage();
	    }
		
	}
	private List<Tickets> getResolvedTickets() {
	    aList = new ArrayList<Tickets>();
		try{
			ticketList = getAllLoggedTickets();
			for(Tickets ticket:ticketList){
				if((ticket.getStatus().equalsIgnoreCase("Resolved"))){
					aList.add(ticket);
				}
			}
		}catch(Exception exception){
			exception.getMessage();
		}
		
		return aList;
	}

	@Override
	public void updateSLA(Tickets tickets) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(tickets);
			sessionFactory.getCurrentSession().beginTransaction().commit();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	}
}
