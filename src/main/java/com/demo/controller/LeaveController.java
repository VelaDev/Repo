package com.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.LeaveBean;
import com.demo.model.Employee;
import com.demo.model.Leave;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.LeaveInt;
import com.demo.service.OrdersServiceInt;
import com.demo.service.TicketsServiceInt;

@Controller
public class LeaveController {

	@Autowired
	private OrdersServiceInt ordersServiceInt;
	@Autowired
	private HttpSession session;
	@Autowired
	private LeaveInt leaveInt;
	@Autowired
	private TicketsServiceInt ticketsServiceInt;
	@Autowired
	private EmployeeServiceInt employeeServiceInt;
	private ModelAndView model = null;
	private String retMessage = null;
	private Employee userName = null;
	private Employee tempEmployee = null;
	private String selectedDateRange;

	@RequestMapping(value = "leavemanagement", method = RequestMethod.GET)
	public ModelAndView displayleaveManagement() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		selectedDateRange = null;
		if (userName != null) {

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				model.addObject("countPendingLeave",
						leaveInt.countAllPendingLeave());
				model.addObject("countActiveLeave",
						leaveInt.countAllActiveLeave());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("dates", leaveInt.getLeaveDates());
				model.addObject("leaveList",
						leaveInt.getAllActiveAndPendingLeave());

				model.setViewName("leavemanagement");

			}

		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "techleavemanagement", method = RequestMethod.GET)
	public ModelAndView displayOrderTechManagement() {

		selectedDateRange = null;
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("countPendingLeave",
					leaveInt.getPendingLeaveCountByTechnician(userName.getEmail()));
			model.addObject("countActiveLeave",
					leaveInt.getActiveLeaveCountByTechnician(userName.getEmail()));
			model.addObject("dates", leaveInt.getLeaveDates());
			model.addObject("leaveList", leaveInt
					.activeAndPendingLeaveByTechnician(userName.getEmail()));

			model.setViewName("techleavemanagement");
		} else {
			model.setViewName("login");
		}
		return model;
	}
	
	@RequestMapping(value = "getTechnicianName1", method = RequestMethod.GET)
	public ModelAndView getTehnnicianName(
			@RequestParam("technicianName") String localTechnicianName) {
		tempEmployee = employeeServiceInt
				.getEmployeeByEmpNumber(localTechnicianName);

		model = new ModelAndView();
		selectedDateRange = null;

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				model.addObject("countPendingLeave", leaveInt
						.getPendingLeaveCountByTechnician(localTechnicianName));
				model.addObject("countActiveLeave", leaveInt
						.getActiveLeaveCountByTechnician(localTechnicianName));
				model.addObject("leaveList", leaveInt
						.activeAndPendingLeaveByTechnician(localTechnicianName));
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("selectedTechnician", tempEmployee);

				model.addObject("dates", ordersServiceInt.getDates());
				model.setViewName("leavemanagement");
			}
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "activeLeave", method = RequestMethod.GET)
	public ModelAndView activeLeave() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		
		if (userName != null) {

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (tempEmployee != null) {
					model.addObject("countPendingLeave", leaveInt
							.getPendingLeaveCountByTechnician(tempEmployee
									.getEmail()));
					model.addObject("countActiveLeave", leaveInt
							.getActiveLeaveCountByTechnician(tempEmployee
									.getEmail()));
					model.addObject("leaveList",
							leaveInt.getActiveLeaveByTechnician(tempEmployee
									.getEmail()));
					model.addObject("technicians",
							employeeServiceInt.getAllTechnicians());
					model.addObject("selectedTechnician", tempEmployee);
					model.addObject("newDate", selectedDateRange);
					model.addObject("dates", leaveInt.getLeaveDates());
					
					model.setViewName("leavemanagement");

				} else if (selectedDateRange != null) {
					model.addObject(
							"countPendingLeave",
							leaveInt.countpendingLeaveForSelectedDate(selectedDateRange));
					model.addObject("countActiveLeave", leaveInt
							.countActiveLeaveForSelectedDate(selectedDateRange));
					model.addObject("leaveList", leaveInt
							.getActiveLeaveForSelectedRange(selectedDateRange));
					model.addObject("technicians",
							employeeServiceInt.getAllTechnicians());
					model.addObject("dates", leaveInt.getLeaveDates());
					model.addObject("newDate", selectedDateRange);
					model.addObject("selectedTechnician", tempEmployee);
					model.setViewName("leavemanagement");
				} else {
					model.addObject("countPendingLeave",
							leaveInt.countAllPendingLeave());
					model.addObject("countActiveLeave",
							leaveInt.countAllActiveLeave());
					model.addObject("technicians",
							employeeServiceInt.getAllTechnicians());
					model.addObject("selectedTechnician", tempEmployee);
					model.addObject("leaveList", leaveInt.getActiveLeave());
					model.addObject("dates", leaveInt.getLeaveDates());
					model.addObject("newDate", selectedDateRange);
					model.setViewName("leavemanagement");

				}
			}
		  else if (userName.getRole().equalsIgnoreCase("Technician")){
			  	
				 if (selectedDateRange != null){
					 model.addObject(
								"countPendingLeave",
								leaveInt.countTechpendingLeaveForSelectedDate(selectedDateRange, userName.getEmail()));
						model.addObject("countActiveLeave", leaveInt
								.countTechActiveLeaveForSelectedDate(selectedDateRange, userName.getEmail()));			
						model.addObject("leaveList", leaveInt
								.getTechActiveLeaveForSelectedRange(selectedDateRange, userName.getEmail()));
						model.addObject("technicians",
								employeeServiceInt.getAllTechnicians());
						model.addObject("dates", leaveInt.getLeaveDates());
						model.addObject("newDate", selectedDateRange);
						model.setViewName("techleavemanagement"); 
				 }
				 else{
					    model.addObject("countPendingLeave",
								leaveInt.getPendingLeaveCountByTechnician(userName.getEmail()));
						model.addObject("countActiveLeave",
								leaveInt.getActiveLeaveCountByTechnician(userName.getEmail()));
						model.addObject("dates", leaveInt.getLeaveDates());
						model.addObject("leaveList", leaveInt
								.getActiveLeaveByTechnician(userName.getEmail()));

						model.setViewName("techleavemanagement");
				 }
		  }
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "pendingLeave", method = RequestMethod.GET)
	public ModelAndView pendingLeave() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		// selectedDateRange = null;
		if (userName != null) {

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (tempEmployee != null) {
					model.addObject("countPendingLeave", leaveInt
							.getPendingLeaveCountByTechnician(tempEmployee
									.getEmail()));
					model.addObject("countActiveLeave", leaveInt
							.getActiveLeaveCountByTechnician(tempEmployee
									.getEmail()));
					model.addObject("leaveList", leaveInt
							.getPendingLeaveByTechnician(tempEmployee
									.getEmail()));
					model.addObject("technicians",
							employeeServiceInt.getAllTechnicians());
					model.addObject("selectedTechnician", tempEmployee);
					model.addObject("newDate", selectedDateRange);
					model.addObject("dates", leaveInt.getLeaveDates());
					model.setViewName("leavemanagement");

				} else if (selectedDateRange != null) {
					model.addObject(
							"countPendingLeave",
							leaveInt.countpendingLeaveForSelectedDate(selectedDateRange));
					model.addObject("countActiveLeave", leaveInt
							.countActiveLeaveForSelectedDate(selectedDateRange));
					model.addObject("leaveList", leaveInt
							.getPendingLeaveForSelectedRange(selectedDateRange));
					model.addObject("technicians",
							employeeServiceInt.getAllTechnicians());
					model.addObject("dates", leaveInt.getLeaveDates());
					model.addObject("newDate", selectedDateRange);
					model.addObject("selectedTechnician", tempEmployee);
					model.setViewName("leavemanagement");
				} else {
					model.addObject("countPendingLeave",
							leaveInt.countAllPendingLeave());
					model.addObject("countActiveLeave",
							leaveInt.countAllActiveLeave());
					model.addObject("technicians",
							employeeServiceInt.getAllTechnicians());
					model.addObject("selectedTechnician", tempEmployee);
					model.addObject("dates", leaveInt.getLeaveDates());
					model.addObject("newDate", selectedDateRange);
					model.addObject("leaveList", leaveInt.getPendingLeaves());
					model.addObject("dates", leaveInt.getLeaveDates());
					model.setViewName("leavemanagement");

				}
			}
		 else if (userName.getRole().equalsIgnoreCase("Technician")){
			 
			 if (selectedDateRange != null){
				 model.addObject(
							"countPendingLeave",
							leaveInt.countTechpendingLeaveForSelectedDate(selectedDateRange, userName.getEmail()));
					model.addObject("countActiveLeave", leaveInt
							.countTechActiveLeaveForSelectedDate(selectedDateRange, userName.getEmail()));			
					model.addObject("leaveList", leaveInt
							.getTechPendingLeaveForSelectedRange(selectedDateRange, userName.getEmail()));
					model.addObject("technicians",
							employeeServiceInt.getAllTechnicians());
					model.addObject("dates", leaveInt.getLeaveDates());
					model.addObject("newDate", selectedDateRange);
					model.addObject("dates", leaveInt.getLeaveDates());
					model.setViewName("techleavemanagement"); 
			 }
			 else{
				    model.addObject("countPendingLeave",
							leaveInt.getPendingLeaveCountByTechnician(userName.getEmail()));
					model.addObject("countActiveLeave",
							leaveInt.getActiveLeaveCountByTechnician(userName.getEmail()));
					model.addObject("dates", leaveInt.getLeaveDates());
					model.addObject("leaveList", leaveInt
							.getPendingLeaveByTechnician(userName.getEmail()));
					model.addObject("dates", leaveInt.getLeaveDates());

					model.setViewName("techleavemanagement");
			 }
			 
			 }
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "leaveHistory", method = RequestMethod.GET)
	public ModelAndView leaveHistory() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (tempEmployee != null) {
					model.addObject("countPendingLeave", leaveInt
							.getPendingLeaveCountByTechnician(tempEmployee
									.getEmail()));
					model.addObject("countActiveLeave", leaveInt
							.getActiveLeaveCountByTechnician(tempEmployee
									.getEmail()));
					model.addObject("leaveList", leaveInt
							.getPendingLeaveByTechnician(tempEmployee
									.getEmail()));
					model.addObject("leaveList",
							leaveInt.getLeaveHistoryByTechician(tempEmployee
									.getEmail()));
					model.addObject("technicians",
							employeeServiceInt.getAllTechnicians());
					model.addObject("selectedTechnician", tempEmployee);
					model.addObject("dates", leaveInt.getLeaveDates());
					model.setViewName("leavemanagement");

				}

				else if (selectedDateRange != null) {
					model.addObject(
							"countPendingLeave",
							leaveInt.countpendingLeaveForSelectedDate(selectedDateRange));
					model.addObject("countActiveLeave", leaveInt
							.countActiveLeaveForSelectedDate(selectedDateRange));
					model.addObject("leaveList", leaveInt
							.getLeaveHistoryForSelectedRange(selectedDateRange));
					model.addObject("technicians",
							employeeServiceInt.getAllTechnicians());
					model.addObject("dates", leaveInt.getLeaveDates());
					model.addObject("newDate", selectedDateRange);
					model.setViewName("leavemanagement");

				} else {
					model.addObject("countPendingLeave",
							leaveInt.countAllPendingLeave());
					model.addObject("countActiveLeave",
							leaveInt.countAllActiveLeave());
					model.addObject("leaveList", leaveInt.leaveHistory());
					model.addObject("technicians",
							employeeServiceInt.getAllTechnicians());
					model.addObject("newDate", selectedDateRange);
					model.addObject("selectedTechnician", tempEmployee);
					model.addObject("dates", leaveInt.getLeaveDates());
					model.setViewName("leavemanagement");
				}
			}
			 else if (userName.getRole().equalsIgnoreCase("Technician")){
				  
				 if (selectedDateRange != null){
					 model.addObject(
								"countPendingLeave",
								leaveInt.countTechpendingLeaveForSelectedDate(selectedDateRange, userName.getEmail()));
						model.addObject("countActiveLeave", leaveInt
								.countTechActiveLeaveForSelectedDate(selectedDateRange, userName.getEmail()));			
						model.addObject("leaveList", leaveInt
								.getTechLeaveHistoryForSelectedRange(selectedDateRange, userName.getEmail()));
						model.addObject("technicians",
								employeeServiceInt.getAllTechnicians());
						model.addObject("dates", leaveInt.getLeaveDates());
						model.addObject("newDate", selectedDateRange);
						model.setViewName("techleavemanagement"); 
				 }
				 else{
					    model.addObject("countPendingLeave",
								leaveInt.getPendingLeaveCountByTechnician(userName.getEmail()));
						model.addObject("countActiveLeave",
								leaveInt.getActiveLeaveCountByTechnician(userName.getEmail()));
						model.addObject("dates", leaveInt.getLeaveDates());
						model.addObject("leaveList", leaveInt
								.getLeaveHistoryByTechician(userName.getEmail()));

						model.setViewName("techleavemanagement");
				 }
				 
				 }

		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "leave", "requestLeave", "userMakeLeave" }, method = RequestMethod.GET)
	public ModelAndView loadLeave() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");

		if (userName != null) {

			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));

			model.addObject("makeLeave", new LeaveBean());

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.setViewName("requestLeave");

			} else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.technicianOrdersCount(userName.getEmail()));
				model.setViewName("leave");

			} else if (userName.getRole().equalsIgnoreCase("User")) {
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.technicianOrdersCount(userName.getEmail()));
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.setViewName("userMakeLeave");
			}

		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "viewLeaveRequests", "viewRequestedLeave",
			"viewRequestedUserLeave" }, method = RequestMethod.GET)
	public ModelAndView loadViewLeaveRequestss() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				model.addObject("leaveList", leaveInt.leaveRequests());
				model.setViewName("viewRequestedLeave");

			} else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("inboxCount", ordersServiceInt
						.technicianOrdersCount(userName.getEmail()));
				model.addObject("leaveList",
						leaveInt.leaveRequests(userName.getEmail()));
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.setViewName("viewLeaveRequests");

			} else if (userName.getRole().equalsIgnoreCase("User")) {
				model.addObject("inboxCount", ordersServiceInt
						.technicianOrdersCount(userName.getEmail()));
				model.addObject("leaveList",
						leaveInt.leaveRequests(userName.getEmail()));
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.setViewName("viewRequestedUserLeave");
			}

		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "updateLeave", "updateMakeLeave",
			"updateUserMakeLeave" }, method = RequestMethod.GET)
	public ModelAndView loadUpdateLeave(@RequestParam("leaveID") int leaveID,
			@ModelAttribute("updateLeave") Leave leave) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("updateLeave", new LeaveBean());
			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				model.addObject("leave", leaveInt.getLeave(leaveID));
				model.setViewName("updateMakeLeave");

			} else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("inboxCount", ordersServiceInt
						.technicianOrdersCount(userName.getEmail()));
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("leave", leaveInt.getLeave(leaveID));
				model.setViewName("updateLeave");

			} else if (userName.getRole().equalsIgnoreCase("User")) {
				model.addObject("inboxCount", ordersServiceInt
						.technicianOrdersCount(userName.getEmail()));
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("leave", leaveInt.getLeave(leaveID));
				model.setViewName("updateUserMakeLeave");
			}

		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "makeLeave", "userMakeLeave" }, method = RequestMethod.POST)
	public ModelAndView submitLeave(@ModelAttribute("makeLeave") LeaveBean leave) {
		model = new ModelAndView();
       
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			retMessage = leaveInt.leaveRequest(leave);
			if (retMessage.startsWith("K")) {
				String retErrorMessage = retMessage;
				model.addObject("retErrorMessage", retErrorMessage);
			} 
			
			else {
				
				model.addObject("retMessage", retMessage);
			}
			
			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
                
				String managerAddLeave = "managerAddLeave";
				if(retMessage.startsWith("Leave already exist")){
					String managerOnLeave = "managerOnLeave";
					model.addObject("manonLeave", retMessage);
					model.addObject("managerOnLeave", managerOnLeave);
				}else{
					model.addObject("managerAddLeave", managerAddLeave);
				}
				
				model.setViewName("confirmations");

			} else if (userName.getRole().equalsIgnoreCase("Technician")) {

				String techAddLeave = "techAddLeave";
				if(retMessage.startsWith("Leave already exist")){
					String techOnLeave = "techOnLeave";
					model.addObject("onLeave", retMessage);
					model.addObject("techOnLeave", techOnLeave);
				}else{
					model.addObject("techAddLeave", techAddLeave);
				}
				
				model.setViewName("confirmation");

			} else if (userName.getRole().equalsIgnoreCase("User")) {

				String addLeave = "addLeave";
				model.addObject("addLeave", addLeave);
				model.setViewName("confirm");
			}
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = { "updateLeave", "updateMakeLeave",
			"updateUserMakeLeave" }, method = RequestMethod.POST)
	public ModelAndView updateLeave(
			@ModelAttribute("updateLeave") LeaveBean leave) {
		
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			retMessage = leaveInt.updateLeaveRequest(leave);
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));			
			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				String updateLeave = "updateLeave";
				model.addObject("updateLeave", updateLeave);
				model.addObject("retMessage", retMessage);
				model.setViewName("confirmations");

			} else if (userName.getRole().equalsIgnoreCase("Technician")) {
				String techUpdateLeave = "techUpdateLeave";
				model.addObject("retMessage", retMessage);
				model.addObject("techUpdateLeave", techUpdateLeave);
				model.setViewName("confirmation");

			} else if (userName.getRole().equalsIgnoreCase("User")) {
				String userUpdateLeave = "userUpdateLeave";
				model.addObject("retMessage", retMessage);
				model.addObject("userUpdateLeave", userUpdateLeave);
				model.setViewName("confirm");
			}
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = "getUserSelectedLeaveDate", method = RequestMethod.GET)
	public ModelAndView getUserSelectedDate(
			@RequestParam("selectedDate") String localSelectedDate) {
		selectedDateRange = localSelectedDate;
		tempEmployee = null;
		System.err.println(tempEmployee);
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				if (selectedDateRange != null) {
					model.addObject(
							"countPendingLeave",
							leaveInt.countpendingLeaveForSelectedDate(selectedDateRange));
					model.addObject("countActiveLeave", leaveInt
							.countActiveLeaveForSelectedDate(selectedDateRange));
					///model.addObject("leaveList", leaveInt.getPendingLeaveForSelectedRange(selectedDateRange));
					model.addObject("leaveList", leaveInt
							.getAllLeaveForSelectedRange(selectedDateRange));
					model.addObject("technicians",
							employeeServiceInt.getAllTechnicians());
					model.addObject("dates", leaveInt.getLeaveDates());
					model.addObject("newDate", selectedDateRange);
					model.setViewName("leavemanagement");
				}
			} else if (userName.getRole().equalsIgnoreCase("Technician")) {
				if (selectedDateRange != null) {
					model.addObject(
							"countPendingLeave",
							leaveInt.countTechpendingLeaveForSelectedDate(selectedDateRange, userName.getEmail()));
					model.addObject("countActiveLeave", leaveInt
							.countTechActiveLeaveForSelectedDate(selectedDateRange, userName.getEmail()));
					///model.addObject("leaveList", leaveInt.getPendingLeaveForSelectedRange(selectedDateRange));
					model.addObject("leaveList", leaveInt
							.getAllTechLeaveForSelectedRange(selectedDateRange, userName.getEmail()));
					model.addObject("technicians",
							employeeServiceInt.getAllTechnicians());
					model.addObject("dates", leaveInt.getLeaveDates());
					model.addObject("newDate", selectedDateRange);
					model.setViewName("leavemanagement");
				}
				model.setViewName("techleavemanagement");
			}
		} else {
			model.setViewName("login");
		}

		return model;
	}
	
	
	@RequestMapping(value = { "leaveCancellation", "techLeaveCancellation",
	"userLeaveCancellation" }, method = RequestMethod.GET)
     public ModelAndView leaveCancellation(@RequestParam("leaveID") int leaveID) {

		model = new ModelAndView();
	   userName = (Employee) session.getAttribute("loggedInUser");
	   if (userName != null) {
		   retMessage = leaveInt.cancelLeave(leaveID);
		if (userName.getRole().equalsIgnoreCase("Manager")|| userName.getRole().equalsIgnoreCase("Admin")) {
             String managerCancel = "managerCancel";
             model.addObject("managerCancel", managerCancel);
             model.addObject("retMessage", retMessage);
			model.setViewName("confirmations");

		} else if (userName.getRole().equalsIgnoreCase("Technician")) {
			String technicianCancel = "technicianCancel";
			model.addObject("technicianCancel", technicianCancel);
			model.addObject("retMessage", retMessage);
			model.setViewName("confirmation");

		} else if (userName.getRole().equalsIgnoreCase("User")) {
			String userCancel = "userCancel";
			model.addObject("userCancel", userCancel);
			model.addObject("retMessage", retMessage);
			model.setViewName("confirm");
		}

	} else {
		model.setViewName("login");
	}

	return model;
}

}
