package com.demo.model;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Table(name="PARTS")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Parts implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="PART_NUMBER")
	private String partNumber;
	@Column(name="MODEL_NUMBER")
	private String modelNumber;
	@Column(name="DESCRIPTION")
	private String description;
	@Column(name="QUANTITY")
	private int quantity;
	@Column(name="ARRIVED_DATE")
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar arrivedDate;
	@Column(name="ITEM_TYPE")
	private String itemType;
	
	@OneToMany(mappedBy="part",cascade=CascadeType.ALL)
	private Set<Orders> orders;

}
