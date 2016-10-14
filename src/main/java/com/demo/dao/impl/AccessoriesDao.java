package com.demo.dao.impl;

import java.util.List;








import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.AccessoriesDaoInt;
import com.demo.model.Accessories;

@Repository("accessoriesDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class AccessoriesDao implements AccessoriesDaoInt{

	@Autowired
	SessionFactory sessionFactory;
	
	private String retMessage = null;
	@Override
	public String saveAccessories(List<Accessories> accessories) {

		try{

		        for(Accessories access:accessories){
			         sessionFactory.getCurrentSession().save(access);
			         retMessage ="OK";
		            }
		}catch (Exception e) {
				retMessage = "Error";
			}
		return retMessage;
	}

	@Override
	public String updateAccessories(List<Accessories> accessories) {
		
		try{
			for(Accessories access:accessories){
				sessionFactory.getCurrentSession().update(access);
				retMessage ="OK";
			}
		}catch(Exception e){
			retMessage = "Error";
		}
		return retMessage;
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Accessories> getAccessoriesByDeviceSerial() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Accessories.class);
		return (List<Accessories>)criteria.list();
	}

}
