package com.demo.dao.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.TicketsBean;
import com.demo.dao.ClientDaoInt;
import com.demo.dao.EmployeeDaoInt;
import com.demo.dao.LogTicketsDaoInt;
import com.demo.dao.DeviceDaoInt;
import com.demo.dao.TicketHistoryDaoInt;
import com.demo.model.Client;
import com.demo.model.Employee;
import com.demo.model.Device;
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
	private DeviceDaoInt deviceDaoInt;
	@Autowired
	private TicketHistoryDaoInt historyDaoInt;
	@Autowired
	private HttpSession session = null;
	private Session session2;
	

	private Employee technician = null;
	private Client client = null;
	private Device device = null;
	 private Tickets ticket = null;
	Calendar cal = Calendar.getInstance();
	DateFormat dateFormat = null;
	Date date = null;
    private String retMessage="";
    private String ticketNum ="INC000";
    private List<Tickets> ticketList = null;
    private TicketsBean ticketBean = null;
   
	@Override
	public String logTicket(TicketsBean tickets) {
		String ticketNumber = ""; 
		ticket = new Tickets();
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		try {

			technician = employeeDaoInt.getEmployeeByEmpNum(tickets.getTechnicianUserName());
			if(technician != null){
				device = deviceDaoInt.getDeviceBySerialNumbuer(tickets.getDevice());
				if(device !=null){
					ticketNumber = newTicketNumber();
					ticket.setTicketNumber(ticketNumber);
					ticket.setEmployee(technician);
					ticket.setStatus("Open");
					ticket.setSlaStart("Not Started");
					ticket.setDescription(tickets.getDescription());
					ticket.setPriority(tickets.getPriority());
					ticket.setDateTime(dateFormat.format(date));
					
					ticket.setDevice(device);
					ticket.setEscalate(false);
					sessionFactory.getCurrentSession().save(ticket);
					
					historyDaoInt.insertTicketHistory(ticket);
					
					retMessage = "Ticket "+ticket.getTicketNumber()+ " is assigned to technician "+ ticket.getEmployee().getFirstName()+".\nAn email has been sent to customer "+ ticket.getDevice().getClient().getClientName();
					JavaMail.sendFromGMail(ticket);
				}
				else{
					retMessage="Device "+device.getSerialNumber()+" does not exist. Ticket "+ticket.getTicketNumber()+" cannot be logged";
				}
				
			}
			else{
				retMessage = "Ticket "+ticket.getTicketNumber() +" is assigned to non-existant technician ";
			}
			
		} catch (Exception e) {
			retMessage = "Ticket " +ticket.getTicketNumber()+" was not logged "+ e.getMessage();
		}
		return retMessage;
	}

	@Override
	public Tickets getLoggedTicketsByTicketNumber(String ticketNumber) {

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
			  System.out.println("SLA started at: "+ " "+  slaStartedHour);
			  System.out.println(diffHours);
			  
			  if(diffHours <=1){
				  
				  openTicket.setStatus("Unresolved");
				  openTicket.setComments("The ticket is closed because technician was drunk");
				  updateSLA(openTicket);
			  }
		   }
	}

	@Override
	public String updateTicket(TicketsBean tickets) {
		ticket = new  Tickets();
		try{
			
			  ticket = getLoggedTicketsByTicketNumber(tickets.getTicketNumber());
			  
			   if(ticket.getSlaStart().equalsIgnoreCase("Started") && tickets.getEscalateReason()!=null || tickets.getEscalateReason()!=null){
				  ticket.setComments(tickets.getComments());
				  ticket.setEscalateReason(tickets.getEscalateReason());
				  ticket.setEscalate(true);
				  sessionFactory.getCurrentSession().saveOrUpdate(ticket);
				  historyDaoInt.insertTicketHistory(ticket);
				  retMessage = "SLA for ticket "+ ticket.getTicketNumber()+ " started";
			  }
			   else if(ticket.getSlaStart().equalsIgnoreCase("Started")){
				   
				      technician = employeeDaoInt.getEmployeeByEmpNum(tickets.getTechnicianUserName());
				      ticket.setEmployee(technician);
				      ticket.setComments("Assigned to next available technician");
				      ticket.setSlaStart("Not Started");
					  //ticket.setSlaAcknowledgeDateTime(cal);
					  //ticket.setTechnicianAcknowledged(true);
					  sessionFactory.getCurrentSession().update(ticket);
					  historyDaoInt.insertTicketHistory(ticket);
					  retMessage = "Ticket "+ ticket.getTicketNumber()+ " is now assigned to " + ticket.getEmployee().getUsername() ;
				  }
			  else{
				  ticket.setSlaStart("Started");
				  ticket.setSlaAcknowledgeDateTime(cal);
				  ticket.setTechnicianAcknowledged(true);
				  sessionFactory.getCurrentSession().update(ticket);
				  historyDaoInt.insertTicketHistory(ticket);
				  retMessage = "SLA for ticket "+ ticket.getTicketNumber()+ " started";
				  
			  }
			  
			
		}catch(Exception e){
			retMessage = "SLA did not start because of "+ e.getMessage();
		}
		return retMessage;
	}
	@Override
	public void updateSLA(Tickets tickets)
	{
		try{
			
			System.out.println(tickets.getStatus()+" and " + tickets.getComments()+ " "+ tickets.getTicketNumber()+ " "+ tickets.getDevice().getProductModel());
			System.out.println("About to insert");
			sessionFactory.getCurrentSession().saveOrUpdate(tickets);
			sessionFactory.getCurrentSession().beginTransaction().commit();
			System.out.println("Updated Now now"+ " "+ tickets.getTicketNumber());
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		}
	}

	@Override
	public List<Tickets> getAllEmployees(String searchName) {
		
		return null;
	}
	
