package com.demo.dao.impl;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.EmployeeDaoInt;
import com.demo.dao.LoginAttemptDaoInt;
import com.demo.model.Employee;
import com.demo.model.LoginAttempt;

@Repository("loginAttemptDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class LoginAttemptDao implements LoginAttemptDaoInt{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Autowired
	private EmployeeDaoInt employeeDaoInt;
	
	private LoginAttempt attempt;
	
	@Override
	public void upsertUserAttempt(LoginAttempt userLoginAttempt) {
		sessionFactory.getCurrentSession().saveOrUpdate(userLoginAttempt);
		
	}

	@Override
	public LoginAttempt getLoginUser(String userName) {
		
		return (LoginAttempt) sessionFactory.getCurrentSession().get(LoginAttempt.class, userName);
	}

	@Override
	public LoginAttempt getEmployeeDetails(Employee employee) {
		LoginAttempt loginattempt = getLoginUser(employee.getEmail());
		int tempCount = 0;
		attempt = new LoginAttempt();
		try{
			
			 if(loginattempt != null){
				 attempt.setUserName(employee.getEmail());
				 tempCount= loginattempt.getAttemptCount() +1;
				 attempt.setAttemptCount(tempCount);
				 if(tempCount ==3){
					 
					 employee.setStatus("BLOCKED");
					 sessionFactory.getCurrentSession().update(employee);
					 
				 }
			 }else{
				 
				 attempt.setUserName(employee.getEmail());
				 attempt.setAttemptCount(1);
			 }
			
		}catch(Exception e){
			e.getMessage();
		}
		return attempt;
	}

}
