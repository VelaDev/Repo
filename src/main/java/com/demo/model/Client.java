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

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Table(name="CLIENT")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Client implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	/*@GeneratedValue(strategy=GenerationType.TABLE)
	@Column(name="CCLIENTID")
	private int clientID;*/
	@Column(name="CLIENT_Name")
	private String clientName;
	@Column(name="IsACTIVE")
	private boolean isActive;
	@Column(name="TELPHONE_NUMBER")
	private String tellphoneNumber;
	@Column(name="EMAIL")
	private String email;
	@Column(name="StreetName")
	private String streetName;
	@Column(name="City_Town")
	private String city_town;
	@Column(name="Province")
	private String province;
	@Column(name="ZipeCode")
	private String zipcode;
	@Column(name="Fax_No")
	private String faxNumber;
	@Column(name="Cell_No")
	private String cellNumber;
	@Column(name="Contact_Person")
	private String contactPerson;
	@Column(name="Floor_No")
	private String floorNumber;
	@Column(name="Street_No")
	private String streetNumber;
	
	@OneToOne(cascade = CascadeType.ALL)
	private Address address;
	
	@OneToMany(mappedBy ="client", cascade= CascadeType.ALL,fetch=FetchType.LAZY)
	private Set<Device> devices;

}
