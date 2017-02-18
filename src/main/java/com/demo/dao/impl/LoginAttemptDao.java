package com.demo.dao.impl;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.LoginAttemptDaoInt;
import com.demo.model.LoginAttempt;

@Repository("loginAttemptDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class LoginAttemptDao implements LoginAttemptDaoInt{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void upsertUserAttempt(LoginAttempt userLoginAttempt) {
		sessionFactory.getCurrentSession().saveOrUpdate(userLoginAttempt);
		
	}

	@Override
	public LoginAttempt getLoginUser(String userName) {
		
		return (LoginAttempt) sessionFactory.getCurrentSession().get(LoginAttempt.class, userName);
	}

}
