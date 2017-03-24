package com.demo.dao.impl;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.LeaveDaoInt;
import com.demo.model.Employee;
import com.demo.model.Leave;

@Repository("leaveDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class LeaveDao implements LeaveDaoInt{
	
	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private HttpSession session;
	
	
	private String retMessage = null;
	

	@Override
	public String leaveRequest(Leave leave) {
	Employee employee = (Employee) session.getAttribute("loggedInUser");
		try{
			leave.setEmployee(employee);
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Leave> leaveRequests(String email) {
		// TODO Auto-generated method stub
		return null;
	}

}
