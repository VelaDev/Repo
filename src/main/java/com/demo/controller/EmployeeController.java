package com.demo.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.CannotCreateTransactionException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.EmployeeBean;
import com.demo.bean.PieChart;
import com.demo.dao.impl.PasswordEncrypt;
import com.demo.model.Employee;
import com.demo.model.LoginAttempt;
import com.demo.model.UserLogDetails;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.LoginAttemptServiceInt;
import com.demo.service.TicketsServiceInt;
import com.demo.service.OrdersServiceInt;
import com.demo.service.UserLogDetailsServiceInt;

@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeServiceInt employeeService;
	@Autowired
	private HttpSession session;
	@Autowired
	private TicketsServiceInt ticketsServiceInt;
	@Autowired
	private OrdersServiceInt ordersServiceInt;
	@Autowired
	private UserLogDetailsServiceInt userLogDetailsServiceInt;
	
	@Autowired
	private LoginAttemptServiceInt serviceInt;
	
	private List<PieChart> beanList = null;
	String retMessage =null;
	ModelAndView model = null;
	Employee userName = null;
	private UserLogDetails details;
	
	private LoginAttempt loginAttempt;
	String retPage = null;
	Integer count = 1;

	
	
	
	@RequestMapping({"/login", "/"})
	public String loadLogin()
	{
		details = new UserLogDetails();
		
		try{
		
			String sessioID = (String) session.getAttribute("sessionID");
			userLogDetailsServiceInt.updateTimeout(sessioID);
			session.invalidate();
		}catch(Exception e){
			e.getMessage();
		}
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
		password = PasswordEncrypt.encryptPassword(password);
		if(employee != null&& employee.getStatus().equalsIgnoreCase("ACTIVE")){
			session.setAttribute("loggedInUser", employee);
			
			if(employee.isFirstTimeLogin()==true && employee.getEmail().equals(userName)&& employee.getPassword().equals(password)){
				retRole ="redirect:changePassword";
			}else{
				
				serviceInt.userLoggeIn(employee);
				model.addObject("loggedInUser", employee.getEmail());
				if(employee.getRole().equalsIgnoreCase("ADMIN")&& employee.getEmail().equals(userName)&& employee.getPassword().equals(password)||
						employee.getRole().equalsIgnoreCase("Manager") && employee.getEmail().equals(userName)&& employee.getPassword().equals(password)){
					String userSessionID =session.getId();
					session.setAttribute("sessionID", userSessionID);
					System.out.println(userSessionID);
					userLogDetailsServiceInt.saveUserLogDetails(details);
					retRole= "redirect:home";
				}
				else if(employee.getRole().equalsIgnoreCase("TECHNICIAN") && employee.getEmail().equals(userName)&& employee.getPassword().equals(password))
				{
					String userSessionID =session.getId();
					session.setAttribute("sessionID", userSessionID);
					System.out.println(userSessionID);
					userLogDetailsServiceInt.saveUserLogDetails(details);
					retRole= "redirect:technicianHome";
					
				}
				else if(employee.getRole().equalsIgnoreCase("USER") && employee.getEmail().equals(userName)&& employee.getPassword().equals(password))
				{
					String userSessionID =session.getId();
					session.setAttribute("sessionID", userSessionID);
					System.out.println(userSessionID);
					userLogDetailsServiceInt.saveUserLogDetails(details);
					retRole= "redirect:ticket";
				}else{
					
					
					loginAttempt = serviceInt.getEmployeeDetails(employee);
					serviceInt.upsertUserAttempt(loginAttempt);
					retRole= "redirect:wrongpasswordoruser";
					
				}
			}
			
		}else if(employee != null&& employee.getStatus().equalsIgnoreCase("BLOCKED")){
			retRole= "redirect:login";
		}
		else{retRole= "redirect:error";
			System.out.print("No such user");
		}
			
			
		return retRole;
	}
	
	
	@RequestMapping(value="home",method=RequestMethod.GET)
	public ModelAndView loadAdminPage(Integer offset, Integer maxResults ) {
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			
			count = ticketsServiceInt.count();
			beanList = ticketsServiceInt.ticketsResults();
			model.addObject("home", ticketsServiceInt.getAllLoggedTickets(offset, maxResults));
			model.addObject("ticketResults",beanList);
			model.addObject("count",count);
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
		
			model.addObject("technicianTickets", ticketsServiceInt.getAssignedCallsToTechnician(userName.getEmail()));
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
	public ModelAndView displayEmployees(){
		model= new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			model.addObject("displayEmployees", employeeService.getAllEmployees());
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
	public ModelAndView searchEmployee(@RequestParam("email") String empName,@ModelAttribute Employee employee) {
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
	@RequestMapping(value ="resetPassword",method=RequestMethod.GET)
	public ModelAndView resetPassword(){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		model.addObject("employee", userName);
		model.setViewName("resetPassword");
		
		return model;
	}
	@RequestMapping(value ="changePassword",method=RequestMethod.GET)
	public ModelAndView loadChangePassword(){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		model.addObject("employee", userName);
		model.setViewName("changePassword");
		
		return model;
	}
	@RequestMapping(value="changePasswords")
	public String changePassword(@RequestParam("newpassword")String newpassword,@RequestParam("email")String email){
		retMessage = employeeService.changePassword(email, newpassword);
		
		String retValue= "redirect:login";
		return retValue;
	}
	
	@RequestMapping(value="searchEmployeeForPasswordReset")
	public ModelAndView searchEmployeeForPasswordReset(@RequestParam("email") String empName,@ModelAttribute Employee employee) {
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
		
		model.setViewName("resetPassword");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="resetPassword")
	public ModelAndView resetPassword(@RequestParam("email")String email){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			retMessage = employeeService.changePassword(email);
			model.addObject("retMessage", retMessage);
			model.setViewName("resetPassword");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value ="deactivateEmployee",method=RequestMethod.GET)
	public ModelAndView loadDeactivateEmployee(){
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		model.addObject("employee", userName);
		model.setViewName("deactivateEmployee");
		
		return model;
	}
	@RequestMapping(value="searchEmployeeForDeactivation")
	public ModelAndView searchEmployeeForDeactivation(@RequestParam("email") String empName,@ModelAttribute Employee employee) {
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
		
		model.setViewName("deactivateEmployee");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="deactivateEmp")
	public ModelAndView deactivateEmployee(@RequestParam("email")String email){
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			retMessage = employeeService.deactivateEmployee(email);
			model.addObject("retMessage", retMessage);
			model.setViewName("deactivateEmployee");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value = "/getEmployees", method = RequestMethod.GET)
	public @ResponseBody
	List<Employee> getEmployees(@RequestParam String empName) {

		return employeeService.getAllEmployees(empName);

	}
	@RequestMapping(value="searchEmployeeByNameForActivities")
	public ModelAndView searchEmployeeByNameForActivities(@RequestParam("email") String email,@ModelAttribute Employee employee) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			employee = employeeService.getEmployeeByEmpNumber(email);
		if(employee != null){
			
			model.addObject("loginUsers", userLogDetailsServiceInt.userActivities(email));
		}
		else{
			model.addObject("", null);
		}
		
		model.setViewName("userLoginActivities");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@ExceptionHandler({DataIntegrityViolationException.class})
    public ModelAndView dataIntegrity(Exception ex) {
        ModelAndView model = new ModelAndView("405");
 
        model.addObject("exception", ex.getMessage());
         
        return model;
    }
	@ExceptionHandler({SQLException.class})
    public ModelAndView handleIOException(Exception ex) {
        ModelAndView model = new ModelAndView("405");
 
        model.addObject("exception", ex.getMessage());
         
        return model;
    }
	@ExceptionHandler({CannotCreateTransactionException.class})
    public ModelAndView connectionIOException(Exception ex) {
        ModelAndView model = new ModelAndView("405");
 
        model.addObject("exception", ex.getMessage()+ ". Hint\nCheck database credentials.");
         
        return model;
    }
	@ExceptionHandler({NullPointerException.class})
    public ModelAndView NullPointerException(Exception ex) {
        ModelAndView model = new ModelAndView("405");
 
        model.addObject("exception", ex.getMessage());
         
        return model;
    }
	@RequestMapping(value="wrongpasswordoruser",method=RequestMethod.GET)
	public ModelAndView errorPage( ) {
		
		model = new ModelAndView();
			
			model.setViewName("wrongpasswordoruser");
		return model;
	}
	
	
}
