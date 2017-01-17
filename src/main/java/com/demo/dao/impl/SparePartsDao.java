package com.demo.dao.impl;



import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.SparePartsDaoInt;
import com.demo.model.Spare;


@Repository("sparePartsDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class SparePartsDao implements SparePartsDaoInt{
	
	@Autowired
	private SessionFactory sessionFactory;
	
	private String retMessage = null;
	
	DateFormat dateFormat = null;
	Date date = null;

	@Override
	public String saveSpareparts(Spare spareParts) {
		
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		
		try{
			   spareParts.setStockType("HO");
			   spareParts.setDateTime(dateFormat.format(date));
			   sessionFactory.getCurrentSession().save(spareParts);
			   retMessage = " Spare Part"+" "+spareParts.getPartNumber()+ " is successfully added";
		}
		catch(Exception e){
			retMessage = " Spare Part"+" "+spareParts.getPartNumber()+ "is not added " + e.getMessage();
		}
		return retMessage;
	}

	@Override
	public Spare getSparePartBySerial(String serialNum) {
		
		return (Spare) sessionFactory.getCurrentSession().get(Spare.class, serialNum);
	}

	@Override
	public String updateSpareParts(Spare spareParts) {
		
		try{
			sessionFactory.getCurrentSession().update(spareParts);
			
		}catch(Exception e){
			
		}
		return "";
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Spare> getAllSpareParts() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Spare.class);
		return (List<Spare>)criteria.list();
	}

}
