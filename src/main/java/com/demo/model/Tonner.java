package com.demo.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.demo.model.Orders;


@Entity
@Table(name="tonners")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Tonner implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="Tonner_Code")
	private String tonnerCode;
	@Column(name="Description")
	private String description;
	@Column(name="Quantity")
	private int quantity;
	@Column(name="Total_Quatity")
	private int totalQuantity;
	@Column(name="Supplier_Name")
	private String supplierName;
	@Column(name="ReceivedBy")
	private String receivedBy;
	
	
	@OneToMany(mappedBy="tonner",cascade=CascadeType.ALL)
	private Set<Orders> orders;
	
	

}
