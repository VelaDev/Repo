package com.demo.dao;

import java.util.List;

import com.demo.model.Employee;

public interface EmployeeDaoInt {
	
	String saveEmployee(Employee employee);
	Employee getEmployeeByEmpNum(String empUsername);
	List<Employee> getAllTechnicians();
	List<Employee>getTechniciansByProvince(String province);

}
