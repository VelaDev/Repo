package com.demo.dao.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.SpareMasterDaoInt;
import com.demo.dao.HOStockDaoInt;
import com.demo.model.HOStock;
import com.demo.model.SpareMaster;

@Repository("HOStockDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class HOStockDao implements HOStockDaoInt {

	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private SpareMasterDaoInt spareMasterDaoInt;

	private String retMessage = null;

	private DateFormat dateFormat = null;
	private Date date = null;

	private SpareMaster spareMaster = null;
	private HOStock hOStock;
	private List<HOStock> tempList = null;
	private List<HOStock> tempHOList = null;
	
	@Override
	public String saveSpareparts(HOStock spareParts) {

		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		date = new Date();

		try {

			hOStock = getSparePartBySerial(spareParts.getPartNumber());
			if (hOStock != null) {
				int updateQuantity = hOStock.getQuantity()
						+ spareParts.getQuantity();
				hOStock.setQuantity(updateQuantity);
				sessionFactory.getCurrentSession().update(hOStock);
				retMessage = "Quantity for Part No " + hOStock.getPartNumber()
						+ " updated";

			} else {
				spareMaster = spareMasterDaoInt.getSpareMaster(spareParts
						.getPartNumber());
				if (spareMaster != null) {

					spareParts.setCompitableDevice(spareMaster
							.getCompitableDevice());
					spareParts.setItemDescription(spareMaster.getItemDescription());
					spareParts.setItemType(spareMaster.getItemType());
					spareParts.setDateTime(dateFormat.format(date));
					sessionFactory.getCurrentSession().save(spareParts);
					retMessage = "Part Number : " + " "
							+ spareParts.getPartNumber()
							+ " successfully added";
				} else {

					spareMaster = new SpareMaster();
					spareMaster.setCompitableDevice(spareParts
							.getCompitableDevice());
					spareMaster.setItemDescription(spareParts.getItemDescription());
					spareMaster.setItemType(spareParts.getItemType());
					spareMaster.setPartNumber(spareParts.getPartNumber());
					spareMaster.setDateCaptured(date);
					spareMaster.setCapturedBy(spareParts.getReceivedBy());

					retMessage = spareMasterDaoInt
							.saveSpareMasterData(spareMaster);

					spareParts.setPartNumber(spareMaster.getPartNumber());
					spareParts.setCompitableDevice(spareMaster
							.getCompitableDevice());
					spareParts.setItemDescription(spareMaster.getItemDescription());
					spareParts.setItemType(spareMaster.getItemType());
					spareParts.setDateTime(dateFormat.format(date));
					sessionFactory.getCurrentSession().save(spareParts);

					retMessage = "Part Number : "
							+ " "
							+ spareParts.getPartNumber()
							+ " successfully added";
				}
			}
		} catch (Exception e) {
			retMessage = " Part Number : " + " " + spareParts.getPartNumber()
					+ " not added " + e.getMessage();
		}
		return retMessage;
	}

	@Override
	public HOStock getSparePartBySerial(String serialNum) {

		return (HOStock) sessionFactory.getCurrentSession().get(HOStock.class,
				serialNum);
	}

	@Override
	public String updateSpareParts(HOStock spareParts) {

		try {
			sessionFactory.getCurrentSession().update(spareParts);

		} catch (Exception e) {

		}
		return "";
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<HOStock> getAllSpareParts() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				HOStock.class);
		return (List<HOStock>) criteria.list();
	}

	@Override
	public List<HOStock> getAllSparePartsWithoutZero() {
		tempList = new ArrayList<HOStock>();
		try{
			tempHOList = getAllSpareParts();
			for(HOStock hoStock:tempHOList){
				if(hoStock.getQuantity()>0){
					tempList.add(hoStock);
				}
			}
		}catch(Exception e){
			e.getMessage();
		}
		return tempList;
	}
	

}
