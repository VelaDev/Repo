package com.demo.dao.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

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

import com.demo.bean.PieChart;
import com.demo.bean.TicketsBean;
import com.demo.dao.BootStockDaoInt;
import com.demo.dao.CustomerDaoInt;
import com.demo.dao.EmployeeDaoInt;
import com.demo.dao.OrdersDaoInt;
import com.demo.dao.SiteStocDaoInt;
import com.demo.dao.TicketsDaoInt;
import com.demo.dao.DeviceDaoInt;
import com.demo.dao.TicketHistoryDaoInt;
import com.demo.model.BootStock;
import com.demo.model.Employee;
import com.demo.model.Device;
import com.demo.model.OrderHeader;
import com.demo.model.SiteStock;
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
	private SiteStocDaoInt siteStockDaoInt;
	@Autowired
	private BootStockDaoInt bootStockDaoIn;
	@Autowired
	private HttpSession session = null;
	private Session session2;

	private Employee technician = null;
	private OrderHeader order = null;
	private Device device = null;
	private Tickets ticket = null;
	Calendar cal = Calendar.getInstance();
	DateFormat dateFormat = null;
	Date date = null;
	private String retMessage = "";
	private List<Tickets> ticketList = null;
	private List<PieChart> beanList = null;
	
	private Date currentDate,contractEndDate = null;
	private SimpleDateFormat myFormat = null;
	
	ArrayList<Tickets> aList = null;
	
	String ticketNumber = null;
	Integer recordID = 1;

	@Override
	public String logTicket(TicketsBean tickets) {
		String ticketNumber = "";
		Boolean isValied = false;
		ticket = new Tickets();
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		try {

			technician = employeeDaoInt.getEmployeeByEmpNum(tickets
					.getTechnicianUserName());
			if (technician != null && technician.getLeaveStatus().equalsIgnoreCase("Available")) {
				device = deviceDaoInt.getDeviceBySerialNumbuer(tickets
						.getDevice());
				if (device != null) {
					
					isValied = isDeviceInContract(device.getSerialNumber());
					if(isValied ==false){
						recordID = newRecordID();
						ticketNumber = "VTC000" + recordID;
						ticket.setRecordID(recordID);
						ticket.setTicketNumber(ticketNumber);
						ticket.setEmployee(technician);
						ticket.setStatus("Open");
						ticket.setSlaStart("Started");
						ticket.setSubject(tickets.getSubject());
						ticket.setOneHourFlag(false);
						ticket.setFourHourFlag(false);
						ticket.setDescription(tickets.getDescription());
						ticket.setPriority(tickets.getPriority());
						ticket.setDateTime(dateFormat.format(date));

						ticket.setDevice(device);
						sessionFactory.getCurrentSession().save(ticket);

						historyDaoInt.insertTicketHistory(ticket);

						retMessage = "Ticket " + ticket.getTicketNumber()
								+ " is assigned to technician "
								+ ticket.getEmployee().getFirstName() + ".";
						JavaMail.sendFromGMail(ticket);
					}
					else{
						retMessage= "Contract for device "+device.getSerialNumber()+" expired. Ticket cannot be logged";
					}
					
				} else {
					retMessage = "Device " + device.getSerialNumber()
							+ " does not exist. Ticket "
							+ ticket.getTicketNumber() + " cannot be logged";
				}

			} else {
				retMessage = "Kindly note that technician in on leave";
			}

		} catch (Exception e) {
			retMessage = "Ticket " + ticket.getTicketNumber()
					+ " was not logged " + e.getMessage();
		}
		return retMessage;
	}

	@Override
	public Tickets getLoggedTicketsByTicketNumber(int ticketNumber) {

		return (Tickets) sessionFactory.getCurrentSession().get(Tickets.class,
				ticketNumber);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tickets> getAllLoggedTickets() {

		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Tickets.class);
		return (List<Tickets>)criteria.list(); 
	}

	@Override
	public List<Tickets> getAllOpenTickets() {
	    aList = new ArrayList<Tickets>();
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
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				Tickets.class);

		aList.addAll(criteria.list());
		for (Object tic : aList) {
			if (tic instanceof Tickets) {
				if (((Tickets) tic).getEmployee().getEmail().equals(username)
						&& ((Tickets) tic).getEmployee().getEmail() != null) {
					ticketList.add((Tickets) tic);
				}
			}
		}
		return ticketList;
	}


	@Transactional
	@Scheduled(fixedRate = 600000)
	// /cron="*/5 * * * * MON-FRI*" this method will be invoked after every 10
	// min to perform calculations and update relevant fields
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

	@Override
	public String updateTicket(TicketsBean tickets) {
		ticket = new Tickets();
		order = new OrderHeader();
		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
	    String date1 =  myFormat.format(cal.getTime());
		
		try {
			String tempTicketNum = tickets.getTicketNumber().substring(6);
			int temp = Integer.parseInt(tempTicketNum);
              String status = tickets.getStatus();
			ticket = getLoggedTicketsByTicketNumber(temp);
			if(ticket !=null){
				/*ticket.setComments(tickets.getComments());
				retMessage = "Ticket "+ ticket.getTicketNumber()+ " is successfully updated";*/
				
				if(tickets.getStatus()==null){
					//ticket.setStatus(tickets.getStatus());
				}
				else if(status.equalsIgnoreCase("Awaiting Spares")){
					order = ordersDaoInt.getOrder(tickets.getOrderNum());
					ticket.setStatus("Awaiting Spares");
					
					if(order !=null){
						ticket.setOrderHeader(order);
					}
				}
				else if(status.equalsIgnoreCase("Escalated")){
					ticket.setEscalatedTo(tickets.getEscalatedTo());
					ticket.setStatus("Escalated");
				}else if(status.equalsIgnoreCase("Resolved")) {
					ticket.setStatus("Resolved");
					ticket.setUsedPartNumbers(tickets.getUsedPartNumbers());
					ticket.setActionTaken(tickets.getActionTaken());
					ticket.setDateResolved(date1);
					ticket.setComments(tickets.getComments());
					device = deviceDaoInt.getDeviceBySerialNumbuer(ticket.getDevice().getSerialNumber());
					device.setMonoReading(tickets.getMonoReading());
					device.setColourReading(tickets.getColourReading());
					
					if(tickets.getUsedPartNumbers().length()>4){
						retMessage = subractUsedSpares(tickets.getUsedPartNumbers(),ticket.getDevice().getCustomerDevice().getCustomerName());
						
						if(retMessage.equalsIgnoreCase("OK")){
							sessionFactory.getCurrentSession().update(device);
							sessionFactory.getCurrentSession().saveOrUpdate(ticket);
							historyDaoInt.insertTicketHistory(ticket);
							
							retMessage ="Ticket "+ ticket.getTicketNumber()+ " is successfully updated";
						}
						
					}else{
						
						sessionFactory.getCurrentSession().update(device);
						sessionFactory.getCurrentSession().saveOrUpdate(ticket);
						
						historyDaoInt.insertTicketHistory(ticket);
						retMessage ="Ticket "+ ticket.getTicketNumber()+ " is successfully updated";
					}
				}
				else{
					ticket.setComments(tickets.getComments());
					
					ticket.setStatus(status);
					sessionFactory.getCurrentSession().update(device);
					sessionFactory.getCurrentSession().saveOrUpdate(ticket);
					
					historyDaoInt.insertTicketHistory(ticket);
					retMessage ="Ticket "+ ticket.getTicketNumber()+ " is successfully updated";
				}
					
			}
			

		} catch (Exception e) {
			retMessage = "SLA did not start because of " + e.getMessage();
		}
		return retMessage;
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

	@Override
	public List<Tickets> getAllEmployees(String searchName) {

		return null;
	}

	private String generateTicketNumber() {

		session2 = sessionFactory.openSession();
		String result = "";
		Query query = session2
				.createQuery("from Tickets order by ticketNumber DESC");
		query.setMaxResults(1);
		Tickets ticketNumber = (Tickets) query.uniqueResult();
		if (ticketNumber != null) {
			result = ticketNumber.getTicketNumber();
		} else {
			result = null;
		}
		return result;
	}
	@Override
	public List<PieChart> ticketsResults() {
		
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

	@Override
	public int ticketCountForTechnician(String technicianEmail) {
		int tempCount = 0;
		try {
			List<Tickets> technicianCount = getAllOpenTickets();

			for (Tickets ticket : technicianCount) {
				if (ticket.getEmployee().getEmail()
						.equalsIgnoreCase(technicianEmail)) {

					tempCount++;
				}
			}
		} catch (Exception e) {
			retMessage = e.getMessage();
		}
		return tempCount;
	}

	@Override
	public List<Tickets> getOpenTicketsForTechnician(String technicianEmail) {
		List<Tickets> ticketList = new ArrayList<Tickets>();
		try {
			List<Tickets> technicianCount = getAllOpenTickets();

			for (Tickets ticket : technicianCount) {
				if (ticket.getEmployee().getEmail()
						.equalsIgnoreCase(technicianEmail)&&( ticket.getStatus().equalsIgnoreCase("Open"))) {

					ticketList.add(ticket);
				}
			}
		} catch (Exception e) {
			retMessage = e.getMessage();
		}
		return ticketList;
	}
	private Boolean isDeviceInContract(String serialNumber){
		Boolean isValid = false;
		myFormat = new SimpleDateFormat("yyyy-MM-dd");
	    currentDate  = new Date();
	    contractEndDate = new Date();
	    String tempCurrentDate = null;
		try{
			device = deviceDaoInt.getDeviceBySerialNumbuer(serialNumber);
			
			tempCurrentDate = myFormat.format(currentDate);
			contractEndDate = myFormat.parse(device.getEndDate());
			
			if(contractEndDate.compareTo(currentDate)<0){
				isValid =true;
			}
			
		}catch(Exception exception){
			exception.getMessage();
		}
		return isValid;
	}

	@Override
	public int countEscalatedTickets() {
		int tempCount =0;
		  aList = new ArrayList<Tickets>();
		  try{
			  ticketList = getAllLoggedTickets();
			  for(Tickets ticket: ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Escalated")){
					tempCount ++;
				}
			  }
		  }catch(Exception exception){
			  exception.getMessage();
		  }
		
		return tempCount;
	}

	@Override
	public int countClosedTickets() {
		int tempCount =0;
		  aList = new ArrayList<Tickets>();
		  try{
			  ticketList = getAllLoggedTickets();
			  for(Tickets ticket: ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Closed")){
					tempCount ++;
				}
			  }
		  }catch(Exception exception){
			  exception.getMessage();
		  }
		
		return tempCount;
	}

	@Override
	public int countBridgedTickets() {
		int tempCount =0;
		  aList = new ArrayList<Tickets>();
		  try{
			  ticketList = getAllLoggedTickets();
			  for(Tickets ticket: ticketList){
				if(ticket.getStatus().equalsIgnoreCase("SLA Bridged")){
					tempCount ++;
				}
			  }
		  }catch(Exception exception){
			  exception.getMessage();
		  }
		
		return tempCount;
	}

	@Override
	public int countOpenTickets() {
		int tempCount =0;
		  aList = new ArrayList<Tickets>();
		  try{
			  ticketList = getAllLoggedTickets();
			  for(Tickets ticket: ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Open")){
					tempCount ++;
				}
			  }
		  }catch(Exception exception){
			  exception.getMessage();
		  }
		
		return tempCount;
	}

	@Override
	public int countAwaitingSparesTickets() {
		int tempCount =0;
		  aList = new ArrayList<Tickets>();
		  try{
			  ticketList = getAllLoggedTickets();
			  for(Tickets ticket: ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Awaiting Spare")){
					tempCount ++;
				}
			  }
		  }catch(Exception exception){
			  exception.getMessage();
		  }
		
		return tempCount;
	}@Override
	public List<Tickets> getAllEscalatedTickets() {
		aList = new ArrayList<Tickets>();
		try{
			ticketList = getAllLoggedTickets();
			for(Tickets ticket:ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Escalated")){
					aList.add(ticket);
				}else if(ticket.getStatus().equalsIgnoreCase("Escalated")&& ticket.isFourHourFlag()==true){
					aList.add(ticket);
				}
			}
		}catch(Exception exception){
			exception.getMessage();
		}
			
		return aList;
	}

	@Override
	public List<Tickets> getAllAwaitingSpares() {
				aList = new ArrayList<Tickets>();
				try{
					ticketList = getAllLoggedTickets();
					for(Tickets ticket:ticketList){
						if(ticket.getStatus().equalsIgnoreCase("Awaiting Spare")){
							aList.add(ticket);
						}else if(ticket.getStatus().equalsIgnoreCase("Awaiting Spare")&& ticket.isFourHourFlag()==true){
							aList.add(ticket);
						}
					}
				}catch(Exception exception){
					exception.getMessage();
				}
					
				return aList;
	}

	@Override
	public List<Tickets> getAllClosedTickets() {
				aList = new ArrayList<Tickets>();
				try{
					ticketList = getAllLoggedTickets();
					for(Tickets ticket:ticketList){
						if(ticket.getStatus().equalsIgnoreCase("Closed")){
							aList.add(ticket);
						}else if(ticket.getStatus().equalsIgnoreCase("Closed")&& ticket.isFourHourFlag()==true){
							aList.add(ticket);
						}
					}
				}catch(Exception exception){
					exception.getMessage();
				}
					
				return aList;
	}

	@Override
	public List<Tickets> getAllBridgedTickets() {
		aList = new ArrayList<Tickets>();
		try{
			ticketList = getAllLoggedTickets();
			for(Tickets ticket:ticketList){
				if(ticket.getStatus().equalsIgnoreCase("SLA Bridged")){
					aList.add(ticket);
				}else if(ticket.getStatus().equalsIgnoreCase("SLA Bridged")&& ticket.isFourHourFlag()==true){
					aList.add(ticket);
				}
			}
		}catch(Exception exception){
			exception.getMessage();
		}
		
		return aList;
	}
	private String subractUsedSpares(String usedSpares, String customerName){
		technician = (Employee) session.getAttribute("loggedInUser");
		int tempCount = 0;
		try{
			List<String> spare = new ArrayList<String>(Arrays.asList(usedSpares.split(",")));
			
			if(customerName != null){
				List<SiteStock> tempSiteList = siteStockDaoInt.getOrdersForCustomer(customerName);
				for(SiteStock siteStock:tempSiteList){
					for(int i=0;i<spare.size();i++){
                        if(siteStock.getPartNumber().equalsIgnoreCase(spare.get(i))){
							
							tempCount = siteStock.getQuantity() -1;
							if(tempCount<0){
								retMessage = "The part number "+spare.get(i)+" is not available. Please order part number";
								siteStock.setQuantity(0);
								break;
							}
							else{
								siteStock.setQuantity(tempCount);
								sessionFactory.getCurrentSession().update(siteStock);
								retMessage = "OK";
							}
                        }
                        else{
                        	retMessage = "The part number "+spare.get(i)+ " does not exist in site stock";
                        }
					}
				}
			}else{
				List<BootStock> tempSiteList =bootStockDaoIn.getAllOrders(technician.getFirstName()+" "+technician.getLastName());
				for(BootStock btStock:tempSiteList){
					
					for(int i=0;i<spare.size();i++){
						if(btStock.getPartNumber().equalsIgnoreCase(spare.get(i))){
							
							tempCount = btStock.getQuantity() -1;
							if(tempCount<0){
								retMessage = "The part number "+spare.get(i)+" is not available. Please order part number";
								btStock.setQuantity(0);
								break;
							}
							else{
								btStock.setQuantity(tempCount);
								bootStockDaoIn.updateBootStock(btStock);
								retMessage = "OK";
							}
							
						}else{
							retMessage ="The part number "+spare.get(i)+" does not exist in boot stock";
						}
					}
				}
				
			}
		}catch(Exception e){
			e.getMessage();
		}
		return retMessage;
	}
	private String[] managersEmails(){
		String [] empEmails = new String[100];
		int i = 0;
		List<Employee> getTempList = employeeDaoInt.getAllManagers();
		for(Employee emp:getTempList){
			empEmails[i] = emp.getEmail();
			i++;
		}
		return empEmails;
	}
	private Integer newRecordID() {

		int tempTicketNum = 0;
		Integer newTicketNum = getRecordID();

		if (newTicketNum != null) {
			tempTicketNum = newTicketNum + 1;
		} else {
			tempTicketNum = 1;
		}

		return tempTicketNum;
	}

	private Integer getRecordID() {

		session2 = sessionFactory.openSession();
		Integer result = 0;
		Query query = session2.createQuery("from Tickets order by recordID DESC");
		query.setMaxResults(1);
		Tickets ticketNumber = (Tickets) query.uniqueResult();

		if (ticketNumber != null) {
			result = ticketNumber.getRecordID();
		} else {
			result = null;
		}
		return result;
	}

	@Override
	public int countResolvedTickets() {
		int tempCount =0;
		  aList = new ArrayList<Tickets>();
		  try{
			  ticketList = getAllLoggedTickets();
			  for(Tickets ticket: ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Resolved")){
					tempCount ++;
				}
			  }
		  }catch(Exception exception){
			  exception.getMessage();
		  }
		
		return tempCount;
	}

	@Override
	public int countEscalatedTickets(String technicianEmail) {
		int tempCount =0;
		  aList = new ArrayList<Tickets>();
		  try{
			  ticketList = getAllLoggedTickets();
			  for(Tickets ticket: ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Escalated")&& ticket.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)){
					tempCount ++;
				}
			  }
		  }catch(Exception exception){
			  exception.getMessage();
		  }
		
		return tempCount;
	}

	@Override
	public int countClosedTickets(String technicianEmail) {
		int tempCount =0;
		  aList = new ArrayList<Tickets>();
		  try{
			  ticketList = getAllLoggedTickets();
			  for(Tickets ticket: ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Closed") && ticket.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)){
					tempCount ++;
				}
			  }
		  }catch(Exception exception){
			  exception.getMessage();
		  }
		
		return tempCount;
	}

	@Override
	public int countBridgedTickets(String technicianEmail) {
		int tempCount =0;
		  aList = new ArrayList<Tickets>();
		  try{
			  ticketList = getAllLoggedTickets();
			  for(Tickets ticket: ticketList){
				if(ticket.getStatus().equalsIgnoreCase("SLA Bridged")&& ticket.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)){
					tempCount ++;
				}
			  }
		  }catch(Exception exception){
			  exception.getMessage();
		  }
		
		return tempCount;
	}

	@Override
	public int countOpenTickets(String technicianEmail) {
		int tempCount =0;
		  aList = new ArrayList<Tickets>();
		  try{
			  ticketList = getAllLoggedTickets();
			  for(Tickets ticket: ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Open")&& ticket.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)){
					tempCount ++;
				}
			  }
		  }catch(Exception exception){
			  exception.getMessage();
		  }
		
		return tempCount;
	}

	@Override
	public int countAwaitingSparesTickets(String technicianEmail) {
		int tempCount =0;
		  aList = new ArrayList<Tickets>();
		  try{
			  ticketList = getAllLoggedTickets();
			  for(Tickets ticket: ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Awaiting Spare")&& ticket.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)){
					tempCount ++;
				}
			  }
		  }catch(Exception exception){
			  exception.getMessage();
		  }
		
		return tempCount;
	}

	@Override
	public int countResolvedTickets(String technicianEmail) {
		int tempCount =0;
		  aList = new ArrayList<Tickets>();
		  try{
			  ticketList = getAllLoggedTickets();
			  for(Tickets ticket: ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Resolved") && ticket.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)){
					tempCount ++;
				}
			  }
		  }catch(Exception exception){
			  exception.getMessage();
		  }
		
		return tempCount;
	}

	@Override
	public List<Tickets> getAllResolvedTickets() {
		aList = new ArrayList<Tickets>();
		try{
			ticketList = getAllLoggedTickets();
			for(Tickets ticket:ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Resolved")){
					aList.add(ticket);
				}
			}
		}catch(Exception exception){
			exception.getMessage();
		}
			
		return aList;
	}

	@Override
	public List<Tickets> getAllOpenTickets(String technicianEmail) {

		return null;
	}

	@Override
	public List<Tickets> getAllEscalatedTickets(String technicianEmail) {
		aList = new ArrayList<Tickets>();
		try{
			ticketList = getAllLoggedTickets();
			for(Tickets ticket:ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Escalated")&& ticket.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)){
					aList.add(ticket);
				}
			}
		}catch(Exception exception){
			exception.getMessage();
		}
			
		return aList;
	}

	@Override
	public List<Tickets> getAllAwaitingSpares(String technicianEmail) {
		aList = new ArrayList<Tickets>();
		try{
			ticketList = getAllLoggedTickets();
			for(Tickets ticket:ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Awaiting Spare")&& ticket.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)){
					aList.add(ticket);
				}
			}
		}catch(Exception exception){
			exception.getMessage();
		}
			
		return aList;
	}

	@Override
	public List<Tickets> getAllClosedTickets(String technicianEmail) {
		aList = new ArrayList<Tickets>();
		try{
			ticketList = getAllLoggedTickets();
			for(Tickets ticket:ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Closed")&& ticket.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)){
					aList.add(ticket);
				}
			}
		}catch(Exception exception){
			exception.getMessage();
		}
			
		return aList;
	}

	@Override
	public List<Tickets> getAllBridgedTickets(String technicianEmail) {
		aList = new ArrayList<Tickets>();
		try{
			ticketList = getAllLoggedTickets();
			for(Tickets ticket:ticketList){
				if(ticket.getStatus().equalsIgnoreCase("SLA Bridged")&& ticket.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)){
					aList.add(ticket);
				}
			}
		}catch(Exception exception){
			exception.getMessage();
		}
		
		return aList;
	}

	@Override
	public List<Tickets> getAllResolvedTickets(String technicianEmail) {
		aList = new ArrayList<Tickets>();
		try{
			ticketList = getAllLoggedTickets();
			for(Tickets ticket:ticketList){
				if(ticket.getStatus().equalsIgnoreCase("Resolved")&& ticket.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)){
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
}
