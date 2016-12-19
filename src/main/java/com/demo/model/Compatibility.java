package com.demo.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
public class Compatibility implements Serializable{/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.TABLE)
	@Column(name="Record_ID")
	private int recordID;
	@Id
	@Column(name="Model_Number")
	private String modelNumber;
	@Column(name="Part_Number")
	private String partNumber;

}
