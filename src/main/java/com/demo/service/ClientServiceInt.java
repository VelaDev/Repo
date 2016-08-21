package com.demo.service;

import java.util.List;

import com.demo.model.Client;

public interface ClientServiceInt {
	
	String saveClient(Client client);
	Client getClientByClientName(String clientName);
	List<Client> getClientList();
	String updateCustomer(Client client);

}
