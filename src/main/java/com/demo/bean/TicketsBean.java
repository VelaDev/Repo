package com.demo.bean;

import java.util.Calendar;

import com.demo.model.Employee;
import com.demo.model.Device;

public class TicketsBean {
	
	private String ticketNumber;
	private String description;
	private String type;
	private String status;
	private String priority;
	private String group;
	private String date;
    private String employee;
	private String device;
	private String comments;
	private String client;
	private String technicianUserName;
	private boolean technicianAcknowledged;
	private boolean escalate;
	private String escalateReason;
	private Calendar slaAcknowledgeDateTime;
	
	public String getTicketNumber() {
		return ticketNumber;
	}
	public void setTicketNumber(String ticketNumber) {
		this.ticketNumber = ticketNumber;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getEmployee() {
		return employee;
	}
	public void setEmployee(String employee) {
		this.employee = employee;
	}
	
	public String getDevice() {
		return device;
	}
	public void setDevice(String device) {
		this.device = device;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getTechnicianUserName() {
		return technicianUserName;
	}
	public void setTechnicianUserName(String technicianUserName) {
		this.technicianUserName = technicianUserName;
	}
	public boolean isTechnicianAcknowledged() {
		return technicianAcknowledged;
	}
	public void setTechnicianAcknowledged(boolean technicianAcknowledged) {
		this.technicianAcknowledged = technicianAcknowledged;
	}
	public boolean isEscalate() {
		return escalate;
	}
	public void setEscalate(boolean escalate) {
		this.escalate = escalate;
	}
	public String getEscalateReason() {
		return escalateReason;
	}
	public void setEscalateReason(String escalateReason) {
		this.escalateReason = escalateReason;
	}
	public Calendar getSlaAcknowledgeDateTime() {
		return slaAcknowledgeDateTime;
	}
	public void setSlaAcknowledgeDateTime(Calendar slaAcknowledgeDateTime) {
		this.slaAcknowledgeDateTime = slaAcknowledgeDateTime;
	}
	
	
}
