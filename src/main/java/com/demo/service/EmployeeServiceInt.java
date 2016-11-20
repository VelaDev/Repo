package com.demo.service;

import java.util.List;

import com.demo.model.Employee;

public interface EmployeeServiceInt {
	String saveEmployee(Employee employee);
	Employee getEmployeeByEmpNumber(String empUsername);
	List<Employee> getAllTechnicians();
	List<Employee> getAllEmployees();
	String updateEmployee (Employee employee);
	String changePassword(String email, String password);
	String changePassword(String email);

}
