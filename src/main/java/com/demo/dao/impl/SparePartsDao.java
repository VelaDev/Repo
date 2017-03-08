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

import com.demo.dao.SpareMasterDaoInt;
import com.demo.dao.SparePartsDaoInt;
import com.demo.model.Spare;
import com.demo.model.SpareMaster;


@Repository("sparePartsDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class SparePartsDao implements SparePartsDaoInt{
	
	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private SpareMasterDaoInt spareMasterDaoInt;
	
	private String retMessage = null;
	
	private DateFormat dateFormat = null;
	private Date date = null;
	
	private SpareMaster spareMaster = null;

	@Override
	public String saveSpareparts(Spare spareParts) {
		
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();
		
		try{
			spareMaster = spareMasterDaoInt.getSpareMaster(spareParts.getPartNumber());
			if(spareMaster != null){
				
				   spareParts.setCompitableDevice(spareMaster.getCompitableDevice());
				   spareParts.setDescription(spareMaster.getDescription());
				   spareParts.setItemType(spareMaster.getItemType());
				   spareParts.setDateTime(dateFormat.format(date));
				   sessionFactory.getCurrentSession().save(spareParts);
				   retMessage = " Spare Part"+" "+spareParts.getPartNumber()+ " is successfully added";   
			}else{
				retMessage ="Part No : "+ spareParts.getPartNumber()+ " does not exist in spare master data. Plase add it into Spare Master Data first";
			}
			   
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
