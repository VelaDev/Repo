package com.demo.dao.impl;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.UserLogDetailsDaoInt;
import com.demo.model.Employee;
import com.demo.model.UserLogDetails;


@Repository("userLogDetailsDao")
@Transactional(propagation = Propagation.REQUIRED)
public class UserLogDetailsDao implements UserLogDetailsDaoInt {
	
	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private HttpSession session;
	
	private Date currentDate;
	private Employee employee;
	@Override
	public void saveUserLogDetails(UserLogDetails details) {
		employee = (Employee) session.getAttribute("loggedInUser");
		
		String sessionID = session.getId();
		currentDate = new  Date();
		
		details = new UserLogDetails();
		try{
			details.setSessionId(sessionID);
			details.setLoginDateTime(currentDate);
			details.setEmployee(employee);
			sessionFactory.getCurrentSession().save(details);
			
		}catch(Exception e){
			e.getMessage();
		}
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<UserLogDetails> getLogoutDateTime() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(UserLogDetails.class);
		return (List<UserLogDetails>)criteria.list();
	}
	@Override
	public List<UserLogDetails> getUserLogDetails() {
		return null;
	}

	@Transactional
	@Scheduled(fixedRate=5000 )
	@Override
	public void lougoutTimeStamp() {
		currentDate = new  Date();
		String sessionID = session.getId();
		employee = (Employee) session.getAttribute("loggedInUser");
		
				try{
					List<UserLogDetails> getUsers = getLogoutDateTime();
					for(UserLogDetails users:getUsers){
						if(users.getSessionId().equalsIgnoreCase("") && users.getLogoutDateTime()==null){
							
							users.setLogoutDateTime(currentDate);
							sessionFactory.getCurrentSession().update(users);
						}
					}

		}catch(Exception e){
			e.getMessage();
		}
		
	}
}
