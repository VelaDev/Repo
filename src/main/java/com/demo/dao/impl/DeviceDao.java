package com.demo.dao.impl;

import java.sql.Date;
import java.util.ArrayList;
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
						+ " is succefully added. The device belongs to customer : "
						+ device.getCustomer().getCustomerName();

			}else{
				retMessage = "Device "+ localdevice.getSerialNumber()+ "is already assigned to customer " +localdevice.getCustomer().getCustomerName()+". One device canot be assigned twice to a customer ";
			}
		} catch (Exception e) {
			retMessage = "Device " + device.getSerialNumber()
					+ " is not added\n" + e.getMessage();
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
					+ device.getCustomer().getCustomerName();
		} catch (Exception e) {
			retMessage = "Device " + device.getSerialNumber()
					+ " is not updated\n" + e.getMessage();
		}
		return retMessage;
	}

	@Override
	public String prepareDeviceData(DeviceBean deviceBean) {
		// Purpose : This method prepares the device data before inserting into
		// the table
		String[] split;
		String retAccessory = null;
		customer = new Customer();
		contactPerson = new DeviceContactPerson();
		device = new Device();
		try {

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
				device.setCustomer(customer);

				list = new ArrayList<Accessories>();
				Accessories accessory = new Accessories();
				// addTypeserial
				if (deviceBean.getAddTypeserial() != null) {
					if (deviceBean.getAddTypeserial().length() > 0) {

						accessory.setSerial(deviceBean.getAddTypeserial());
						accessory.setAccessotyType("Additional Paper Trays");
						accessory.setDevice(device);
						list.add(accessory);
					}
				}
				if (deviceBean.getBridgeUnitSerialTypeSerialNo() != null) {
					if (deviceBean.getBridgeUnitSerialTypeSerialNo().length() > 0) {

						Accessories accessory1 = new Accessories();
						accessory1.setSerial(deviceBean
								.getBridgeUnitSerialTypeSerialNo());
						accessory1.setAccessotyType("Bridge Unit");
						accessory1.setDevice(device);
						list.add(accessory1);
					}
				}
				// creTypeserial
				if (deviceBean.getCreTypeserial() != null) {
					if (deviceBean.getCreTypeserial().length() > 0) {

						Accessories accessory2 = new Accessories();
						accessory2.setSerial(deviceBean.getCreTypeserial());
						accessory2.setAccessotyType("Credenza");
						accessory2.setDevice(device);
						list.add(accessory2);
					}

				}

				if (deviceBean.getFaxUnitSerialTypeSerialNo() != null) {
					if (deviceBean.getFaxUnitSerialTypeSerialNo().length() > 0) {
						Accessories accessory3 = new Accessories();
						accessory3.setSerial(deviceBean
								.getFaxUnitSerialTypeSerialNo());
						accessory3.setAccessotyType("Fax Unit");
						accessory3.setDevice(device);
						list.add(accessory3);
					}
				}

				if (deviceBean.getFinisherTypeSerialNo() != null) {
					if (deviceBean.getFinisherTypeSerialNo().length() > 0) {

						Accessories accessory4 = new Accessories();
						accessory4.setSerial(deviceBean
								.getFinisherTypeSerialNo());
						accessory4.setAccessotyType("Finisher");
						accessory4.setDevice(device);
						list.add(accessory4);
					}
				}

				if (deviceBean.getLtcTypeSerial() != null) {
					if (deviceBean.getLtcTypeSerial().length() > 0) {

						Accessories accessory5 = new Accessories();
						accessory5.setSerial(deviceBean.getLtcTypeSerial());
						accessory5.setAccessotyType("LTC");
						accessory5.setDevice(device);
						list.add(accessory5);
					}
				}

				if (deviceBean.getOneBinTrayTypeSerialNo() != null) {
					if (deviceBean.getOneBinTrayTypeSerialNo().length() > 0) {

						Accessories accessory6 = new Accessories();
						accessory6.setSerial(deviceBean
								.getOneBinTrayTypeSerialNo());
						accessory6.setAccessotyType("One bin tray");
						accessory6.setDevice(device);
						list.add(accessory6);
					}
				}

				retMessage = contactPersonDaoInt
						.saveContactPerson(contactPerson);
				if (retMessage.equalsIgnoreCase("OK")) {

					device.setContactPerson(contactPerson);
					if(deviceBean.getUpdateFlag()== "YES")
					{
						retMessage= updateDevice(device);
					}else if(deviceBean.getUpdateFlag()==null){
						retMessage = saveDevice(device);
					}
					
					retAccessory = accessoriesDaoInt.saveAccessories(list);
					if (retAccessory.equalsIgnoreCase("Error")) {
						retMessage = "Device not inserted into the table "
								+ retAccessory;
					}

				} else {
					retMessage = "Contact person cannot be captured"
							+ retMessage;
				}
			} else {
				retMessage = "Customer "
						+ customer.getCustomerName()
						+ " does not exist on database. Please make sure that the customer exist before assigning a device";
			}

		} catch (Exception e) {
			retMessage = e.getMessage();
		}

		return retMessage;
	}

	@Override
	public DeviceBean getAccessoriesForUpdate(String serialNumber) {

		deviceBean = new DeviceBean();
		try {

			accessoryList = accessoriesDaoInt
					.getAccessoriesByDeviceSerial(serialNumber);
			for (Accessories access : accessoryList) {
				if (access.getDevice().getSerialNumber()
						.equalsIgnoreCase(serialNumber)) {
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
		} catch (Exception e) {
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
					if (((Device) pro).getCustomer().getCustomerName() != null
							&& ((Device) pro).getCustomer().getCustomerName()
									.startsWith(name)) {
						productList.add((Device) pro);
						customer = ((Device) pro).getCustomer();
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
