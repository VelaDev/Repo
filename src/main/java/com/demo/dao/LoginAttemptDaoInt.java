package com.demo.dao;

import com.demo.model.LoginAttempt;


public interface LoginAttemptDaoInt {

	void upsertUserAttempt(LoginAttempt userLoginAttempt);
	LoginAttempt getLoginUser(String userName);
}
