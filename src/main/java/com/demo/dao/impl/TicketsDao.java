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

	private Date currentDate, contractEndDate = null;
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
			if (technician != null
					&& technician.getLeaveStatus()
							.equalsIgnoreCase("Available")) {
				device = deviceDaoInt.getDeviceBySerialNumbuer(tickets
						.getDevice());
				if (device != null) {

					isValied = isDeviceInContract(device.getSerialNumber());
					if (isValied == false) {
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

						ticket.setFirstName(tickets.getFirstName());
						ticket.setLastName(tickets.getLastName());
						ticket.setContactCellNumber(tickets
								.getContactCellNumber());
						ticket.setContactTelephoneNumber(tickets
								.getContactTelephoneNumber());
						ticket.setContactEmail(tickets.getContactEmail());

						ticket.setDevice(device);
						sessionFactory.getCurrentSession().save(ticket);

						historyDaoInt.insertTicketHistory(ticket);

						retMessage = "Ticket " + ticket.getTicketNumber()
								+ " is assigned to technician "
								+ ticket.getEmployee().getFirstName() + ".";
						JavaMail.sendFromGMail(ticket);
					} else {
						retMessage = "Contract for device "
								+ device.getSerialNumber()
								+ " expired. Ticket cannot be logged.";
					}

				} else {
					retMessage = "Device " + device.getSerialNumber()
							+ " does not exist. Ticket "
							+ ticket.getTicketNumber() + " cannot be logged.";
				}

			} else {
				retMessage = "Kindly note that technician in on leave.";
			}

		} catch (Exception e) {
			retMessage = "Ticket " + ticket.getTicketNumber() + " not logged "
					+ e.getMessage() + ".";
		}
		return retMessage;
	}

	@Override
	public Tickets getLoggedTicketsByTicketNumber(int ticketNumber) {

		return (Tickets) sessionFactory.getCurrentSession().get(Tickets.class,
				ticketNumber);
	}

	@Transactional
	@SuppressWarnings("unchecked")
	@Override
	public List<Tickets> getAllLoggedTickets() {

		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				Tickets.class);
		criteria.addOrder(Order.desc("recordID"));
		return (List<Tickets>) criteria.list();
	}

	@Override
	public List<Tickets> getAllOpenTickets() {
		aList = new ArrayList<Tickets>();
		try {
			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				if ((ticket.getStatus().equalsIgnoreCase("Open") && ticket
						.isOneHourFlag() == false)) {
					aList.add(ticket);
				} else if ((ticket.getStatus().equalsIgnoreCase("Open")
						&& ticket.isOneHourFlag() == true && ticket
							.isFourHourFlag() == false)) {
					aList.add(ticket);
				}
			}
		} catch (Exception exception) {
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

	@Override
	public String updateTicket(TicketsBean tickets) {
		ticket = new Tickets();
		order = new OrderHeader();
		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String date1 = myFormat.format(cal.getTime());
		date = new Date();

		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();

		try {
			String tempTicketNum = tickets.getTicketNumber().substring(6);
			int temp = Integer.parseInt(tempTicketNum);
			String status = tickets.getStatus();
			ticket = getLoggedTicketsByTicketNumber(temp);
			if (ticket != null) {

				if (status.equalsIgnoreCase("Awaiting Spares")) {
					order = ordersDaoInt.getOrder(tickets.getOrderNum());
					ticket.setStatus("Awaiting Spares");
					historyDaoInt.insertTicketHistory(ticket);
					retMessage = "Ticket " + ticket.getTicketNumber()
							+ " awaiting for order no " + order.getOrderNum()
							+ ".";
					if (order != null) {
						ticket.setOrderHeader(order);
					}
				} else if (status.equalsIgnoreCase("Escalated")) {
					ticket.setEscalatedTo(tickets.getEscalatedTo());
					ticket.setComments(tickets.getComments());
					ticket.setStatus("Escalated");
					historyDaoInt.insertTicketHistory(ticket);
					Employee employee = employeeDaoInt
							.getEmployeeByEmpNum(tickets.getEscalatedTo());
					retMessage = "Ticket " + ticket.getTicketNumber()
							+ " esalated to Manager " + employee.getFirstName()
							+ " " + employee.getLastName() + ".";

				} else if (status.equalsIgnoreCase("Resolved")) {

					ticket.setStatus("Resolved");
					ticket.setUsedPartNumbers(tickets.getUsedPartNumbers());
					ticket.setDateResolved(date1);
					ticket.setComments(tickets.getComments());
					device = deviceDaoInt.getDeviceBySerialNumbuer(ticket
							.getDevice().getSerialNumber());
					device.setMonoReading(tickets.getMonoReading());
					device.setColourReading(tickets.getColourReading());

					if (tickets.getUsedPartNumbers() != null) {
						if (ticket.getUsedPartNumbers().length() > 4) {
							ticket.setActionTaken(tickets.getActionTaken());
							retMessage = subractUsedSpares(
									tickets.getUsedPartNumbers(), ticket
											.getDevice().getCustomerDevice()
											.getCustomerName(),
									tickets.getGroupboot());

							if (retMessage.equalsIgnoreCase("OK")) {
								sessionFactory.getCurrentSession().update(
										device);
								sessionFactory.getCurrentSession()
										.saveOrUpdate(ticket);
								historyDaoInt.insertTicketHistory(ticket);

								retMessage = "Ticket "
										+ ticket.getTicketNumber()
										+ " successfully resolved.";
							}
						}

					} else {

						ticket.setActionTaken(tickets.getActionTaken());
						sessionFactory.getCurrentSession().update(device);
						sessionFactory.getCurrentSession().saveOrUpdate(ticket);

						historyDaoInt.insertTicketHistory(ticket);
						retMessage = "Ticket " + ticket.getTicketNumber()
								+ " successfully resolved.";
					}
				} else {
					ticket.setFourHourFlag(false);
					ticket.setOneHourFlag(false);
					ticket.setComments(tickets.getComments());
					ticket.setDateTime(dateFormat.format(date));

					ticket.setStatus(status);

					sessionFactory.getCurrentSession().saveOrUpdate(ticket);
					if (tickets.getMonoReading() != null
							|| tickets.getColourReading() != null) {
						sessionFactory.getCurrentSession().update(device);
					}
					historyDaoInt.insertTicketHistory(ticket);
					retMessage = "Ticket " + ticket.getTicketNumber()
							+ " successfully re-opened.";
				}
			}
		} catch (Exception e) {
			retMessage = "SLA did not start because of " + e.getMessage() + ".";
		}
		return retMessage;
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
		List<Tickets> tempTickets = null;

		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		Calendar cal = Calendar.getInstance();
		date = new Date();
		Date previoueDay = new Date();
		Date currentDate = new Date();
		Date dataDate = new Date();
		try {
			tempTickets = new ArrayList<Tickets>();
			cal.setTime(new Date());
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);

			// convert to date
			date = cal.getTime();
			currentDate = myFormat.parse(endDate);
			previoueDay = myFormat.parse(startDate);

			List<Tickets> tickets = getAllOpenTickets();
			for (Tickets tic : tickets) {
				dataDate = myFormat.parse(tic.getDateTime());
				if (dataDate.after(currentDate) && dataDate.before(currentDate)) {
					tempTickets.add(tic);
				}

			}

		} catch (Exception e) {
			e.getMessage();
		}

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
						.equalsIgnoreCase(technicianEmail)
						&& (ticket.getStatus().equalsIgnoreCase("Open"))) {

					ticketList.add(ticket);
				}
			}
		} catch (Exception e) {
			retMessage = e.getMessage();
		}
		return ticketList;
	}

	private Boolean isDeviceInContract(String serialNumber) {
		Boolean isValid = false;
		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		contractEndDate = new Date();
		String tempCurrentDate = null;
		try {
			device = deviceDaoInt.getDeviceBySerialNumbuer(serialNumber);

			tempCurrentDate = myFormat.format(currentDate);
			contractEndDate = myFormat.parse(device.getEndDate());

			if (contractEndDate.compareTo(currentDate) < 0) {
				isValid = true;
			}

		} catch (Exception exception) {
			exception.getMessage();
		}
		return isValid;
	}

	@Override
	public int countEscalatedTickets() {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Escalated")
						&& current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public int countClosedTickets() {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Closed")
						&& current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public int countBridgedTickets() {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = bridgedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("SLA Bridged")
						&& current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public int countOpenTickets() {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Open")
						&& current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public int countAwaitingSparesTickets() {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Awaiting Spares")
						&& current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public List<Tickets> getAllEscalatedTickets() {
		List<Tickets> tempTickets = null;
		// TODO Auto-generated method stub
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			tempTickets = new ArrayList<Tickets>();
			List<Tickets> list = escalatedTickets();
			for(Tickets tic:list){
				String convDate = tic.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if(current.compareTo(dateData)<=0 ){
					tempTickets.add(tic);
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return tempTickets;
	}

	@Override
	public List<Tickets> getAllAwaitingSpares() {
		aList = new ArrayList<Tickets>();
		try {
			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				if (ticket.getStatus().equalsIgnoreCase("Awaiting Spares")) {
					aList.add(ticket);
				} else if (ticket.getStatus().equalsIgnoreCase(
						"Awaiting Spares")
						&& ticket.isFourHourFlag() == true) {
					aList.add(ticket);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}
		return aList;
	}

	@Override
	public List<Tickets> getAllClosedTickets() {

		List<Tickets> tempTickets = null;
		// TODO Auto-generated method stub
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			tempTickets = new ArrayList<Tickets>();
			List<Tickets> list = closedTickets();
			for (Tickets tic : list) {
				String convDate = tic.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					tempTickets.add(tic);
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return tempTickets;
	}

	private List<Tickets> closedTickets() {
		aList = new ArrayList<Tickets>();
		try {
			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				if (ticket.getStatus().equalsIgnoreCase("Closed")) {
					aList.add(ticket);
				} else if (ticket.getStatus().equalsIgnoreCase("Closed")
						&& ticket.isFourHourFlag() == true) {
					aList.add(ticket);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}
		return aList;
	}
	private List<Tickets> bridgedTickets() {
		aList = new ArrayList<Tickets>();
		try {
			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				if (ticket.getStatus().equalsIgnoreCase("SLA Bridged")) {
					aList.add(ticket);
				} else if (ticket.getStatus().equalsIgnoreCase("SLA Bridged")
						&& ticket.isFourHourFlag() == true) {
					aList.add(ticket);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}
	private List<Tickets> escalatedTickets() {
		aList = new ArrayList<Tickets>();
		try {
			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				if (ticket.getStatus().equalsIgnoreCase("Escalated")) {
					aList.add(ticket);
				} 
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<Tickets> getAllClosedTickets(String startDate, String endDate) {
		List<Tickets> tempTickets = null;

		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		Date dateData = null;
		Calendar cal = Calendar.getInstance();
		date = new Date();
		Date previoueDay = new Date();
		Date currentDate = new Date();
		Date dataDate = new Date();
		try {
			tempTickets = new ArrayList<Tickets>();

			// convert to date
			currentDate = myFormat.parse(endDate);
			previoueDay = myFormat.parse(startDate);

			List<Tickets> tickets = closedTickets();
			for (Tickets tic : tickets) {
				String convDate = tic.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (previoueDay.compareTo(dateData) <= 0
						&& currentDate.compareTo(dateData) >= 0) {
					tempTickets.add(tic);
				}

			}

		} catch (Exception e) {
			e.getMessage();
		}

		return tempTickets;
	}

	@Override
	public List<Tickets> getAllBridgedTickets() {
		List<Tickets> tempTickets = null;
		// TODO Auto-generated method stub
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			tempTickets = new ArrayList<Tickets>();
			List<Tickets> list = bridgedTickets();
			for(Tickets tic:list){
				String convDate = tic.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if(current.compareTo(dateData)<=0){
					tempTickets.add(tic);
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return tempTickets;
	}

	private String subractUsedSpares(String usedSpares, String customerName,
			String groupBoot) {
		technician = (Employee) session.getAttribute("loggedInUser");
		int tempCount = 0;
		try {
			List<String> spare = new ArrayList<String>(Arrays.asList(usedSpares
					.split(",")));

			if (groupBoot.equalsIgnoreCase("siteType")) {
				for (int i = 0; i < spare.size(); i++) {
					SiteStock siteStock = siteStockDaoInt.getSiteStock(
							spare.get(i), customerName);
					if (siteStock != null) {
						tempCount = siteStock.getQuantity() - 1;
						if (tempCount > 0) {
							siteStock.setQuantity(tempCount);
							sessionFactory.getCurrentSession()
									.update(siteStock);
							retMessage = "OK";
						} else {
							retMessage = "The part number "
									+ spare.get(i)
									+ " not available. Please order part number.";
							siteStock.setQuantity(0);
							break;
						}
					}
				}
			} else if (groupBoot.equalsIgnoreCase("bootType")) {
				for (int i = 0; i < spare.size(); i++) {
					BootStock boot = bootStockDaoIn.getBootStock(
							spare.get(i),
							technician.getFirstName() + " "
									+ technician.getLastName());
					if (boot != null) {
						tempCount = boot.getQuantity() - 1;
						if (tempCount > 0) {
							boot.setQuantity(tempCount);
							bootStockDaoIn.updateBootStock(boot);
							retMessage = "OK";
						} else {
							retMessage = "The part number "
									+ spare.get(i)
									+ " not available. Please order part number.";
							boot.setQuantity(0);
							break;
						}
					}
				}

			}
		} catch (Exception e) {
			e.getMessage();
		}
		return retMessage;
	}

	private String[] managersEmails() {
		String[] empEmails = new String[100];
		int i = 0;
		List<Employee> getTempList = employeeDaoInt.getAllManagers();
		for (Employee emp : getTempList) {
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
		Query query = session2
				.createQuery("from Tickets order by recordID DESC");
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

		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Resolved")
						&& current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public int countEscalatedTickets(String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Escalated")
						&& current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public int countClosedTickets(String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Closed")
						&& current.compareTo(dateData) <= 0
						&& ticket.getEmployee().getEmail()
								.equalsIgnoreCase(technicianEmail)) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public int countBridgedTickets(String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("SLA Bridged")
						&& current.compareTo(dateData) <= 0
						&& ticket.getEmployee().getEmail()
								.equalsIgnoreCase(technicianEmail)) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public int countOpenTickets(String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Open")
						&& current.compareTo(dateData) <= 0
						&& ticket.getEmployee().getEmail()
								.equalsIgnoreCase(technicianEmail)) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public int countAwaitingSparesTickets(String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Awaiting Spares")
						&& current.compareTo(dateData) <= 0
						&& ticket.getEmployee().getEmail()
								.equalsIgnoreCase(technicianEmail)) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public int countResolvedTickets(String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Resolved")
						&& current.compareTo(dateData) <= 0
						&& ticket.getEmployee().getEmail()
								.equalsIgnoreCase(technicianEmail)) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public List<Tickets> getAllResolvedTickets() {
		aList = new ArrayList<Tickets>();
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Resolved")
						&& current.compareTo(dateData) <= 0) {
					aList.add(ticket);
				}
			}
		} catch (Exception exception) {
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
		List<Tickets> tempTickets = null;
		// TODO Auto-generated method stub
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			tempTickets = new ArrayList<Tickets>();
			ticketList = getAllLoggedTickets();
			for (Tickets tic : ticketList) {
				String convDate = tic.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0
						&& ticket.getStatus().equalsIgnoreCase("Escalated")
						&& ticket.getEmployee().getEmail()
								.equalsIgnoreCase(technicianEmail)) {
					tempTickets.add(tic);
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return tempTickets;
	}

	@Override
	public List<Tickets> getAllAwaitingSpares(String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Awaiting Spares")
						&& current.compareTo(dateData) <= 0
						&& ticket.getEmployee().getEmail()
								.equalsIgnoreCase(technicianEmail)) {
					aList.add(ticket);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<Tickets> getAllClosedTickets(String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Closed")
						&& current.compareTo(dateData) <= 0
						&& ticket.getEmployee().getEmail()
								.equalsIgnoreCase(technicianEmail)) {
					aList.add(ticket);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<Tickets> getAllBridgedTickets(String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("SLA Bridged")
						&& current.compareTo(dateData) <= 0
						&& ticket.getEmployee().getEmail()
								.equalsIgnoreCase(technicianEmail)) {
					aList.add(ticket);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<Tickets> getAllResolvedTickets(String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 6);
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				String convDate = ticket.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (ticket.getStatus().equalsIgnoreCase("Resolved")
						&& current.compareTo(dateData) <= 0
						&& ticket.getEmployee().getEmail()
								.equalsIgnoreCase(technicianEmail)) {
					aList.add(ticket);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	/*
	 * @Transactional
	 * 
	 * @Scheduled(fixedRate = 60000)
	 */
	/*
	 * @Override public void resolveToClosedTicketUpdate() { myFormat = new
	 * SimpleDateFormat("yyyy-MM-dd"); currentDate = new Date(); Calendar cal =
	 * Calendar.getInstance(); String date1 = myFormat.format(cal.getTime());
	 * String date2= null; Date secondDate =null; try{ List<Tickets> ticketList
	 * = getResolvedTickets(); currentDate = myFormat.parse(date1);
	 * 
	 * for(Tickets ticket:ticketList){ date2 = ticket.getDateResolved();
	 * currentDate= myFormat.parse(date1); secondDate= myFormat.parse(date2);
	 * long difference = currentDate.getTime()- secondDate.getTime(); // 86400
	 * is equal to 24 hrs if(difference > 86400){
	 * 
	 * ticket.setStatus("Closed");
	 * sessionFactory.getCurrentSession().update(ticket); }
	 * 
	 * }
	 * 
	 * }catch(Exception e){ e.getMessage(); } }
	 */

	private List<Tickets> getResolvedTickets() {
		aList = new ArrayList<Tickets>();
		try {
			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				if ((ticket.getStatus().equalsIgnoreCase("Resolved"))) {
					aList.add(ticket);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tickets> getAwaitingSparesTickets() {
		List<Tickets> tempTickets = null;
		try {
			List<Tickets> localTicket = getAllLoggedTickets();
			tempTickets = new ArrayList<Tickets>();
			for (Tickets tic : localTicket) {
				if (tic.getStatus().equalsIgnoreCase("Awaiting Spares")) {
					tempTickets.add(tic);
				}
			}
		} catch (Exception e) {
			e.getMessage();
		}
		return tempTickets;
	}

	@Override
	public List<Tickets> getAllEscalatedTickets(String startDate, String endDate) {
		List<Tickets> tempTickets = null;

		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		Date dateData = null;
		Calendar cal = Calendar.getInstance();
		date = new Date();
		Date previoueDay = new Date();
		Date currentDate = new Date();
		Date dataDate = new Date();
		try {
			tempTickets = new ArrayList<Tickets>();

			// convert to date
			currentDate = myFormat.parse(endDate);
			previoueDay = myFormat.parse(startDate);

			List<Tickets> tickets = escalatedTickets();
			for (Tickets tic : tickets) {
				String convDate = tic.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (previoueDay.compareTo(dateData) <= 0
						&& currentDate.compareTo(dateData) >= 0) {
					tempTickets.add(tic);
				}

			}

		} catch (Exception e) {
			e.getMessage();
		}

		return tempTickets;
	}

	@Override
	public List<Tickets> getAllBridgedTickets(String startDate, String endDate) {
		List<Tickets> tempTickets = null;

		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		Date dateData = null;
		Calendar cal = Calendar.getInstance();
		date = new Date();
		Date previoueDay = new Date();
		Date currentDate = new Date();
		Date dataDate = new Date();
		try {
			tempTickets = new ArrayList<Tickets>();

			// convert to date
			currentDate = myFormat.parse(endDate);
			previoueDay = myFormat.parse(startDate);

			List<Tickets> tickets = bridgedTickets();
			for (Tickets tic : tickets) {
				String convDate = tic.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (previoueDay.compareTo(dateData) <= 0
						&& currentDate.compareTo(dateData) >= 0) {
					tempTickets.add(tic);
				}

			}

		} catch (Exception e) {
			e.getMessage();
		}

		return tempTickets;
	}

	@Override
	public List<Tickets> getAllAwaitingSparesTickets(String startDate,
			String endDate) {
		List<Tickets> tempTickets = null;

		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		Date dateData = null;
		Calendar cal = Calendar.getInstance();
		date = new Date();
		Date previoueDay = new Date();
		Date currentDate = new Date();
		Date dataDate = new Date();
		try {
			tempTickets = new ArrayList<Tickets>();

			// convert to date
			currentDate = myFormat.parse(endDate);
			previoueDay = myFormat.parse(startDate);

			List<Tickets> tickets = getAllAwaitingSpares();
			for (Tickets tic : tickets) {
				String convDate = tic.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (previoueDay.compareTo(dateData) <= 0
						&& currentDate.compareTo(dateData) >= 0) {
					tempTickets.add(tic);
				}

			}

		} catch (Exception e) {
			e.getMessage();
		}

		return tempTickets;
	}

	@Override
	public List<Tickets> getAllOpenTickets(String startDate, String endDate) {
		List<Tickets> tempTickets = null;

		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		Date dateData = null;
		Calendar cal = Calendar.getInstance();
		date = new Date();
		Date previoueDay = new Date();
		Date currentDate = new Date();
		Date dataDate = new Date();
		try {
			tempTickets = new ArrayList<Tickets>();

			// convert to date
			currentDate = myFormat.parse(endDate);
			previoueDay = myFormat.parse(startDate);

			List<Tickets> tickets = getAllOpenTickets();
			for (Tickets tic : tickets) {
				String convDate = tic.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (previoueDay.compareTo(dateData) <= 0
						&& currentDate.compareTo(dateData) >= 0) {
					tempTickets.add(tic);
				}

			}

		} catch (Exception e) {
			e.getMessage();
		}

		return tempTickets;
	}

	@Override
	public List<Tickets> getAllClosedTickets(String startDate, String endDate,
			String technicianEmail) {
		List<Tickets> tempTickets = null;

		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		Date dateData = null;
		Calendar cal = Calendar.getInstance();
		date = new Date();
		Date previoueDay = new Date();
		Date currentDate = new Date();
		Date dataDate = new Date();
		try {
			tempTickets = new ArrayList<Tickets>();

			// convert to date
			currentDate = myFormat.parse(endDate);
			previoueDay = myFormat.parse(startDate);

			List<Tickets> tickets = closedTickets();
			for (Tickets tic : tickets) {
				String convDate = tic.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (previoueDay.compareTo(dateData) <= 0
						&& currentDate.compareTo(dateData) >= 0 && tic.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)) {
					tempTickets.add(tic);
				}

			}

		} catch (Exception e) {
			e.getMessage();
		}

		return tempTickets;
	}

	@Override
	public List<Tickets> getAllEscalatedTickets(String startDate,
			String endDate, String technicianEmail) {
		List<Tickets> tempTickets = null;

		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		Date dateData = null;
		Calendar cal = Calendar.getInstance();
		date = new Date();
		Date previoueDay = new Date();
		Date currentDate = new Date();
		Date dataDate = new Date();
		try {
			tempTickets = new ArrayList<Tickets>();

			// convert to date
			currentDate = myFormat.parse(endDate);
			previoueDay = myFormat.parse(startDate);

			List<Tickets> tickets = escalatedTickets();
			for (Tickets tic : tickets) {
				String convDate = tic.getDateTime().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (previoueDay.compareTo(dateData) <= 0
						&& currentDate.compareTo(dateData) >= 0 && tic.getEmployee().getEmail().equalsIgnoreCase(technicianEmail)) {
					tempTickets.add(tic);
				}
			}
		} catch (Exception e) {
			e.getMessage();
		}

		return tempTickets;
	}

	@Override
	public List<Tickets> getAllBridgedTickets(String startDate, String endDate,
			String technicianEmail) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Tickets> getAllAwaitingSparesTickets(String startDate,
			String endDate, String technicianEmail) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Tickets> getAllOpenTickets(String startDate, String endDate,
			String technicianEmail) {
		// TODO Auto-generated method stub
		return null;
	}
}
