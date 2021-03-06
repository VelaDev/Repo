package com.demo.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Table(name="Accessories")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Accessories implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.TABLE)
	@Column(name="RecordID")
	private int recordID;
	@Column(name="Type")
	private String accessotyType;
	@Column(name="Serial")
	private String serial;
	
	@ManyToOne
	@JoinColumn(name="Device_Serial")
	private Device device;

	
}
