package com.demo.model;

import java.io.Serializable;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;


@Entity  
@DiscriminatorValue("User")  
public class User extends Employee implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

}
