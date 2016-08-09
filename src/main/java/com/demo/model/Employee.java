package com.demo.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;





@Entity
@Table(name="EMPLOYEE")
public class Employee implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="USERNAME")
	private String username;
	@Column(name="EMPLOYEE_NUMBER")
	private String empNumber;
	@Column(name="PASSWORD")
	private String password;
	@Column(name="TITLE")
	private String title;
	@Column(name="FIRST_NAME")
	private String firstName;
	@Column(name="LAST_NAME")
    private String lastName;
	@Column(name="ROLE")
    private String role;
	@Column(name="EMAIL")
	private String email;
	@Column(name="GENDER")
	private String gender;
	
	@OneToMany(mappedBy ="employee", cascade= CascadeType.ALL)
	private Set<Tickets> logTickets;
	
	@OneToMany(mappedBy="employee",cascade=CascadeType.ALL)
	private Set<Orders> orders;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmpNumber() {
		return empNumber;
	}

	public void setEmpNumber(String empNumber) {
		this.empNumber = empNumber;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Set<Tickets> getLogTickets() {
		return logTickets;
	}

	public void setLogTickets(Set<Tickets> logTickets) {
		this.logTickets = logTickets;
	}
	
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
    
	public Set<Orders> getOrders() {
		return orders;
	}

	public void setOrders(Set<Orders> orders) {
		this.orders = orders;
	}

	public Employee(String username, String empNumber, String password,
			String title, String firstName, String lastName, String role,
			String email, Set<Tickets> logTickets) {
		this.username = username;
		this.empNumber = empNumber;
		this.password = password;
		this.title = title;
		this.firstName = firstName;
		this.lastName = lastName;
		this.role = role;
		this.email = email;
		this.logTickets = logTickets;
	}
	

	public Employee() {
	}

}
