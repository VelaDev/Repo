package com.demo.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

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
	String retMessage = null;
	private Employee emp = null;
	
	public String saveEmployee(Employee employee) {
		String password = "";
		
		try{
			  employee.setFirstTimeLogin(true);
			  employee.setStatus("ACTIVE");
			  password = generatePassword();
			  employee.setPassword(password);
		      sessionFactory.getCurrentSession().save(employee);
		      JavaMail.sendPasswordToEmployee(employee);
		      retMessage = "Employee"+ " "+ employee.getFirstName()+" "+ employee.getLastName()+ " " + "is successfully added";
		}
		catch(Exception e)
		{
			retMessage = "Employee"+ " "+ employee.getFirstName()+" "+ employee.getLastName()+ " " + "is not added\n" + e.getMessage();
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

	@SuppressWarnings("unchecked")
	@Override
	public List<Employee> getAllEmployees() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Employee.class);
		return (List<Employee>)criteria.list();
	}

	@Override
	public String updateEmployee(Employee employee) {
		try{
			
			sessionFactory.getCurrentSession().update(employee);
		      retMessage = "Employee"+ " "+ employee.getFirstName()+" "+ employee.getLastName()+ " " + "is successfully updated";
		}
		catch(Exception e){
			retMessage = "Employee"+ " "+ employee.getFirstName()+" "+ employee.getLastName()+ " " + "is not updated\n" + e.getMessage();
		}
		return retMessage;
	}
	private String generatePassword(){
		String retPassword = null;
		Random random = new Random();
		try{
			String text = "VeLaPhAnDa", text1 = "EmPlOYeEs",text2 = "PaSsWoRd",text3= "GeNeRaToRFroMAToZ",text4 = "CqXxHkB",text5 = "1234567890",specialCaractors ="!@#$%^&*";
	    	
	    	
	    	int select = random.nextInt(text.length());
	    	int select1 = random.nextInt(text1.length());
	    	int select2 = random.nextInt(specialCaractors.length());
	    	int select3 = random.nextInt(text3.length());
	    	int select4 = random.nextInt(text5.length());
	    	int select5 = random.nextInt(text5.length());
	    	int select6 = random.nextInt(text2.length());
	    	retPassword ="V"+text.charAt(select)+ text1.charAt(select1)+ specialCaractors.charAt(select2)+ text3.charAt(select3)+text5.charAt(select5)+text4.charAt(select4)+text2.charAt(select6);
			
		}catch(Exception e){
			retPassword = "DaNIy$D2b";
		}
		return retPassword;
	}

	@Override
	public String changePassword(String email, String password) {
		String passworChange = "";
		try{
			 emp = getEmployeeByEmpNum(email);
			 if(emp != null){
				 emp.setPassword(password);
				 emp.setFirstTimeLogin(false);
				 passworChange = updateEmployee(emp);
				 retMessage= "Password successfully changed";
			 }
		}catch(Exception e){
			retMessage = "Password not changed "+ e.getMessage();
		}
		return retMessage;
	}

	@Override
	public String changePassword(String email) {
		String passworChange = "";
		try
		{
			emp = getEmployeeByEmpNum(email);
			if(emp!= null){
				String tempPassword = generatePassword();
				emp.setPassword(tempPassword);
				emp.setFirstTimeLogin(true);
				passworChange = updateEmployee(emp);
				JavaMail.sendPasswordToEmployee(emp);
				retMessage = "Temp password for employee "+ emp.getFirstName() +" "+ emp.getLastName()+ " is "+ tempPassword+".\nTemp password is sent to employee through email.";
			}
			
		}catch (Exception e) {
			retMessage = "Password not reseted "+ e.getMessage();
		}
		return retMessage;
	}
}
