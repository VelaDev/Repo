package com.demo.dao.impl;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;


import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.ClientDaoInt;
import com.demo.dao.DeviceDaoInt;
import com.demo.model.Accessories;
import com.demo.model.Client;
import com.demo.model.Device;

@Repository("productDAO")
@Transactional(propagation=Propagation.REQUIRED)
public class DeviceDao implements DeviceDaoInt {

	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private ClientDaoInt clientDaoInt;
	private String retMessage = null;
	@SuppressWarnings("unused")
	private Date currentDate =null;
	ArrayList<Device> productList = null;
	ArrayList<?> aList = null;
	Client client = null;
	
	
	@Override
	public String saveDevice(Device device) {
		
		try{
		
		/*Client client = clientDaoInt.getClientByClientName(product.getClientName());
		product.setClient(client);*/
		/*if(product.getAdditionalPaperTraysTypeSerial()!=null){
			product.setAdditionalPaperTrays("Additional Paper Trays");
		}
		if(product.getBridgeUnitSerialTypeSerialNo()!=null){
			product.setBridgeUnitSerialType("Bridge unit");
		}
		if(product.getCredenzaSerialNo()!= null){
			product.setCredenza("Credenza");
		}if(product.getFaxUnitSerialTypeSerialNo()!=null){
			product.setFaxUnitSerialType("Fax Unit");
		}if(product.getFinisherTypeSerialNo()!=null){
			product.setFinisherType("Finisher");
		}if(product.getLtcTypeSerial()!=null){
			product.setLtcType("LCT");
		}if(product.getOneBinTrayTypeSerialNo()!=null){
			product.setOneBinTrayType("One Bin Tray");
		}*/
		sessionFactory.getCurrentSession().save(device);
		retMessage = "Device "+ device.getSerialNumber() + " is succefully added. The device belongs to customer :" + device.getClient().getClientName();
		}catch(Exception e)
		{
			retMessage = "Device "+ device.getSerialNumber() + " is not added\n" + e.getMessage();
		}
		
		return retMessage;
		
	}

