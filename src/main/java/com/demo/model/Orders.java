package com.demo.model;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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
	@GeneratedValue(strategy=GenerationType.TABLE) 
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
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar dateOrdered;
	@Column(name="APPROVED")
	private boolean approved;
	@Column(name="DATE_APPROVED")
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar dateApproved;
	@Column(name="COMMENTS")
	private String comments;
	@Column(name="DESCRIPTION")
	private String description;
	@Column(name="APPROVEDBY")
	private String approdedBy;
	
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
	private Product product;

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

	public Calendar getDateOrdered() {
		return dateOrdered;
	}

	public void setDateOrdered(Calendar dateOrdered) {
		this.dateOrdered = dateOrdered;
	}

	public Calendar getDateApproved() {
		return dateApproved;
	}

	public void setDateApproved(Calendar dateApproved) {
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

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getProd() {
		return prod;
	}

	public void setProd(String prod) {
		this.prod = prod;
	}
	
}
