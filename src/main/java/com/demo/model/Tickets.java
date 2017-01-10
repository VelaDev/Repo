package com.demo.model;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Table(name="Tickets")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Tickets implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="Ticket_Number")
	private String ticketNumber;
	@Column(name="Comments")
	private String comments;
	@Column(name="Status")
	private String status;
	@Column(name="Priority")
	private String priority;
	@Column(name="Logged_Date")
	private String dateTime;
	@Column(name="EscalatedTo")
	private String escalatedTo;
	@Column(name="Description")
	private String description;
	@Column(name="Technician_Acknowledged")
	private boolean technicianAcknowledged;
	@Column(name="SLA")
	private String slaStart;
	@Column(name="Escalate")
	private boolean escalate;
	@Column(name="Escalate_Reason")
	private String escalateReason;
	@Column(name="SLA_Acknowledge_DateTime")
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar slaAcknowledgeDateTime;
	@Column (name="Solution")
	private String solution;
	
	
	
	
	@ManyToOne
	@JoinColumn(name="AssignedTechnician")
	private Employee employee;
	
	@ManyToOne
	@JoinColumn(name="Serial_Number")
	private Device device;
	
	@ManyToOne
	@JoinColumn(name="Order_Number")
	private OrdersHeader ordersHeader;
	
	@OneToMany(mappedBy= "tickets",cascade= CascadeType.ALL,fetch=FetchType.LAZY)
	private Set<TicketHistory> ticketHistory; 
	
}
