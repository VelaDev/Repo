package com.demo.dao.impl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.demo.dao.LeaveDaoInt;
import com.demo.model.Leave;

public class LeaveDao implements LeaveDaoInt{
	
	@Autowired
	private SessionFactory sessionFactory;
	
	private String retMessage = null;

	@Override
	public String leaveRequest(Leave leave) {
		try{
			
		}
		catch(Exception e){
			retMessage = "";
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