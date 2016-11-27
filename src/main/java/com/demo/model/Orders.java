package com.demo.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Table(name= "SpareOrders")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Orders implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="ORDER_NUMBER")
	private String orderNum;
	@Column(name="QUANTITY")
	private int quantity;
	@Column(name="DELIVERY")
	private boolean delivery;
	@Column(name="DELIVERED")
	private boolean delivered;
	@Column(name="RECEIVED")
	private boolean received;
	@Column(name="DATE_ORDERED")
	private String dateOrdered;
	@Column(name="APPROVED")
	private boolean approved;
	@Column(name="DATE_APPROVED")
	private String dateApproved;
	@Column(name="COMMENTS")
	private String comments;
	@Column(name="DESCRIPTION")
	private String description;
	@Column(name="APPROVEDBY")
	private String approdedBy;
	@Column(name="STATUS")
	private String status;
	
	@ManyToOne
	@JoinColumn(name="ORDEREDBY")
	private Employee employee;
	
	@ManyToOne
	@JoinColumn(name="SPARES")
	private Parts part;
	@ManyToOne
	@JoinColumn(name="SPARES")
	private Tonner tonner;
	@ManyToOne
	@JoinColumn(name="CLIENTNAME")
	private Customer customer;
	@ManyToOne
	@JoinColumn(name="SERIALNUMBER")
	private Device device;
}
