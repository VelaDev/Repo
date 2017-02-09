package com.demo.model;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="LEAVES") 
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Leave implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="Leave_ID")
	private String leaveID;
	@Column(name="First_Leave_Date")
	private Date startDate;
	@Column(name="Last_Leave_Date")
	private Date endDate;
	@Column(name="Approver")
	private String approver;
	@Column(name="Contact_Number")
	private String contactNumber;
	@Column(name="Status")
	private String status;
	@Column(name="Address")
	private String address;
	
	@ManyToOne
	@JoinColumn(name="Requested_By")
	private Employee employee;
	

}
