package com.demo.dao.impl;



import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.ClientDaoInt;
import com.demo.model.Client;

@Repository("clientDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class ClintDao implements ClientDaoInt{
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public String saveClient(Client client) {
		
		sessionFactory.getCurrentSession().save(client);
		return client.getClientName() + " "+ "Was successfully added";
	}

	@Override
	public Client getClientByClientName(String clientName) {
	
		return (Client) sessionFactory.getCurrentSession().get(Client.class,clientName);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Client> getClientList() {
		
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Client.class);
		return (List<Client>)criteria.list();
	}

	@Override
	public String updateClient(Client client) {
		sessionFactory.getCurrentSession().update(client);
		return ""+ client.getClientName()+ " is successfully updated";
	}

}
