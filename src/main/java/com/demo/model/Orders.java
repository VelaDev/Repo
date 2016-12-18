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
	@Column(name="Order_Number")
	private String orderNum;
	@Column(name="Quantity")
	private int quantity;
	@Column(name="Delivery")
	private boolean delivery;
	@Column(name="Delivered")
	private boolean delivered;
	@Column(name="Received")
	private boolean received;
	@Column(name="Date_Orderd")
	private String dateOrdered;
	@Column(name="Approved")
	private boolean approved;
	@Column(name="Date_Approved")
	private String dateApproved;
	@Column(name="Comments")
	private String comments;
	@Column(name="Description")
	private String description;
	@Column(name="ApprovedBy")
	private String approdedBy;
	@Column(name="Status")
	private String status;
	@Column(name="Stock_Type")
	private String stockType;
	@Column(name="Location")
	private String location;
	@ManyToOne
	@JoinColumn(name="OrderedBY")
	private Employee employee;
	
	@ManyToOne
	@JoinColumn(name="Spare")
	private Spare part;
	@ManyToOne
	@JoinColumn(name="Customer_Name")
	private Customer customer;
	@ManyToOne
	@JoinColumn(name="Serial_Number")
	private Device device;
}
