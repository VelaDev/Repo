package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.ClientDaoInt;
import com.demo.dao.EmployeeDaoInt;
import com.demo.dao.LogTicketsDaoInt;
import com.demo.dao.ProductDaoInt;
import com.demo.model.Client;
import com.demo.model.Employee;
import com.demo.model.Product;
import com.demo.model.Tickets;

@Repository("LogTicketsDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class LogTicketsDao implements LogTicketsDaoInt {

	@Autowired
	private SessionFactory sessionFactory;

	@Autowired
	private EmployeeDaoInt employeeDaoInt;
	
	@Autowired
	private ClientDaoInt clientDaoInt;
	@Autowired
	private ProductDaoInt productDaoInt;
	@Autowired
	private HttpSession session = null;

	Employee technician = null;
	Client client = null;
	Product product = null;
	Calendar cal = Calendar.getInstance();

	@Override
	public void logTicket(Tickets tickets) {
		try {

			
			technician = employeeDaoInt.getEmployeeByEmpNum(tickets.getTechnicianUserName());
			tickets.setEmployee(technician);
			tickets.setStatus("Open");
			tickets.setSlaStart("Not Started");
			
			//tickets.setTechnicianAcknowledged(false);
			tickets.setEscalate(false);
			sessionFactory.getCurrentSession().save(tickets);
			
			JavaMail.sendFromGMail(tickets);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Tickets getLoggedTicketsByTicketNumber(int ticketNumber) {

		return (Tickets) sessionFactory.getCurrentSession().get(Tickets.class, ticketNumber);
	}

	@Override
	public List<Tickets> getAllLoggedTickets() {

		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tickets> getAllOpenTickets() {

		ArrayList<?> aList = new ArrayList<Object>();
		ArrayList<Tickets> ticketList = new ArrayList<Tickets>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				Tickets.class);

		aList.addAll(criteria.list());
		for (Object tic : aList) {
			if (tic instanceof Tickets) {
				if (((Tickets) tic).getStatus().equalsIgnoreCase("Open")&& (((Tickets)tic).getSlaStart().equalsIgnoreCase("Started"))) {
					ticketList.add((Tickets) tic);
				}
			}
		}
		return ticketList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tickets> getAssignedCallsToTechnician() {

		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				Tickets.class);
		criteria.addOrder(Order.asc("AssignedTechnician"));
		return (List<Tickets>) criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tickets> getAssignedCallsToTechnician(String username) {

		ArrayList<?> aList = new ArrayList<Object>();
		ArrayList<Tickets> ticketList = new ArrayList<Tickets>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Tickets.class);

		aList.addAll(criteria.list());
		for (Object tic : aList) {
			if (tic instanceof Tickets) {
				if (((Tickets) tic).getEmployee().getUsername().equals(username) && ((Tickets) tic).getEmployee().getUsername()!=null) {
					ticketList.add((Tickets) tic);
				}
			}
		}
		return ticketList;
	}

	@SuppressWarnings("unused")
	private Employee assingACallToTechnician() {

		List<Employee> getTechnician = employeeDaoInt.getAllTechnicians();

		technician = technician(getTechnician);
		return technician;

	}

	private Employee technician(List<Employee> emp) {

		Random random = new Random();
		int index = random.nextInt(emp.size());
		return emp.get(index);
	}

	@Transactional(readOnly = true)
	@Scheduled(fixedRate=60000 )//cron="*/5 * * * * MON-FRI*" this method will be invoked after every 5 min to perform calculations and update relevant table
	@Override
	public void calculateSLAHours() {
		
		   Calendar cal = Calendar.getInstance();
		   
		   @SuppressWarnings("deprecation")
		int currentHour = cal.getTime().getHours();
		   
		   List<Tickets> openTickets= getAllOpenTickets();
		   for(Tickets openTicket:openTickets){
			   
			   @SuppressWarnings("deprecation")
			int slaStartedHour = openTicket.getSlaAcknowledgeDateTime().getTime().getHours();
			  long diffHours = slaStartedHour - currentHour;
			  System.out.println("SLA started hour: "+ " "+  slaStartedHour);
			  System.out.println(diffHours);
			  
			  if(diffHours >=4){
				  System.out.println(" Update ticket");
				  openTicket.setStatus("Unresolved");
				  openTicket.setComments("The ticket is closed because technician was drunk");
				  updateSLA(openTicket);
			  }
		   }
	}

	@Override
	public void updateTicket(Tickets ticket) {
		
		String technicianTemp = (String) session.getAttribute("loggedInUser");
		String clientTemp =   (String) session.getAttribute("client");
		String productTemp = (String) session.getAttribute("product");
		
		technician = employeeDaoInt.getEmployeeByEmpNum(technicianTemp);
		client = clientDaoInt.getClientByClientName(clientTemp);
		product = productDaoInt.getProductBySerialNumbuer(productTemp);
		ticket.setProduct(product);
		ticket.setEmployee(technician);
		ticket.setSlaStart("Started");
		ticket.setSlaAcknowledgeDateTime(cal);
		sessionFactory.getCurrentSession().update(ticket);
		
	}
	@Override
	public void updateSLA(Tickets tickets)
	{
		sessionFactory.getCurrentSession().update(tickets);
		System.out.print("Updated "+ " "+ tickets.getTicketNumber());
	}

	@Override
	public List<Tickets> getAllEmployees(String searchName) {
		
		return null;
	}
}
