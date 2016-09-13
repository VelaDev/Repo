package com.demo.dao.impl;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import org.hibernate.HibernateException;
import org.hibernate.engine.SessionImplementor;
import org.hibernate.id.IdentifierGenerator;


public class OrderNumberGenerator implements IdentifierGenerator{
	public int generateCustId() {
        Random random = new Random();
        return random.nextInt(20);
    }

	@Override
	public Serializable generate(SessionImplementor arg0, Object arg1)
			throws HibernateException {
		Date date = new Date();
        
        Calendar calendar = Calendar.getInstance();
        return "ORD-"+ calendar.get(Calendar.YEAR)+ calendar.get(Calendar.MONTH)+ calendar.get(Calendar.DAY_OF_MONTH)+"-"+this.generateCustId();
	}
	

}
