package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.CompatibilityBean;
import com.demo.dao.CompatibilityDaoInt;
import com.demo.dao.SparePartsDaoInt;
import com.demo.model.Compatibility;
import com.demo.model.Spare;



@Repository("compitabilityDao")
@Transactional(propagation = Propagation.REQUIRED)
public class CompatibilityDao implements CompatibilityDaoInt{

	
	@Autowired
	private SessionFactory sessionFactory;
	private String retMessage = null;
	private List<Compatibility> compatibility = null;
	private List<Compatibility> compitableByPartNumber =null;
	@Autowired
	private SparePartsDaoInt sparePartsDaoInt;
	
	
	
	
	@Override
	public String saveCompitability(CompatibilityBean comp) {
		Compatibility compatibility = new Compatibility();
		Spare spare =null;
		
		try{
			  spare = sparePartsDaoInt.getSparePartBySerial(comp.getPartNumber());
			  compatibility.setModelNumber(comp.getModelNumber());
			  compatibility.setSpare(spare);
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
