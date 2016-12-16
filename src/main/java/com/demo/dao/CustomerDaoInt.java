package com.demo.dao;

import java.util.List;

import com.demo.bean.CustomerBean;
import com.demo.model.Customer;

public interface CustomerDaoInt {
	
	String saveClient(Customer customer);
	Customer getClientByClientName(String clientName);
	List<Customer> getClientList(Integer offset, Integer maxResults);
	String updateClient(Customer customer);
	Integer count();
	String prepareCustomer(CustomerBean customerBean);
	

}
