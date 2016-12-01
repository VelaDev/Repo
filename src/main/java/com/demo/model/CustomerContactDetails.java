package com.demo.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

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
	
	/*@GenericGenerator(name = "generator", strategy = "foreign",
			parameters = @Parameter(name = "property", value = "customer"))*/
	@Id
	@GeneratedValue(strategy=GenerationType.TABLE)
	@Column(name="Customer_ID")
	private long addressId;
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

}
