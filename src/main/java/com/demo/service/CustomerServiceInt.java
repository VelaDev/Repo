package com.demo.service;

import java.util.List;

import com.demo.bean.CustomerBean;
import com.demo.model.Customer;

public interface CustomerServiceInt {
	
	String saveClient(Customer customer);
	Customer getClientByClientName(String clientName);
	List<Customer> getClientList(Integer offset, Integer maxResults);
	List<Customer> getClientList();
	String updateCustomer(CustomerBean customerBean);
	Integer count();
	String prepareCustomer(CustomerBean customerBean);
	CustomerBean contactDetails(String customerName);
	String saveCustomer(CustomerBean customerBean);

}
