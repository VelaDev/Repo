package com.demo.service;

import com.demo.model.UserLogDetails;

public interface UserLogDetailsServiceInt {
	
	void saveUserLogDetails(UserLogDetails details);
	void updateTimeout(String sessionID);
	UserLogDetails getUserLogDetails(String sessionID);

}
