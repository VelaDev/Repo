package com.demo.dao;

import java.util.List;

import com.demo.bean.LeaveBean;
import com.demo.model.Leave;

public interface LeaveDaoInt {
	
	String leaveRequest(LeaveBean leave);
	String updateLeaveRequest(LeaveBean leave);
	List<Leave> leaveRequests(String email);
	List<Leave> leaveRequests();
	Leave getLeave(int leaveID);
	Boolean isTechnicianOnLeave(String technicianEmail);
	String onLeaveTechnician(String technicianEmail);
	String [] techniciansOnLeave();
	void isTechnicianOnLeaveDate();
	

}
