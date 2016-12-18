package com.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.bean.CustomerBean;
import com.demo.dao.CustomerContactDetailsDaoInt;
import com.demo.model.CustomerContactDetails;
import com.demo.service.CustomerContactDetailsServiceInt;

@Service("CustomerContactDetailsService")
public class CustomerContactDetailsService implements CustomerContactDetailsServiceInt{

	
	@Autowired
	private CustomerContactDetailsDaoInt contactDetailsDaoInt;
	
	@Override
	public CustomerBean contactDetails(String customerName) {	
		
		return contactDetailsDaoInt.contactDetails(customerName);
	}

	@Override
	public List<CustomerContactDetails> contacts(String customerName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CustomerContactDetails> contacts() {
		// TODO Auto-generated method stub
		return null;
	}

}
