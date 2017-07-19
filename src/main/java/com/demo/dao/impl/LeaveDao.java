package com.demo.dao.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.LeaveBean;
import com.demo.dao.EmployeeDaoInt;
import com.demo.dao.LeaveDaoInt;
import com.demo.model.Employee;
import com.demo.model.Leave;

@Repository("leaveDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class LeaveDao implements LeaveDaoInt {

	@Autowired
	private SessionFactory sessionFactory;
	private Session session2;
	@Autowired
	private HttpSession session;
	@Autowired
	private EmployeeDaoInt employeeDaoInt;
	private List<Leave> tempLeave = null;
	private List<Leave> leaveList = null;
	private Leave globalLeave;

	private String retMessage = null;
	private Date currentDate, secondDate = null;
	private SimpleDateFormat myFormat = null;
	private int recordID = 0;
	private Employee emp = null;

	@Override
	public List<Leave> getAllTechLeaveForSelectedRange(String dateRange, String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List<Leave> aList = new ArrayList<Leave>();
		List<Leave> leaveList = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			// If we give 7 there it will give 8 days back
			if (dateRange.equalsIgnoreCase("Last 7 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 6);
			} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 31);
			} else if (dateRange.equalsIgnoreCase("Last 6 Months")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 182);
			} else if (dateRange.equalsIgnoreCase("Last Year")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 365);
			}
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			leaveList = activeAndPendingLeaveByTechnician(technicianEmail);
			for (Leave leave : leaveList) {
				String convDate = leave.getLeaveDate().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(leave);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		System.err.println(aList.size());
		return aList;
	}
	
	@Override
	public List<Leave> getAllLeaveForSelectedRange(String dateRange) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List<Leave> aList = new ArrayList<Leave>();
		List<Leave> leaveList = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			// If we give 7 there it will give 8 days back
			if (dateRange.equalsIgnoreCase("Last 7 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 6);
			} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 31);
			} else if (dateRange.equalsIgnoreCase("Last 6 Months")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 182);
			} else if (dateRange.equalsIgnoreCase("Last Year")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 365);
			}
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			leaveList = leaveRequests();
			for (Leave leave : leaveList) {
				String convDate = leave.getLeaveDate().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(leave);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		System.err.println(aList.size());
		return aList;
	}
	
	@Override
	public List<Leave> getActiveLeaveForSelectedRange(String dateRange) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List<Leave> aList = new ArrayList<Leave>();
		List<Leave> leaveList = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			// If we give 7 there it will give 8 days back
			if (dateRange.equalsIgnoreCase("Last 7 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 6);
			} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 31);
			} else if (dateRange.equalsIgnoreCase("Last 6 Months")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 182);
			} else if (dateRange.equalsIgnoreCase("Last Year")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 365);
			}
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			leaveList = getActiveLeave();
			for (Leave leave : leaveList) {
				String convDate = leave.getLeaveDate().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(leave);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		System.err.println(aList.size());
		return aList;
	}
	
	
	@Override
	public List<Leave> getLeaveHistoryForSelectedRange(String dateRange) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List<Leave> aList = new ArrayList<Leave>();
		List<Leave> leaveList = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			// If we give 7 there it will give 8 days back
			if (dateRange.equalsIgnoreCase("Last 7 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 6);
			} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 31);
			} else if (dateRange.equalsIgnoreCase("Last 6 Months")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 182);
			} else if (dateRange.equalsIgnoreCase("Last Year")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 365);
			}
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			leaveList = leaveHistory();
			for (Leave leave : leaveList) {
				String convDate = leave.getLeaveDate().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(leave);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		System.err.println(aList.size());
		return aList;
	}
	
	
	
	@Override
	public List<Leave> getPendingLeaveForSelectedRange(String dateRange) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List<Leave> aList = new ArrayList<Leave>();
		List<Leave> leaveList = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			// If we give 7 there it will give 8 days back
			if (dateRange.equalsIgnoreCase("Last 7 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 6);
			} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 31);
			} else if (dateRange.equalsIgnoreCase("Last 6 Months")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 182);
			} else if (dateRange.equalsIgnoreCase("Last Year")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 365);
			}
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			leaveList = getPendingLeaves();
			for (Leave leave : leaveList) {
				String convDate = leave.getLeaveDate().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(leave);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		System.err.println(aList.size());
		return aList;
	}
	
	@Override
	public List<Leave> getTechLeaveHistoryForSelectedRange(String dateRange, String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List<Leave> aList = new ArrayList<Leave>();
		List<Leave> leaveList = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			// If we give 7 there it will give 8 days back
			if (dateRange.equalsIgnoreCase("Last 7 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 6);
			} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 31);
			} else if (dateRange.equalsIgnoreCase("Last 6 Months")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 182);
			} else if (dateRange.equalsIgnoreCase("Last Year")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 365);
			}
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			leaveList = getLeaveHistoryByTechician(technicianEmail);
			for (Leave leave : leaveList) {
				String convDate = leave.getLeaveDate().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(leave);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		System.err.println(aList.size());
		return aList;
	}
	
	@Override
	public List<Leave> getTechActiveLeaveForSelectedRange(String dateRange, String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List<Leave> aList = new ArrayList<Leave>();
		List<Leave> leaveList = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			// If we give 7 there it will give 8 days back
			if (dateRange.equalsIgnoreCase("Last 7 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 6);
			} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 31);
			} else if (dateRange.equalsIgnoreCase("Last 6 Months")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 182);
			} else if (dateRange.equalsIgnoreCase("Last Year")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 365);
			}
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			leaveList = getActiveLeaveByTechnician(technicianEmail);
			for (Leave leave : leaveList) {
				String convDate = leave.getLeaveDate().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(leave);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		System.err.println(aList.size());
		return aList;
	}

	@Override
	public List<Leave> getTechPendingLeaveForSelectedRange(String dateRange, String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		List<Leave> aList = new ArrayList<Leave>();
		List<Leave> leaveList = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			// If we give 7 there it will give 8 days back
			if (dateRange.equalsIgnoreCase("Last 7 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 6);
			} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 31);
			} else if (dateRange.equalsIgnoreCase("Last 6 Months")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 182);
			} else if (dateRange.equalsIgnoreCase("Last Year")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 365);
			}
			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			leaveList = getPendingLeaveByTechnician(technicianEmail);
			for (Leave leave : leaveList) {
				String convDate = leave.getLeaveDate().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					aList.add(leave);
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}

		System.err.println(aList.size());
		return aList;
	}

	@Override
	public List<String> getLeaveDates() {
		List<String> newDates = new ArrayList<String>();
		newDates.add("Last 7 Days");
		newDates.add("Last 30 Days");
		newDates.add("Last 6 Months");
		newDates.add("Last Year");
		return newDates;
	}

	@Override
	public int countTechpendingLeaveForSelectedDate(String dateRange, String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		List<Leave> pendingLeave = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			if (dateRange.equalsIgnoreCase("Last 7 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 6);
			} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 31);
			} else if (dateRange.equalsIgnoreCase("Last 6 Months")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 182);
			} else if (dateRange.equalsIgnoreCase("Last Year")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 365);
			}

			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			leaveList = getPendingLeaveByTechnician(technicianEmail);
			for (Leave leave : leaveList) {
				String convDate = leave.getLeaveDate().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}
		System.out.println(tempCount);
		return tempCount;
	}
	
	@Override
	public int countTechActiveLeaveForSelectedDate(String dateRange, String technicianEmail) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		List<Leave> pendingLeave = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			if (dateRange.equalsIgnoreCase("Last 7 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 6);
			} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 31);
			} else if (dateRange.equalsIgnoreCase("Last 6 Months")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 182);
			} else if (dateRange.equalsIgnoreCase("Last Year")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 365);
			}

			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			leaveList = getActiveLeaveByTechnician(technicianEmail);
			for (Leave leave : leaveList) {
				String convDate = leave.getLeaveDate().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}
		System.out.println(tempCount);
		return tempCount;
	}
	
	@Override
	public int countpendingLeaveForSelectedDate(String dateRange) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		List<Leave> pendingLeave = null;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			if (dateRange.equalsIgnoreCase("Last 7 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 6);
			} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 31);
			} else if (dateRange.equalsIgnoreCase("Last 6 Months")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 182);
			} else if (dateRange.equalsIgnoreCase("Last Year")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 365);
			}

			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			leaveList = getPendingLeaves();
			for (Leave leave : leaveList) {
				String convDate = leave.getLeaveDate().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}
		System.out.println(tempCount);
		return tempCount;
	}
	@Override
	public int countActiveLeaveForSelectedDate(String dateRange) {
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		// get Calendar instance
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int tempCount = 0;
		try {
			// substract 7 days
			// If we give 7 there it will give 8 days back
			if (dateRange.equalsIgnoreCase("Last 7 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 6);
			} else if (dateRange.equalsIgnoreCase("Last 30 Days")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 31);
			} else if (dateRange.equalsIgnoreCase("Last 6 Months")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 182);
			} else if (dateRange.equalsIgnoreCase("Last Year")) {
				cal.set(Calendar.DAY_OF_MONTH,
						cal.get(Calendar.DAY_OF_MONTH) - 365);
			}

			// convert to date
			Date myDate = cal.getTime();

			String date1 = myFormat.format(myDate);
			String Date2 = myFormat.format(currentDate);
			Date current = new Date();
			Date previous = new Date();
			Date dateData = new Date();

			current = myFormat.parse(date1);
			previous = myFormat.parse(Date2);

			leaveList = getActiveLeave();
			for (Leave leave : leaveList) {
				String convDate = leave.getLeaveDate().substring(0, 10);
				String normalDate = convDate.replace("/", "-");
				dateData = myFormat.parse(normalDate);
				if (current.compareTo(dateData) <= 0) {
					tempCount++;
				}
			}
		} catch (Exception exception) {
			exception.getMessage();
		}
		System.out.println(tempCount);
		return tempCount;
	}

	@Override
	public int countAllPendingLeave() {

		int tempCount = 0;
		List<Leave> pendingLeave = null;
		try {

			pendingLeave = getPendingLeaves();
			for (Leave leave : pendingLeave) {

				if (leave.getStatus().equalsIgnoreCase("Pending")) {
					tempCount++;
				}

			}
		} catch (Exception exception) {
			exception.getMessage();
		}
		return tempCount;
	}

	@Override
	public int getPendingLeaveCountByTechnician(String technicianEmail) {
		List<Leave> pendingLeave = null;
		int tempCount = 0;
		try {
			leaveList = getPendingLeaves();

			for (Leave leave : leaveList) {
				if (leave.getEmployee().getEmail()
						.equalsIgnoreCase(technicianEmail)) {
					tempCount++;
				} else if (technicianEmail.equalsIgnoreCase("All Technicians")) {
					tempCount++;
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return tempCount;
	}

	@Override
	public List<Leave> getPendingLeaveByTechnician(String technicianEmail) {
		List<Leave> currentList = new ArrayList<Leave>();

		try {
			leaveList = getPendingLeaves();

			for (Leave leave : leaveList) {
				if (leave.getEmployee().getEmail()
						.equalsIgnoreCase(technicianEmail)) {
					currentList.add(leave);
				} else if (technicianEmail.equalsIgnoreCase("All Technicians")) {
					currentList.add(leave);
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return currentList;
	}

	@Override
	public List<Leave> getActiveLeaveByTechnician(String technicianEmail) {
		List<Leave> currentList = new ArrayList<Leave>();

		try {
			leaveList = getActiveLeave();

			for (Leave leave : leaveList) {
				if (leave.getEmployee().getEmail()
						.equalsIgnoreCase(technicianEmail)) {
					currentList.add(leave);
				} else if (technicianEmail.equalsIgnoreCase("All Technicians")) {
					currentList.add(leave);
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return currentList;
	}

	@Override
	public int getActiveLeaveCountByTechnician(String technicianEmail) {
		List<Leave> pendingLeave = null;
		int tempCount = 0;
		try {
			leaveList = getActiveLeave();

			for (Leave leave : leaveList) {
				if (leave.getEmployee().getEmail()
						.equalsIgnoreCase(technicianEmail)) {
					if (leave.getStatus().equalsIgnoreCase("Active")) {
						tempCount++;
					}
				} else if (technicianEmail.equalsIgnoreCase("All Technicians")) {
					tempCount++;
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return tempCount;
	}

	@Override
	public int countAllActiveLeave() {

		int tempCount = 0;
		List<Leave> activeLeave = null;
		try {

			activeLeave = getActiveLeave();
			for (Leave leave : activeLeave) {

				if (leave.getStatus().equalsIgnoreCase("Active")) {
					tempCount++;
				}
			}
			System.err.println("Count is " + tempCount);
		} catch (Exception exception) {
			exception.getMessage();
		}
		return tempCount;
	}

	public String getLeaveStatus(String startDate, String endDate) {
		String leaveStatus = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date start = sdf.parse(startDate);
			Date end = sdf.parse(endDate);
			Date currentDate = sdf.parse(sdf.format(new Date()));

			// Leave Start date in future
			if (start.compareTo(currentDate) > 0) {
				leaveStatus = "Pending";
			}
			// Leave Started and end day not reached yet
			else if (start.compareTo(currentDate) <= 0
					&& end.compareTo(currentDate) >= 0) {
				leaveStatus = "Active";
			}
			// End date reached
			else if (end.compareTo(currentDate) < 0) {
				leaveStatus = "Completed";
			}

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return leaveStatus;
	}
	
/*	@Scheduled(fixedRate=18000000)
	public void updateLeaveStatus() {
		
		String startDate = "";  
		String endDate = "";
		String leaveStatus = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date start = sdf.parse(startDate);
			Date end = sdf.parse(endDate);
			Date currentDate = sdf.parse(sdf.format(new Date()));

			// Leave Start date in future
			if (start.compareTo(currentDate) > 0) {
				leaveStatus = "Pending";
			}
			// Leave Started and end day not reached yet
			else if (start.compareTo(currentDate) <= 0
					&& end.compareTo(currentDate) >= 0) {
				leaveStatus = "Active";
			}
			// End date reached
			else if (end.compareTo(currentDate) < 0) {
				leaveStatus = "Completed";
			}

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}
*/

	boolean duplicateLeave(String startDate, String endDate, String technician) {
		boolean duplicate = false;
		tempLeave = new ArrayList<Leave>();
		try {
			leaveList = leaveRequests();
			for (Leave leave : leaveList) {
				if (leave.getEmployee().getEmail().equalsIgnoreCase(technician)) {
					if (startDate.equalsIgnoreCase(leave.getStartDate())
							&& (endDate.equalsIgnoreCase(leave.getEndDate()))) {

						duplicate = true;

					}
					tempLeave.add(leave);
				}
			}
		} catch (Exception e) {
			e.getMessage();
		}

		return duplicate;
	}

	@Override
	public String leaveRequest(LeaveBean leave) {
		Employee employee = (Employee) session.getAttribute("loggedInUser");
		globalLeave = new Leave();
		String userName = null;
		
		//Get Current Time Stamp
		Calendar cal = Calendar.getInstance();		
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:s");
		Date currentDate = new Date();
		cal.setTime(new Date());

		currentDate = cal.getTime();

	    
	    
		try {
			int newrecordID = 0;
			if (leave.getTechnicianUserName() != null) {
				employee = employeeDaoInt.getEmployeeByEmpNum(leave.getTechnicianUserName());
				globalLeave.setEmployee(employee);
				userName = employee.getEmail();
			} else {
				globalLeave.setEmployee(employee);
				userName = employee.getEmail();
			}

			emp = employeeDaoInt.getEmployeeByEmpNum(userName);
			// if (emp.getLeaveStatus().equalsIgnoreCase("Active")) {
			boolean duplicate = duplicateLeave(leave.getStartDate(),
					leave.getEndDate(), userName);

			if (duplicate == true) {
				retMessage = "Leave already exist for " + emp.getFirstName()
						+ " " + emp.getLastName();
			} else {

				String leaveStatus = getLeaveStatus(leave.getStartDate(),
						leave.getEndDate());
				globalLeave.setStatus(leaveStatus);

				globalLeave.setAddress(leave.getAddress());
				globalLeave.setContactNumber(leave.getContactNumber());
				globalLeave.setEndDate(leave.getEndDate());
				globalLeave.setLeaveType(leave.getLeaveType());
				globalLeave.setStartDate(leave.getStartDate());
			    globalLeave.setLeaveDate(myFormat.format(currentDate));
				recordID = newRecordID();
				newrecordID = recordID;

				globalLeave.setLeaveID(newrecordID);
				sessionFactory.getCurrentSession().save(globalLeave);
				emp.setLeaveStatus(leaveStatus);
				sessionFactory.getCurrentSession().update(emp);

				retMessage = "Leave successfully submited.";
			}

		} catch (Exception e) {
			retMessage = "Leave not submitted " + e.getMessage() + ".";
		}
		return retMessage;
	}

	@Override
	public String updateLeaveRequest(LeaveBean leave) {
		globalLeave = new Leave();
		Employee employee = (Employee) session.getAttribute("loggedInUser");
		try {
			globalLeave.setAddress(leave.getAddress());
			globalLeave.setContactNumber(leave.getContactNumber());
			globalLeave.setEndDate(leave.getEndDate());
			globalLeave.setLeaveID(leave.getLeaveID());
			globalLeave.setLeaveType(leave.getLeaveType());
			globalLeave.setStartDate(leave.getStartDate());

			if (leave.getTechnicianUserName() != null) {
				employee = employeeDaoInt.getEmployeeByEmpNum(leave
						.getTechnicianUserName());
				globalLeave.setEmployee(employee);
			} else {
				globalLeave.setEmployee(employee);
			}
			sessionFactory.getCurrentSession().update(globalLeave);
			retMessage = "Leave sucessfully updated";
		} catch (Exception e) {
			retMessage = "Leave not updated " + e.getMessage() + ".";
		}
		return retMessage;
	}

	@Override
	public List<Leave> leaveRequests(String email) {
		tempLeave = new ArrayList<Leave>();
		try {
			leaveList = leaveRequests();
			for (Leave leave : leaveList) {
				if (leave.getEmployee().getEmail().equalsIgnoreCase(email)) {
					tempLeave.add(leave);
				}
			}
		} catch (Exception e) {
			e.getMessage();
		}
		return tempLeave;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Leave> leaveRequests() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				Leave.class);
		return (List<Leave>) criteria.list();
	}

	@Override
	public List<Leave> activeAndPendingLeaveByTechnician(String technicianEmail) {
		List<Leave> currentList = new ArrayList<Leave>();

		try {
			leaveList = getAllActiveAndPendingLeave();

			for (Leave leave : leaveList) {
				if (leave.getEmployee().getEmail()
						.equalsIgnoreCase(technicianEmail)) {

					currentList.add(leave);
				} else if (technicianEmail.equalsIgnoreCase("All Technicians")) {
					currentList.add(leave);
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return currentList;
	}

	@Override
	public List<Leave> getAllActiveAndPendingLeave() {
		List<Leave> currentList = new ArrayList<Leave>();
		try {
			leaveList = leaveRequests();

			for (Leave leave : leaveList) {
				if (leave.getStatus().equalsIgnoreCase("Active")
						|| leave.getStatus().equalsIgnoreCase("Pending")) {
					currentList.add(leave);
				}
			}
		} catch (Exception e) {
			e.getMessage();
		}
		return currentList;
	}

	private List<Leave> getCurrentLeaves() {
		List<Leave> currentList = new ArrayList<Leave>();
		try {
			leaveList = leaveRequests();

			for (Leave leave : leaveList) {
				if (leave.getStatus().equalsIgnoreCase("On Leave")) {
					currentList.add(leave);
				}
			}
		} catch (Exception e) {
			e.getMessage();
		}
		return currentList;
	}

	@Override
	public List<Leave> leaveHistory() {
		List<Leave> currentList = new ArrayList<Leave>();

		try {
			leaveList = leaveRequests();

			for (Leave leave : leaveList) {
				if (leave.getStatus().equalsIgnoreCase("Completed")) {
					currentList.add(leave);
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return currentList;
	}

	@Override
	public List<Leave> getLeaveHistoryByTechician(String technicianEmail) {
		List<Leave> currentList = new ArrayList<Leave>();

		try {
			leaveList = leaveHistory();

			for (Leave leave : leaveList) {
				if (leave.getEmployee().getEmail()
						.equalsIgnoreCase(technicianEmail)) {

					currentList.add(leave);
				} else if (technicianEmail.equalsIgnoreCase("All Technicians")) {
					currentList.add(leave);
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return currentList;
	}

	@Override
	public List<Leave> getPendingLeaves() {
		List<Leave> currentList = new ArrayList<Leave>();

		try {
			leaveList = leaveRequests();

			for (Leave leave : leaveList) {
				if (leave.getStatus().equalsIgnoreCase("Pending")) {
					currentList.add(leave);
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return currentList;
	}

	@Override
	public List<Leave> getActiveLeave() {
		List<Leave> currentList = new ArrayList<Leave>();
		try {
			leaveList = leaveRequests();

			for (Leave leave : leaveList) {
				if (leave.getStatus().equalsIgnoreCase("Active")) {
					currentList.add(leave);
				}
			}
		} catch (Exception e) {
			e.getMessage();
		}
		return currentList;
	}

	@Override
	public Leave getLeave(int leaveID) {
		return (Leave) sessionFactory.getCurrentSession().get(Leave.class,
				leaveID);
	}

	private Integer newRecordID() {

		int tempOrderNum = 0;
		Integer newOrderNum = getRecordID();

		if (newOrderNum != null) {
			tempOrderNum = newOrderNum + 1;
		} else {
			tempOrderNum = 1;
		}

		return tempOrderNum;
	}

	private Integer getRecordID() {

		session2 = sessionFactory.openSession();
		Integer result = 0;
		Query query = session2.createQuery("from Leave order by leaveID DESC");
		query.setMaxResults(1);
		Leave leaveNumber = (Leave) query.uniqueResult();

		if (leaveNumber != null) {
			result = leaveNumber.getLeaveID();
		} else {
			result = null;
		}
		return result;
	}

	@Override
	public Boolean isTechnicianOnLeave(String technicianEmail) {
		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		secondDate = new Date();
		String tempCurrentDate = null;
		Boolean isOnLeave = false;
		try {
			tempLeave = technicianOnLeave(technicianEmail);
			tempCurrentDate = myFormat.format(currentDate);
			currentDate = myFormat.parse(tempCurrentDate);

			if (tempLeave.size() > 0) {
				for (Leave leave : tempLeave) {
					if (leave != null) {
						secondDate = myFormat.parse(leave.getEndDate());
						if (secondDate.compareTo(currentDate) < 0) {
							isOnLeave = true;
							break;
						}
					}

				}
			}

		} catch (Exception e) {
			e.getMessage();
		}

		return isOnLeave;
	}

	private List<Leave> technicianOnLeave(String technicianEmail) {

		try {
			leaveList = leaveRequests();
			tempLeave = new ArrayList<Leave>();
			for (Leave leave : leaveList) {
				if (leave.getEmployee().getEmail()
						.equalsIgnoreCase(technicianEmail))
					;
				tempLeave.add(leave);
			}

		} catch (Exception e) {
			e.getMessage();
		}
		return tempLeave;
	}

	@Override
	public String onLeaveTechnician(String technicianEmail) {
		String retMessage = "";
		Boolean isOnleave = false;
		try {
			isOnleave = isTechnicianOnLeave(technicianEmail);
			if (isOnleave == true) {
				// Employee emp =
				// employeeDaoInt.getEmployeeByEmpNum(technicianEmail);

				retMessage = "Kindly note that technician is on leave.";
			}
		} catch (Exception exception) {
			exception.getMessage();
		}
		return retMessage;
	}

	@Override
	public String[] techniciansOnLeave() {

		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		secondDate = new Date();
		String tempCurrentDate = null;
		ArrayList<String> newList = null;
		String techniciansOnLeave[] = null;
		try {

			newList = new ArrayList<String>();

			tempLeave = leaveRequests();
			tempCurrentDate = myFormat.format(currentDate);
			currentDate = myFormat.parse(tempCurrentDate);

			for (Leave leave : tempLeave) {
				secondDate = myFormat.parse(leave.getEndDate());
				if (secondDate.compareTo(currentDate) < 0) {
					newList.add(leave.getEmployee().getEmail());
				}
			}
			techniciansOnLeave = new String[newList.size()];

			for (int i = 0; i < newList.size(); i++) {
				techniciansOnLeave[i] = newList.get(i);
			}
		} catch (Exception e) {
			e.getMessage();
		}
		return techniciansOnLeave;
	}

	@Transactional
	@Scheduled(fixedRate = 1440000)
	@Override
	public void isTechnicianOnLeaveDate() {
		myFormat = new SimpleDateFormat("yyyy-MM-dd");
		currentDate = new Date();
		secondDate = new Date();
		Calendar cal = Calendar.getInstance();
		String date1 = myFormat.format(cal.getTime());
		try {
			tempLeave = getCurrentLeaves();

			if (tempLeave.size() > 0) {
				for (Leave leave : tempLeave) {
					secondDate = myFormat.parse(leave.getEndDate());
					currentDate = myFormat.parse(date1);
					if (currentDate.compareTo(secondDate) >= 0) {
						emp = employeeDaoInt.getEmployeeByEmpNum(leave
								.getEmployee().getEmail());
						emp.setLeaveStatus("Available");
						sessionFactory.getCurrentSession().update(emp);
						leave.setStatus("Available");
						sessionFactory.getCurrentSession().update(leave);
					}
				}
			}

		} catch (Exception e) {
			e.getMessage();
		}

	}
}
