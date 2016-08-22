package com.demo.bean;

import java.util.Date;

import com.demo.model.Client;


public class ProductBean {

	
	private String serialNumber;
	private String productName;
	private String productType;
	private String prductDescription;
	private String productModel;
	private String productStatus;
	private Date startDate;
	private Date endDate;
	private Client client;
	private String accessoryName;
	private String accessorySerial;
	
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
	public Client getClient() {
		return client;
	}
	public void setClient(Client client) {
		this.client = client;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getAccessoryName() {
		return accessoryName;
	}
	public void setAccessoryName(String accessoryName) {
		this.accessoryName = accessoryName;
	}
	public String getAccessorySerial() {
		return accessorySerial;
	}
	public void setAccessorySerial(String accessorySerial) {
		this.accessorySerial = accessorySerial;
	}
	
}
