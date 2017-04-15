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
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.PieChart;
import com.demo.bean.TicketsBean;
import com.demo.dao.CustomerDaoInt;
import com.demo.dao.EmployeeDaoInt;
import com.demo.dao.OrdersDaoInt;
import com.demo.dao.TicketsDaoInt;
import com.demo.dao.DeviceDaoInt;
import com.demo.dao.TicketHistoryDaoInt;
import com.demo.model.Customer;
import com.demo.model.Employee;
import com.demo.model.Device;
import com.demo.model.OrderHeader;
import com.demo.model.Tickets;

@Repository("LogTicketsDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class TicketsDao implements TicketsDaoInt {

	@Autowired
	private SessionFactory sessionFactory;

	@Autowired
	private EmployeeDaoInt employeeDaoInt;
	
	@Autowired
	private CustomerDaoInt customerDaoInt;
	@Autowired
	private DeviceDaoInt deviceDaoInt;
	@Autowired
	private TicketHistoryDaoInt historyDaoInt;
	@Autowired
	private OrdersDaoInt ordersDaoInt;
	@Autowired
	private HttpSession session = null;
	private Session session2;
	

	private Employee technician = null;
	private Customer customer = null;
	private OrderHeader order = null;
	private Device device = null;
	 private Tickets ticket = null;
	Calendar cal = Calendar.getInstance();
	DateFormat dateFormat = null;
	Date date = null;
    private String retMessage="";
    private String ticketNum ="VTC000";
    private List<Tickets> ticketList = null;
    private PieChart pieChart = null;
    private PieChart pieChart1 = null;
    private PieChart pieChart2 = null;
    private PieChart pieChart3 = null;
    private PieChart pieChart4 = null;
    private PieChart pieChart5 = null;
    private List<PieChart> beanList = null;
   
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
					ticket.setSlaStart("Started");
					ticket.setOneHourFlag(false);
					ticket.setFourHourFlag(false);
					ticket.setDescription(tickets.getDescription());
					ticket.setPriority(tickets.getPriority());
					ticket.setDateTime(dateFormat.format(date));
					
					ticket.setDevice(device);
					ticket.setEscalate(false);
					sessionFactory.getCurrentSession().save(ticket);
					
					historyDaoInt.insertTicketHistory(ticket);
					
					retMessage = "Ticket "+ticket.getTicketNumber()+ " is assigned to technician "+ ticket.getEmployee().getFirstName()+".\nAn email has been sent to customer "+ ticket.getDevice().getCustomerDevice().getCustomerName();
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
				if (((Tickets) tic).getStatus().equalsIgnoreCase("Open") && (((Tickets)tic).isOneHourFlag()==false)) {
					ticketList.add((Tickets) tic);
				}
				else if(((Tickets) tic).getStatus().equalsIgnoreCase("Open") && (((Tickets)tic).isOneHourFlag()==true)&& (((Tickets)tic).isFourHourFlag()==false)){
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
				if (((Tickets) tic).getEmployee().getEmail().equals(username) && ((Tickets) tic).getEmployee().getEmail()!=null) {
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

	@Transactional
	@Scheduled(fixedRate=600000 )///cron="*/5 * * * * MON-FRI*" this method will be invoked after every 10 min to perform calculations and update relevant fields 
	@Override
	public void calculateSLAHours() {
		
		
		try{
			Calendar cal = Calendar.getInstance();
			   
			   @SuppressWarnings("deprecation")
			   int currentHour = cal.getTime().getHours();
			   
			   List<Tickets> openTickets= getAllOpenTickets();
			   for(Tickets openTicket:openTickets){
				   dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				   date = new Date();
				   @SuppressWarnings("deprecation")
				   String tempDate = openTicket.getDateTime();
				  date = dateFormat.parse(tempDate);
				  
				  int slaStartedHour = date.getHours();
				  long diffHours = slaStartedHour - currentHour;
				  System.out.println("SLA started at: "+ " "+  slaStartedHour);
				  System.out.println(diffHours);
				  
				  if(diffHours >=1 && diffHours < 4){
					  
					  
					  openTicket.setComments("System update");
					  openTicket.setOneHourFlag(true);
					  updateSLA(openTicket);
					  JavaMail.oneHourReminder(openTicket, "cassino.happies@gmail.com", "mohapi27@outlook.com");
				  }
				  else if(diffHours >=4){
					  openTicket.setStatus("SLA Bridged");
					  openTicket.setFourHourFlag(true);
					  openTicket.setComments("System update");
					  updateSLA(openTicket);
					  JavaMail.fourHourReminder(openTicket, "cassino.happies@gmail.com", "mohapi27@outlook.com");
				  }
			   }
		}catch(Exception e){
			e.getMessage();
		}
	}

	@Override
	public String updateTicket(TicketsBean tickets) {
		ticket = new  Tickets();
		order = new OrderHeader();
		try{
			
			  ticket = getLoggedTicketsByTicketNumber(tickets.getTicketNumber());
			  
			   if(ticket.getStatus().equalsIgnoreCase("Open") && tickets.getEscalateReason()!=null){
				  ticket.setComments(tickets.getComments());
				  ticket.setEscalateReason(tickets.getEscalateReason());
				  ticket.setEscalate(true);
				  ticket.setStatus("Awaiting HOStock");
				  //order = ordersDaoInt.getOrder(tickets.getOrderNumber());
				  ticket.setOrderHeader(order);
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
					  retMessage = "Ticket "+ ticket.getTicketNumber()+ " is now assigned to " + ticket.getEmployee().getFirstName() ;
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
			
			System.out.println(tickets.getStatus()+" and " + tickets.getComments()+ " "+ tickets.getTicketNumber()+ " "+ tickets.getDevice().getModelNumber());
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
			  newTicketNum = "VTC0001";
		}
		
		return newTicketNum;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PieChart> ticketsResults() {
		int openTickets = 0;
		int closedTickets = 0;
		int escalatedTickets = 0;
		int loggedTickets = 0;
		int totalTickets = 0;
		int slaBrigged = 0;
		int awaitingSpare = 0;
		pieChart = new PieChart();
		pieChart1 = new PieChart();
	    pieChart2 = new PieChart();
	    pieChart3 = new PieChart();
	    pieChart4 = new PieChart();
	    pieChart5 = new PieChart();
		beanList = new ArrayList<PieChart>();
		try{
			
			Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Tickets.class);
			
			ticketList = (List<Tickets>)criteria.list();
			
			for(Tickets ticket:ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Open")){
					openTickets ++;
				}
				else if(ticket.getStatus().equalsIgnoreCase("Escalated")){
					escalatedTickets ++;
				}
				else if(ticket.getStatus().equalsIgnoreCase("Closed")){
					closedTickets ++;
					
				}else if(ticket.getStatus().equalsIgnoreCase("SLA Bridged")){
					slaBrigged ++;
					
				}
				else if(ticket.getStatus().equalsIgnoreCase("Awaiting HOStock")){
					awaitingSpare ++;
					
				}
				else {
					loggedTickets++;
				
				}
				totalTickets ++;
				
			}
			
			pieChart.setNumberTicket(openTickets);
			pieChart.setStatus("Open Tickets");
			beanList.add(pieChart);
			
			pieChart1.setNumberTicket(escalatedTickets);
			pieChart1.setStatus("Escalated Tickets");
			beanList.add(pieChart1);
			
			pieChart2.setNumberTicket(closedTickets);
			pieChart2.setStatus("Closed Tickets");
			beanList.add(pieChart2);
			
			pieChart3.setNumberTicket(loggedTickets);
			pieChart3.setStatus("Logged Tickets");
			beanList.add(pieChart3);
			
			pieChart4.setNumberTicket(slaBrigged);
			pieChart4.setStatus("SLA Bridged");
			beanList.add(pieChart4);
			
			pieChart5.setNumberTicket(awaitingSpare);
			pieChart5.setStatus("Awaiting HOStock");
			beanList.add(pieChart5);
		}
		catch(Exception ex)
		{
			
		}
		return beanList;
	}

	@Override
	public List<Tickets> getAllLoggedTickets(String startDate) {
		
		return null;
	}

	@Override
	public List<Tickets> getAllLoggedTickets(String startDate, String endDate) {
		
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tickets> getAllLoggedTickets(Integer offset, Integer maxResults) {
		return sessionFactory.openSession()
			    .createCriteria(Tickets.class)
			    .setFirstResult(offset!=null?offset:0)
			    .setMaxResults(maxResults!=null?maxResults:10)
			    .list();
	}

	@Override
	public Integer count() {
		
		return (Integer) sessionFactory.getCurrentSession().createCriteria(Tickets.class).setProjection(Projections.rowCount()).uniqueResult();
		
	}

	
}
