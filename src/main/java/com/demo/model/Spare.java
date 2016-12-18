package com.demo.model;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Table(name="Spares")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Spare implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="Part_Number")
	private String partNumber;
	@Column(name="Description")
	private String description;
	@Column(name="Type")
	private String type;
	@Column(name="Quantity")
	private int quantity;
	@Column(name="Supplier_Name")
	private String supplierName;
	@Column(name="ReceivedBy")
	private String receivedBy;
	
	
	@OneToMany(mappedBy="part",cascade=CascadeType.ALL)
	private Set<Orders> orders;

}
