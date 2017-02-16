package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.SpareMasterDaoInt;
import com.demo.model.Device;
import com.demo.model.SpareMaster;



@Repository("spareMasterDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class SpareMasterDao implements SpareMasterDaoInt{

	
	@Autowired
	private SessionFactory sessionFactory;
	@SuppressWarnings("unchecked")
	@Override
	public List<SpareMaster> getSparesFromMastaData() {
		
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(SpareMaster.class);
		return (List<SpareMaster>)criteria.list(); 
	}
	@Override
	public SpareMaster getSpareMaster(String partNumber) {
		
		return (SpareMaster) sessionFactory.getCurrentSession().get(SpareMaster.class, partNumber);
	}
	@Override
	public String[] getSerials() {
		List<SpareMaster> list = null;
		ArrayList<String> newList = null;
		String array[] = null;
		try{
			list = getSparesFromMastaData();
			newList = new ArrayList<String>();
			
			for(SpareMaster master:list){
				newList.add(master.getPartNumber());
			}
			
			 array = new String[newList.size()];
			
			for(int i =0;i<newList.size();i++){
				  array[i] = newList.get(i);
				}
		}
		catch(Exception e){
			e.getMessage();
		}
		return array;
	}

}
