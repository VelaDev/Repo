package com.demo.model;

import java.io.Serializable;

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
@Table(name="Site_Stock") 
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class SiteStock implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="RecordID")
	private Integer recordID;
	@Column(name="Part_Number")
	private String partNumber;
	@Column(name="Item_Type")
	private String itemType;
	@Column(name="Item_Description")
	private String itemDescription;
	@Column(name="Technician_Name")
	private String technicianName;
	@Column(name="Technician_Email")
	private String technicianEmail;
	@Column(name="Quantity")
	private int quantity;
	@Column(name="Customer_Name")
	private String customerName;
	@Column(name="Location")
	private String location;
	
}
