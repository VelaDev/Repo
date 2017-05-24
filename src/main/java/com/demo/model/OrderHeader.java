package com.demo.model;

import java.io.Serializable;
import java.util.Date;
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
@Table(name= "Order_Header")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class OrderHeader implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="RecordID")
	private Integer recordID;
	@Column(name="Order_Number")
	private String orderNum;
	@Column(name="Delivered")
	private boolean delivered;
	@Column(name="Date_Orderd")
	private String dateOrdered;
	@Column(name="Approved")
	private boolean approved;
	@Column(name="Date_Approved")
	private String dateApproved;
	@Column(name="Declined_Reason")
	private String comments;
	@Column(name="Approver")
	private String approver;
	@Column(name="Order_Status")
	private String status;
	@Column(name="Stock_Type")
	private String stockType;
	@Column(name="DateTime")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dateTime;
	@Column(name="Shipping_Date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date shippingDate;
	
	
	@ManyToOne
	@JoinColumn(name="OrderBy")
	private Employee employee;
	
	/*@ManyToOne
	@JoinColumn(name="Spare_Part")
	private HOStock spare;*/
	@ManyToOne
	@JoinColumn(name="Customer_Name")
	private Customer customer;
	/*@ManyToOne
	@JoinColumn(name="Serial_Number")
	private Device device;*/
	
	@OneToMany(mappedBy ="orderHeader", cascade= CascadeType.ALL,fetch=FetchType.LAZY)
	private Set<OrderDetails> orderDetails;
	
	@OneToMany(mappedBy ="orderHeader", cascade= CascadeType.ALL,fetch=FetchType.LAZY)
	private Set<Tickets> tickets;
}
