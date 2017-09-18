package com.demo.dao.impl;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.DeviceBean;
import com.demo.dao.AccessoriesDaoInt;
import com.demo.dao.CustomerDaoInt;
import com.demo.dao.DeviceDaoInt;
import com.demo.dao.deviceContactPersonDaoInt;
import com.demo.model.Accessories;
import com.demo.model.Customer;
import com.demo.model.Device;
import com.demo.model.DeviceContactPerson;

@Repository("productDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class DeviceDao implements DeviceDaoInt {

	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private CustomerDaoInt customerDaoInt;
	@Autowired
	private AccessoriesDaoInt accessoriesDaoInt;
	@Autowired
	deviceContactPersonDaoInt contactPersonDaoInt;

	private String retMessage = null;
	@SuppressWarnings("unused")
	private Date currentDate = null;
	ArrayList<Device> productList = null;      
	ArrayList<?> aList = null;
	ArrayList<Accessories> list = null;
	Customer customer = null;
	Device device = null;
	List<Accessories> accessoryList = null;
	private DeviceBean deviceBean = null;
	private DeviceContactPerson contactPerson;
	Device localdevice = null;
	@Override
	public String saveDevice(Device device) {
		try {
			 localdevice = getDeviceBySerialNumbuer(device.getSerialNumber());
			if (localdevice == null) {
				sessionFactory.getCurrentSession().saveOrUpdate(device);
				retMessage = "Device "
						+ device.getSerialNumber()
						+ " succefully added. The device belongs to customer : "
						+ device.getCustomerDevice().getCustomerName()+".";

			}else{
				retMessage = "Device "+ localdevice.getSerialNumber()+ " already assigned to customer " +localdevice.getCustomerDevice().getCustomerName()+". One device canot be assigned twice to a customer.";
			}
		} catch (Exception e) {
			retMessage = "Device " + device.getSerialNumber()
					+ " not added\n" + e.getMessage()+".";
		}

		return retMessage;

	}

	@Override
	public Device getDeviceBySerialNumbuer(String serialNumber) {

		return (Device) sessionFactory.getCurrentSession().get(Device.class,
				serialNumber);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Device> getDeviceList() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				Device.class);
		return (List<Device>) criteria.list();
	}
	@Override
	public List<Accessories> accessories(Device device) {
		/*
		 * ArrayList list = new ArrayList<Accessories>(); Accessories accessory
		 * = new Accessories();
		 */
		return list;
	}

	@Override
	public String updateDevice(Device device) {
		try {
			sessionFactory.getCurrentSession().update(device);
			retMessage = "Device " + device.getSerialNumber()
					+ " is successfully updated. Device belongs to customer : "
					+ device.getCustomerDevice().getCustomerName()+".";
		} catch (Exception e) {
			retMessage = "Device " + device.getSerialNumber()
					+ " not updated\n" + e.getMessage();
		}
		return retMessage;
	}

	@Override
	public String prepareDeviceData(DeviceBean deviceBean) {
		// Purpose : This method prepares the device data before inserting into
		// the table
		String retAccessory = null;
		customer = new Customer();
		contactPerson = new DeviceContactPerson();
		device = new Device();
		String newSerial = null;
		String oldSerial =null;
		
		try {

			if(deviceBean.getChkAccessories()==null){
				device.setEndDate(deviceBean.getEndDate());
				device.setModelNumber(deviceBean.getModelNumber());
				device.setSerialNumber(deviceBean.getSerialNumber());
				device.setStartDate(deviceBean.getStartDate());
				device.setInstallationDate(deviceBean.getInstallationDate());
				device.setModelBrand(deviceBean.getModelBrand());

				device.setMonoReading(deviceBean.getMonoReading());
				device.setColourReading(deviceBean.getColourReading());
				device.setMonoCopyCost(deviceBean.getMonoCopyCost());
				device.setColourCopyCost(deviceBean.getColourCopyCost());

				device.setBuildingName(deviceBean.getBuildingName());
				device.setFloorNumber(deviceBean.getFloorNumber());
				device.setAreaCode(deviceBean.getZipcode());
				device.setCity_town(deviceBean.getCity_town());
				device.setProvince(deviceBean.getProvince());
				device.setStreetName(deviceBean.getStreetName());
				device.setStreetNumber(deviceBean.getStreetNumber());

				contactPerson.setEmail(deviceBean.getEmail());
				contactPerson.setFirstName(deviceBean.getFirstName());
				contactPerson.setLastName(deviceBean.getLastName());
				contactPerson.setCellphone(deviceBean.getCellphone());
				contactPerson.setTelephone(deviceBean.getTelephone());

				customer = customerDaoInt.getClientByClientName(deviceBean
						.getCustomerName());

				if (customer != null) {
					device.setCustomerDevice(customer);

					list = new ArrayList<Accessories>();
					Accessories accessory = new Accessories();
					// addTypeserial
					if (deviceBean.getAddTypeserial() != null) {
						if (deviceBean.getAddTypeserial().length() > 3) {
							oldSerial = deviceBean.getAddTypeserial().replace(",", "");
							//newSerial = oldSerial.substring( 0, oldSerial.indexOf(","));
							accessory.setSerial(oldSerial);
							accessory.setAccessotyType("Additional Paper Trays");
							accessory.setDevice(device);
							list.add(accessory);
						}
					}
					if (deviceBean.getBridgeUnitSerialTypeSerialNo() != null) {
						if (deviceBean.getBridgeUnitSerialTypeSerialNo().length() > 3) {

							Accessories accessory1 = new Accessories();
							
							oldSerial = deviceBean.getBridgeUnitSerialTypeSerialNo().replace(",", "");
							//newSerial = oldSerial.substring( 0, oldSerial.indexOf(","));
							accessory1.setSerial(oldSerial);
							accessory1.setAccessotyType("Bridge Unit");
							accessory1.setDevice(device);
							list.add(accessory1);
						}
					}
					// creTypeserial
					if (deviceBean.getCreTypeserial() != null) {
						if (deviceBean.getCreTypeserial().length() > 3) {

							Accessories accessory2 = new Accessories();
							oldSerial = deviceBean.getCreTypeserial().replace(",", "");
							//newSerial = oldSerial.substring( 0, oldSerial.indexOf(","));
							accessory2.setSerial(oldSerial);
							accessory2.setAccessotyType("Credenza");
							accessory2.setDevice(device);
							list.add(accessory2);
						}

					}

					if (deviceBean.getFaxUnitSerialTypeSerialNo() != null) {
						if (deviceBean.getFaxUnitSerialTypeSerialNo().length() > 3) {
							Accessories accessory3 = new Accessories();
							
							oldSerial = deviceBean.getFaxUnitSerialTypeSerialNo().replace(",", "");
							//newSerial = oldSerial.substring( 0, oldSerial.indexOf(","));
							accessory3.setSerial(oldSerial);
							accessory3.setAccessotyType("Fax Unit");
							accessory3.setDevice(device);
							list.add(accessory3);
						}
					}

					if (deviceBean.getFinisherTypeSerialNo() != null) {
						if (deviceBean.getFinisherTypeSerialNo().length() > 3) {

							Accessories accessory4 = new Accessories();
							oldSerial = deviceBean.getFinisherTypeSerialNo().replace(",", "");
							//newSerial = oldSerial.substring( 0, oldSerial.indexOf(","));
							accessory4.setSerial(oldSerial);
							accessory4.setAccessotyType("Finisher");
							accessory4.setDevice(device);
							list.add(accessory4);
						}
					}

					if (deviceBean.getLtcTypeSerial() != null) {
						if (deviceBean.getLtcTypeSerial().length() > 3) {

							Accessories accessory5 = new Accessories();
							oldSerial = deviceBean.getLtcTypeSerial().replace(",", "");
							//newSerial = oldSerial.substring( 0, oldSerial.indexOf(","));
							accessory5.setSerial(oldSerial);
							accessory5.setAccessotyType("LCT");
							accessory5.setDevice(device);
							list.add(accessory5);
						}
					}

					if (deviceBean.getOneBinTrayTypeSerialNo() != null) {
						if (deviceBean.getOneBinTrayTypeSerialNo().length() > 3) {

							Accessories accessory6 = new Accessories();
							oldSerial = deviceBean.getOneBinTrayTypeSerialNo().replace(",", "");
							//newSerial = oldSerial.substring( 0, oldSerial.indexOf(","));
							accessory6.setSerial(oldSerial);
							accessory6.setAccessotyType("One Bin Tray");
							accessory6.setDevice(device);
							list.add(accessory6);
						}
					}
					if(deviceBean.getMachineType().length()>3 && deviceBean.getSerialNumberOtherAccessory().length()>3){
						List<String> accessoryType = new ArrayList<String>(Arrays.asList(deviceBean.getMachineType().split(",")));
						List<String> accessorySerial = new ArrayList<String>(Arrays.asList(deviceBean.getSerialNumberOtherAccessory().split(",")));
						for(int i =0;i<accessoryType.size();i++){
							for(int x=0;x<accessorySerial.size();x++){
								if(i==x){
									Accessories otherAccessorry = new Accessories();
									otherAccessorry.setAccessotyType(accessoryType.get(i));
									otherAccessorry.setSerial(accessorySerial.get(x));
									otherAccessorry.setDevice(device);
									list.add(otherAccessorry);
								}
							}
						}
					}
					retMessage = contactPersonDaoInt
							.saveContactPerson(contactPerson);
					if (retMessage.equalsIgnoreCase("OK")) {

						device.setContactPerson(contactPerson);
						if(deviceBean.getUpdateFlag()== "YES")
						{
							retMessage= updateDevice(device);
							if(retMessage.startsWith("Device " + device.getSerialNumber()
									+ " is successfully updated.")){
								if(list.size()>0){
									retAccessory = accessoriesDaoInt.saveAccessories(list);
									if (retAccessory.equalsIgnoreCase("Error")) {
										retMessage = "Device not inserted into the table "
												+ retAccessory+".";
									}
								}
							}
						}else if(deviceBean.getUpdateFlag()==null){
							retMessage = saveDevice(device);
							if(retMessage.startsWith("Device "+ device.getSerialNumber()+ " succefully added.")){
								retAccessory = accessoriesDaoInt.saveAccessories(list);
								if (retAccessory.equalsIgnoreCase("Error")) {
									retMessage = "Device not inserted into the table "
											+ retAccessory+".";
								}
							}
						}

					} else {
						retMessage = "Contact person cannot be captured"
								+ retMessage+".";
					}
				} else {
					retMessage = "Customer "
							+ customer.getCustomerName()
							+ " does not exist on database. Please make sure that the customer exist before assigning a device.";
				}
			}else{
				retMessage = accessoriesDaoInt.removeAccessory(deviceBean.getChkAccessories());
			}

		} catch (Exception e) {
			retMessage = e.getMessage();
		}
		return retMessage;
	}

	@Override
	public DeviceBean getAccessoriesForUpdate(Long recordID) {

		deviceBean = new DeviceBean();
		try {

			/*accessoryList = accessoriesDaoInt
					.getAccessoriesByDeviceSerial(serialNumber);
			for (Accessories access : accessoryList) {
				if (access.getDevice().getSerialNumber().equalsIgnoreCase(serialNumber)) {
					if (access.getAccessotyType().equalsIgnoreCase(
							"Bridge Unit")) {
						deviceBean.setBridgeUnitSerialTypeSerialNo(access
								.getSerial());
						;
					} else if (access.getAccessotyType().equalsIgnoreCase(
							"Fax Unit")) {
						deviceBean.setFaxUnitSerialTypeSerialNo(access
								.getSerial());
					} else if (access.getAccessotyType().equalsIgnoreCase(
							"Credenza")) {
						deviceBean.setCreTypeserial(access.getSerial());
					} else if (access.getAccessotyType().equalsIgnoreCase(
							"Finisher")) {
						deviceBean.setFinisherTypeSerialNo(access.getSerial());
					} else if (access.getAccessotyType().equalsIgnoreCase(
							"Additional Paper Trays")) {
						deviceBean.setAddTypeserial(access.getSerial());
					} else if (access.getAccessotyType()
							.equalsIgnoreCase("LTC")) {
						deviceBean.setLtcTypeSerial(access.getSerial());
					} else if (access.getAccessotyType().equalsIgnoreCase(
							"One bin tray")) {
						deviceBean
								.setOneBinTrayTypeSerialNo(access.getSerial());
					}
				}
			}
		*/} catch (Exception e) {
			return null;
		}
		return deviceBean;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Device> getDeviceList(Integer offset, Integer maxResults,
			String clientName) {
		List<Device> dev = sessionFactory.openSession()
				.createCriteria(Device.class, clientName)
				.setFirstResult(offset != null ? offset : 0)
				.setMaxResults(maxResults != null ? maxResults : 10).list();
		return dev;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Device> getDeviceListByClientName(String clientName) {
		String name = clientName;
		try {

			aList = new ArrayList<Object>();
			productList = new ArrayList<Device>();
			Criteria criteria = sessionFactory.getCurrentSession()
					.createCriteria(Device.class);
			aList.addAll(criteria.list());
			for (Object pro : aList) {
				if (pro instanceof Device) {
					if (((Device) pro).getCustomerDevice().getCustomerName() != null
							&& ((Device) pro).getCustomerDevice().getCustomerName()
									.startsWith(name)) {
						productList.add((Device) pro);
						customer = ((Device) pro).getCustomerDevice();
					}
				}
			}
		} catch (Exception e) {
			return null;
		}
		return productList;
	}

	@Override
	public Integer count() {
		return (Integer) sessionFactory.getCurrentSession()
				.createCriteria(Customer.class)
				.setProjection(Projections.rowCount()).uniqueResult();
	}

	@Override
	public String[] getSerials() {
		List<Device> list = null;
		ArrayList<String> newList = null;
		String array[] = null;
		try {
			list = getDeviceList();
			newList = new ArrayList<String>();

			for (Device device : list) {
				newList.add(device.getSerialNumber());
			}

			array = new String[newList.size()];

			for (int i = 0; i < newList.size(); i++) {
				array[i] = newList.get(i);
			}
		} catch (Exception e) {
			e.getMessage();
		}
		return array;
	}

}
