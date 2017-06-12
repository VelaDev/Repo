package com.demo.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.exception.JDBCConnectionException;
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
import com.demo.service.CredentialsServiceInt;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.LoginAttemptServiceInt;
import com.demo.service.TicketsServiceInt;
import com.demo.service.OrdersServiceInt;
import com.demo.service.UserLogDetailsServiceInt;

@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeServiceInt employeeServiceInt;
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
	private CredentialsServiceInt credentialsServiceInt;
	
	@Autowired
	private LoginAttemptServiceInt serviceInt;
	
	private List<PieChart> beanList = null;
	String retMessage =null;
	ModelAndView model = null;
	Employee userName = null;
	private UserLogDetails details;
	private Employee techName;
	
	private LoginAttempt loginAttempt;
	String retPage = null;
	Integer count = 1;

	
	
	
	@RequestMapping({"/login", "/"})
	public ModelAndView loadLogin()
	{
		model = new ModelAndView();
		details = new UserLogDetails();
		
		try{
		
			String sessioID = (String) session.getAttribute("sessionID");
			userLogDetailsServiceInt.updateTimeout(sessioID);
			session.invalidate();
		}catch(Exception e){
			e.getMessage();
		}
		model.setViewName("login");
		return model;
	}
	
	
	@RequestMapping(value="authenticate",method={ RequestMethod.POST,RequestMethod.GET})
	public ModelAndView authenticateLogin(@ModelAttribute("authenticate")Employee employee,@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout)
	{
		ModelAndView model = new ModelAndView();
		String userName = employee.getEmail();
		String password = employee.getPassword();
		long numberOfDays = 1L;
		
		employee = employeeService.getEmployeeByEmpNumber(employee.getEmail());
		password = PasswordEncrypt.encryptPassword(password);
		if(employee != null&& employee.getStatus().equalsIgnoreCase("ACTIVE")){
			session.setAttribute("loggedInUser", employee);
			String user= employee.getFirstName()+" " + employee.getLastName();
			String userEmail = employee.getEmail();
			session.setAttribute("user", user);
			session.setAttribute("userEmail", userEmail);
			
			
			if(employee.isFirstTimeLogin()==true && employee.getEmail().equals(userName)&& employee.getPassword().equals(password)){
				model.setViewName("changePassword");
			}else{
				
				numberOfDays = credentialsServiceInt.passwordDateDifference(userName);
				
				System.out.println("Number of days : "+numberOfDays);
				
				if(numberOfDays > 65 && numberOfDays <= 75){
					int noDays = (int) (75 - numberOfDays);
					String message = "Your password is about to expire in "+ noDays + " days, Please reset your password now.";
					model.addObject("message", message);
					model.setViewName("changePassword");
				}else if(numberOfDays >75){
					model.setViewName("passwordExpired");
				}
				else{
					model.addObject("loggedInUser", employee.getEmail());
					if(employee.getRole().equalsIgnoreCase("ADMIN")&& employee.getEmail().equals(userName)&& employee.getPassword().equals(password)||
							employee.getRole().equalsIgnoreCase("Manager") && employee.getEmail().equals(userName)&& employee.getPassword().equals(password)){
						String userSessionID =session.getId();
						
						session.setAttribute("sessionID", userSessionID);
						if(details !=null){
							userLogDetailsServiceInt.saveUserLogDetails(details);
						}
						model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(employee.getEmail()));
						model.addObject("openTickets", ticketsServiceInt.countOpenTickets());
						model.addObject("closedTickets", ticketsServiceInt.countClosedTickets());
						model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
						model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
						model.addObject("resolvedTickets",ticketsServiceInt.countResolvedTickets());
						model.addObject("bridgedTickets", ticketsServiceInt.countBridgedTickets());
						serviceInt.userLoggeIn(employee);
						model.setViewName("home");
					}
					else if(employee.getRole().equalsIgnoreCase("TECHNICIAN") && employee.getEmail().equals(userName)&& employee.getPassword().equals(password))
					{
						String userSessionID =session.getId();
						session.setAttribute("sessionID", userSessionID);
						System.out.println(userSessionID);
						if(details !=null){
							userLogDetailsServiceInt.saveUserLogDetails(details);
						}
						serviceInt.userLoggeIn(employee);
						model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(employee.getEmail()));
						model.addObject("shipment",	ordersServiceInt.shippedOrders(employee.getEmail()));						   
						model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(employee.getEmail()));
						model.addObject("technicianTickets", ticketsServiceInt.getOpenTicketsForTechnician(employee.getEmail()));
						model.setViewName("technicianHome");
						
					}
					else if(employee.getRole().equalsIgnoreCase("USER") && employee.getEmail().equals(userName)&& employee.getPassword().equals(password))
					{
						String userSessionID =session.getId();
						session.setAttribute("sessionID", userSessionID);
						System.out.println(userSessionID);
						if(details!=null){
							userLogDetailsServiceInt.saveUserLogDetails(details);
						}
						
						serviceInt.userLoggeIn(employee);
						model.setViewName("ticket");
					}else{
						
						
						loginAttempt = serviceInt.getEmployeeDetails(employee);
						serviceInt.upsertUserAttempt(loginAttempt);
						if(loginAttempt.getAttemptCount()==1){
							String attempMessage = "Invalid password.You have 2 attempts left";
							model.addObject("attempMessage", attempMessage);
							
							model.setViewName("loginattempted");
						}
						else if(loginAttempt.getAttemptCount()==2){
							String attempMessage = "Invalid password.You have 1 attempts left";
							model.addObject("attempMessage", attempMessage);
							model.setViewName("loginattempted");
						}
						else if(loginAttempt.getAttemptCount()>=3){
							String attempMessage = "Your account is blocked after "+ loginAttempt.getAttemptCount() + " wrong attempts. Please consult your manager for password reset";
							model.addObject("attempMessage", attempMessage);
							model.addObject("count", loginAttempt.getAttemptCount());
							
							model.setViewName("lastAttemptLogin");
						}
					}
				}
			
			}
			
		}else if(employee != null&& employee.getStatus().equalsIgnoreCase("BLOCKED")){
			//retRole= "redirect:loginattempted";
			model.addObject("attempMessage", "Your acount has been BLOCKED after 3 wrong attempts, please consult your manager for password reset");
			model.setViewName("loginattempted");
		}
		else{//retRole= "redirect:error";
			   model.setViewName("error");
		}
			
			
		return model;
	}
	
	
	@RequestMapping(value="home",method=RequestMethod.GET)
	public ModelAndView loadAdminPage() {
		
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			
			beanList = ticketsServiceInt.ticketsResults();
			model.addObject("ticketResults",beanList);
			model.addObject("openTickets", ticketsServiceInt.countOpenTickets());
			model.addObject("closedTickets", ticketsServiceInt.countClosedTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("bridgedTickets", ticketsServiceInt.countBridgedTickets());
			model.addObject("resolvedTickets",ticketsServiceInt.countResolvedTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("home");
		}
		else{
			model.setViewName("login");
		}
		return model;
	}
	//Search for technician
	@RequestMapping(value="searchtechnicianName")
	public ModelAndView searchTechnicianName(@RequestParam("technicianName") String technicianName) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());			
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			if(techName !=null){
				model.addObject("technicians",employeeServiceInt.getAllTechnicians());
				
			}else{
				model.addObject("errorRetMessage", "Technicain does not exist.");
			}
		model.setViewName("bootSite");
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
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());			
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
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
		String addEmployee = "addEmployee";
		//session.setAttribute("addEmployee", actionTakenAddEmployee);
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			retMessage = employeeService.saveEmployee(employee);
			if(retMessage.startsWith("Email")){
				String retErrorMessage = retMessage;
				model.addObject("retErrorMessage", retErrorMessage);
			}else{
				model.addObject("retMessage", retMessage);
			}
			model.addObject("addEmployee", addEmployee);
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("confirmations");
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
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("technicianTickets", ticketsServiceInt.getOpenTicketsForTechnician(userName.getEmail()));
			model.addObject("ticketCount",ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());			
			model.addObject("inboxCount",ordersServiceInt.technicianOrdersCount(userName.getEmail()));
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
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());			
			model.addObject("displayEmployees", employeeService.getAllEmployees());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
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
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			
			model.addObject("updateEmployee", new EmployeeBean());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
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
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());			
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
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
		String updateEmployee = "updateEmployee";
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
		
			retMessage = employeeService.updateEmployee(employee);
			model.addObject("retMessage", retMessage);
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());			
			model.addObject("updateEmployee", updateEmployee);
			model.setViewName("confirmations");
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
		model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
		model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
		model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());		
		model.setViewName("changePassword");
		
		return model;
	}
	@RequestMapping(value="changePasswords",method=RequestMethod.POST)
	public ModelAndView changePassword(@RequestParam("newpassword")String newpassword,@RequestParam("email")String email){
		model = new ModelAndView();
		retMessage = employeeService.changePassword(email, newpassword);
		
		
		if(retMessage.equalsIgnoreCase("OK")){
			retMessage = "Password successfully changed";
			model.addObject("retMessage", retMessage);
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());			
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("passwordchanged");
		}
		else{
			retMessage = "Password already used, please use another password";
			  model.addObject("retMessage", retMessage);
			   model.setViewName("changePassword");
		}
		
		return model;
	}
	
	@RequestMapping(value="searchEmployeeForPasswordReset")
	public ModelAndView searchEmployeeForPasswordReset(@RequestParam("email") String empName,@ModelAttribute Employee employee) {
		/*String resetPassword ="resetPassword";*/
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			employee = employeeService.getEmployeeByEmpNumber(empName);
		if(employee != null){
			
			model.addObject("employeeObject", employee);
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());			
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
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
	@RequestMapping(value="resetPassword",method=RequestMethod.POST)
	public ModelAndView resetPassword(@RequestParam("email")String email){
		String resetPassword = "resetPassword";
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			retMessage = employeeService.changePassword(email);
			model.addObject("retMessage", retMessage);
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());			
			model.addObject("resetPassword", resetPassword);
			model.setViewName("confirmations");
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
		model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
		model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
		model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
		model.setViewName("deactivateEmployee");
		
		return model;
	}
	@RequestMapping(value="searchEmployeeForDeactivation")
	public ModelAndView searchEmployeeForDeactivation(@RequestParam("email") String empName,@ModelAttribute Employee employee) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			employee = employeeService.getEmployeeByEmpNumber(empName);
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
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
		String deactivateEmployee ="deactivateEmployee";
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			retMessage = employeeService.deactivateEmployee(email);
			model.addObject("retMessage", retMessage);
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("deactivateEmployee", deactivateEmployee);
			model.setViewName("confirmations");
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
			model.addObject("awaitingSparesTickets", ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets", ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
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
	@RequestMapping(value="loginattempted",method=RequestMethod.GET)
	public ModelAndView loginAttempt( ) {
		
		model = new ModelAndView();
			
			model.setViewName("loginattempted");
		return model;
	}
	@RequestMapping(value="passwordchanged",method=RequestMethod.GET)
	public ModelAndView loginSuccess( ) {
		
		model = new ModelAndView();
			
			model.setViewName("passwordchanged");
		return model;
	}
	@RequestMapping(value="passwordExpired",method=RequestMethod.GET)
	public ModelAndView passwordExpired( ) {
		model = new ModelAndView();
			
			model.setViewName("passwordExpired");
		return model;
	}
	@RequestMapping(value="lastAttemptLogin",method=RequestMethod.GET)
	public ModelAndView lastAttemptLogin( ) {
		model = new ModelAndView();
			
			model.setViewName("lastAttemptLogin");
		return model;
	}
	@ExceptionHandler({JDBCConnectionException.class})
    public ModelAndView jdbConnectionException(Exception ex) {
        ModelAndView model = new ModelAndView("405");
 
        model.addObject("exception", ex.getMessage());
         
        return model;
    }
}
