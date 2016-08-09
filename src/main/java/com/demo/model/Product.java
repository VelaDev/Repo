package com.demo.model;

import java.io.Serializable;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="Products")
public class Product implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="SERIAL_NUMBER")
	private String serialNumber;
	@Column(name="PRODUCT_NAME")
	private String productName;
	@Column(name="PRODUCT_TYPE")
	private String productType;
	@Column(name="PRODUCT_DESCRIPTION")
	private String prductDescription;
	@Column(name="PRODUCT_MODEL")
	private String productModel;
	@Column(name="PRODUCT_STATUS")
	private String productStatus;
	@Column(name="ARRIVED_DATE")
	@Temporal(TemporalType.TIMESTAMP)
	private Date arrivedDate;
	@ManyToOne
	@JoinColumn(name="CLIENTNAME")
	private Client client; 
	

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public String getPrductDescription() {
		return prductDescription;
	}

	public void setPrductDescription(String prductDescription) {
		this.prductDescription = prductDescription;
	}

	public String getProductModel() {
		return productModel;
	}

	public void setProductModel(String productModel) {
		this.productModel = productModel;
	}

	public String getProductStatus() {
		return productStatus;
	}

	public void setProductStatus(String productStatus) {
		this.productStatus = productStatus;
	}

	/*public Set<Tickets> getLogTickets() {
		return logTickets;
	}

	public void setLogTickets(Set<Tickets> logTickets) {
		this.logTickets = logTickets;
	}*/
	

	public Date getArrivedDate() {
		return arrivedDate;
	}

	public void setArrivedDate(Date arrivedDate) {
		this.arrivedDate = arrivedDate;
	}

	public Client getClient() {
		return client;
	}

	public void setClient(Client client) {
		this.client = client;
	}
	
}
