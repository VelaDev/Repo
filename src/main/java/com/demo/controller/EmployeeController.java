package com.demo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.EmployeeBean;
import com.demo.bean.PieChart;
import com.demo.bean.TicketsBean;
import com.demo.model.Device;
import com.demo.model.Employee;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.LogTicketsServiceInt;
import com.demo.service.OrdersServiceInt;

@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeServiceInt employeeService;
	@Autowired
	private HttpSession session;
	@Autowired
	private LogTicketsServiceInt logTicketsServiceInt;
	@Autowired
	private OrdersServiceInt ordersServiceInt;
	private List<PieChart> beanList = null;
	String retMessage =null;
	ModelAndView model = null;
	Employee userName = null;
	String retPage = null;
	
	
	
	@RequestMapping({"/login", "/"})
	public String loadLogin()
	{
		return "login";
	}
	
	
	@RequestMapping(value="authenticate",method={ RequestMethod.POST,RequestMethod.GET})
	public String authenticateLogin(@ModelAttribute("authenticate")Employee employee,@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout)
	{
		ModelAndView model = new ModelAndView();
		String userName = employee.getEmail();
		String password = employee.getPassword();
		String retRole = null;
		
		employee = employeeService.getEmployeeByEmpNumber(employee.getEmail());
		
		if(employee != null&& employee.isActive()==true){
			session.setAttribute("loggedInUser", employee);
			
			/*if(employee.isFirstTimeLogin()==true && employee.getEmail().equals(userName)&& employee.getPassword().equals(password)){
				retRole ="redirect:resertPassword";
			}else{*/
				model.addObject("loggedInUser", employee.getEmail());
				if(employee.getRole().equalsIgnoreCase("ADMIN") && employee.getEmail().equals(userName)&& employee.getPassword().equals(password)||
						employee.getRole().equalsIgnoreCase("Manager") && employee.getEmail().equals(userName)&& employee.getPassword().equals(password)){
					
					retRole= "redirect:home";
				}
				else if(employee.getRole().equalsIgnoreCase("TECHNICIAN") && employee.getEmail().equals(userName)&& employee.getPassword().equals(password))
				{
					retRole= "redirect:technicianHome";
					
				}
				else if(employee.getRole().equalsIgnoreCase("USER") && employee.getEmail().equals(userName)&& employee.getPassword().equals(password))
				{
					retRole= "redirect:ticket";
				}else{
					System.out.println("Username or password incorrect");
				}
			}
			
		//}
		/*else{
			
		}*/
			
			
		return retRole;
	}
	
	
	@RequestMapping(value="home",method=RequestMethod.GET)
	public ModelAndView loadAdminPage() {
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			
			beanList = logTicketsServiceInt.ticketsResults();
			model.addObject("ticketResults",beanList);
			model.setViewName("home");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value="registerEmployee",method=RequestMethod.GET)
	public ModelAndView loadAddEmployee() {
		
		userName = (Employee) session.getAttribute("loggedInUser");
		model = new ModelAndView("registerEmployee");
		if(userName !=null){
			
			model.addObject("addEmployee", new EmployeeBean());
			model.setViewName("registerEmployee");
		}
		else{
			model.setViewName("login");
		}
		
		
		return model;
		
	}
	@RequestMapping(value="addEmployee",method=RequestMethod.POST)
	public ModelAndView addEmployee(@ModelAttribute("addEmployee")Employee employee)
	{
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			retMessage = employeeService.saveEmployee(employee);
			model.addObject("retMessage", retMessage);
			model.setViewName("registerEmployee");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
		
	@RequestMapping(value = {"technicianHome"})
    public ModelAndView displayLoggedTickets() {

		 model = new ModelAndView();
		 userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			model.addObject("technicianTickets", logTicketsServiceInt.getAssignedCallsToTechnician(userName.getEmail()));
			model.setViewName("technicianHome");
			}
			else{
				model.setViewName("login");
			}
		return model;
       
    }
	@RequestMapping(value="userHome",method=RequestMethod.GET)
	public ModelAndView loadUserPage() {
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			model = new ModelAndView();
			
			model.setViewName("userHome");
		}
		else
		{
			model.setViewName("login");
			
		}
		 
		return model;
		
	}
	
	@RequestMapping(value="displayEmployees",method=RequestMethod.GET)
	public ModelAndView displayCustomers(){
		model= new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		 
			model.addObject("employeeList", employeeService.getAllEmployees());
			model.setViewName("displayEmployees");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="updateEmployee",method=RequestMethod.GET)
	public ModelAndView loadUpdateEmployee() {
		
		userName = (Employee) session.getAttribute("loggedInUser");
		model = new ModelAndView("registerEmployee");
		if(userName !=null){
			
			model.addObject("updateEmployee", new EmployeeBean());
			model.setViewName("updateEmployee");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value="searchEmployeeByName")
	public ModelAndView searchEmployee(@RequestParam("empName") String empName,@ModelAttribute Employee employee) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			employee = employeeService.getEmployeeByEmpNumber(empName);
		if(employee != null){
			
			model.addObject("employeeObject", employee);
		}
		else{
			model.addObject("", null);
		}
		
		model.setViewName("updateEmployee");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="updateEmployee",method=RequestMethod.POST)
	public ModelAndView updateEmployee(@ModelAttribute("updateEmployee")Employee employee)
	{
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			retMessage = employeeService.updateEmployee(employee);
			model.addObject("retMessage", retMessage);
			model.setViewName("updateEmployee");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value ="resertPassword",method=RequestMethod.GET)
	public ModelAndView resetPassword(){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		model.addObject("employee", userName);
		model.setViewName("resertPassword");
		
		return model;
	}
}
