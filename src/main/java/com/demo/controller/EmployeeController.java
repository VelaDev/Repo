package com.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.EmployeeBean;
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
	String retMessage =null;
	ModelAndView model = null;
	
	
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
		String userName = employee.getUsername();
		String password = employee.getPassword();
		String retRole = null;
		
		employee = employeeService.getEmployeeByEmpNumber(employee.getUsername());
		
		if(employee != null){
			
			session.setAttribute("loggedInUser", employee.getUsername());
			model.addObject("loggedInUser", employee.getUsername());
			if(employee.getRole().equalsIgnoreCase("ADMIN") && employee.getUsername().equals(userName)&& employee.getPassword().equals(password)){
				
				retRole= "redirect:home";
			}
			else if(employee.getRole().equalsIgnoreCase("TECHNICIAN") && employee.getUsername().equals(userName)&& employee.getPassword().equals(password))
			{
				retRole= "redirect:technicianHome";
				
			}
			else if(employee.getRole().equalsIgnoreCase("USER") && employee.getUsername().equals(userName)&& employee.getPassword().equals(password))
			{
				retRole= "redirect:ticket";
			}
			else {
				System.out.println("Username or password incorrect");
			}
		}
		else{
			  retRole="redirect:error";
			  System.out.println("You are not registered to use the system. Consults Administrator");
		}
		return retRole;
	}
	
	
	@RequestMapping(value="home",method=RequestMethod.GET)
	public ModelAndView loadAdminPage() {
		
		ModelAndView model = new ModelAndView();
		model.addObject("orderList",ordersServiceInt.getOpenOrders());
		model.setViewName("home");
		return model;
		
	}
	
	@RequestMapping(value="registerEmployee",method=RequestMethod.GET)
	public ModelAndView loadAddEmployee() {
		
		ModelAndView model = new ModelAndView("registerEmployee");
		model.addObject("addEmployee", new EmployeeBean());
		model.setViewName("registerEmployee");
		
		return model;
		
	}
	@RequestMapping(value="addEmployee",method=RequestMethod.POST)
	public ModelAndView addEmployee(@ModelAttribute("addEmployee")Employee employee)
	{
		model = new ModelAndView();
		retMessage = employeeService.saveEmployee(employee);
		//model.addObject("client", retMessage);
		model.setViewName("redirect:home");
		return model;
	}
		
	@RequestMapping(value = {"technicianHome"})
    public ModelAndView displayLoggedTickets() {
		String user = (String) session.getAttribute("loggedInUser");
		ModelAndView model = new ModelAndView();
		model.addObject("technicianTickets", logTicketsServiceInt.getAssignedCallsToTechnician(user));
		model.setViewName("technicianHome");
		return model;
       
    }
	@RequestMapping(value="userHome",method=RequestMethod.GET)
	public ModelAndView loadUserPage() {
		
		ModelAndView model = new ModelAndView();
		model.setViewName("userHome");
		return model;
		
	}
}
