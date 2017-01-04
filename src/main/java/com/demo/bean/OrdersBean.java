package com.demo.bean;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@NoArgsConstructor
@Getter
@Setter
public class OrdersBean {
	

	private String orderNum;
	private boolean delivery;
	private boolean delivered;
	private boolean received;
	private String dateOrdered;
	private boolean approved;
	private String dateApproved;
	private String comments;
	private String description;
	private String approdedBy;
	private String status;
	
	private String employee;
	private String part;
	private String client;
	private String device;
	
	private String []partNumber;
	private String []modelNumber;
	private String []quantity;
	private String[]selectedItem;
	
	
}
