package com.demo.dao.impl;

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
	public String leaveRequest(LeaveBean leave) {
		Employee employee = (Employee) session.getAttribute("loggedInUser");
		globalLeave = new Leave();
		String userName = null;
		try {
			int newrecordID = 0;
			if (leave.getTechnicianUserName() != null) {
				employee = employeeDaoInt.getEmployeeByEmpNum(leave
						.getTechnicianUserName());
				globalLeave.setEmployee(employee);
				userName = employee.getEmail();
			} else {
				globalLeave.setEmployee(employee);
				userName = employee.getEmail();
			}

			emp = employeeDaoInt.getEmployeeByEmpNum(userName);
			if (emp.getLeaveStatus().equalsIgnoreCase("On Leave")) {
				retMessage = "Kindly note that "+emp.getFirstName() +" "+emp.getLastName()+" is on leave";
			} else  {
				globalLeave.setStatus("On Leave");

				globalLeave.setAddress(leave.getAddress());
				globalLeave.setContactNumber(leave.getContactNumber());
				globalLeave.setEndDate(leave.getEndDate());
				globalLeave.setLeaveType(leave.getLeaveType());
				globalLeave.setStartDate(leave.getStartDate());
				recordID = newRecordID();
				newrecordID = recordID;

				globalLeave.setLeaveID(newrecordID);
				sessionFactory.getCurrentSession().save(globalLeave);
				emp.setLeaveStatus("On Leave");
				sessionFactory.getCurrentSession().update(emp);

				retMessage = "Leave successfully submited";
			}/*else{
				emp.setLeaveStatus("On Leave");

				globalLeave.setAddress(leave.getAddress());
				globalLeave.setContactNumber(leave.getContactNumber());
				globalLeave.setEndDate(leave.getEndDate());
				globalLeave.setLeaveType(leave.getLeaveType());
				globalLeave.setStartDate(leave.getStartDate());
				recordID = newRecordID();
				newrecordID = recordID;

				globalLeave.setLeaveID(newrecordID);
				sessionFactory.getCurrentSession().save(globalLeave);

				sessionFactory.getCurrentSession().update(emp);

				retMessage = "Leave successfully submited";
			}*/

		} catch (Exception e) {
			retMessage = "Leave not submitted " + e.getMessage();
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
			retMessage = "Leave was not updated" + e.getMessage();
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
	private List<Leave> getCurrentLeaves(){
		List<Leave> currentList = new ArrayList<Leave>();
		try{
			leaveList = leaveRequests();
			
			for(Leave leave:leaveList){
				if(leave.getStatus().equalsIgnoreCase("On Leave")){
					currentList.add(leave);
				}
			}
		}catch(Exception e){
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

				retMessage = "Kindly note that technician is on leave";
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
	@Scheduled(fixedRate = 600000)
	@Override
	public void isTechnicianOnLeaveDate() {
			myFormat = new SimpleDateFormat("yyyy-MM-dd");
			currentDate = new Date();
			secondDate = new Date();
			Calendar cal = Calendar.getInstance();
		    String date1 =  myFormat.format(cal.getTime());
			try {
				tempLeave = getCurrentLeaves();
				
				if(tempLeave.size()>0){
					for (Leave leave : tempLeave) {
						secondDate = myFormat.parse(leave.getEndDate());
						currentDate = myFormat.parse(date1);
						if (currentDate.compareTo(secondDate)>=0) {
							emp = employeeDaoInt.getEmployeeByEmpNum(leave.getEmployee().getEmail());
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
