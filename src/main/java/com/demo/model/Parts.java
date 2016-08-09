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


@Entity
@Table(name="PARTS")
public class Parts implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="PART_NUMBER")
	private String partNumber;
	@Column(name="MODEL_NUMBER")
	private String modelNumber;
	@Column(name="DESCRIPTION")
	private String description;
	@Column(name="QUANTITY")
	private int quantity;
	@Column(name="ARRIVED_DATE")
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar arrivedDate;
	@Column(name="ITEM_TYPE")
	private String itemType;
	
	@OneToMany(mappedBy="part",cascade=CascadeType.ALL)
	private Set<Orders> orders;

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

	public Set<Orders> getOrders() {
		return orders;
	}

	public void setOrders(Set<Orders> orders) {
		this.orders = orders;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	
}
