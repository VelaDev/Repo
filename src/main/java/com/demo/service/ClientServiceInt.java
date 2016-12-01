package com.demo.service;

import java.util.List;

import com.demo.bean.CustomerBean;
import com.demo.model.Customer;

public interface ClientServiceInt {
	
	String saveClient(Customer customer);
	Customer getClientByClientName(String clientName);
	List<Customer> getClientList(Integer offset, Integer maxResults);
	String updateCustomer(Customer customer);
	Integer count();
	String prepareCustomer(CustomerBean customerBean);

}
