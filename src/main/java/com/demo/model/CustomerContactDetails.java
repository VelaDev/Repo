package com.demo.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Table(name="CustomerContactDetails")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CustomerContactDetails implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	@Id
	@GeneratedValue
	@Column(name="Record_ID")
	private int recordID;
	@Column(name="First_Name")
	private String firstName;
	@Column(name="First_LastName")
	private String lastName;
	@Column(name="Telephone_Number")
	private String telephoneNumber;
	@Column(name="Cell_Number")
	private String cellNumber;
	@Column(name="Email")
	private String email;
	
	@ManyToOne
	@JoinColumn(name="Customer")
	private Customer customer;

}
