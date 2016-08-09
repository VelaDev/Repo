package com.demo.dao.impl;



import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.SparePartsDaoInt;
import com.demo.model.Parts;


@Repository("sparePartsDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class SparePartsDao implements SparePartsDaoInt{
	
	@Autowired
	private SessionFactory sessionFactory;
	
	private String retMessage = null;

	@Override
	public String saveSpareparts(Parts spareParts) {
		
		try{
			   sessionFactory.getCurrentSession().save(spareParts);
			   retMessage = " Spare Part"+" "+spareParts.getPartNumber()+ "is successfully added";
		}
		catch(Exception e){
			retMessage = " Spare Part"+" "+spareParts.getPartNumber()+ "is not added";
		}
		return retMessage;
	}

	@Override
	public Parts getSparePartBySerial(String serialNum) {
		
		return (Parts) sessionFactory.getCurrentSession().get(Parts.class, serialNum);
	}

	@Override
	public String updateSpareParts(Parts spareParts) {
		
		try{
			sessionFactory.getCurrentSession().update(spareParts);
			
		}catch(Exception e){
			
		}
		return "";
	}

}