	@Override
	public Device getDeviceBySerialNumbuer(String serialNumber) {
		
		return (Device) sessionFactory.getCurrentSession().get(Device.class, serialNumber);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Device> getDeviceList() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Device.class);
		return (List<Device>)criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Device> getDeviceListByClientName(String clientName) {
		String name = clientName;
		try{
			
		    aList = new ArrayList<Object>();
		     productList = new ArrayList<Device>();
			Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Device.class);
			aList.addAll(criteria.list());
			for (Object pro : aList) {
				if (pro instanceof Device) {
					if (((Device) pro).getClient().getClientName()!=null&&((Device) pro).getClient().getClientName().startsWith(name) ) {
						productList.add((Device) pro);
						System.out.println(((Device) pro).getClient().getClientName());
						 client = ((Device) pro).getClient();
					}
				}
			}
		}
		catch(Exception e){
			return null;
		}
		return productList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Accessories> accessories(Device device) {
		ArrayList list = new ArrayList<Accessories>();
		Accessories accessory = new Accessories();
		
		/*if(product.getAdditionalPaperTrays()!=null && product.getAdditionalPaperTraysTypeSerial()!=""){
			accessory.setBridgeUnitSerial(product.getAdditionalPaperTraysTypeSerial());
			accessory.setBridgeUnitSerialType(product.getAdditionalPaperTrays());
			accessory.setProd(product.getSerialNumber());
			list.add(accessory);
		}
		if(product.getBridgeUnitSerialType()!=null && product.getBridgeUnitSerialTypeSerialNo()!=""){
			Accessories accessory1 = new Accessories();
			accessory1.setBridgeUnitSerial(product.getBridgeUnitSerialTypeSerialNo());
			accessory1.setBridgeUnitSerialType(product.getBridgeUnitSerialType());
			accessory1.setProd(product.getSerialNumber());
			list.add(accessory1);
		}
		
		if(product.getCredenza() != null && product.getCredenzaSerialNo() !=""){
			Accessories accessory2 = new Accessories();
			accessory2.setBridgeUnitSerial(product.getCredenzaSerialNo());
			accessory2.setBridgeUnitSerialType(product.getCredenza());
			accessory2.setProd(product.getSerialNumber());
			list.add(accessory2);
		}
		
		
		if(product.getFaxUnitSerialType()!= null && product.getFaxUnitSerialTypeSerialNo()!=""){
			Accessories accessory3 = new Accessories();
			accessory3.setBridgeUnitSerial(product.getFaxUnitSerialTypeSerialNo());
			accessory3.setBridgeUnitSerialType(product.getFaxUnitSerialType());
			accessory3.setProd(product.getSerialNumber());
			list.add(accessory3);
		}
		
		if(product.getFinisherType()!= null && product.getFinisherTypeSerialNo()!=""){
			Accessories accessory4 = new Accessories();
			accessory4.setBridgeUnitSerial(product.getFinisherTypeSerialNo());
			accessory4.setBridgeUnitSerialType(product.getFinisherType());
			accessory4.setProd(product.getSerialNumber());
			list.add(accessory4);
		}
		
		if(product.getLtcType()!=null && product.getLtcTypeSerial()!=""){
			Accessories accessory5 = new Accessories();
			accessory5.setBridgeUnitSerial(product.getLtcTypeSerial());
			accessory5.setBridgeUnitSerialType(product.getLtcType());
			accessory5.setProd(product.getSerialNumber());
			list.add(accessory5);
		}
		
		if(product.getOneBinTrayType()!= null && product.getOneBinTrayTypeSerialNo()!=""){
			Accessories accessory6 = new Accessories();
			accessory6.setBridgeUnitSerial(product.getOneBinTrayTypeSerialNo());
			accessory6.setBridgeUnitSerialType(product.getOneBinTrayType());
			accessory6.setProd(product.getSerialNumber());
			list.add(accessory6);
		}*/
		
		
		return list;
	}

	@Override
	public String updateDevice(Device device) {
		try{
			
			/*Client client = clientDaoInt.getClientByClientName(product.getClientName());
			product.setClient(client);*/
			/*if(product.getAdditionalPaperTraysTypeSerial()!=null && product.getAdditionalPaperTraysTypeSerial()!=""){
				product.setAdditionalPaperTrays("Additional Paper Trays");
			}
			if(product.getBridgeUnitSerialTypeSerialNo()!=null && product.getBridgeUnitSerialTypeSerialNo()!=""){
				product.setBridgeUnitSerialType("Bridge unit");
			}
			if(product.getCredenzaSerialNo()!= null && product.getCredenzaSerialNo()!=""){
				product.setCredenza("Credenza");
			}if(product.getFaxUnitSerialTypeSerialNo()!=null && product.getFaxUnitSerialTypeSerialNo()!=""){
				product.setFaxUnitSerialType("Fax Unit");
			}if(product.getFinisherTypeSerialNo()!=null && product.getFinisherTypeSerialNo()!=""){
				product.setFinisherType("Finisher");
			}if(product.getLtcTypeSerial()!=null && product.getLtcTypeSerial()!=""){
				product.setLtcType("LCT");
			}if(product.getOneBinTrayTypeSerialNo()!=null && product.getOneBinTrayTypeSerialNo()!=""){
				product.setOneBinTrayType("One Bin Tray");
			}*/
			sessionFactory.getCurrentSession().update(device);
			retMessage = "Device "+device.getSerialNumber()+ " is successfully updated. Device belongs to customer : " + device.getClient().getClientName();
		}
		catch(Exception e){
			retMessage = "Device "+device.getSerialNumber()+ " is not updated\n"+ e.getMessage();
		}
		return retMessage;
	}
	
}
