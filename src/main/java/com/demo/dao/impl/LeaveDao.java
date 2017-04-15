package com.demo.dao.impl;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.LeaveDaoInt;
import com.demo.model.Employee;
import com.demo.model.Leave;
import com.demo.model.OrderHeader;

@Repository("leaveDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class LeaveDao implements LeaveDaoInt{
	
	@Autowired
	private SessionFactory sessionFactory;
	private Session session2;
	@Autowired
	private HttpSession session;
	private List<Leave> tempLeave = null;
	private List<Leave> leaveList = null;
	
	
	private String retMessage = null;
	
   private int recordID =0;
  
	@Override
	public String leaveRequest(Leave leave) {
	Employee employee = (Employee) session.getAttribute("loggedInUser");
		try{
			int newrecordID = 0;
			leave.setEmployee(employee);
			recordID =  newRecordID();
			newrecordID =  recordID;
			
			leave.setLeaveID(newrecordID);
			sessionFactory.getCurrentSession().save(leave);
			retMessage = "Leave "+leave.getLeaveID()+" successfully submited";
		}
		catch(Exception e){
			retMessage = "Leave not submitted " + e.getMessage();
		}
		return retMessage;
	}
		
	@Override
	public String updateLeaveRequest(Leave leave) {
		
		Employee employee = (Employee) session.getAttribute("loggedInUser");
		try{
			leave.setEmployee(employee);
			sessionFactory.getCurrentSession().update(leave);
			retMessage = "Leave sucessfully updated";
		}
		catch(Exception e){
			retMessage = "Leave was not updated" + e.getMessage();
		}
		return retMessage;
	}
	
	
	@Override
	public List<Leave> leaveRequests(String email) {
		tempLeave = new ArrayList<Leave>();
		try{
			leaveList = leaveRequests();
			for(Leave leave:leaveList){
				if(leave.getEmployee().getEmail().equalsIgnoreCase(email)){
					tempLeave.add(leave);
				}
			}
		}catch(Exception e){
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
		Query query = session2
				.createQuery("from Leave order by leaveID DESC");
		query.setMaxResults(1);
		Leave leaveNumber = (Leave) query.uniqueResult();

		if (leaveNumber != null) {
			result = leaveNumber.getLeaveID();
		} else {
			result = null;
		}
		return result;
	}

}
