package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.bean.CustomerBean;
import com.demo.dao.CustomerDaoInt;
import com.demo.dao.CustomerContactDetailsDaoInt;
import com.demo.model.Customer;
import com.demo.model.CustomerContactDetails;


@Repository("clientDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class CustomerDao implements CustomerDaoInt {

	@Autowired
	private SessionFactory sessionFactory;

	@Autowired
	private CustomerContactDetailsDaoInt customerContactDetailsDaoIntDaoInt;

	private String retMessage = null;
	List<Customer> clientList = null;
	Customer customer = null;

	@Override
	public Customer getClientByClientName(String clientName) {
		return (Customer) sessionFactory.getCurrentSession().get(
				Customer.class, clientName);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Customer> getClientList(Integer offset, Integer maxResults) {

		return sessionFactory.openSession().createCriteria(Customer.class)
				.setFirstResult(offset != null ? offset : 0)
				.setMaxResults(maxResults != null ? maxResults : 10).list();
	}

	@Override
	public String saveCustomer(CustomerBean customerBean) {

		CustomerContactDetails contactDetails, contactDetails1 = null;
		List<CustomerContactDetails> list = null;
		Customer tempCustomer = new Customer();
		try {

			customer = getClientByClientName(customerBean.getCustomerName());
			if (customer == null) {

				// Customer Object
				tempCustomer.setActive(true);
				tempCustomer.setCity_town(customerBean.getCity_town());
				tempCustomer.setCustomerName(customerBean.getCustomerName());
				tempCustomer.setEmail(customerBean.getEmail());
				tempCustomer.setFaxNumber(customerBean.getFaxNumber());
				tempCustomer.setProvince(customerBean.getProvince());
				tempCustomer.setStreetName(customerBean.getStreetName());
				tempCustomer.setStreetNumber(customerBean.getStreetNumber());
				tempCustomer.setContactEmail(customerBean.getContactEmail());
				
				tempCustomer.setTelephoneNumber(customerBean
						.getTelephoneNumber());
				tempCustomer.setZipcode(customerBean.getZipcode());

				list = new ArrayList<CustomerContactDetails>();

				// Required contact person object
				contactDetails = new CustomerContactDetails();
				contactDetails.setContactCellNumber(customerBean
						.getContactCellNumber());
				contactDetails.setContactTelephoneNumber(customerBean
						.getContactTelephoneNumber());
				contactDetails.setContactEmail(customerBean.getContactEmail());
				contactDetails.setFirstName(customerBean.getFirstName());
				contactDetails.setLastName(customerBean.getLastName());
				contactDetails.setCustomerContactDetails(tempCustomer);
				list.add(contactDetails);

				// Optional contact person object
				if (customerBean.getFirstName1() != null
						&& customerBean.getFirstName1().length() > 0) {
					contactDetails1 = new CustomerContactDetails();
					contactDetails1.setContactCellNumber(customerBean
							.getContactCellNumber1());
					contactDetails1.setContactEmail(customerBean
							.getContactEmail1());
					contactDetails1.setFirstName(customerBean.getFirstName1());
					contactDetails1.setLastName(customerBean.getLastName1());
					contactDetails1.setContactTelephoneNumber(customerBean
							.getContactTelephoneNumber1());
					contactDetails1.setCustomerContactDetails(tempCustomer);
					list.add(contactDetails1);
				}
				sessionFactory.getCurrentSession().save(tempCustomer);
				customerContactDetailsDaoIntDaoInt.saveContactDetails(list);
				retMessage = "Customer " + tempCustomer.getCustomerName() + " "
						+ "successfully added.";
			} else {
				retMessage = "Customer " + customer.getCustomerName() + " "
						+ "already exist. Please add new customer with a different name.";
			}
		} catch (Exception e) {
			retMessage = "Customer " + customer.getCustomerName()
					+ " not added\n" + e.getMessage()+".";
		}

		return retMessage;
	}

	@Override
	public String updateCustomer(CustomerBean customerBean) {

		CustomerContactDetails contactDetails, contactDetails1 = null;
		List<CustomerContactDetails> list = null;
		Customer tempCustomer = new Customer();

		try {
			// Customer Object
			tempCustomer.setActive(true);
			tempCustomer.setCity_town(customerBean.getCity_town());
			tempCustomer.setCustomerName(customerBean.getCustomerName());
			tempCustomer.setEmail(customerBean.getEmail());
			tempCustomer.setFaxNumber(customerBean.getFaxNumber());
			tempCustomer.setProvince(customerBean.getProvince());
			tempCustomer.setStreetName(customerBean.getStreetName());
			tempCustomer.setStreetNumber(customerBean.getStreetNumber());
			tempCustomer.setTelephoneNumber(customerBean.getTelephoneNumber());
			tempCustomer.setContactEmail(customerBean.getContactEmail());			
			tempCustomer.setZipcode(customerBean.getZipcode());

			list = new ArrayList<CustomerContactDetails>();

			// Required contact person object
			contactDetails = new CustomerContactDetails();
			contactDetails.setContactCellNumber(customerBean
					.getContactCellNumber());
			contactDetails.setContactTelephoneNumber(customerBean
					.getContactTelephoneNumber());
			contactDetails.setContactEmail(customerBean.getContactEmail());
			contactDetails.setFirstName(customerBean.getFirstName());
			contactDetails.setLastName(customerBean.getLastName());
			contactDetails.setCustomerContactDetails(tempCustomer);
			list.add(contactDetails);

			// Optional contact person object
			if (customerBean.getFirstName1() != null
					&& customerBean.getFirstName1().length() > 0) {
				contactDetails1 = new CustomerContactDetails();
				contactDetails1.setContactCellNumber(customerBean
						.getContactCellNumber1());
				contactDetails1
						.setContactEmail(customerBean.getContactEmail1());
				contactDetails1.setFirstName(customerBean.getFirstName1());
				contactDetails1.setLastName(customerBean.getLastName1());
				contactDetails1.setContactTelephoneNumber(customerBean
						.getContactTelephoneNumber1());
				contactDetails1.setCustomerContactDetails(tempCustomer);
				list.add(contactDetails1);
			}

			sessionFactory.getCurrentSession().update(tempCustomer);
			retMessage = "Customer " + tempCustomer.getCustomerName()
					+ " successfully updated.";

			customerContactDetailsDaoIntDaoInt.saveContactDetails(list);
		} catch (Exception e) {
			retMessage = "Customer " + customer.getCustomerName()
					+ " not updated\n" + e.getMessage()+".";
		}
		return retMessage;
	}

	@Override
	public Integer count() {
		return (Integer) sessionFactory.getCurrentSession()
				.createCriteria(Customer.class)
				.setProjection(Projections.rowCount()).uniqueResult();

	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Customer> getClientList() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				Customer.class);
		return (List<Customer>) criteria.list();
	}

	@Override
	public CustomerBean contactDetails(String customerName) {
		CustomerBean returnCustomerContact = new CustomerBean();
		try {
			Customer customer = getClientByClientName(customerName);
			returnCustomerContact.setCustomerName(customer.getCustomerName());
			returnCustomerContact.setCity_town(customer.getCity_town());
			returnCustomerContact.setEmail(customer.getEmail());
			returnCustomerContact.setFaxNumber(customer.getFaxNumber());
			returnCustomerContact.setProvince(customer.getProvince());
			returnCustomerContact.setStreetName(customer.getStreetName());
			returnCustomerContact.setStreetNumber(customer.getStreetNumber());
			returnCustomerContact.setTelephoneNumber(customer
					.getTelephoneNumber());
			returnCustomerContact.setZipcode(customer.getZipcode());
		} catch (Exception ex) {

		}
		return returnCustomerContact;
	}

}
