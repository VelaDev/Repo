package com.demo.dao;

import java.util.List;

import com.demo.bean.CustomerBean;
import com.demo.model.Customer;

public interface CustomerDaoInt {
	
	Customer getClientByClientName(String clientName);
	List<Customer> getClientList(Integer offset, Integer maxResults);
	List<Customer> getClientList();
	Integer count();
	CustomerBean contactDetails(String customerName);
	String updateCustomer(CustomerBean customerBean);
	String saveCustomer(CustomerBean customerBean);
	
	

}
