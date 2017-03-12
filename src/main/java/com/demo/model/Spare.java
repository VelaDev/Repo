package com.demo.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Table(name="Spares")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Spare implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="Part_Number")
	private String partNumber;
	@Column(name="Item_Type")
	private String itemType;
	@Column(name="Description")
	private String description;
	@Column(name="Compitable_Devices")
	private String compitableDevice;
	@Column(name="Quantity")
	private int quantity;
	@Column(name="ReceivedBy")
	private String receivedBy;
	@Column(name="Date_Arrived")
	private String dateTime;
	

}
