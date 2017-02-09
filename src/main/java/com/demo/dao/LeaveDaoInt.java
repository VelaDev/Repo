package com.demo.dao;

import java.util.List;

import com.demo.model.Leave;

public interface LeaveDaoInt {
	
	String leaveRequest(Leave leave);
	String updateLeaveRequest(Leave leave);
	List<Leave> leaveRequests(String email);

}
