package com.demo.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
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
	@GeneratedValue
	@Column(name="TicketHistoryID")
	private int historyId;
	@Column(name="EscalatedResoan")
	private String escalatedReason;
	@Column(name="EscalatedDate")
	private String escalatedDate;
	@Column(name="Resolution")
	private String resolution;
	@Column(name="Solution")
	private String solution;
	
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
	
}
