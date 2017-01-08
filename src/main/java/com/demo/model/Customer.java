package com.demo.model;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
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
@Table(name="Customers")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Customer implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="Customer_Name")
	private String customerName;
	@Column(name="IsACTIVE")
	private boolean isActive;
	@Column(name="Telephone_Number")
	private String tellphoneNumber;
	@Column(name="Emal")
	private String email;
	@Column(name="Street_Name")
	private String streetName;
	@Column(name="City_Town")
	private String city_town;
	@Column(name="Province")
	private String province;
	@Column(name="Area_Code")
	private String zipcode;
	@Column(name="Fax_No")
	private String faxNumber;
	@Column(name="Street_No")
	private String streetNumber;
	@Column(name="DateTime")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dateTime;
	
	
	@OneToMany(mappedBy ="customer", cascade= CascadeType.ALL,fetch=FetchType.LAZY)
	private Set<CustomerContactDetails> customerContactDetails;
	
	@OneToMany(mappedBy ="customer", cascade= CascadeType.ALL,fetch=FetchType.LAZY)
	private Set<Device> devices;

}
