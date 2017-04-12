package com.demo.model;

import java.io.Serializable;
import java.util.Date;

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

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



@Entity
@Table(name= "Order_Details")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class OrderDetails implements Serializable{/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.TABLE)
	@Column(name="Order_DetailNumber")
	private int orderDertailNumber;
	@Column(name="Stock_Type")
	private String stockType;
	@Column(name="Location")
	private String location;
	@Column(name="Part_Type")
	private String partType;
	@Column(name="Part_Number")
	private String partNumber;
	@Column(name="Model")
	private String model;
	@Column(name="Description")
	private String itemDescription;
	@Column(name="DateTime")
	private String dateTime;
	@Column(name="Quantity")
	private int quantity;
	@Column(name="Technician")
	private String technician;
	@ManyToOne
	@JoinColumn(name="Order_Number")
	private OrderHeader orderHeader;
	

}
