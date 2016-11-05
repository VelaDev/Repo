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
import com.demo.bean.ProductBean;
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
	List <Accessories> accessoryList = null;
	
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
		
		
		
		
		return list;
	}

	@Override
	public String updateDevice(Device device) {
		try{
			
			
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
		client = new Client();
		device = new Device();
		device.setEndDate(deviceBean.getEndDate());
		device.setProductModel(deviceBean.getProductModel());
		device.setSerialNumber(deviceBean.getSerialNumber());
		device.setStartDate(deviceBean.getStartDate());
		
		
		client.setCellNumber(deviceBean.getCellNumber());
		client.setCity_town(deviceBean.getCity_town());
		client.setContactPerson(deviceBean.getContactPerson());
		client.setEmail(deviceBean.getEmail());
		client.setFaxNumber(deviceBean.getFaxNumber());
		client.setFloorNumber(deviceBean.getFloorNumber());
		client.setProvince(deviceBean.getProvince());
		client.setStreetName(deviceBean.getStreetName());
		client.setTellphoneNumber(deviceBean.getTellphoneNumber());
		client.setZipcode(deviceBean.getZipcode());
		client.setClientName(deviceBean.getClientName());
		
		retMessage = clientDaoInt.saveClient(client);
		client = clientDaoInt.getClientByClientName(deviceBean.getClientName());
		
		
		
		if(client != null){
			device.setClient(client);
			
		    list = new ArrayList<Accessories>();
			Accessories accessory = new Accessories();
			
			if(deviceBean.getAdditionalPaperTrays()!=null && deviceBean.getAdditionalPaperTraysTypeSerial()!=""){
				accessory.setSerial(deviceBean.getAdditionalPaperTraysTypeSerial());
				accessory.setAccessotyType("Additional Paper Trays");
				accessory.setDevice(device);
				list.add(accessory);
			}
			if(deviceBean.getBridgeUnitSerialType()!=null && deviceBean.getBridgeUnitSerialTypeSerialNo()!=""){
				Accessories accessory1 = new Accessories();
				accessory1.setSerial(deviceBean.getBridgeUnitSerialTypeSerialNo());
				accessory1.setAccessotyType("Bridge Unit");
				accessory1.setDevice(device);
				list.add(accessory1);
			}
			
			if(deviceBean.getCredenza() != null && deviceBean.getCredenzaSerialNo() !=""){
				Accessories accessory2 = new Accessories();
				accessory2.setSerial(deviceBean.getCredenzaSerialNo());
				accessory2.setAccessotyType("Credenza");
				accessory2.setDevice(device);
				list.add(accessory2);
			}
			
			
			if(deviceBean.getFaxUnitSerialType()!= null && deviceBean.getFaxUnitSerialTypeSerialNo()!=""){
				Accessories accessory3 = new Accessories();
				accessory3.setSerial(deviceBean.getFaxUnitSerialTypeSerialNo());
				accessory3.setAccessotyType("Fax Unit");
				accessory3.setDevice(device);
				list.add(accessory3);
			}
			
			if(deviceBean.getFinisherType()!= null && deviceBean.getFinisherTypeSerialNo()!=""){
				Accessories accessory4 = new Accessories();
				accessory4.setSerial(deviceBean.getFinisherTypeSerialNo());
				accessory4.setAccessotyType("Finisher");
				accessory4.setDevice(device);
				list.add(accessory4);
			}
			
			if(deviceBean.getLtcType()!=null && deviceBean.getLtcTypeSerial()!=""){
				Accessories accessory5 = new Accessories();
				accessory5.setSerial(deviceBean.getLtcTypeSerial());
				accessory5.setAccessotyType("LTC");
				accessory5.setDevice(device);
				list.add(accessory5);
			}
			
			if(deviceBean.getOneBinTrayType()!= null && deviceBean.getOneBinTrayTypeSerialNo()!=""){
				Accessories accessory6 = new Accessories();
				accessory6.setSerial(deviceBean.getOneBinTrayTypeSerialNo());
				accessory6.setAccessotyType("One bin tray");
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

	@Override
	public ProductBean getAccessoriesForUpdate(String serialNumber) {
		try{
			
			accessoryList = accessoriesDaoInt.getAccessoriesByDeviceSerial(serialNumber);
			for(Accessories access : accessoryList){
				if(access.getDevice().getSerialNumber().equalsIgnoreCase(serialNumber))
				{
					if(access.getAccessotyType().equalsIgnoreCase("Bridge Unit"))
					{
						
					}
				}
			}
		}
		catch(Exception e)
		{
			return null;
		}
		return null;
	}
	
}
