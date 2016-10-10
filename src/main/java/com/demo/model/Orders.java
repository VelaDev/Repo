package com.demo.model;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name= "SpareOrders")
public class Orders implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="ORDER_NUMBER")
	private String orderNum;
	@Column(name="QUANTITY")
	private int quantity;
	@Column(name="DELIVERY")
	private boolean delivery;
	@Column(name="DELIVERED")
	private boolean delivered;
	@Column(name="RECEIVED")
	private boolean received;
	@Column(name="DATE_ORDERED")
	private String dateOrdered;
	@Column(name="APPROVED")
	private boolean approved;
	@Column(name="DATE_APPROVED")
	private String dateApproved;
	@Column(name="COMMENTS")
	private String comments;
	@Column(name="DESCRIPTION")
	private String description;
	@Column(name="APPROVEDBY")
	private String approdedBy;
	@Column(name="Status")
	private String status;
	
	private String partP;
	private String prod;
	@ManyToOne
	@JoinColumn(name="ORDEREDBY")
	private Employee employee;
	
	@ManyToOne
	@JoinColumn(name="SPARES")
	private Parts part;
	@ManyToOne
	@JoinColumn(name="CLIENTNAME")
	private Client client;
	@ManyToOne
	@JoinColumn(name="SERIALNUMBER")
	private Device device;

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public boolean isDelivery() {
		return delivery;
	}

	public void setDelivery(boolean delivery) {
		this.delivery = delivery;
	}

	public boolean isDelivered() {
		return delivered;
	}

	public void setDelivered(boolean delivered) {
		this.delivered = delivered;
	}

	public boolean isReceived() {
		return received;
	}

	public void setReceived(boolean received) {
		this.received = received;
	}

	public String getDateOrdered() {
		return dateOrdered;
	}

	public void setDateOrdered(String dateOrdered) {
		this.dateOrdered = dateOrdered;
	}

	public String getDateApproved() {
		return dateApproved;
	}

	public void setDateApproved(String dateApproved) {
		this.dateApproved = dateApproved;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Parts getPart() {
		return part;
	}

	public void setPart(Parts part) {
		this.part = part;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean isApproved() {
		return approved;
	}

	public void setApproved(boolean approved) {
		this.approved = approved;
	}

	public String getPartP() {
		return partP;
	}

	public void setPartP(String partP) {
		this.partP = partP;
	}

	public String getApprodedBy() {
		return approdedBy;
	}

	public void setApprodedBy(String approdedBy) {
		this.approdedBy = approdedBy;
	}

	public Client getClient() {
		return client;
	}

	public void setClient(Client client) {
		this.client = client;
	}

	public Device getProduct() {
		return device;
	}

	public void setProduct(Device device) {
		this.device = device;
	}

	public String getProd() {
		return prod;
	}

	public void setProd(String prod) {
		this.prod = prod;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
