package com.demo.bean;

import java.util.Calendar;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
public class SparePartsBean {
	
	private String partNumber;
	private String modelNumber;
	private String description;
	private int quantity;
	private Calendar arrivedDate;
}
