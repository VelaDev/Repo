package com.demo.dao.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.demo.dao.CredentialsDaoInt;
import com.demo.model.Credentials;


@Transactional
@Repository("credentialsDao")
public class CredentialsDao implements CredentialsDaoInt{

	@Autowired
	private SessionFactory sessionFactory;
	@Override
	public void saveNewPassword(Credentials credentials) {
		try{
			sessionFactory.getCurrentSession().save(credentials);
			
		}catch(Exception e){
			e.getMessage();
		}
		
	}
	@Override
	public List<Credentials> getCredentialsForUser(String email) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<Credentials> getCredentialsForUser() {
		// TODO Auto-generated method stub
		return null;
	}

}
