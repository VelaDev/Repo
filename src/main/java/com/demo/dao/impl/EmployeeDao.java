package com.demo.dao.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.CredentialsDaoInt;
import com.demo.dao.EmployeeDaoInt;
import com.demo.model.Credentials;
import com.demo.model.Customer;
import com.demo.model.Employee;
import com.demo.model.Tickets;


@Repository("employeeDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class EmployeeDao implements EmployeeDaoInt{


	@Autowired
	private SessionFactory sessionFactory;
	
	@Autowired
	private CredentialsDaoInt credentialsDaoInt;
	String retMessage = null;
	private Employee emp = null;
	private List<Employee> empEmail = null;
	private List<Employee> empEmailReturn;
	private String encryptPassword ="";
	private Credentials credential = null;
	
	private Calendar cal = Calendar.getInstance();
	private DateFormat dateFormat = null;
	private Date date = null;
	
	public String saveEmployee(Employee employee) {
		String password = "";
		
		try{
			  employee.setFirstTimeLogin(true);
			  employee.setStatus("ACTIVE");
			  password = generatePassword();
			  encryptPassword = PasswordEncrypt.encryptPassword(password);
			  employee.setPassword(encryptPassword);
			  
		      sessionFactory.getCurrentSession().save(employee);
		      credential = getUserCredentials(employee);
		      credentialsDaoInt.saveNewPassword(credential);
		      
		      
		      JavaMail.sendPasswordToEmployee(employee,password);
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
	public List<Employee> getAllEmployees(Integer offset, Integer maxResults) {
		return sessionFactory.openSession()
			    .createCriteria(Employee.class)
			    .setFirstResult(offset!=null?offset:0)
			    .setMaxResults(maxResults!=null?maxResults:10)
			    .list();
	}

	@Override
	public String updateEmployee(Employee updateEmployee) {
		Employee tempEmp = new Employee();
		try{
			
			tempEmp = getEmployeeByEmpNum(updateEmployee.getEmail());
			String pass = tempEmp.getPassword();
			String cellNumber = updateEmployee.getCellNumber();
			tempEmp.setPassword(pass);
			tempEmp.setStatus("ACTIVE");
			tempEmp.setCellNumber(cellNumber);
			tempEmp.setEmail(updateEmployee.getEmail());
			tempEmp.setFirstName(updateEmployee.getFirstName());
			tempEmp.setGender(updateEmployee.getGender());
			tempEmp.setLastName(updateEmployee.getLastName());
			tempEmp.setRole(updateEmployee.getRole());
			tempEmp.setTitle(updateEmployee.getTitle());
			System.out.println(tempEmp.getCellNumber());
			  sessionFactory.getCurrentSession().update(tempEmp);
		      retMessage = "Employee"+ " "+ tempEmp.getFirstName()+" "+ tempEmp.getLastName()+ " " + "is successfully updated";
		}
		catch(Exception e){
			retMessage = "Employee"+ " "+ tempEmp.getFirstName()+" "+ tempEmp.getLastName()+ " " + "is not updated\n" + e.getMessage();
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
				 passworChange = PasswordEncrypt.encryptPassword(password);
				 emp.setPassword(passworChange);
				 emp.setFirstTimeLogin(false);
				 emp.setStatus("ACTIVE");
				 sessionFactory.getCurrentSession().update(emp);
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
				encryptPassword = PasswordEncrypt.encryptPassword(tempPassword);
				emp.setPassword(encryptPassword);
				emp.setFirstTimeLogin(true);
				emp.setStatus("ACTIVE");
			/*	passworChange = updateEmployee(emp);*/
				sessionFactory.getCurrentSession().update(emp);
				JavaMail.sendPasswordToEmployee(emp,tempPassword);
				retMessage = "Temp password for employee "+ emp.getFirstName() +" "+ emp.getLastName()+ " is "+ tempPassword+".\nTemp password is sent to employee through email.";
			}
			
		}catch (Exception e) {
			retMessage = "Password not reseted "+ e.getMessage();
		}
		return retMessage;
	}

	@Override
	public Integer count() {
		
		return (Integer) sessionFactory.getCurrentSession().createCriteria(Employee.class).setProjection(Projections.rowCount()).uniqueResult();
		
	}

	@Override
	public String deactivateEmployee(String email) {
		String localRetMessage = null;
		try{
			
			emp = getEmployeeByEmpNum(email);
			if(emp != null && emp.getStatus().equalsIgnoreCase("ACTIVE")){
				emp.setStatus("INACTIVE");
				localRetMessage = updateActivateDeactivate(emp);
				retMessage ="Employee "+ " "+ emp.getFirstName()+" "+ emp.getLastName()+ " is deactivated" ;
			}
			else {
				emp.setStatus("ACTIVE");
				localRetMessage = updateActivateDeactivate(emp);
				retMessage ="Employee "+ " "+ emp.getFirstName()+" "+ emp.getLastName()+ " is activated" ;
			}
		}catch(Exception e){
			retMessage = "Employee "+ emp.getFirstName()+" "+ emp.getLastName()+" "+ "is not deactivated";
		}
		
		return retMessage;
	}

	@Override
	public List<Employee> getAllEmployees(String email) {
		empEmailReturn = new ArrayList<Employee>();
		try{
			empEmail = getAllEmployees();
			for(Employee emp:empEmail){
				if(emp.getEmail().contains(email)){
					empEmailReturn.add(emp);
				}
			}
			
		}catch(Exception e){
			
		}
		return empEmailReturn;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Employee> getAllEmployees() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Employee.class);
		return (List<Employee>)criteria.list();
	}

	@Override
	public List<Employee> getAllManagers() {
		@SuppressWarnings("rawtypes")
		ArrayList<?> aList = new ArrayList();
		ArrayList<Employee> empList = new ArrayList<Employee>();
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Employee.class);
		 
		 aList.addAll(criteria.list());
		 for(Object emp:aList)
		 {
			 if(emp instanceof Employee){
				 if(((Employee) emp).getRole().equalsIgnoreCase("Manager")){
					 empList.add((Employee) emp);
				 }
			 }
		 }
		return empList;
	}
	
	private String updateActivateDeactivate(Employee employee)
	{
		sessionFactory.getCurrentSession().update(employee);
		retMessage = "OK";
		return retMessage;
	}
	
	private Credentials getUserCredentials(Employee employee){
		Credentials credential = null;
		dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		date = new Date();
		
		try{
			credential = new Credentials();
			credential.setPassword(employee.getPassword());
			credential.setEmployee(employee);
			credential.setStatus("Current");
			credential.setPasswordDateInserted(dateFormat.format(date));
		}catch(Exception e){
			e.getMessage();
		}
		return credential;
		
	}
}
