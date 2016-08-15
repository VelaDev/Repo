package com.demo.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;


@Entity
@Table(name="CLIENT")
public class Client implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
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
	
	@OneToOne(cascade = CascadeType.ALL)
	private Address address;
	
	@OneToMany(mappedBy ="client", cascade= CascadeType.ALL,fetch=FetchType.EAGER)
	private Set<Product> products;

	
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public boolean isActive() {
		return isActive;
	}
	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}
	public String getTellphoneNumber() {
		return tellphoneNumber;
	}
	public void setTellphoneNumber(String tellphoneNumber) {
		this.tellphoneNumber = tellphoneNumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Address getAddress() {
		return address;
	}
	public void setAddress(Address address) {
		this.address = address;
	}
	public Set<Product> getProducts() {
		return products;
	}
	public void setProducts(Set<Product> products) {
		this.products = products;
	}
	public String getStreetName() {
		return streetName;
	}
	public void setStreetName(String streetName) {
		this.streetName = streetName;
	}
	public String getCity_town() {
		return city_town;
	}
	public void setCity_town(String city_town) {
		this.city_town = city_town;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getFaxNumber() {
		return faxNumber;
	}
	public void setFaxNumber(String faxNumber) {
		this.faxNumber = faxNumber;
	}
	public String getCellNumber() {
		return cellNumber;
	}
	public void setCellNumber(String cellNumber) {
		this.cellNumber = cellNumber;
	}
	public String getContactPerson() {
		return contactPerson;
	}
	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}
	public String getFloorNumber() {
		return floorNumber;
	}
	public void setFloorNumber(String floorNumber) {
		this.floorNumber = floorNumber;
	}
	
	
}
