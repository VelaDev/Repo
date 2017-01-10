package com.demo.dao.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.CustomerBean;
import com.demo.dao.CustomerContactDetailsDaoInt;
import com.demo.model.Customer;
import com.demo.model.CustomerContactDetails;


@Repository("customerContactDetailsDao")
@Transactional(propagation=Propagation.REQUIRED)
public class CustomerContactDetailsDao implements CustomerContactDetailsDaoInt{

	@Autowired
	private SessionFactory sessionFactory;
	
	private List<CustomerContactDetails> tempContacts = null;
	
	@Override
	public void saveContactDetails(List<CustomerContactDetails> contacts) {
		try{
			for(CustomerContactDetails contactDetails:contacts){
				sessionFactory.getCurrentSession().saveOrUpdate(contactDetails);
			}
		}catch(Exception e){
			
		}
		
	}

	@Override
	public CustomerBean contactDetails(String customerName) {
		CustomerBean returnCustomerContact = new CustomerBean();
        try{
			
			tempContacts = contacts();
			int count = 0;
			for(CustomerContactDetails temp:tempContacts){
				
					if(temp.getCustomer().getCustomerName().equalsIgnoreCase(customerName)){
						
						if(count ==0){
							returnCustomerContact.setFirstName(temp.getFirstName());
							returnCustomerContact.setLastName(temp.getLastName());
							returnCustomerContact.setEmail(temp.getEmail());
							returnCustomerContact.setTelephoneNumber(temp.getTelephoneNumber());
							returnCustomerContact.setCellphoneNumber(temp.getCellNumber());
						}
						else if (count ==1){
							returnCustomerContact.setFirstName1(temp.getFirstName());
							returnCustomerContact.setLastName1(temp.getLastName());
							returnCustomerContact.setEmail1(temp.getEmail());
							returnCustomerContact.setTelephoneNumber1(temp.getTelephoneNumber());
							returnCustomerContact.setCellphoneNumber1(temp.getCellNumber());
						}
						count ++;
					}
					
				}
        }
		catch(Exception e){
			
		}
		return returnCustomerContact;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CustomerContactDetails> contacts(String customerName) {
		try{
			
			tempContacts = contacts();
			for(CustomerContactDetails temp:tempContacts){
				if(temp.getCustomer().getCustomerName().equalsIgnoreCase(customerName));
				
			}
		}
		catch(Exception e){
			
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CustomerContactDetails> contacts() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(CustomerContactDetails.class);
		return (List<CustomerContactDetails>)criteria.list(); 
	}

	@Override
	public CustomerContactDetails getContactPerson(String customerName) {
		CustomerContactDetails contactDetails= null;
		
		try{
			   List<CustomerContactDetails> list = contacts();
			   for(CustomerContactDetails temp:list){
				   if(temp.getCustomer().getCustomerName().equalsIgnoreCase(customerName)){
					   contactDetails = temp;
					   break;
				   }
			   }
		}catch(Exception e){
			
		}

		return contactDetails;
	}
}
