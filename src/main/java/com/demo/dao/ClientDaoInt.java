package com.demo.dao;

import java.util.List;

import com.demo.model.Client;

public interface ClientDaoInt {
	
	String saveClient(Client client);
	Client getClientByClientName(String clientName);
	List<Client> getClientList();
	String updateClient(Client client);
	

}
