package com.demo.service;

import java.util.List;

import com.demo.model.Leave;

public interface LeaveInt {
	String leaveRequest(Leave leave);
	String updateLeaveRequest(Leave leave);
	List<Leave> leaveRequests(String email);

}