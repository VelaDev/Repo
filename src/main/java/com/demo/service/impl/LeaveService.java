package com.demo.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.LeaveDaoInt;
import com.demo.model.Leave;
import com.demo.service.LeaveInt;


@Service("leaveService")
@Transactional
public class LeaveService implements LeaveInt{
	
	@Autowired
	private LeaveDaoInt leaveDaoInt;
	
	private String retMessage = null;

	@Override
	public String leaveRequest(Leave leave) {
		retMessage = leaveDaoInt.leaveRequest(leave);
		return retMessage;
	}

	@Override
	public String updateLeaveRequest(Leave leave) {
		retMessage = leaveDaoInt.updateLeaveRequest(leave);
		return null;
	}

	@Override
	public List<Leave> leaveRequests(String email) {
		
		return leaveDaoInt.leaveRequests(email);
	}

	@Override
	public List<Leave> leaveRequests() {
		
		return leaveDaoInt.leaveRequests();
	}

	@Override
	public Leave getLeave(String leaveID) {
		return leaveDaoInt.getLeave(leaveID);
	}

}
