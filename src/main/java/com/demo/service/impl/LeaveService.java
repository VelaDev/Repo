package com.demo.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.bean.LeaveBean;
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
	public String leaveRequest(LeaveBean leave) {
		retMessage = leaveDaoInt.leaveRequest(leave);
		return retMessage;
	}

	@Override
	public String updateLeaveRequest(LeaveBean leave) {
		retMessage = leaveDaoInt.updateLeaveRequest(leave);
		return retMessage;
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
	public Leave getLeave(int leaveID) {
		return leaveDaoInt.getLeave(leaveID);
	}

	@Override
	public Boolean isTechnicianOnLeave(String technicianEmail) {
		return leaveDaoInt.isTechnicianOnLeave(technicianEmail);
	}

	@Override
	public String onLeaveTechnician(String technicianEmail) {
		return leaveDaoInt.onLeaveTechnician(technicianEmail);
	}

	@Override
	public String[] techniciansOnLeave() {
		return leaveDaoInt.techniciansOnLeave();
	}

}
