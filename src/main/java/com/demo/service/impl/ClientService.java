package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.ClientDaoInt;
import com.demo.model.Client;
import com.demo.service.ClientServiceInt;

@Service("clientService")
public class ClientService implements ClientServiceInt{
	
	@Autowired
	private ClientDaoInt clientDAO;
	private String retMessage = null;

	@Override
	public String saveClient(Client client) {
		retMessage = clientDAO.saveClient(client);
		return retMessage;
	}

	@Override
	public Client getClientByClientName(String clientName) {
		
		return clientDAO.getClientByClientName(clientName);
	}

	@Override
	public List<Client> getClientList() {
		
		return clientDAO.getClientList();
	}

	@Override
	public String updateCustomer(Client client) {
		retMessage = clientDAO.updateClient(client);
		return retMessage;
	}

}
