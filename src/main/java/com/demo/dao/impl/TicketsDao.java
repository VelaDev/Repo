package com.demo.dao.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.EmployeeBean;
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

	private Employee technician,ticketLoggedBy,emp= null;
	private OrderHeader order = null;
	private Device device = null;
	private Tickets ticket = null;
	Calendar cal = Calendar.getInstance();
	DateFormat dateFormat = null;
	Date date = null;
	private String retMessage = "";
	private String tempTicketNum = "VTC000";
	private String tempOrderNum = "ORD00";
	private List<Tickets> ticketList = null;
	private List<PieChart> beanList = null;

	private Date currentDate, contractEndDate = null;
	private SimpleDateFormat myFormat = null;

	ArrayList<Tickets> aList = null;
	

	Long ticketNumber = null;
	Integer recordID = 1;

	// Start of new functionality

	@Override
	public int getTicketCount(String status, String dateRange,
			String technicianEmail, String customer, Long ticketNumber) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {

			// Get Count by Date Range and Status
			if (dateRange.length() >= 3 && status.length() >= 3) {
				if (dateRange.equalsIgnoreCase("Last 24 Hours")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 1);
				} else if (dateRange.equalsIgnoreCase("Last 7 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 6);
				} else if (dateRange.equalsIgnoreCase("Last 14 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 13);
				} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 30);
				}
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
					if (ticket.getStatus().equalsIgnoreCase(status)
							&& current.compareTo(dateData) <= 0) {
						tempCount++;
					}
				}

			}
			// Get Count by Technician and Status
			else if (technicianEmail.length() >= 3 && status.length() >= 3) {
				ticketList = getAllLoggedTickets();
				boolean isAllTechnicians = false;
				isAllTechnicians = technicianEmail
						.equalsIgnoreCase("All Technicians");

				if (isAllTechnicians == false) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)
								&& ticket.getEmployee().getEmail()
										.equalsIgnoreCase(technicianEmail)) {
							tempCount++;
						}
					}
				} else if (isAllTechnicians == true) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)) {
							tempCount++;
						}
					}
				}

			}

			// Get Count by Customer Name and Status
			else if (customer.length() >= 3 && status.length() >= 3) {
				ticketList = getAllLoggedTickets();
				boolean isAllCustomers = false;
				isAllCustomers = customer.equalsIgnoreCase("All Customers");
				if (isAllCustomers == false) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)
								&& ticket.getDevice().getCustomerDevice()
										.getCustomerName()
										.equalsIgnoreCase(customer)) {
							tempCount++;
						}
					}

				}
				if (isAllCustomers == true) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)) {
							tempCount++;
						}
					}

				}

			}

			else if (status.length() >= 3) {
				ticketList = getAllLoggedTickets();
				if (ticketNumber != null) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)
								&& ticket.getRecordID() == ticketNumber) {
							tempCount++;
						}
					}
				}

			}

		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public int getTicketCountForTechnician(String status, String dateRange,
			String technicianEmail, String customer, Long ticketNumber) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		aList = new ArrayList<Tickets>();
		try {

			// Get Count by Date Range and Status
			if (dateRange.length() >= 3 && status.length() >= 3) {
				if (dateRange.equalsIgnoreCase("Last 24 Hours")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 1);
				} else if (dateRange.equalsIgnoreCase("Last 7 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 6);
				} else if (dateRange.equalsIgnoreCase("Last 14 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 13);
				} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 30);
				}
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
					if (ticket.getStatus().equalsIgnoreCase(status)
							&& current.compareTo(dateData) <= 0
							&& ticket.getEmployee().getEmail()
									.equalsIgnoreCase(technicianEmail)) {
						tempCount++;
					}
				}

			}

			// Get Count by Customer Name and Status
			else if (customer.length() >= 3 && status.length() >= 3) {
				ticketList = getAllLoggedTickets();
				boolean isAllCustomers = false;
				isAllCustomers = customer.equalsIgnoreCase("All Customers");
				if (isAllCustomers == false) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)
								&& ticket.getDevice().getCustomerDevice()
										.getCustomerName()
										.equalsIgnoreCase(customer)
								&& ticket.getEmployee().getEmail()
										.equalsIgnoreCase(technicianEmail)) {
							tempCount++;
						}
					}

				}
				if (isAllCustomers == true) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)
								&& ticket.getEmployee().getEmail()
										.equalsIgnoreCase(technicianEmail)) {
							tempCount++;
						}
					}

				}

			}

			else if (status.length() >= 3) {
				ticketList = getAllLoggedTickets();
				if (ticketNumber != null) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)
								&& ticket.getRecordID() == ticketNumber
								&& ticket.getEmployee().getEmail()
										.equalsIgnoreCase(technicianEmail)) {
							tempCount++;
						}
					}
				}

			}

		} catch (Exception exception) {
			exception.getMessage();
		}

		return tempCount;
	}

	@Override
	public List<Tickets> getTicketListByStatus(String status, String dateRange,
			String technicianEmail, String customer, Long ticketNumber) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		List<Tickets> ticketList = null;
		aList = new ArrayList<Tickets>();
		try {

			// Get Ticket List by Date Range and Status
			if (dateRange.length() >= 3 && status.length() >= 3) {
				if (dateRange.equalsIgnoreCase("Last 24 Hours")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 1);
				} else if (dateRange.equalsIgnoreCase("Last 7 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 6);
				} else if (dateRange.equalsIgnoreCase("Last 14 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 13);
				} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 30);
				}
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
					if (ticket.getStatus().equalsIgnoreCase(status)
							&& current.compareTo(dateData) <= 0) {
						aList.add(ticket);
					}
				}

			}
			// Get Ticket List by Technician and Status
			else if (technicianEmail.length() >= 3 && status.length() >= 3) {
				ticketList = getAllLoggedTickets();
				boolean isAllTechnicians = false;
				isAllTechnicians = technicianEmail
						.equalsIgnoreCase("All Technicians");

				if (isAllTechnicians == false) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)
								&& ticket.getEmployee().getEmail()
										.equalsIgnoreCase(technicianEmail)) {
							aList.add(ticket);
						}
					}
				} else if (isAllTechnicians == true) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)) {
							aList.add(ticket);
						}
					}
				}

			}

			// Get Ticket List by Customer Name and Status
			else if (customer.length() >= 3 && status.length() >= 3) {
				ticketList = getAllLoggedTickets();
				boolean isAllCustomers = false;
				isAllCustomers = customer.equalsIgnoreCase("All Customers");

				if (isAllCustomers == false) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)
								&& ticket.getDevice().getCustomerDevice()
										.getCustomerName()
										.equalsIgnoreCase(customer)) {
							aList.add(ticket);
						}
					}
				} else if (isAllCustomers == true) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)) {
							aList.add(ticket);
						}
					}
				}

			}

			else if (status.length() >= 3) {
				ticketList = getAllLoggedTickets();
				if (ticketNumber != null) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)
								&& ticket.getRecordID() == ticketNumber) {
							aList.add(ticket);
						}
					}
				}

			}
			// Get Ticket List by status
			else {
				ticketList = getAllLoggedTickets();
				for (Tickets ticket : ticketList) {
					if (ticket.getStatus().equalsIgnoreCase(status)) {
						aList.add(ticket);
					}
				}

			}

		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<Tickets> getTicketListByStatusForTech(String status,
			String dateRange, String technicianEmail, String customer,
			Long ticketNumber) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		List<Tickets> ticketList = null;
		aList = new ArrayList<Tickets>();
		try {

			// Get Ticket List by Date Range and Status
			if (dateRange.length() >= 3 && status.length() >= 3) {
				if (dateRange.equalsIgnoreCase("Last 24 Hours")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 1);
				} else if (dateRange.equalsIgnoreCase("Last 7 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 6);
				} else if (dateRange.equalsIgnoreCase("Last 14 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 13);
				} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 30);
				}
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
					if (ticket.getStatus().equalsIgnoreCase(status)
							&& current.compareTo(dateData) <= 0
							&& ticket.getEmployee().getEmail()
									.equalsIgnoreCase(technicianEmail)) {
						aList.add(ticket);
					}
				}

			}
			// Get Ticket List by Customer Name and Status
			else if (customer.length() >= 3 && status.length() >= 3) {
				ticketList = getAllLoggedTickets();
				boolean isAllCustomers = false;
				isAllCustomers = customer.equalsIgnoreCase("All Customers");

				if (isAllCustomers == false) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)
								&& ticket.getDevice().getCustomerDevice()
										.getCustomerName()
										.equalsIgnoreCase(customer)
								&& ticket.getEmployee().getEmail()
										.equalsIgnoreCase(technicianEmail)) {
							aList.add(ticket);
						}
					}
				} else if (isAllCustomers == true) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)
								&& ticket.getEmployee().getEmail()
										.equalsIgnoreCase(technicianEmail)) {
							aList.add(ticket);
						}
					}
				}

			}

			else if (status.length() >= 3) {
				ticketList = getAllLoggedTickets();
				if (ticketNumber != null) {
					for (Tickets ticket : ticketList) {
						if (ticket.getStatus().equalsIgnoreCase(status)
								&& ticket.getRecordID() == ticketNumber
								&& ticket.getEmployee().getEmail()
										.equalsIgnoreCase(technicianEmail)) {
							aList.add(ticket);
						}
					}
				}

			}
			// Get Ticket List by status
			else {
				ticketList = getAllLoggedTickets();
				for (Tickets ticket : ticketList) {
					if (ticket.getStatus().equalsIgnoreCase(status)
							&& ticket.getEmployee().getEmail()
									.equalsIgnoreCase(technicianEmail)) {
						aList.add(ticket);
					}
				}

			}

		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<Tickets> getTicketListByCustomerName(String customer) {
		List<Tickets> ticketList = null;
		aList = new ArrayList<Tickets>();
		try {
			boolean isAllCustomers = false;
			isAllCustomers = customer.equalsIgnoreCase("All Customers");
			// Get Ticket List by Customer Name
			if (isAllCustomers == false) {
				if (customer.length() >= 2) {
					ticketList = getAllLoggedTickets();
					for (Tickets ticket : ticketList) {
						if (ticket.getDevice().getCustomerDevice()
								.getCustomerName().equalsIgnoreCase(customer)) {
							aList.add(ticket);
						}
					}
				}
			} else if (isAllCustomers == true) {
				ticketList = getLastFourteenDaysTickets();
				for (Tickets ticket : ticketList) {
					aList.add(ticket);
				}
			}

		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<Tickets> getTicketListByCustomerNameForTech(String customer,
			String technicianEmail) {
		List<Tickets> ticketList = null;
		aList = new ArrayList<Tickets>();
		try {
			boolean isAllCustomers = false;
			isAllCustomers = customer.equalsIgnoreCase("All Customers");
			// Get Ticket List by Customer Name
			if (isAllCustomers == false) {
				if (customer.length() >= 2) {
					ticketList = getAllLoggedTickets();
					for (Tickets ticket : ticketList) {
						if (ticket.getDevice().getCustomerDevice()
								.getCustomerName().equalsIgnoreCase(customer)
								&& ticket.getEmployee().getEmail()
										.equalsIgnoreCase(technicianEmail)) {
							aList.add(ticket);
						}
					}
				}
			} else if (isAllCustomers == true) {
				ticketList = getLastFourteenDaysTickets();
				for (Tickets ticket : ticketList) {
					if (ticket.getEmployee().getEmail()
							.equalsIgnoreCase(technicianEmail)) {
						aList.add(ticket);
					}
				}
			}

		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<Tickets> getTicketListByDateRange(String dateRange) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		List<Tickets> ticketList = null;
		aList = new ArrayList<Tickets>();
		try {
			if (dateRange.length() >= 3) {
				if (dateRange.equalsIgnoreCase("Last 24 Hours")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 1);
				} else if (dateRange.equalsIgnoreCase("Last 7 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 6);
				} else if (dateRange.equalsIgnoreCase("Last 14 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 13);
				} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 30);
				}
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
					if (current.compareTo(dateData) <= 0) {
						aList.add(ticket);
					}
				}

			}

		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<Tickets> getTicketListByTechnicianEmail(String technicianEmail) {
		List<Tickets> ticketList = null;
		aList = new ArrayList<Tickets>();
		try {
			boolean isAllTechnicians = false;
			isAllTechnicians = technicianEmail
					.equalsIgnoreCase("All Technicians");
			// Get Ticket List by Customer Name
			if (isAllTechnicians == false) {
				if (technicianEmail.length() >= 2) {
					ticketList = getAllLoggedTickets();
					for (Tickets ticket : ticketList) {
						if (ticket.getEmployee().getEmail()
								.equalsIgnoreCase(technicianEmail)) {
							aList.add(ticket);
						}
					}
				}
			} else if (isAllTechnicians == true) {
				ticketList = getAllLoggedTickets();
				for (Tickets ticket : ticketList) {
					aList.add(ticket);
				}
			}

		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<Tickets> searchTicketByTicketNumber(Long ticketNumber) {
		List<Tickets> ticketList = null;
		aList = new ArrayList<Tickets>();
		try {

			if (ticketNumber != null) {
				ticketList = getAllLoggedTickets();
				for (Tickets ticket : ticketList) {
					if (ticket.getRecordID() == ticketNumber) {
						aList.add(ticket);
					}
				}

			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<Tickets> searchByTicketNumberForTech(Long ticketNumber,
			String technicianEmail) {
		List<Tickets> ticketList = null;
		aList = new ArrayList<Tickets>();
		try {

			if (ticketNumber != null) {
				ticketList = getAllLoggedTickets();
				for (Tickets ticket : ticketList) {
					if (ticket.getRecordID() == ticketNumber
							&& ticket.getEmployee().getEmail()
									.equalsIgnoreCase(technicianEmail)) {
						aList.add(ticket);
					}
				}

			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public String[] getTicketNumbers() {
		List<Tickets> list = null;
		ArrayList<String> newList = null;
		String array[] = null;
		try {
			list = getAllLoggedTickets();
			newList = new ArrayList<String>();

			for (Tickets ticket : list) {
				String tempTicketID = tempTicketNum + ticket.getRecordID();
				newList.add(tempTicketID);
			}

			array = new String[newList.size()];

			for (int i = 0; i < newList.size(); i++) {
				array[i] = newList.get(i);
			}
		} catch (Exception e) {
			e.getMessage();
		}
		return array;
	}

	@Override
	public String[] getTicketNumbersForTech(String technicianEmail) {
		List<Tickets> list = null;
		ArrayList<String> newList = null;
		String array[] = null;
		try {
			list = getAllLoggedTickets();
			newList = new ArrayList<String>();

			for (Tickets ticket : list) {

				if (ticket.getEmployee().getEmail()
						.equalsIgnoreCase(technicianEmail)) {
					String tempTicketID = tempTicketNum + ticket.getRecordID();
					newList.add(tempTicketID);
				}

			}

			array = new String[newList.size()];

			for (int i = 0; i < newList.size(); i++) {
				array[i] = newList.get(i);
			}
		} catch (Exception e) {
			e.getMessage();
		}
		return array;
	}

	@Override
	public String performTicketAction(TicketsBean ticketsBean) {
		order = new OrderHeader();
		dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		date = new Date();

		retMessage = null;
		try {
			if (ticketsBean != null) {
				ticketNumber = ticketsBean.getRecordID();
				ticket = getLoggedTicketsByTicketNumber(ticketNumber);
				technician = employeeDaoInt.getEmployeeByEmpNum(ticket
						.getEmployee().getEmail());
				String action = ticketsBean.getTicketAction();
				if (ticketsBean.getTechnicianUserName() != null
						&& ticketsBean.getTechnicianUserName().length() > 2) {

				}

				if (action != null && action.length() >= 2) {
					if (action.equalsIgnoreCase("Reassign")) {

						ticket.setStatus("Re-Open");
						ticket.setDateTime(dateFormat.format(date));
						ticket.setFourHourFlag(false);
						ticket.setOneHourFlag(false);
						String technicianName = technician.getFirstName() + " "
								+ technician.getLastName();
						String currentTechnicianName = ticket.getEmployee()
								.getFirstName()
								+ " "
								+ ticket.getEmployee().getLastName();
						Employee newAssignedTech = employeeDaoInt
								.getEmployeeByEmpNum(ticketsBean
										.getTechnicianUserName());
						ticket.setEmployee(newAssignedTech);
						sessionFactory.getCurrentSession().update(ticket);

						ticket.setComments("Ticket re-assigned from" + " "
								+ currentTechnicianName + " to "
								+ technicianName);
						historyDaoInt.insertTicketHistory(ticket);

						retMessage = "Ticket " + ticketNumber
								+ " re-assigned to "
								+ newAssignedTech.getFirstName() + " "
								+ newAssignedTech.getLastName();
					}

					else if (action.equalsIgnoreCase("Reopen")) {
						ticket.setStatus("Re-Open");
						ticket.setDateTime(dateFormat.format(date));
						sessionFactory.getCurrentSession().update(ticket);

						ticket.setComments("Ticket Re-opened");
						ticket.setReopenReason(ticketsBean.getReopenReason());
						historyDaoInt.insertTicketHistory(ticket);

						retMessage = "Ticket " + tempTicketNum
								+ ticket.getRecordID()
								+ " successfully re-opened.";

					}

					else if (action.equalsIgnoreCase("acknowledge")) {

						ticket.setStatus("Acknowledged");
						sessionFactory.getCurrentSession().update(ticket);

						ticket.setComments("Ticket Acknowledged by "
								+ technician.getFirstName() + " "
								+ technician.getLastName());
						historyDaoInt.insertTicketHistory(ticket);

						retMessage = "Ticket " + tempTicketNum
								+ ticket.getRecordID()
								+ " successfully Acknowledged";

					}

					else if (action.equalsIgnoreCase("taketicket")) {

						ticket.setStatus("Taken");
						sessionFactory.getCurrentSession().update(ticket);

						ticket.setComments("Ticket Taken by "
								+ technician.getFirstName() + " "
								+ technician.getLastName());
						historyDaoInt.insertTicketHistory(ticket);

						retMessage = "Ticket " + tempTicketNum
								+ ticket.getRecordID() + " successfully Taken";
					}

					else if (action.equalsIgnoreCase("awaitingspares")) {

						order = ordersDaoInt
								.getOrder(ticketsBean.getRecordID());
						ticket.setStatus("Awaiting Spares");
						retMessage = "Ticket " + tempTicketNum
								+ ticket.getRecordID()
								+ " awaiting for order no " + tempOrderNum
								+ order.getRecordID() + ".";
						if (order != null) {
							ticket.setOrderHeader(order);
						}

						sessionFactory.getCurrentSession().update(ticket);

						ticket.setComments("Ticket Awaiting Spares");
						historyDaoInt.insertTicketHistory(ticket);

					} else if (action.equalsIgnoreCase("Resolve")) {

						ticket.setStatus("Resolved");
						ticket.setUsedPartNumbers(ticketsBean
								.getUsedPartNumbers());
						ticket.setBridgedReason(ticketsBean.getBridgedReason());
						ticket.setReopenReason(ticketsBean.getReopenReason());
						ticket.setDateResolved(dateFormat.format(date));
						ticket.setComments(ticketsBean.getComments());
						device = deviceDaoInt.getDeviceBySerialNumbuer(ticket
								.getDevice().getSerialNumber());
						device.setMonoReading(ticketsBean.getMonoReading());
						device.setColourReading(ticketsBean.getColourReading());

						if (ticketsBean.getUsedPartNumbers() != null
								&& ticket.getUsedPartNumbers().length() > 4) {

							ticket.setActionTaken(ticketsBean.getActionTaken());
							retMessage = subractUsedSpares(
									ticketsBean.getUsedPartNumbers(), ticket
											.getDevice().getCustomerDevice()
											.getCustomerName(),
									ticketsBean.getGroupboot());

							if (retMessage.equalsIgnoreCase("OK")) {
								sessionFactory.getCurrentSession().update(
										device);
								sessionFactory.getCurrentSession()
										.saveOrUpdate(ticket);
								historyDaoInt.insertTicketHistory(ticket);
								JavaMail.sendEmailForResolvedTickets(ticket,ticket.getEmployee());
								retMessage = "Ticket " + tempTicketNum
										+ ticket.getRecordID()
										+ " successfully resolved.";
							}

						} else {

							ticket.setActionTaken(ticketsBean.getActionTaken());
							sessionFactory.getCurrentSession().update(device);
							sessionFactory.getCurrentSession().saveOrUpdate(
									ticket);

							historyDaoInt.insertTicketHistory(ticket);
							retMessage = "Ticket " + tempTicketNum
									+ ticket.getRecordID()
									+ " successfully resolved.";
						}

					} else if (action.equalsIgnoreCase("escalate")) {
						ticket.setStatus("Escalated");
						ticket.setEscalateReason(ticketsBean
								.getEscalateReason());
						ticket.setEscalatedTo(ticketsBean.getEscalatedTo());
						sessionFactory.getCurrentSession().update(ticket);

						ticket.setComments("Ticket Escalated");
						historyDaoInt.insertTicketHistory(ticket);
						JavaMail.sendMailDetailsToTechnicianForEscalation(ticket, ticket.getEmployee());

						retMessage = "Ticket " +tempTicketNum + ticketNumber
								+ " successfully Escalated to "
								+ ticketsBean.getEscalatedTo();

					}
					// Close the big if
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}

		return retMessage;
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
	public List<Tickets> getLastFourteenDaysTickets() {

		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List<Tickets> aList = new ArrayList<Tickets>();
		List<Tickets> ticketList = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 13);
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
				if (current.compareTo(dateData) <= 0) {
					aList.add(ticket);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	@Override
	public List<Tickets> getFourteenDaysTicketsForTech(String technicianEmail) {

		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List<Tickets> aList = new ArrayList<Tickets>();
		List<Tickets> ticketList = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 13);
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
				if (current.compareTo(dateData) <= 0
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
	public String logTicket(TicketsBean tickets) {
		String ticketNumber = "";
		Boolean isValied = false;
		//String userName = employee.getEmail();
		ticket = new Tickets();
		dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		date = new Date();
		try {

			technician = employeeDaoInt.getEmployeeByEmpNum(tickets
					.getTechnicianUserName());
			if (technician != null && technician.getLeaveStatus() != "Active") {
				device = deviceDaoInt.getDeviceBySerialNumbuer(tickets
						.getDevice());
				if (device != null) {

					isValied = isDeviceInContract(device.getSerialNumber());
					if (isValied == false) {
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
						ticketLoggedBy = (Employee) session.getAttribute("loggedInUser");
						String userEmail = ticketLoggedBy.getEmail();
						ticket.setTicketLoggedBy(userEmail);
						ticket.setDevice(device);
						sessionFactory.getCurrentSession().save(ticket);

						historyDaoInt.insertTicketHistory(ticket);
						retMessage = "Ticket " + tempTicketNum
								+ ticket.getRecordID()
								+ " is assigned to technician "
								+ ticket.getEmployee().getFirstName() + ".";
						JavaMail.sendEmailMessageDetailsToTechnician(ticket);
						emp = (Employee) session.getAttribute("loggedInUser");
						//JavaMail.sendMailFeedBackFromSystemToClient(ticket, employee)
						JavaMail.sendMailFeedBackFromSystemToClient(ticket, emp);
						
					} else {
						retMessage = "Contract for device "
								+ device.getSerialNumber()
								+ " expired. Ticket cannot be logged.";
					}

				} else {
					retMessage = "Device " + device.getSerialNumber()
							+ " does not exist. Ticket " + tempTicketNum
							+ ticket.getRecordID() + " cannot be logged.";
				}

			} else {
				retMessage = "Kindly note that technician in on leave.";
			}

		} catch (Exception e) {
			retMessage = "Ticket " + tempTicketNum + ticket.getRecordID()
					+ " not logged " + e.getMessage() + ".";
		}
		return retMessage;
	}

	@Override
	public Tickets getLoggedTicketsByTicketNumber(Long ticketNumber) {

		return (Tickets) sessionFactory.getCurrentSession().get(Tickets.class,
				ticketNumber);
	}

	// End of new functionality

	@Override
	public List<Tickets> getAllOpenTickets() {
		aList = new ArrayList<Tickets>();
		try {
			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				if ((ticket.getStatus().equalsIgnoreCase("Open") || ticket
						.getStatus().equalsIgnoreCase("Re-Open"))
						&& ticket.isOneHourFlag() == false) {
					aList.add(ticket);
				} else if ((ticket.getStatus().equalsIgnoreCase("Open") || ticket
						.getStatus().equalsIgnoreCase("Re-Open"))
						&& ticket.isOneHourFlag() == true
						&& ticket.isFourHourFlag() == false) {
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

		dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		date = new Date();

		try {
			String tempTicketNum = tickets.getTicketNumber().substring(6);
			Long temp = (long) Integer.parseInt(tempTicketNum);
			String status = tickets.getStatus();
			ticket = getLoggedTicketsByTicketNumber(temp);
			if (ticket != null) {

				if (status.equalsIgnoreCase("Awaiting Spares")) {
					order = ordersDaoInt.getOrder(tickets.getRecordID());
					ticket.setStatus("Awaiting Spares");
					historyDaoInt.insertTicketHistory(ticket);
					retMessage = "Ticket " + tempTicketNum
							+ ticket.getRecordID() + " awaiting for order no "
							+ tempOrderNum + order.getRecordID() + ".";
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
					retMessage = "Ticket " + tempTicketNum
							+ ticket.getRecordID() + " esalated to Manager "
							+ employee.getFirstName() + " "
							+ employee.getLastName() + ".";
					//Send mail for escalation
					JavaMail.sendMailDetailsToTechnicianForEscalation(ticket, employee);

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

								retMessage = "Ticket " + tempTicketNum
										+ ticket.getRecordID()
										+ " successfully resolved.";
							}
						}

					} else {

						ticket.setActionTaken(tickets.getActionTaken());
						sessionFactory.getCurrentSession().update(device);
						sessionFactory.getCurrentSession().saveOrUpdate(ticket);

						historyDaoInt.insertTicketHistory(ticket);
						retMessage = "Ticket " + tempTicketNum
								+ ticket.getRecordID()
								+ " successfully resolved.";
					}
				} else {
					ticket.setFourHourFlag(false);
					ticket.setOneHourFlag(false);
					ticket.setComments(tickets.getComments());
					ticket.setDateTime(dateFormat.format(date));

					ticket.setStatus("Re-Open");

					sessionFactory.getCurrentSession().saveOrUpdate(ticket);
					if (tickets.getMonoReading() != null
							|| tickets.getColourReading() != null) {
						sessionFactory.getCurrentSession().update(device);
					}
					historyDaoInt.insertTicketHistory(ticket);
					retMessage = "Ticket " + tempTicketNum
							+ ticket.getRecordID() + " successfully re-opened.";
				}
			}
		} catch (Exception e) {
			retMessage = "Something went wrong when updating ticket "
					+ tempTicketNum + ticket.getRecordID();
		}
		return retMessage;
	}

	@Override
	public List<Tickets> getAllEmployees(String searchName) {

		return null;
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
				if (ticket.getStatus().equalsIgnoreCase("Open")
						|| (ticket.getStatus().equalsIgnoreCase("Re-Open") && ticket
								.getEmployee().getEmail()
								.equalsIgnoreCase(technicianEmail))) {

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
						|| ticket.getStatus().equalsIgnoreCase("Re-Open")
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

	private List<Tickets> acknowledgedTickets() {
		aList = new ArrayList<Tickets>();
		try {
			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				if (ticket.getStatus().equalsIgnoreCase("Acknowledged")) {
					aList.add(ticket);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}

	private List<Tickets> takenTickets() {
		aList = new ArrayList<Tickets>();
		try {
			ticketList = getAllLoggedTickets();
			for (Tickets ticket : ticketList) {
				if (ticket.getStatus().equalsIgnoreCase("Taken")) {
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

	private String subractUsedSpares(String usedSpares, String customerName,
			String groupBoot) {
		technician = (Employee) session.getAttribute("loggedInUser");
		int tempCount = 0;
		try {
			List<String> spare = new ArrayList<String>(Arrays.asList(usedSpares
					.split(",")));

			if (groupBoot.equalsIgnoreCase("Site Stock")) {
				for (int i = 0; i < spare.size(); i++) {
					SiteStock siteStock = siteStockDaoInt.getSiteStock(
							spare.get(i), customerName);
					if (siteStock != null && siteStock.getQuantity() > 0) {

						if (siteStock.getQuantity() > 0) {
							tempCount = siteStock.getQuantity() - 1;
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
			} else if (groupBoot.equalsIgnoreCase("Boot Stock")) {
				for (int i = 0; i < spare.size(); i++) {
					BootStock boot = bootStockDaoIn.getBootStock(
							spare.get(i),
							technician.getFirstName() + " "
									+ technician.getLastName());
					if (boot != null && boot.getQuantity() > 0) {

						if (boot.getQuantity() > 0) {
							tempCount = boot.getQuantity() - 1;
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
			// result = ticketNumber.getRecordID();
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
						|| ticket.getStatus().equalsIgnoreCase("Re-Open")
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


	@SuppressWarnings("unused")
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
						&& currentDate.compareTo(dateData) >= 0
						&& tic.getEmployee().getEmail()
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
						&& currentDate.compareTo(dateData) >= 0
						&& tic.getEmployee().getEmail()
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

	@Override
	public List<Tickets> getAllAcknowledgedTickets() {
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
				if (ticket.getStatus().equalsIgnoreCase("Acknowledged")
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
	public List<Tickets> getAllAcknowledgedTickets(String technicianEmail) {
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
				if (ticket.getStatus().equalsIgnoreCase("Acknowledged")
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
	public List<Tickets> getAllTakenTickets() {
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
				if (ticket.getStatus().equalsIgnoreCase("Taken")
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
	public List<Tickets> getAllTakenTickets(String technicianEmail) {
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
				if (ticket.getStatus().equalsIgnoreCase("Taken")
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
	public int countAcknowledgedTickets() {

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
				if (ticket.getStatus().equalsIgnoreCase("Acknowledged")
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
	public int countAcknowledgedTickets(String technicianEmail) {
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
				if (ticket.getStatus().equalsIgnoreCase("Acknowledged")
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
	public int countTakenTickets() {
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
				if (ticket.getStatus().equalsIgnoreCase("Taken")
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
	public int countTakenTickets(String technicianEmail) {
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
				if (ticket.getStatus().equalsIgnoreCase("Taken")
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
	public List<Tickets> getTicketByDateAndCustomer(String selecteDate,
			String customerName, String technicianEmai) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Tickets> getTicketByDateAndCustomerForManager(
			String selecteDate, String customerName, String technicianEmai) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		List<Tickets> ticketList = null;
		aList = new ArrayList<Tickets>();
		try {

			// Get Ticket List by Date Range and Status
			if (selecteDate.length() >= 3) {
				if (selecteDate.equalsIgnoreCase("Last 24 Hours")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 1);
				} else if (selecteDate.equalsIgnoreCase("Last 7 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 6);
				} else if (selecteDate.equalsIgnoreCase("Last 14 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 13);
				} else if (selecteDate.equalsIgnoreCase("Last 30 Days")) {
					cal.set(Calendar.DAY_OF_MONTH,
							cal.get(Calendar.DAY_OF_MONTH) - 30);
				}
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
					if (current.compareTo(dateData) <= 0
							&& ticket.getEmployee().getEmail()
									.equalsIgnoreCase(technicianEmai)
							&& ticket.getDevice().getCustomerDevice()
									.getCustomerName()
									.equalsIgnoreCase(customerName)) {
						aList.add(ticket);
					}
				}

			}

		} catch (Exception exception) {
			exception.getMessage();
		}

		return aList;
	}


}