private String generateTicketNumber(){
		
		session2=sessionFactory.openSession();
		String result ="";
		Query query = session2.createQuery("from Tickets order by ticketNumber DESC");
		query.setMaxResults(1);
		Tickets ticketNumber = (Tickets) query.uniqueResult();
		if(ticketNumber != null){
			result = ticketNumber.getTicketNumber();
		}
		else{
			result = null;
		}
		return result;
	}
	private String newTicketNumber(){
		String tempTicket = "";
		int tempTicketNum = 0;
		String newTicketNum = generateTicketNumber();
		
		if (newTicketNum != null){
			tempTicket = newTicketNum.substring(6);
			tempTicketNum = Integer.parseInt(tempTicket)+1;
			newTicketNum = ticketNum+ tempTicketNum;
		}
		else{
			/*newTicketNum = "TIC-VEL-1";*/
			newTicketNum = "INC0001";
		}
		
		return newTicketNum;
	}

	@SuppressWarnings("unchecked")
	@Override
	public TicketsBean ticketsResults() {
		double openTickets = 0;
		double closedTickets = 0;
		double escalatedTickets = 0;
		double loggedTickets = 0;
		double totalTickets = 0;
		double totalOpenTickets = 0;
		double totalclosedTickets = 0;
		double totalEscalatedTickets = 0;
		double totalLoggegedTickets = 0;
		ticketBean = new TicketsBean();
		try{
			
			Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Tickets.class);
			
			ticketList = (List<Tickets>)criteria.list();
			
			for(Tickets ticket:ticketList){
				if(ticket.getSlaStart().equalsIgnoreCase("Started")){
					openTickets ++;
				}
				else if(ticket.getSlaStart().equalsIgnoreCase("Escalated")){
					escalatedTickets ++;
				}
				else if(ticket.getSlaStart().equalsIgnoreCase("Closed")){
					closedTickets ++;
				}
				else {
					loggedTickets++;
				}
				totalTickets ++;
			}
			 totalOpenTickets = (openTickets/totalTickets)*100;
			 totalclosedTickets = (closedTickets/totalTickets)*100;
			 totalEscalatedTickets = (escalatedTickets/totalTickets)*100;
			 totalLoggegedTickets = (loggedTickets/totalTickets)*100;
			
			ticketBean.setOpenTickets(totalOpenTickets);
			ticketBean.setClosedTickets(totalclosedTickets);
			ticketBean.setEscalatedTickets(totalEscalatedTickets);
			ticketBean.setLoggedTickets(totalLoggegedTickets);
		}
		catch(Exception ex)
		{
			
		}
		return ticketBean;
	}

	
}
