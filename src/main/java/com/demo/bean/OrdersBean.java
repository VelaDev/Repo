package com.demo.bean;

import java.util.Calendar;

import com.demo.model.Employee;
import com.demo.model.Parts;
import com.demo.model.Product;


public class OrdersBean {
	
	private long orderNum;
	private int quantity;
	private boolean delivery;
	private boolean delivered;
	private boolean received;
	private Calendar dateOrdered;
	private Calendar dateApproved;
	private String description;
	private String comments;
	private Employee employee;
	private Parts part;
	private String partP;
	private Product product;
	private String prod;
	
	public long getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(long orderNum) {
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
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
	public String getPartP() {
		return partP;
	}
	public void setPartP(String partP) {
		this.partP = partP;
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
