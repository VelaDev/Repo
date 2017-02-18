package com.demo.dao;

import java.util.List;

import com.demo.model.Credentials;

public interface CredentialsDaoInt {
	
	void saveNewPassword(Credentials credentials);
	List<Credentials> getCredentialsForUser(String email);
	List<Credentials> getCredentialsForUser();
	

}
