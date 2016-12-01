package com.demo.dao.impl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.CustomerContactDetailsDaoInt;
import com.demo.model.CustomerContactDetails;


@Repository("customerContactDetailsDao")
@Transactional(propagation=Propagation.REQUIRED)
public class CustomerContactDetailsDao implements CustomerContactDetailsDaoInt{

	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public void saveContactDetails(List<CustomerContactDetails> contacts) {
		try{
			for(CustomerContactDetails contactDetails:contacts){
				sessionFactory.getCurrentSession().saveOrUpdate(contactDetails);
			}
		}catch(Exception e){
			
		}
		
	}

}
