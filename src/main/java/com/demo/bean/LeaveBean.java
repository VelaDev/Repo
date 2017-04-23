package com.demo.bean;

import javax.persistence.Column;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@NoArgsConstructor
@Getter
@Setter
public class LeaveBean {
	
	private String leaveType;
	private String startDate;
	private String endDate;
	private String contactNumber;
	private String address;
	private String technicianUserName;
	private int leaveID;

}
