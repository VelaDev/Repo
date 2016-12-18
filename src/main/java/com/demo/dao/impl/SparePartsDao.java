package com.demo.dao.impl;



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

	@Override
	public String saveSpareparts(Spare spareParts) {
		
		try{
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

}
