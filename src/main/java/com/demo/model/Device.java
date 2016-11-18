package com.demo.model;

import java.io.Serializable;


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

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="Products")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Device implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="SERIAL_NUMBER")
	private String serialNumber;
	@Column(name="PRODUCT_MODEL")
	private String productModel;
	@Column(name="START_DATE")
	private String startDate;
	@Column(name="END_DATE")
	private String endDate;
	@Column(name="INSTALLATION_DATE")
	private String installationDate;
	@Column(name="DEVICE_LOCATION")
	private String deviceLocation;
	@Column(name="MONO")
	private String mono;
	@Column(name="COLOUR")
	private String colour;
	
	@ManyToOne
	@JoinColumn(name="CLIENT")
	private Client client;
    
	@OneToMany(mappedBy ="device", cascade= CascadeType.ALL,fetch=FetchType.LAZY)
	private Set<Accessories> accessories;
	
}
