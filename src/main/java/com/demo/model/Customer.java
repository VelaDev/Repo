package com.demo.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
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
	private String clientName;
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
	
	
	@OneToMany(mappedBy ="customer", cascade= CascadeType.ALL,fetch=FetchType.LAZY)
	private Set<CustomerContactDetails> customerContactDetails;
	
	@OneToMany(mappedBy ="customer", cascade= CascadeType.ALL,fetch=FetchType.LAZY)
	private Set<Device> devices;

}
