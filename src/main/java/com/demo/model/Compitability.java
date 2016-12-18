package com.demo.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



@Entity
@Table(name="Compitability")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Compitability implements Serializable{/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="Part_Number")
	private String partNumber;
	@Id
	@Column(name="Model_Number")
	private String modelNumber;

}
