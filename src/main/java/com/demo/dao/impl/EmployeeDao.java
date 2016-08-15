package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.EmployeeDaoInt;
import com.demo.model.Employee;


@Repository("employeeDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class EmployeeDao implements EmployeeDaoInt{


	@Autowired
	private SessionFactory sessionFactory;
	
	
	public String saveEmployee(Employee employee) {
		String retMessage = null;
		try{
		sessionFactory.getCurrentSession().save(employee);
		retMessage = "Employee"+ " "+ employee.getUsername()+ " " + "is successfully added";
		}
		catch(Exception e)
		{
			retMessage = "Employee"+ " "+ employee.getUsername()+ " " + "is not added";
		}
		return retMessage;
	}

	public Employee getEmployeeByEmpNum(String empUsername) {


		return (Employee) sessionFactory.getCurrentSession().get(Employee.class, empUsername);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Employee> getAllTechnicians() {
		@SuppressWarnings("rawtypes")
		ArrayList<?> aList = new ArrayList();
		ArrayList<Employee> empList = new ArrayList<Employee>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Employee.class);
		 
		 aList.addAll(criteria.list());
		 for(Object emp:aList)
		 {
			 if(emp instanceof Employee){
				 if(((Employee) emp).getRole().equalsIgnoreCase("Technician")){
					 empList.add((Employee) emp);
				 }
			 }
		 }
		return empList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Employee> getTechniciansByProvince(String province) {
		
		@SuppressWarnings("rawtypes")
		ArrayList<?> aList = new ArrayList();
		ArrayList<Employee> empList = new ArrayList<Employee>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Employee.class);
		 
		 aList.addAll(criteria.list());
		 for(Object emp:aList)
		 {
			 if(emp instanceof Employee){
				 if(((Employee) emp).getRole().equalsIgnoreCase("Technician")){
					 empList.add((Employee) emp);
				 }
			 }
		 }
		return empList;
	}
}
