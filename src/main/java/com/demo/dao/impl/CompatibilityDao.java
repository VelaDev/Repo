package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.CompatibilityDaoInt;
import com.demo.model.Compatibility;



@Repository("compitabilityDao")
@Transactional(propagation = Propagation.REQUIRED)
public class CompatibilityDao implements CompatibilityDaoInt{

	
	@Autowired
	private SessionFactory sessionFactory;
	String retMessage = null;
	List<Compatibility> compatibility = null;
	List<Compatibility> compitableByPartNumber;
	
	@Override
	public String saveCompitability(Compatibility compatibility) {
		try{
			
			sessionFactory.getCurrentSession().save(compatibility);
			retMessage = "Part Number : "+ compatibility.getSpare().getPartNumber()+ " is compitable with model "+compatibility.getModelNumber();
		}
		catch(Exception e){
			retMessage = "Part Number "+ compatibility.getSpare().getPartNumber()+ " is not compitable with model "+compatibility.getModelNumber();
		} 
		return retMessage;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Compatibility> compitabilityList() {
		
			Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Compatibility.class);
			return (List<Compatibility>)criteria.list();
	}

	@Override
	public List<Compatibility> compitabilityList(String parNumber) {
		compitableByPartNumber = new ArrayList<Compatibility>();
		try{
			compatibility = compitabilityList();
			for(Compatibility comp:compatibility){
				if(comp.getSpare().getPartNumber().equalsIgnoreCase(parNumber)){
					compitableByPartNumber.add(comp);
				}
			}
			
		}catch(Exception e){
			
		}
		return compitableByPartNumber;
	}

}
