package com.demo.dao.impl;



import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.ClientDaoInt;
import com.demo.model.Client;
import com.demo.model.Device;
import com.demo.model.Employee;

@Repository("clientDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class ClintDao implements ClientDaoInt{
	
	@Autowired
	private SessionFactory sessionFactory;
	private String retMessage = null;
	List<Client> clientList = null;

	@Override
	public String saveClient(Client client) {
		try{
			sessionFactory.getCurrentSession().saveOrUpdate(client);
			retMessage =  "Customer "+ client.getClientName() + " "+ "Was successfully added";
		}
		catch(Exception e){
			retMessage = "Customer "+ client.getClientName() + " is not added\n" + e.getMessage();
		}
		
		return retMessage;
	}

	@Override
	public Client getClientByClientName(String clientName) {
		
		Client client = null;
		try{
			
			clientList = getClientList();
			for(Client tempClient:clientList)
			{
				if(tempClient.getClientName().equalsIgnoreCase(clientName))
				{
					client= tempClient;
					break;
				}
			}
		}
		catch(Exception e)
		{
			client = null;
		}
	
		return client;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Client> getClientList(Integer offset, Integer maxResults) {
		
		return sessionFactory.openSession()
			    .createCriteria(Client.class)
			    .setFirstResult(offset!=null?offset:0)
			    .setMaxResults(maxResults!=null?maxResults:10)
			    .list();
	}
    @SuppressWarnings("unchecked")
	private List<Client> getClientList(){
    	Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Client.class);
		return (List<Client>)criteria.list(); 
    }
	@Override
	public String updateClient(Client client) {
		try{
			sessionFactory.getCurrentSession().update(client);
			retMessage = "Customer "+ client.getClientName()+ " is successfully updated";
		}
		catch( Exception e){
			retMessage = "Customer "+ client.getClientName() + " is not updated\n" + e.getMessage();
		}
		return retMessage;
	}

	@Override
	public Integer count() {
		return (Integer) sessionFactory.getCurrentSession().createCriteria(Client.class).setProjection(Projections.rowCount()).uniqueResult();
		
	}

}
