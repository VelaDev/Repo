package com.demo.service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.bean.CustomerBean;
import com.demo.dao.CustomerDaoInt;
import com.demo.model.Customer;
import com.demo.service.CustomerServiceInt;

@Service("clientService")
public class CustomerService implements CustomerServiceInt{
	
	@Autowired
	private CustomerDaoInt clientDAO;
	private String retMessage = null;
	@Override
	public Customer getClientByClientName(String clientName) {
		
		return clientDAO.getClientByClientName(clientName);
	}

	@Override
	public List<Customer> getClientList(Integer offset, Integer maxResults) {
		
		return clientDAO.getClientList(offset,maxResults);
	}

	@Override
	public String updateCustomer(CustomerBean customerBean) {
		retMessage = clientDAO.updateCustomer(customerBean);
		return retMessage;
	}

	@Override
	public Integer count() {
		
		return clientDAO.count();
	}

	@Override
	public List<Customer> getClientList() {
		return clientDAO.getClientList();
	}

	@Override
	public CustomerBean contactDetails(String customerName) {
	
		return clientDAO.contactDetails(customerName);
	}

	@Override
	public String saveCustomer(CustomerBean customerBean) {
		retMessage = clientDAO.saveCustomer(customerBean);
		return retMessage;
	}


}
