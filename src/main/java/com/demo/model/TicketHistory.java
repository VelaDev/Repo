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

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Table(name="TicketHistory")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
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

}
