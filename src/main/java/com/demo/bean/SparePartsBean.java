package com.demo.bean;

import java.util.Calendar;


public class SparePartsBean {
	
	private String partNumber;
	private String modelNumber;
	private String description;
	private int quantity;
	private Calendar arrivedDate;
	public String getPartNumber() {
		return partNumber;
	}
	public void setPartNumber(String partNumber) {
		this.partNumber = partNumber;
	}
	public String getModelNumber() {
		return modelNumber;
	}
	public void setModelNumber(String modelNumber) {
		this.modelNumber = modelNumber;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public Calendar getArrivedDate() {
		return arrivedDate;
	}
	public void setArrivedDate(Calendar arrivedDate) {
		this.arrivedDate = arrivedDate;
	}
}
