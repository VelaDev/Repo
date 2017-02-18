package com.demo.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.demo.dao.LoginAttemptDaoInt;
import com.demo.model.Employee;
import com.demo.model.LoginAttempt;
import com.demo.service.LoginAttemptServiceInt;

public class LoginAttemptService implements LoginAttemptServiceInt{
	
	@Autowired
	private LoginAttemptDaoInt loginAttemptDaoInt;

	@Override
	public void upsertUserAttempt(LoginAttempt userLoginAttempt) {
		
		loginAttemptDaoInt.upsertUserAttempt(userLoginAttempt);
	}

	@Override
	public LoginAttempt getLoginUser(String userName) {
		
		return loginAttemptDaoInt.getLoginUser(userName);
	}

	@Override
	public LoginAttempt getEmployeeDetails(Employee employee) {
		return loginAttemptDaoInt.getEmployeeDetails(employee);
	}

}
