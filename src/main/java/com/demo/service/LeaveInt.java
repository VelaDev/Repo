package com.demo.service;

import java.util.List;

import com.demo.bean.LeaveBean;
import com.demo.model.Leave;

public interface LeaveInt {
	
	String leaveRequest(LeaveBean leave);
	String updateLeaveRequest(LeaveBean leave);
	List<Leave> leaveRequests(String email);
	List<Leave> leaveRequests();
	Leave getLeave(int leaveID);
	Boolean isTechnicianOnLeave(String technicianEmail);
	String onLeaveTechnician(String technicianEmail);
	String[] techniciansOnLeave();
	int countAllPendingLeave();
	int countAllActiveLeave();
	List<Leave> getPendingLeaves();
	List<Leave> getActiveLeave();
	List<Leave> leaveHistory();
	List<Leave> getPendingLeaveByTechnician(String technicianEmail);
	int getPendingLeaveCountByTechnician(String technicianEmail);
	int getActiveLeaveCountByTechnician(String technicianEmail);
	List<Leave> getActiveLeaveByTechnician(String technicianEmail);
	List<Leave> getAllActiveAndPendingLeave();
	List<Leave> activeAndPendingLeaveByTechnician(String technicianEmail);
	List<Leave> getLeaveHistoryByTechician(String technicianEmail);
	int countpendingLeaveForSelectedDate(String dateRange);
	List<String> getLeaveDates();
	List<Leave> getAllLeaveForSelectedRange(String dateRange);
	int countActiveLeaveForSelectedDate(String dateRange);
	List<Leave> getPendingLeaveForSelectedRange(String dateRange);
	List<Leave> getActiveLeaveForSelectedRange(String dateRange);
	List<Leave> getLeaveHistoryForSelectedRange(String dateRange);
	int countTechpendingLeaveForSelectedDate(String dateRange,
			String technicianEmail);
	int countTechActiveLeaveForSelectedDate(String dateRange,
			String technicianEmail);
	List<Leave> getAllTechLeaveForSelectedRange(String dateRange,
			String technicianEmail);
	List<Leave> getTechPendingLeaveForSelectedRange(String dateRange,
			String technicianEmail);
	List<Leave> getTechActiveLeaveForSelectedRange(String dateRange,
			String technicianEmail);
	List<Leave> getTechLeaveHistoryForSelectedRange(String dateRange,
			String technicianEmail);
}
