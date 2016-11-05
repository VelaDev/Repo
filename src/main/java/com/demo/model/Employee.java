package com.demo.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;





@Entity
@Table(name="EMPLOYEE")
@Inheritance(strategy= InheritanceType.SINGLE_TABLE)  
@DiscriminatorColumn(name="Type",discriminatorType= DiscriminatorType.STRING)  
@DiscriminatorValue(value="employee")  
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
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
	
	@OneToMany(mappedBy="employee",cascade=CascadeType.ALL)
	private Set<TicketHistory> ticketHistory;

}
