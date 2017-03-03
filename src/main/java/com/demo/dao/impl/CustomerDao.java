package com.demo.dao.impl;



import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.CustomerBean;
import com.demo.dao.CustomerDaoInt;
import com.demo.dao.CustomerContactDetailsDaoInt;
import com.demo.model.Customer;
import com.demo.model.CustomerContactDetails;
import com.demo.model.Employee;

@Repository("clientDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class CustomerDao implements CustomerDaoInt{
	
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
			sessionFactory.getCurrentSession().saveOrUpdate(customer);
			retMessage =  "Customer "+ customer.getCustomerName() + " "+ "Was successfully added";
		}
		catch(Exception e){
			retMessage = "Customer "+ customer.getCustomerName() + " is not added\n" + e.getMessage();
		}
		
		return retMessage;
	}

	@Override
	public Customer getClientByClientName(String clientName) {
		return(Customer) sessionFactory.getCurrentSession().get(Customer.class,clientName );
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
	@Override
	public String updateClient(Customer customer) {
		try{
			sessionFactory.getCurrentSession().update(customer);
			retMessage = "Customer "+ customer.getCustomerName()+ " is successfully updated";
		}
		catch( Exception e){
			retMessage = "Customer "+ customer.getCustomerName() + " is not updated\n" + e.getMessage();
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
			
		    
		    customer = new Customer();
		    // Client object
			customer.setActive(true);
		    customer.setCity_town(customerBean.getCity_town());
		    customer.setCustomerName(customerBean.getCustomerName());
		    customer.setEmail(customerBean.getEmailCompany());
		    customer.setFaxNumber(customerBean.getFaxNumber());
		    customer.setProvince(customerBean.getProvince());
		    customer.setStreetName(customerBean.getStreetName());
		    customer.setStreetNumber(customerBean.getStreetNumber());
		    customer.setTellphoneNumber(customerBean.getTellphoneNumber());
		    customer.setZipcode(customerBean.getZipcode());
		    
		    list = new ArrayList<CustomerContactDetails>();
		    // Required contact person object
		     contactDetails = new CustomerContactDetails();
		     contactDetails.setCellNumber(customerBean.getCellphoneNumber());
		     contactDetails.setTelephoneNumber(customerBean.getTelephoneNumber());
		     contactDetails.setEmail(customerBean.getEmail());
		     contactDetails.setFirstName(customerBean.getFirstName());
		     contactDetails.setLastName(customerBean.getLastName());
		     contactDetails.setCustomer(customer);
		     list.add(contactDetails);
		     
		     // Optional contact person object
		     if(customerBean.getFirstName1() != null && customerBean.getFirstName1().length()>0){
		    	 contactDetails1 = new CustomerContactDetails();
		    	 contactDetails1.setCellNumber(customerBean.getCellphoneNumber1());
		    	 contactDetails1.setEmail(customerBean.getEmail1());
		    	 contactDetails1.setFirstName(customerBean.getFirstName1());
		    	 contactDetails1.setLastName(customerBean.getLastName1());
		    	 contactDetails1.setTelephoneNumber(customerBean.getTelephoneNumber1());
		    	 contactDetails1.setCustomer(customer);
		    	 list.add(contactDetails1);
		     }
		    
		    retMessage = saveClient(customer);
		    customerContactDetailsDaoIntDaoInt.saveContactDetails(list);
		}catch(Exception e){
			retMessage = "Customer "+ customer.getCustomerName() +" "+ "is not added";
		}
	    
	    
		return retMessage;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Customer> getClientList() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Customer.class);
		return (List<Customer>)criteria.list(); 
	}

	@Override
	public CustomerBean contactDetails(String customerName) {
		CustomerBean returnCustomerContact = new CustomerBean();
		try{
			Customer customer= getClientByClientName(customerName);
			returnCustomerContact.setCustomerName(customer.getCustomerName());
			returnCustomerContact.setCity_town(customer.getCity_town());
			returnCustomerContact.setEmailCompany(customer.getEmail());
			returnCustomerContact.setFaxNumber(customer.getFaxNumber());
			returnCustomerContact.setProvince(customer.getProvince());
			returnCustomerContact.setStreetName(customer.getStreetName());
			returnCustomerContact.setStreetNumber(customer.getStreetNumber());
			returnCustomerContact.setTellphoneNumber(customer.getTellphoneNumber());
			returnCustomerContact.setZipcode(customer.getZipcode());
		}
		catch(Exception ex){
			
		}
		return returnCustomerContact;
	}

}
