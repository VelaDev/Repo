package com.demo.dao.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.SpareMasterDaoInt;
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

}
