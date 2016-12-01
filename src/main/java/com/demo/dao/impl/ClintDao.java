package com.demo.dao.impl;



import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.CustomerBean;
import com.demo.dao.AccessoriesDaoInt;
import com.demo.dao.ClientDaoInt;
import com.demo.dao.CustomerContactDetailsDaoInt;
import com.demo.model.Customer;
import com.demo.model.CustomerContactDetails;
import com.demo.model.Device;
import com.demo.model.Employee;

@Repository("clientDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class ClintDao implements ClientDaoInt{
	
	@Autowired
	private SessionFactory sessionFactory;
	
	
	@Autowired
	private CustomerContactDetailsDaoInt customerContactDetailsDaoIntDaoInt;
	
	private String retMessage = null;
	List<Customer> clientList = null;
	Customer customer = null;

	@Override
	public String saveClient(Customer customer) {
		try{
			String name ="";
			sessionFactory.getCurrentSession().saveOrUpdate(customer);
			retMessage =  "Customer "+ customer.getClientName() + " "+ "Was successfully added";
		}
		catch(Exception e){
			retMessage = "Customer "+ customer.getClientName() + " is not added\n" + e.getMessage();
		}
		
		return retMessage;
	}

	@Override
	public Customer getClientByClientName(String clientName) {
		
		Customer customer = null;
		try{
			
			clientList = getClientList();
			for(Customer tempClient:clientList)
			{
				if(tempClient.getClientName().equalsIgnoreCase(clientName))
				{
					customer= tempClient;
					break;
				}
			}
		}
		catch(Exception e)
		{
			customer = null;
		}
	
		return customer;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Customer> getClientList(Integer offset, Integer maxResults) {
		
		return sessionFactory.openSession()
			    .createCriteria(Customer.class)
			    .setFirstResult(offset!=null?offset:0)
			    .setMaxResults(maxResults!=null?maxResults:10)
			    .list();
	}
    @SuppressWarnings("unchecked")
	private List<Customer> getClientList(){
    	Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Customer.class);
		return (List<Customer>)criteria.list(); 
    }
	@Override
	public String updateClient(Customer customer) {
		try{
			sessionFactory.getCurrentSession().update(customer);
			retMessage = "Customer "+ customer.getClientName()+ " is successfully updated";
		}
		catch( Exception e){
			retMessage = "Customer "+ customer.getClientName() + " is not updated\n" + e.getMessage();
		}
		return retMessage;
	}

	@Override
	public Integer count() {
		return (Integer) sessionFactory.getCurrentSession().createCriteria(Customer.class).setProjection(Projections.rowCount()).uniqueResult();
		
	}

	@Override
	public String prepareCustomer(CustomerBean customerBean) {
		
		CustomerContactDetails contactDetails, contactDetails1 = null;
		List<CustomerContactDetails>list = null;
	  try{
			list = new ArrayList<CustomerContactDetails>();
		     contactDetails = new CustomerContactDetails();
		     contactDetails.setCellNumber(customerBean.getCellphoneNumber());
		     contactDetails.setEmail(customerBean.getEmail());
		     contactDetails.setFirstName(customerBean.getFirstName());
		     contactDetails.setLastName(customerBean.getLastName());
		     list.add(contactDetails);
		     
		     if(customerBean.getFirstName1() != null){
		    	 contactDetails1 = new CustomerContactDetails();
		    	 contactDetails1.setCellNumber(customerBean.getCellphoneNumber1());
		    	 contactDetails1.setEmail(customerBean.getEmail1());
		    	 contactDetails1.setFirstName(customerBean.getFirstName1());
		    	 contactDetails1.setLastName(customerBean.getLastName1());
		     }
		    
		     customer = new Customer();
			customer.setActive(true);
		    customer.setCity_town(customerBean.getCity_town());
		    customer.setClientName(customerBean.getClientName());
		    customer.setEmail(customerBean.getEmailCompany());
		    customer.setFaxNumber(customerBean.getFaxNumber());
		    customer.setProvince(customerBean.getProvince());
		    customer.setStreetName(customerBean.getStreetName());
		    customer.setStreetNumber(customerBean.getStreetNumber());
		    customer.setTellphoneNumber(customerBean.getTellphoneNumber());
		    customer.setZipcode(customerBean.getZipcode());
		    
		    retMessage = saveClient(customer);
		    customerContactDetailsDaoIntDaoInt.saveContactDetails(list);
		}catch(Exception e){
			retMessage = "Customer "+ customer.getClientName() +" "+ "is not added";
		}
	    
	    
		return retMessage;
	}

}
