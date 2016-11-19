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
	@Column(name="TicketNumber")
	private String ticketNumber;
	@Column(name="Comments")
	private String comments;
	@Column(name="Status")
	private String status;
	@Column(name="Priority")
	private String priority;
	@Column(name="LoggedDate")
	private String dateTime;
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
	@Column (name="Solution")
	private String solution;
	
	
	
	@ManyToOne
	@JoinColumn(name="AssignedTechnician")
	private Employee employee;
	
	@ManyToOne
	@JoinColumn(name="SERIAL_NUMBER")
	private Device device;
	
	@OneToMany(mappedBy= "tickets",cascade= CascadeType.ALL,fetch=FetchType.LAZY)
	private Set<TicketHistory> ticketHistory; 
	
}
