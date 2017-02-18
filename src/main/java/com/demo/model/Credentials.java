package com.demo.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.ForeignKey;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="Compatibility")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Credentials implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="RecordID")
	private int recordID;
	@Column(name="User_Password")
	private String password;
	@Column(name="Password_InsertedDate")
	private Date passwordDateInserted;
	
	@ManyToOne
	@ForeignKey(name="User_Name")
	private Employee employee;

}
