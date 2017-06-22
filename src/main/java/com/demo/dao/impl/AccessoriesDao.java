package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.AccessoriesDaoInt;
import com.demo.model.Accessories;
import com.demo.model.Device;

@Repository("accessoriesDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class AccessoriesDao implements AccessoriesDaoInt {

	@Autowired
	SessionFactory sessionFactory;

	List<Accessories> accessoriesList = null;
	ArrayList<?> aList = null;
	Accessories acc = null;

	private String retMessage = null;

	@Override
	public String saveAccessories(List<Accessories> accessories) {

		try {

			if (accessories.isEmpty() == false) {
				for (Accessories access : accessories) {
					if (access.getSerial() != null) {
						sessionFactory.getCurrentSession().saveOrUpdate(access);
						retMessage = "OK";
					}

				}
			} else {
				retMessage = "OK";
			}

		} catch (Exception e) {
			retMessage = e.getMessage();
		}
		return retMessage;
	}

	@Override
	public String updateAccessories(List<Accessories> accessories) {

		try {
			for (Accessories access : accessories) {
				sessionFactory.getCurrentSession().update(access);
				retMessage = "OK";
			}
		} catch (Exception e) {
			retMessage = "Error";
		}
		return retMessage;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Accessories> getAccessoriesByDeviceSerial(String serialNo) {
		try {

			aList = new ArrayList<Object>();
			accessoriesList = new ArrayList<Accessories>();
			Criteria criteria = sessionFactory.getCurrentSession()
					.createCriteria(Accessories.class);
			aList.addAll(criteria.list());
			for (Object access : aList) {
				if (access instanceof Accessories) {
					if (((Accessories) access).getDevice().getSerialNumber() != null
							&& ((Accessories) access).getDevice()
									.getSerialNumber()
									.equalsIgnoreCase(serialNo)
							&& ((Accessories) access).getDevice()
									.getSerialNumber() != "") {
						accessoriesList.add((Accessories) access);
					}
				}
			}
		} catch (Exception ex) {
			return null;
		}
		return accessoriesList;
	}

	@Override
	public String removeAccessory(String []serialNumbers) {
		String serialNo = null;
		try {
			
			for(int i=0;i < serialNumbers.length; i++){
				serialNo = serialNumbers[i];
				
				Accessories accessories = getAccessories(serialNo);
				sessionFactory.getCurrentSession().delete(accessories);
			}
			retMessage = "Accessories removed";
		} catch (Exception e) {
			e.getMessage();
		}
		return retMessage;
	}

	@Override
	public Accessories getAccessories(String serialNo) {

		return (Accessories) sessionFactory.getCurrentSession().get(
				Accessories.class, serialNo);
	}
}
