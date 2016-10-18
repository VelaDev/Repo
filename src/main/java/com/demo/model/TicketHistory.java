package com.demo.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name="TicketHistory")
public class TicketHistory implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.TABLE)
	@Column(name="TicketHistoryID")
	private int historyId;
	@Column(name="TicketNumber")
	private String ticketNumber;
	@Column(name="EscalatedResoan")
	private String escalatedReason;
	@Column(name="EscalatedDate")
	private String escalatedDate;
	@Column(name="Resolution")
	private String resolution;
	@Column(name="Solution")
	private String solution;
	@Column(name="Comment")
	private String comment;
	
	
	@ManyToOne
	@JoinColumn(name="EscalatedTo")
	private Employee employee;
	
	@ManyToOne
	@JoinColumn(name="Device")
	private Tickets tickets;

	public int getHistoryId() {
		return historyId;
	}

	public void setHistoryId(int historyId) {
		this.historyId = historyId;
	}

	public String getEscalatedReason() {
		return escalatedReason;
	}

	public void setEscalatedReason(String escalatedReason) {
		this.escalatedReason = escalatedReason;
	}

	public String getEscalatedDate() {
		return escalatedDate;
	}

	public void setEscalatedDate(String escalatedDate) {
		this.escalatedDate = escalatedDate;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Tickets getTickets() {
		return tickets;
	}

	public void setTickets(Tickets tickets) {
		this.tickets = tickets;
	}

	public String getResolution() {
		return resolution;
	}

	public void setResolution(String resolution) {
		this.resolution = resolution;
	}

	public String getSolution() {
		return solution;
	}

	public void setSolution(String solution) {
		this.solution = solution;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getTicketNumber() {
		return ticketNumber;
	}

	public void setTicketNumber(String ticketNumber) {
		this.ticketNumber = ticketNumber;
	}
	
}
