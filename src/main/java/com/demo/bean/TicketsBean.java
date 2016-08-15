package com.demo.bean;

import java.util.Calendar;

import com.demo.model.Employee;
import com.demo.model.Product;

public class TicketsBean {
	
	private String ticketNumber;
	private String description;
	private  String type;
	private String status;
	private String priority;
	private String group;
	private Calendar date;
    private Employee employee;
	private Product product;
	private String comments;
	private String clientC;
	private String productS;
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
	public Calendar getDate() {
		return date;
	}
	public void setDate(Calendar date) {
		this.date = date;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getClientC() {
		return clientC;
	}
	public void setClientC(String clientC) {
		this.clientC = clientC;
	}
	public String getProductS() {
		return productS;
	}
	public void setProductS(String productS) {
		this.productS = productS;
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
