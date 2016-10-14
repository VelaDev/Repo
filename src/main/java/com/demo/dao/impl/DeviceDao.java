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

import com.demo.bean.DeviceBean;
import com.demo.dao.AccessoriesDaoInt;
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
	@Autowired
	private AccessoriesDaoInt accessoriesDaoInt;
	
	
	private String retMessage = null;
	@SuppressWarnings("unused")
	private Date currentDate =null;
	ArrayList<Device> productList = null;
	ArrayList<?> aList = null;
	ArrayList list = null;
	Client client = null;
	Device device = null;
	
	
	@Override
	public String saveDevice(Device device) {
		
		try{
			
		       sessionFactory.getCurrentSession().save(device);
		        retMessage = "Device "+ device.getSerialNumber() + " is succefully added. The device belongs to customer :" + device.getClient().getClientName();
		   }
		catch(Exception e){
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

	@Override
	public String prepareDeviceData(DeviceBean deviceBean) {
		//Purpose	: This method prepares the device data before inserting into the table
		
		String retAccessory = null;
		device = new Device();
		device.setEndDate(deviceBean.getEndDate());
		device.setProductModel(deviceBean.getProductModel());
		device.setSerialNumber(deviceBean.getSerialNumber());
		device.setStartDate(deviceBean.getStartDate());
		client = clientDaoInt.getClientByClientName(deviceBean.getClientName());
		if(client != null){
			device.setClient(client);
			
		    list = new ArrayList<Accessories>();
			Accessories accessory = new Accessories();
			
			if(deviceBean.getAdditionalPaperTrays()!=null && deviceBean.getAdditionalPaperTraysTypeSerial()!=""){
				accessory.setSerial(deviceBean.getAdditionalPaperTraysTypeSerial());
				accessory.setAccessotyType(deviceBean.getAdditionalPaperTrays());
				accessory.setDevice(device);
				list.add(accessory);
			}
			if(deviceBean.getBridgeUnitSerialType()!=null && deviceBean.getBridgeUnitSerialTypeSerialNo()!=""){
				Accessories accessory1 = new Accessories();
				accessory1.setSerial(deviceBean.getBridgeUnitSerialTypeSerialNo());
				accessory1.setAccessotyType(deviceBean.getBridgeUnitSerialType());
				accessory1.setDevice(device);
				list.add(accessory1);
			}
			
			if(deviceBean.getCredenza() != null && deviceBean.getCredenzaSerialNo() !=""){
				Accessories accessory2 = new Accessories();
				accessory2.setSerial(deviceBean.getCredenzaSerialNo());
				accessory2.setAccessotyType(deviceBean.getCredenza());
				accessory2.setDevice(device);
				list.add(accessory2);
			}
			
			
			if(deviceBean.getFaxUnitSerialType()!= null && deviceBean.getFaxUnitSerialTypeSerialNo()!=""){
				Accessories accessory3 = new Accessories();
				accessory3.setSerial(deviceBean.getFaxUnitSerialTypeSerialNo());
				accessory3.setAccessotyType(deviceBean.getFaxUnitSerialType());
				accessory3.setDevice(device);
				list.add(accessory3);
			}
			
			if(deviceBean.getFinisherType()!= null && deviceBean.getFinisherTypeSerialNo()!=""){
				Accessories accessory4 = new Accessories();
				accessory4.setSerial(deviceBean.getFinisherTypeSerialNo());
				accessory4.setAccessotyType(deviceBean.getFinisherType());
				accessory4.setDevice(device);
				list.add(accessory4);
			}
			
			if(deviceBean.getLtcType()!=null && deviceBean.getLtcTypeSerial()!=""){
				Accessories accessory5 = new Accessories();
				accessory5.setSerial(deviceBean.getLtcTypeSerial());
				accessory5.setAccessotyType(deviceBean.getLtcType());
				accessory5.setDevice(device);
				list.add(accessory5);
			}
			
			if(deviceBean.getOneBinTrayType()!= null && deviceBean.getOneBinTrayTypeSerialNo()!=""){
				Accessories accessory6 = new Accessories();
				accessory6.setSerial(deviceBean.getOneBinTrayTypeSerialNo());
				accessory6.setAccessotyType(deviceBean.getOneBinTrayType());
				accessory6.setDevice(device);
				list.add(accessory6);
			}
			
			retMessage = saveDevice(device);
			retAccessory =accessoriesDaoInt.saveAccessories(list);
			if(retAccessory.equalsIgnoreCase("Error")){
				retMessage ="Device not inserted into the table";
			}
		}
		else{
			retMessage = "Client "+ client.getClientName() +" does not exist on database. Please make sure that the client exist before assigning a device" ;
		}
		
		return retMessage;
	}
	
}
