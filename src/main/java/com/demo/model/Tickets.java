package com.demo.model;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name="Tickets")
public class Tickets implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.TABLE)
	@Column(name="TicketNumber")
	private int ticketNumber;
	@Column(name="Comments")
	private String comments;
	@Column(name="Status")
	private String status;
	@Column(name="Priority")
	private String priority;
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="LoggedDate")
	private Calendar dateTime;
	@Column(name="EscalatedTo")
	private String escalatedTo;
	@Column(name="Description")
	private String description;
	@Column(name="TechnicianAcknowledged")
	private boolean technicianAcknowledged;
	@Column(name="SLA")
	private String slaStart;
	@Column(name="Escalate")
	private boolean escalate;
	@Column(name="ESCALATE_REASON")
	private String escalateReason;
	@Column(name="SLA_ACKNOWLEDGE_DATETIME")
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar slaAcknowledgeDateTime;
	
	private String productS;
	private String technicianUserName;
	
	@ManyToOne
	@JoinColumn(name="AssignedTechnician")
	private Employee employee;
	
	@ManyToOne
	@JoinColumn(name="SERIAL_NUMBER")
	private Product product;
	
	public int getTicketNumber() {
		return ticketNumber;
	}

	public void setTicketNumber(int ticketNumber) {
		this.ticketNumber = ticketNumber;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
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

	public Calendar getDateTime() {
		return dateTime;
	}

	public void setDateTime(Calendar dateTime) {
		this.dateTime = dateTime;
	}

	public String getEscalatedTo() {
		return escalatedTo;
	}

	public void setEscalatedTo(String escalatedTo) {
		this.escalatedTo = escalatedTo;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	/*public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}*/

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

	public String getSlaStart() {
		return slaStart;
	}

	public void setSlaStart(String slaStart) {
		this.slaStart = slaStart;
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

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
}
