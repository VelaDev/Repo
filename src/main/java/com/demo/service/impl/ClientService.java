package com.demo.service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.bean.CustomerBean;
import com.demo.dao.ClientDaoInt;
import com.demo.model.Customer;
import com.demo.service.ClientServiceInt;

@Service("clientService")
public class ClientService implements ClientServiceInt{
	
	@Autowired
	private ClientDaoInt clientDAO;
	private String retMessage = null;

	@Override
	public String saveClient(Customer customer) {
		retMessage = clientDAO.saveClient(customer);
		return retMessage;
	}

	@Override
	public Customer getClientByClientName(String clientName) {
		
		return clientDAO.getClientByClientName(clientName);
	}

	@Override
	public List<Customer> getClientList(Integer offset, Integer maxResults) {
		
		return clientDAO.getClientList(offset,maxResults);
	}

	@Override
	public String updateCustomer(Customer customer) {
		retMessage = clientDAO.updateClient(customer);
		return retMessage;
	}

	@Override
	public Integer count() {
		
		return clientDAO.count();
	}

	@Override
	public String prepareCustomer(CustomerBean customerBean) {
		return clientDAO.prepareCustomer(customerBean);
	}

}
