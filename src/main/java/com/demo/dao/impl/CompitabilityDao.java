package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.CompitabilityDaoInt;
import com.demo.model.Compitability;



@Repository("compitabilityDao")
@Transactional(propagation = Propagation.REQUIRED)
public class CompitabilityDao implements CompitabilityDaoInt{

	
	@Autowired
	private SessionFactory sessionFactory;
	String retMessage = null;
	List<Compitability> compitability = null;
	List<Compitability> compitableByPartNumber;
	
	@Override
	public String saveCompitability(Compitability compitability) {
		try{
			
			sessionFactory.getCurrentSession().save(compitability);
			retMessage = "Part Number : "+ compitability.getPartNumber()+ " is compitable with model "+compitability.getModelNumber();
		}
		catch(Exception e){
			retMessage = "Part Number "+ compitability.getPartNumber()+ " is not compitable with model "+compitability.getModelNumber();
		} 
		return retMessage;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Compitability> compitabilityList() {
		
			Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Compitability.class);
			return (List<Compitability>)criteria.list();
	}

	@Override
	public List<Compitability> compitabilityList(String parNumber) {
		compitableByPartNumber = new ArrayList<Compitability>();
		try{
			compitability = compitabilityList();
			for(Compitability comp:compitability){
				if(comp.getPartNumber().equalsIgnoreCase(parNumber)){
					compitableByPartNumber.add(comp);
				}
			}
			
		}catch(Exception e){
			
		}
		return compitableByPartNumber;
	}

}
