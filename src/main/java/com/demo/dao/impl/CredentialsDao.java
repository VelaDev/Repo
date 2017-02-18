package com.demo.dao.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.demo.dao.CredentialsDaoInt;
import com.demo.model.Credentials;
import com.demo.model.OrdersHeader;


@Transactional
@Repository("credentialsDao")
public class CredentialsDao implements CredentialsDaoInt{

	@Autowired
	private SessionFactory sessionFactory;
	@Override
	public boolean saveNewPassword(Credentials credentials) {
		boolean retFlag = false;
		try{
			   retFlag =  checkPasswordExists(credentials.getEmployee().getEmail(),credentials.getPassword());
			   if(retFlag == false){
				   sessionFactory.getCurrentSession().save(credentials);
				   retFlag = true;
			   }else{
				   retFlag = false;
			   }
		}catch(Exception e){
			retFlag = false;
			e.getMessage();
			
		}
		return retFlag;
	}
	@Override
	public List<Credentials> getCredentialsForUser(String email) {
		return null;
	}
	@Override
	public List<Credentials> getCredentialsForUser() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Credentials.class);
		return (List<Credentials>)criteria.list();
	}
	
	private boolean checkPasswordExists(String username, String newPassword){
		boolean retFlag = false;
		try{
			List <Credentials> currentPasswords = getCredentialsForUser();
			for(Credentials cred : currentPasswords){
				if(cred.getEmployee().getEmail().equalsIgnoreCase(username)&& cred.getEmployee().getPassword().equalsIgnoreCase(newPassword)){
					
					retFlag = true;
					break;
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
		
		return retFlag;
	}

}
