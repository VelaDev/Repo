package com.demo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.demo.bean.PieChart;
import com.demo.bean.SparePartsBean;
import com.demo.bean.TicketsBean;
import com.demo.model.Customer;
import com.demo.model.Employee;
import com.demo.model.OrderHeader;
import com.demo.model.OrderHistory;
import com.demo.model.Tickets;
import com.demo.service.BootStockInt;
import com.demo.service.CustomerContactDetailsServiceInt;
import com.demo.service.CustomerServiceInt;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.LeaveInt;
import com.demo.service.OrderHistoryInt;
import com.demo.service.OrdersServiceInt;
import com.demo.service.SiteStockInt;
import com.demo.service.SpareMasterServiceInt;
import com.demo.service.TicketsServiceInt;
import com.demo.service.DeviceServiceInt;
import com.demo.service.TicketHistoryInt;

@Controller
public class TicketController {

	@Autowired
	private TicketsServiceInt logTicketService;
	@Autowired
	private CustomerServiceInt customerServiceInt;
	@Autowired
	private DeviceServiceInt deviceServiceInt;
	@Autowired
	private EmployeeServiceInt employeeServiceInt;
	@Autowired
	private TicketHistoryInt ticketHistoryInt;
	@Autowired
	private OrdersServiceInt ordersServiceInt;
	@Autowired
	private TicketsServiceInt ticketsServiceInt;
	@Autowired
	private SpareMasterServiceInt spareMasterServiceInt;
	@Autowired
	private BootStockInt bootStockint;
	@Autowired
	private SiteStockInt siteStock;
	@Autowired
	private LeaveInt leaveInt;
	@Autowired
	private OrderHistoryInt historyInt;
	private List<PieChart> beanList = null;
	Integer count = 1;
	public String[] getSerialNumbers = null;

	@Autowired
	private CustomerContactDetailsServiceInt contactDetailsServiceInt;
	@Autowired
	private HttpSession session = null;

	@SuppressWarnings("unused")
	private Customer customer = null;
	private ModelAndView model = null;
	private Employee userName = null;
	private String retMessage = "";
	public String[] getSerials = null;
	private String customerName, orderNum, technicianName,
			selectedDateRange = null;
	public String[] getOrdersNumbers = null;
	private Employee tempEmployee = null;

	@RequestMapping(value = "ticket", method = RequestMethod.GET)
	public ModelAndView loadTicket() {

		model = new ModelAndView();
		String retPage = null;
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("logTicket", new TicketsBean());
			getSerialNumbers = deviceServiceInt.getSerials();
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("technicians",
					employeeServiceInt.getAllTechnicians());
			model.addObject("serialNumbers", getSerialNumbers);
			model.addObject("onLeaveTechnicians", leaveInt.techniciansOnLeave());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));

			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			/* retPage = "redirect:ticket"; */
			model.setViewName("ticket");
		} else {
			model.setViewName("login");
		}
		return model;

	}

	@RequestMapping(value = "logTicketAdmin", method = RequestMethod.POST)
	public ModelAndView logTicketAdmin(
			@ModelAttribute("logTicketAdmin") TicketsBean logTickets) {

		model = new ModelAndView();
		String tickets = "tickets";
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			retMessage = logTicketService.logTicket(logTickets);
			if (retMessage.startsWith("K")) {
				String message = retMessage;
				model.addObject("retMessage", retMessage);
			} else {
				model.addObject("retMessage", retMessage);

			}
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject(tickets, "tickets");
			model.setViewName("confirmations");
			// model.setViewName("logTicket");
		} else {

			model.setViewName("login");
		}
		return model;

	}

	@RequestMapping(value = "UserlogTicket", method = RequestMethod.POST)
	public ModelAndView userLogTicket(
			@ModelAttribute("UserlogTicket") TicketsBean logTickets) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		String tickets = "tickets";
		if (userName != null) {
			retMessage = logTicketService.logTicket(logTickets);
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));

			if (retMessage.startsWith("C")) {
				String message = retMessage;
				model.addObject("message", message);
			} else {
				model.addObject("retMessage", retMessage);
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("tickets", tickets);

			}
			model.setViewName("confirm");
			// model.setViewName("ticket");
		} else {
			model.setViewName("login");
		}
		return model;

	}

	@RequestMapping(value = { "monitoringTickets" })
	public ModelAndView displayLoggedTickets() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("ticketList", logTicketService.getAllOpenTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("monitoringTickets");
		} else {
			model.setViewName("login");
		}
		return model;

	}

	@RequestMapping("ticketDetails")
	public ModelAndView loadTicketdetails(@RequestParam int id,
			@ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			String technician = userName.getFirstName() + " "
					+ userName.getLastName();
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject("saveSpareParts", new SparePartsBean());
			getSerials = spareMasterServiceInt.getSerials();
			model.addObject("spareParts", getSerials);
			model.addObject(
					"contactPerson",
					contactDetailsServiceInt.getContactPerson(ticket
							.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList",
					ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.addObject("customerList", customerServiceInt.getClientList());
			model.addObject("bootStock",
					bootStockint.getAllOrders(technician, id));
			model.addObject(
					"siteStock",
					siteStock.getOrdersForCustomer(ticket.getDevice()
							.getCustomerDevice().getCustomerName(), id));

			model.setViewName("ticketDetails");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = "viewCustomerDetails")
	public ModelAndView viewCustomerDetails(
			@RequestParam("customerName") String customerName,
			@ModelAttribute Customer customer) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("customer",
					customerServiceInt.contactDetails(customerName));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("customerDetails",
					contactDetailsServiceInt.contactDetails(customerName));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("viewCustomerDetails");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping("updateTicket")
	public ModelAndView updateTicket(
			@ModelAttribute("updateTicket") TicketsBean updateTicket) {
		String managerUpdateTicket = "managerUpdateTicket";
		String techUpdateTicket = "techUpdateTicket";
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			retMessage = logTicketService.updateTicket(updateTicket);
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			if (retMessage.startsWith("The part number")) {
				String retErrorMessage = retMessage;
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("retErrorMessage", retErrorMessage);
			} else {
				model.addObject("retMessage", retMessage);
			}
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				model.addObject("managerUpdateTicket", managerUpdateTicket);
				model.setViewName("confirmations");
			}

			else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("techUpdateTicket", techUpdateTicket);
				model.setViewName("confirmation");
			}

		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping("updateTicketUser")
	public ModelAndView userUpdateTicket(
			@ModelAttribute("updateTicket") TicketsBean updateTicket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			retMessage = logTicketService.updateTicket(updateTicket);
			model.addObject("retMessage", retMessage);
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("userUpdateTicket");
		} else {
			model.setViewName("login");
		}

		return model;

	}

	@RequestMapping("searchTechnician")
	public ModelAndView searchEmployee(
			@RequestParam("searchName") String searchName) {
		model.addObject("awaitingSparesTickets",
				ticketsServiceInt.countAwaitingSparesTickets());
		model.addObject("escalatedTickets",
				ticketsServiceInt.countEscalatedTickets());
		model.addObject("inboxCount",
				ordersServiceInt.pendingOrdersCount(userName.getEmail()));
		return new ModelAndView("");
	}

	@RequestMapping("clientInfo")
	public ModelAndView clientInfo() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("", "");
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("clientInfo");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = "logTicket", method = RequestMethod.GET)
	public ModelAndView loadTicketAdmin() {

		model = new ModelAndView("logTicket");
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("logTicket", new TicketsBean());
			getSerialNumbers = deviceServiceInt.getSerials();
			model.addObject("technicians",
					employeeServiceInt.getAllTechnicians());
			model.addObject("serialNumbers", getSerialNumbers);
			model.addObject("onLeaveTechnicians", leaveInt.techniciansOnLeave());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("logTicket");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("AssignTicketToOtherTechnician")
	public ModelAndView assignTicketToAnotherTechnicia(
			@RequestParam int ticketNumber, @ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			ticket = logTicketService
					.getLoggedTicketByTicketNumber(ticketNumber);
			model.addObject("ticketupdate", ticket);
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("technicians",
					employeeServiceInt.getAllTechnicians());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("ticketUpdate");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("userAssignTicketToOtherTechnician")
	public ModelAndView userAssignTicketToAnotherTechnicia(
			@RequestParam int ticketNumber, @ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			ticket = logTicketService
					.getLoggedTicketByTicketNumber(ticketNumber);
			model.addObject("ticketupdate", ticket);
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("technicians",
					employeeServiceInt.getAllTechnicians());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("userUpdateTicket");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("updateTicketAdmin")
	public ModelAndView updateTicketAdmin(
			@ModelAttribute("updateTicket") TicketsBean updateTicket) {
		String managerUpdateTicket = "managerUpdateTicket";
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			retMessage = logTicketService.updateTicket(updateTicket);
			model.addObject("retMessage", retMessage);
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("managerUpdateTicket", managerUpdateTicket);
			model.setViewName("confirmations");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "userTicket", method = RequestMethod.GET)
	public ModelAndView loadUserTicket(Integer offset, Integer maxResults) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			beanList = ticketsServiceInt.ticketsResults();
			model.addObject("ticketResults", beanList);
			model.addObject("count", count);
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("userTicket");
		} else {
			model.setViewName("login");
		}
		return model;

	}

	@RequestMapping("openTickets")
	public ModelAndView openTickets() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("ticketList", logTicketService.getAllOpenTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("openTickets");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping("openTicketsDetails")
	public ModelAndView loadOpenTicketsDetails(@RequestParam int id,
			@ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				ticket = logTicketService.getLoggedTicketByTicketNumber(id);
				model.addObject("ticketObject", ticket);
				model.addObject(
						"contactPerson",
						contactDetailsServiceInt.getContactPerson(ticket
								.getDevice().getCustomerDevice()
								.getCustomerName()));
				model.addObject("ticketHistoryList",
						ticketHistoryInt.getHistoryByTicketNumber(id));
				model.addObject("OrderNumber",
						ordersServiceInt.getAllOrders(userName.getEmail()));
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("managersList",
						employeeServiceInt.getAllManagers());
				model.setViewName("openTicketsDetails");
			}
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = { "closedTickets", "closedTechTickets" })
	public ModelAndView closedTickets() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("ticketList",
					logTicketService.getAllClosedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				model.setViewName("closedTickets");
			}

			else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("ticketList", logTicketService
						.getAllClosedTickets(userName.getEmail()));
				model.setViewName("closedTechTickets");
			}
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "closedTicketsDetails",
			"closedTechTicketsDetails" })
	public ModelAndView loadClosedTicketsDetails(@RequestParam int id,
			@ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject(
					"contactPerson",
					contactDetailsServiceInt.getContactPerson(ticket
							.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList",
					ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList", employeeServiceInt.getAllManagers());

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.setViewName("closedTicketsDetails");
			}

			else if (userName.getRole().equalsIgnoreCase("Technician")) {

				model.setViewName("closedTechTicketsDetails");
			}
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping("awaitingSpares")
	public ModelAndView awaitingSparesTickes() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("ticketList",
					logTicketService.getAllAwaitingSpares());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("awaitingSpares");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("awaitingSparesDetails")
	public ModelAndView loadAwaitingSparesTicketdetails(@RequestParam int id,
			@ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			String technician = userName.getFirstName() + " "
					+ userName.getLastName();
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject("saveSpareParts", new SparePartsBean());
			getSerials = spareMasterServiceInt.getSerials();
			model.addObject("spareParts", getSerials);
			model.addObject(
					"contactPerson",
					contactDetailsServiceInt.getContactPerson(ticket
							.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList",
					ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.addObject("customerList", customerServiceInt.getClientList());
			model.addObject("bootStock", bootStockint.getAllOrders(technician));
			model.addObject("orderStatus",
					historyInt.getAllOrderHistoryTicketNumber(id));
			model.addObject(
					"siteStock",
					siteStock.getOrdersForCustomer(ticket.getDevice()
							.getCustomerDevice().getCustomerName()));

			model.setViewName("awaitingSparesDetails");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("awaitSpares")
	public ModelAndView awaitSpares() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("ticketList",
					logTicketService.getAllAwaitingSpares());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("awaitSpares");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("awaitingSparesTechDetails")
	public ModelAndView loadAwaitingSparesTechdetails(@RequestParam int id,
			@ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject(
					"contactPerson",
					contactDetailsServiceInt.getContactPerson(ticket
							.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList",
					ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.addObject("orderStatus",
					historyInt.getAllOrderHistoryTicketNumber(id));
			model.setViewName("awaitingSparesTechDetails");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("bridgedTickets")
	public ModelAndView bridgedTickets() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("ticketList",
					logTicketService.getAllBridgedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("bridgedTickets");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("bridgedTicketsDetails")
	public ModelAndView loadBridgedTicketsDetails(@RequestParam int id,
			@ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject(
					"contactPerson",
					contactDetailsServiceInt.getContactPerson(ticket
							.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList",
					ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.setViewName("bridgedTicketsDetails");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("slaBridged")
	public ModelAndView slaBridged() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("ticketList",
					logTicketService.getAllBridgedTickets(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("slaBridged");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("bridgedTechDetails")
	public ModelAndView loadBridgedTechDetails(@RequestParam int id,
			@ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			String technician = userName.getFirstName() + " "
					+ userName.getLastName();
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject(
					"contactPerson",
					contactDetailsServiceInt.getContactPerson(ticket
							.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList",
					ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject(
					"siteStock",
					siteStock.getOrdersForCustomer(ticket.getDevice()
							.getCustomerDevice().getCustomerName()));
			model.addObject("bootStock", bootStockint.getAllOrders(technician));
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.setViewName("bridgedTechDetails");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("escalatedTickes")
	public ModelAndView escalatedTickes() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("ticketList",
					logTicketService.getAllEscalatedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.setViewName("escalatedTickes");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("escalatedTickesDetails")
	public ModelAndView loadEscalatedTickesDetails(@RequestParam int id,
			@ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject(
					"contactPerson",
					contactDetailsServiceInt.getContactPerson(ticket
							.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList",
					ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.setViewName("escalatedTickesDetails");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("escalatedTech")
	public ModelAndView escalatedTech() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("ticketList",
					logTicketService.getAllEscalatedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("escalatedTech");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("escalatedTechDetails")
	public ModelAndView loadEscalatedTechDetails(@RequestParam int id,
			@ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject(
					"contactPerson",
					contactDetailsServiceInt.getContactPerson(ticket
							.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList",
					ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.addObject("manager", employeeServiceInt
					.getEmployeeByEmpNumber(ticket.getEscalatedTo()));
			model.setViewName("escalatedTechDetails");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = { "resolvedTickets", "userResolvedTickets" })
	public ModelAndView resolvedTicket() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("ticketList",
					logTicketService.getAllResolvedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				model.setViewName("resolvedTickets");

			} else if (userName.getRole().equalsIgnoreCase("User")) {

				model.setViewName("userResolvedTickets");
			}
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = { "resolvedTickectDetails",
			"userResolvedTickectDetails" })
	public ModelAndView loadResolvedTicketDetails(@RequestParam int id,
			@ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject(
					"contactPerson",
					contactDetailsServiceInt.getContactPerson(ticket
							.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList",
					ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList", employeeServiceInt.getAllManagers());

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin"))

				model.setViewName("resolvedTickectDetails");
		} else if (userName.getRole().equalsIgnoreCase("User")) {

			model.setViewName("userResolvedTickets");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping("resolvedTechTickets")
	public ModelAndView resolvedTechTicket() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);

			model.addObject("ticketList",
					logTicketService.getAllResolvedTickets(userName.getEmail()));
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("resolvedTechTickets");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("resolvedTechTicketsDetails")
	public ModelAndView loadResolvedTechTicketsDetails(@RequestParam int id,
			@ModelAttribute Tickets ticket) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			ticket = logTicketService.getLoggedTicketByTicketNumber(id);
			model.addObject("ticketObject", ticket);
			model.addObject(
					"contactPerson",
					contactDetailsServiceInt.getContactPerson(ticket
							.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList",
					ticketHistoryInt.getHistoryByTicketNumber(id));
			model.addObject("OrderNumber",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.setViewName("resolvedTechTicketsDetails");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("technicianDashboard")
	public ModelAndView bridgedTicketsForTech() {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("shipment",
					ordersServiceInt.shippedOrders(userName.getEmail()));
			model.addObject("ticketList",
					logTicketService.getAllBridgedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("escalatedTickets", ticketsServiceInt
					.countEscalatedTickets(userName.getEmail()));
			model.addObject("awaitingSparesTickets", ticketsServiceInt
					.countAwaitingSparesTickets(userName.getEmail()));
			model.addObject("bridgedTickets",
					ticketsServiceInt.countBridgedTickets(userName.getEmail()));
			model.addObject("resolvedTickets",
					ticketsServiceInt.countResolvedTickets(userName.getEmail()));
			model.addObject("closedTickets",
					ticketsServiceInt.countClosedTickets(userName.getEmail()));
			model.setViewName("technicianDashboard");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@ExceptionHandler({ DataIntegrityViolationException.class })
	public ModelAndView dataIntegrity(Exception ex) {
		ModelAndView model = new ModelAndView("405");

		model.addObject("exception", ex.getMessage());
		return model;

	}

	@RequestMapping(value = { "closedTicketsAdmin", "closedTechDetails" })
	public ModelAndView closedTicketsAdmin1(
			@RequestParam("startDate") String startDate,
			@RequestParam("endDate") String endDate) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("ticketList",
					logTicketService.getAllClosedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketList",
					logTicketService.getAllClosedTickets(startDate, endDate));

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				model.setViewName("closedTickets");
			}

			else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("ticketList", logTicketService
						.getAllClosedTickets(userName.getEmail()));
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("ticketList", logTicketService
						.getAllClosedTickets(startDate, endDate,
								userName.getEmail()));
				model.setViewName("closedTechTickets");
			}
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "escalateTechTicket", "adminEscalates" })
	public ModelAndView TicketsAdmin(
			@RequestParam("startDate") String startDate,
			@RequestParam("endDate") String endDate) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("ticketList",
					logTicketService.getAllEscalatedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("ticketList",
					logTicketService.getAllEscalatedTickets(startDate, endDate));

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				model.setViewName("escalatedTickes");
			}

			else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("ticketList", logTicketService
						.getAllEscalatedTickets(userName.getEmail()));
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("ticketList", logTicketService
						.getAllEscalatedTickets(startDate, endDate,
								userName.getEmail()));
				model.setViewName("escalatedTech");
			}
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "bridgedTicketsAdmin", "adminEscalates" })
	public ModelAndView slaTicketsAdmin(
			@RequestParam("startDate") String startDate,
			@RequestParam("endDate") String endDate) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("ticketList",
					logTicketService.getAllBridgedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("ticketList",
					logTicketService.getAllBridgedTickets(startDate, endDate));

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				model.setViewName("bridgedTickets");
			}

			else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("ticketList", logTicketService
						.getAllBridgedTickets(userName.getEmail()));
				model.addObject("ticketList", logTicketService
						.getAllBridgedTickets(startDate, endDate,
								userName.getEmail()));
				model.setViewName("slaBridged");
			}
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "awaitingTechDetails", "awaitingAdminDetails" })
	public ModelAndView awaitingTicketsAdmin(
			@RequestParam("startDate") String startDate,
			@RequestParam("endDate") String endDate) {

		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage", retMessage);
			model.addObject("ticketList",
					logTicketService.getAllBridgedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketList", logTicketService
					.getAllAwaitingSparesTickets(startDate, endDate));

			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				model.setViewName("awaitingSpares");
			}

			else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("ticketList", logTicketService
						.getAllAwaitingSpares(userName.getEmail()));
				model.addObject("ticketList", logTicketService
						.getAllAwaitingSparesTickets(startDate, endDate,
								userName.getEmail()));
				model.setViewName("awaitSpares");
			}
		} else {
			model.setViewName("login");
		}

		return model;
	}

	// ticket management for manager and admin
	@RequestMapping(value = "ticketmanagement", method = RequestMethod.GET)
	public ModelAndView displayTicketManagement() {
		customerName = null;
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("lastForteenList",
					ticketsServiceInt.getLastFourteenDaysTickets());

			model.addObject("pendingOrderList",
					ordersServiceInt.pendingOrders(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("orderList",
					ordersServiceInt.getLastFourteenDaysOrders());
			model.addObject("customers", customerServiceInt.getClientList());
			model.addObject("dates", ordersServiceInt.getDates());

			model.addObject("countOpenTickets", ticketsServiceInt
					.getTicketCount("Open", "Last 14 Days", "", ""));
			model.addObject("countAcknowledgedTickets", ticketsServiceInt
					.getTicketCount("Acknowledged", "Last 14 Days", "", ""));
			model.addObject("countTakenTickets", ticketsServiceInt
					.getTicketCount("Taken", "Last 14 Days", "", ""));
			model.addObject("countEscalatedTickets", ticketsServiceInt
					.getTicketCount("Escalated", "Last 14 Days", "", ""));
			model.addObject("countAwaitingSparesTickets", ticketsServiceInt
					.getTicketCount("Awaiting Spares", "Last 14 Days", "", ""));
			model.addObject("countBridgedTickets", ticketsServiceInt
					.getTicketCount("SLA Bridged", "Last 14 Days", "", ""));
			model.addObject("countResolvedTickets", ticketsServiceInt
					.getTicketCount("Resolved", "Last 14 Days", "", ""));
			model.addObject("countClosedTickets", ticketsServiceInt
					.getTicketCount("Closed", "Last 14 Days", "", ""));

			model.addObject("orderNumbers", ordersServiceInt.getOrderNumbers());
			model.addObject("technicians",
					employeeServiceInt.getAllTechnicians());

			model.setViewName("ticketmanagement");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	// ticket management for technician
	@RequestMapping(value = "techticketmanagement", method = RequestMethod.GET)
	public ModelAndView displayTechticketManagement() {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("lastForteenList",
					ticketsServiceInt.getLastFourteenDaysTickets());
			// List<Tickets> getLastFourteenDaysTickets();

			model.addObject("pendingOrderList",
					ordersServiceInt.pendingOrders(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("orderList",
					ordersServiceInt.getLastFourteenDaysOrders());
			model.addObject("customers", customerServiceInt.getClientList());
			model.addObject("dates", ordersServiceInt.getDates());

			model.addObject("countOpenTickets",
					ticketsServiceInt.countOpenTickets(userName.getEmail()));
			model.addObject("countAcknowledgedTickets", ticketsServiceInt
					.countAcknowledgedTickets(userName.getEmail()));
			model.addObject("countTakenTickets",
					ticketsServiceInt.countTakenTickets(userName.getEmail()));
			model.addObject("countEscalatedTickets", ticketsServiceInt
					.countEscalatedTickets(userName.getEmail()));
			model.addObject("countAwaitingSparesTickets", ticketsServiceInt
					.countAwaitingSparesTickets(userName.getEmail()));
			model.addObject("countBridgedTickets",
					ticketsServiceInt.countBridgedTickets(userName.getEmail()));
			model.addObject("countResolvedTickets",
					ticketsServiceInt.countResolvedTickets(userName.getEmail()));
			model.addObject("countClosedTickets",
					ticketsServiceInt.countClosedTickets(userName.getEmail()));

			model.addObject("orderNumbers", ordersServiceInt.getOrderNumbers());
			model.addObject("technicians",
					employeeServiceInt.getAllTechnicians());
			model.setViewName("techticketmanagement");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	// ticket management details
	@RequestMapping(value = { "ticketItemDetailsM", "ticketItemDetailsT" }, method = RequestMethod.GET)
	public ModelAndView orderHistory(
			@RequestParam("recordID") Integer recordID,
			@ModelAttribute Tickets ticket) {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			String technician = userName.getFirstName() + " "
					+ userName.getLastName();
			ticket = logTicketService.getLoggedTicketByTicketNumber(recordID);

			model.addObject("ticketObject", ticket);

			OrderHeader ord = ordersServiceInt.getOrder(recordID);
			Employee appoer = employeeServiceInt.getEmployeeByEmpNumber(ord
					.getApprover());
			String approverName = appoer.getFirstName() + " "
					+ appoer.getLastName();
			model.addObject("OrderNum", ordersServiceInt.getOrder(recordID));
			model.addObject("status",
					historyInt.getAllOrderHistoryByOrderNumber(recordID));
			model.addObject("saveSpareParts", new SparePartsBean());
			getSerials = spareMasterServiceInt.getSerials();
			model.addObject("spareParts", getSerials);
			model.addObject(
					"contactPerson",
					contactDetailsServiceInt.getContactPerson(ticket
							.getDevice().getCustomerDevice().getCustomerName()));
			model.addObject("ticketHistoryList",
					ticketHistoryInt.getHistoryByTicketNumber(recordID));
			model.addObject("OrderNumber",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("onLeaveTechnicians", leaveInt.techniciansOnLeave());
			model.addObject("serialNumbers", getSerialNumbers);
			model.addObject("technicians",
					employeeServiceInt.getAllTechnicians());
			model.addObject("countOpenTickets",
					ticketsServiceInt.countOpenTickets());
			model.addObject("countEscalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("countAcknowledgedTickets",
					ticketsServiceInt.countAcknowledgedTickets());
			model.addObject("countTakenTickets",
					ticketsServiceInt.countTakenTickets());
			model.addObject("countAwaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("countBridgedTickets",
					ticketsServiceInt.countBridgedTickets());
			model.addObject("countResolvedTickets",
					ticketsServiceInt.countResolvedTickets());
			model.addObject("countClosedTickets",
					ticketsServiceInt.countClosedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.addObject("customerList", customerServiceInt.getClientList());
			model.addObject("bootStock",
					bootStockint.getAllOrders(technician, recordID));
			model.addObject(
					"siteStock",
					siteStock.getOrdersForCustomer(ticket.getDevice()
							.getCustomerDevice().getCustomerName(), recordID));

			model.addObject("approver", approverName);

			if (userName.getRole().equalsIgnoreCase("Technician")) {

				model.setViewName("ticketItemDetailsT");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				model.addObject("OrderNum", ordersServiceInt.getOrder(recordID));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.addObject("countOpenTickets",
						ticketsServiceInt.countOpenTickets());
				model.addObject("countEscalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("countAcknowledgedTickets", ticketsServiceInt
						.countAcknowledgedTickets(userName.getEmail()));
				model.addObject("countTakenTickets", ticketsServiceInt
						.countTakenTickets(userName.getEmail()));
				model.addObject("countAwaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("countBridgedTickets",
						ticketsServiceInt.countBridgedTickets());
				model.addObject("countResolvedTickets",
						ticketsServiceInt.countResolvedTickets());
				model.addObject("countClosedTickets",
						ticketsServiceInt.countClosedTickets());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("status",
						historyInt.getAllOrderHistoryByOrderNumber(recordID));

				model.setViewName("ticketItemDetailsM");
			}

		} else {
			model.setViewName("login");
		}

		return model;
	}

	// Open Tickets
	@RequestMapping(value = "openTickets", method = RequestMethod.GET)
	public ModelAndView forOpenTickets() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Technician")) {

				if (customerName != null) {

					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysClosedOrdersForTechnicianCustomer(
											userName.getEmail(), customerName));

				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(userName.getEmail(),
									selectedDateRange));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("orderList", ordersServiceInt
							.getLastFourteenDaysClosedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));

				} else {

					model.addObject("countOpenTickets", ticketsServiceInt
							.countOpenTickets(userName.getEmail()));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.countAcknowledgedTickets(userName
									.getEmail()));
					model.addObject("countTakenTickets", ticketsServiceInt
							.countTakenTickets(userName.getEmail()));
					model.addObject("countEscalatedTickets", ticketsServiceInt
							.countEscalatedTickets(userName.getEmail()));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt
									.countAwaitingSparesTickets(userName
											.getEmail()));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.countBridgedTickets(userName.getEmail()));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.countResolvedTickets(userName.getEmail()));
					model.addObject("countClosedTickets", ticketsServiceInt
							.countClosedTickets(userName.getEmail()));
				}
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers(userName.getEmail()));
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.setViewName("techticketmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() >= 2) {
						model.addObject("selectedName", customerName);
						model.addObject("lastForteenList", ticketsServiceInt
								.getTicketListByStatus("Open", "", "", customerName));
						model.addObject("countOpenTickets", ticketsServiceInt
								.getTicketCount("Open", "", "", customerName));
						model.addObject("countAcknowledgedTickets",
								ticketsServiceInt.getTicketCount("Acknowledged",
										"", "", customerName));
						model.addObject("countTakenTickets", ticketsServiceInt
								.getTicketCount("Taken",  "", "", customerName));
						model.addObject("countEscalatedTickets",
								ticketsServiceInt.getTicketCount("Escalated",
										"", "", customerName));
						model.addObject("countAwaitingSparesTickets",
								ticketsServiceInt.getTicketCount("Awaiting Spares",
										"", "", customerName));
						model.addObject("countBridgedTickets", ticketsServiceInt
								.getTicketCount("SLA Bridged", "", "", customerName));
						model.addObject("countResolvedTickets", ticketsServiceInt
								.getTicketCount("Resolved",  "", "", customerName));
						model.addObject("countClosedTickets", ticketsServiceInt
								.getTicketCount("Closed",  "", "", customerName));
					
					}
				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Open", selectedDateRange, "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", selectedDateRange, "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									 selectedDateRange, "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken",  selectedDateRange, "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									 selectedDateRange, "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									 selectedDateRange, "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", selectedDateRange, "", ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved",  selectedDateRange, "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed",  selectedDateRange, "", ""));
				
					
				} else if (tempEmployee != null) {
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Open", "", tempEmployee.getEmail(), ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "", tempEmployee.getEmail(), ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "", tempEmployee.getEmail(), ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "", tempEmployee.getEmail(), ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "", tempEmployee.getEmail(), ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "", tempEmployee.getEmail(), ""));
					model.addObject("selectedTechnician", tempEmployee);
				} else {

					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Open", "Last 14 Days", "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "Last 14 Days", "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"Last 14 Days", "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "Last 14 Days", "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"Last 14 Days", "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"Last 14 Days", "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "Last 14 Days", "",
									""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "Last 14 Days", "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "Last 14 Days", "", ""));

				}
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));

				model.setViewName("ticketmanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}

	// Acknowledged Tickets
	@RequestMapping(value = "acknowledgedTickets", method = RequestMethod.GET)
	public ModelAndView acknowledgedTickets() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Technician")) {

				if (customerName != null) {

					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysClosedOrdersForTechnicianCustomer(
											userName.getEmail(), customerName));

				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(userName.getEmail(),
									selectedDateRange));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("orderList", ordersServiceInt
							.getLastFourteenDaysClosedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));

				} else {

					model.addObject("countOpenTickets", ticketsServiceInt
							.countOpenTickets(userName.getEmail()));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.countAcknowledgedTickets(userName
									.getEmail()));
					model.addObject("countTakenTickets", ticketsServiceInt
							.countTakenTickets(userName.getEmail()));
					model.addObject("countEscalatedTickets", ticketsServiceInt
							.countEscalatedTickets(userName.getEmail()));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt
									.countAwaitingSparesTickets(userName
											.getEmail()));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.countBridgedTickets(userName.getEmail()));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.countResolvedTickets(userName.getEmail()));
					model.addObject("countClosedTickets", ticketsServiceInt
							.countClosedTickets(userName.getEmail()));
				}
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers(userName.getEmail()));
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.setViewName("techticketmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() >= 2) {
						model.addObject("selectedName", customerName);
						model.addObject("lastForteenList", ticketsServiceInt
								.getTicketListByStatus("Acknowledged", "", "", customerName));
						model.addObject("countOpenTickets", ticketsServiceInt
								.getTicketCount("Open", "", "", customerName));
						model.addObject("countAcknowledgedTickets",
								ticketsServiceInt.getTicketCount("Acknowledged",
										"", "", customerName));
						model.addObject("countTakenTickets", ticketsServiceInt
								.getTicketCount("Taken",  "", "", customerName));
						model.addObject("countEscalatedTickets",
								ticketsServiceInt.getTicketCount("Escalated",
										"", "", customerName));
						model.addObject("countAwaitingSparesTickets",
								ticketsServiceInt.getTicketCount("Awaiting Spares",
										"", "", customerName));
						model.addObject("countBridgedTickets", ticketsServiceInt
								.getTicketCount("SLA Bridged", "", "", customerName));
						model.addObject("countResolvedTickets", ticketsServiceInt
								.getTicketCount("Resolved",  "", "", customerName));
						model.addObject("countClosedTickets", ticketsServiceInt
								.getTicketCount("Closed",  "", "", customerName));
					
					}
				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Acknowledged", selectedDateRange, "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", selectedDateRange, "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									 selectedDateRange, "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken",  selectedDateRange, "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									 selectedDateRange, "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									 selectedDateRange, "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", selectedDateRange, "", ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved",  selectedDateRange, "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed",  selectedDateRange, "", ""));
				
					
				} else if (tempEmployee != null) {
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Acknowledged", "", tempEmployee.getEmail(), ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "", tempEmployee.getEmail(), ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "", tempEmployee.getEmail(), ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "", tempEmployee.getEmail(), ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "", tempEmployee.getEmail(), ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "", tempEmployee.getEmail(), ""));
					model.addObject("selectedTechnician", tempEmployee);
				} else {

					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Acknowledged", "Last 14 Days", "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "Last 14 Days", "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"Last 14 Days", "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "Last 14 Days", "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"Last 14 Days", "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"Last 14 Days", "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "Last 14 Days", "",
									""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "Last 14 Days", "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "Last 14 Days", "", ""));

				}
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));

				model.setViewName("ticketmanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}


	// Taken Tickets
	@RequestMapping(value = "takenTickets", method = RequestMethod.GET)
	public ModelAndView takenTickets() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Technician")) {

				if (customerName != null) {

					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysClosedOrdersForTechnicianCustomer(
											userName.getEmail(), customerName));

				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(userName.getEmail(),
									selectedDateRange));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("orderList", ordersServiceInt
							.getLastFourteenDaysClosedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));

				} else {

					model.addObject("countOpenTickets", ticketsServiceInt
							.countOpenTickets(userName.getEmail()));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.countAcknowledgedTickets(userName
									.getEmail()));
					model.addObject("countTakenTickets", ticketsServiceInt
							.countTakenTickets(userName.getEmail()));
					model.addObject("countEscalatedTickets", ticketsServiceInt
							.countEscalatedTickets(userName.getEmail()));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt
									.countAwaitingSparesTickets(userName
											.getEmail()));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.countBridgedTickets(userName.getEmail()));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.countResolvedTickets(userName.getEmail()));
					model.addObject("countClosedTickets", ticketsServiceInt
							.countClosedTickets(userName.getEmail()));
				}
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers(userName.getEmail()));
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.setViewName("techticketmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() >= 2) {
						model.addObject("selectedName", customerName);
						model.addObject("lastForteenList", ticketsServiceInt
								.getTicketListByStatus("Taken", "", "", customerName));
						model.addObject("countOpenTickets", ticketsServiceInt
								.getTicketCount("Open", "", "", customerName));
						model.addObject("countAcknowledgedTickets",
								ticketsServiceInt.getTicketCount("Acknowledged",
										"", "", customerName));
						model.addObject("countTakenTickets", ticketsServiceInt
								.getTicketCount("Taken",  "", "", customerName));
						model.addObject("countEscalatedTickets",
								ticketsServiceInt.getTicketCount("Escalated",
										"", "", customerName));
						model.addObject("countAwaitingSparesTickets",
								ticketsServiceInt.getTicketCount("Awaiting Spares",
										"", "", customerName));
						model.addObject("countBridgedTickets", ticketsServiceInt
								.getTicketCount("SLA Bridged", "", "", customerName));
						model.addObject("countResolvedTickets", ticketsServiceInt
								.getTicketCount("Resolved",  "", "", customerName));
						model.addObject("countClosedTickets", ticketsServiceInt
								.getTicketCount("Closed",  "", "", customerName));
					
					}
				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Taken", selectedDateRange, "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", selectedDateRange, "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									 selectedDateRange, "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken",  selectedDateRange, "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									 selectedDateRange, "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									 selectedDateRange, "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", selectedDateRange, "", ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved",  selectedDateRange, "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed",  selectedDateRange, "", ""));
				
					
				} else if (tempEmployee != null) {
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Taken", "", tempEmployee.getEmail(), ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "", tempEmployee.getEmail(), ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "", tempEmployee.getEmail(), ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "", tempEmployee.getEmail(), ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "", tempEmployee.getEmail(), ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "", tempEmployee.getEmail(), ""));
					model.addObject("selectedTechnician", tempEmployee);
				} else {

					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Taken", "Last 14 Days", "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "Last 14 Days", "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"Last 14 Days", "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "Last 14 Days", "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"Last 14 Days", "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"Last 14 Days", "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "Last 14 Days", "",
									""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "Last 14 Days", "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "Last 14 Days", "", ""));

				}
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));

				model.setViewName("ticketmanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}


	// Tickets Awaiting Spares
	@RequestMapping(value = "ticketsAwaitingSpares", method = RequestMethod.GET)
	public ModelAndView ticketsAwaitingSpares() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Technician")) {

				if (customerName != null) {

					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysClosedOrdersForTechnicianCustomer(
											userName.getEmail(), customerName));

				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(userName.getEmail(),
									selectedDateRange));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("orderList", ordersServiceInt
							.getLastFourteenDaysClosedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));

				} else {

					model.addObject("countOpenTickets", ticketsServiceInt
							.countOpenTickets(userName.getEmail()));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.countAcknowledgedTickets(userName
									.getEmail()));
					model.addObject("countTakenTickets", ticketsServiceInt
							.countTakenTickets(userName.getEmail()));
					model.addObject("countEscalatedTickets", ticketsServiceInt
							.countEscalatedTickets(userName.getEmail()));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt
									.countAwaitingSparesTickets(userName
											.getEmail()));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.countBridgedTickets(userName.getEmail()));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.countResolvedTickets(userName.getEmail()));
					model.addObject("countClosedTickets", ticketsServiceInt
							.countClosedTickets(userName.getEmail()));
				}
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers(userName.getEmail()));
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.setViewName("techticketmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() >= 2) {
						model.addObject("selectedName", customerName);
						model.addObject("lastForteenList", ticketsServiceInt
								.getTicketListByStatus("Awaiting Spares", "", "", customerName));
						model.addObject("countOpenTickets", ticketsServiceInt
								.getTicketCount("Open", "", "", customerName));
						model.addObject("countAcknowledgedTickets",
								ticketsServiceInt.getTicketCount("Acknowledged",
										"", "", customerName));
						model.addObject("countTakenTickets", ticketsServiceInt
								.getTicketCount("Taken",  "", "", customerName));
						model.addObject("countEscalatedTickets",
								ticketsServiceInt.getTicketCount("Escalated",
										"", "", customerName));
						model.addObject("countAwaitingSparesTickets",
								ticketsServiceInt.getTicketCount("Awaiting Spares",
										"", "", customerName));
						model.addObject("countBridgedTickets", ticketsServiceInt
								.getTicketCount("SLA Bridged", "", "", customerName));
						model.addObject("countResolvedTickets", ticketsServiceInt
								.getTicketCount("Resolved",  "", "", customerName));
						model.addObject("countClosedTickets", ticketsServiceInt
								.getTicketCount("Closed",  "", "", customerName));
					
					}
				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Awaiting Spares", selectedDateRange, "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", selectedDateRange, "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									 selectedDateRange, "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken",  selectedDateRange, "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									 selectedDateRange, "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									 selectedDateRange, "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", selectedDateRange, "", ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved",  selectedDateRange, "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed",  selectedDateRange, "", ""));
				
					
				} else if (tempEmployee != null) {
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Awaiting Spares", "", tempEmployee.getEmail(), ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "", tempEmployee.getEmail(), ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "", tempEmployee.getEmail(), ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "", tempEmployee.getEmail(), ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "", tempEmployee.getEmail(), ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "", tempEmployee.getEmail(), ""));
					model.addObject("selectedTechnician", tempEmployee);
				} else {

					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Awaiting Spares", "Last 14 Days", "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "Last 14 Days", "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"Last 14 Days", "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "Last 14 Days", "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"Last 14 Days", "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"Last 14 Days", "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "Last 14 Days", "",
									""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "Last 14 Days", "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "Last 14 Days", "", ""));

				}
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));

				model.setViewName("ticketmanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}

	// Escalated Tickets
	@RequestMapping(value = "escalatedTickets", method = RequestMethod.GET)
	public ModelAndView escalatedTickets() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Technician")) {

				if (customerName != null) {

					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysClosedOrdersForTechnicianCustomer(
											userName.getEmail(), customerName));

				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(userName.getEmail(),
									selectedDateRange));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("orderList", ordersServiceInt
							.getLastFourteenDaysClosedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));

				} else {

					model.addObject("countOpenTickets", ticketsServiceInt
							.countOpenTickets(userName.getEmail()));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.countAcknowledgedTickets(userName
									.getEmail()));
					model.addObject("countTakenTickets", ticketsServiceInt
							.countTakenTickets(userName.getEmail()));
					model.addObject("countEscalatedTickets", ticketsServiceInt
							.countEscalatedTickets(userName.getEmail()));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt
									.countAwaitingSparesTickets(userName
											.getEmail()));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.countBridgedTickets(userName.getEmail()));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.countResolvedTickets(userName.getEmail()));
					model.addObject("countClosedTickets", ticketsServiceInt
							.countClosedTickets(userName.getEmail()));
				}
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers(userName.getEmail()));
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.setViewName("techticketmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() >= 2) {
						model.addObject("selectedName", customerName);
						model.addObject("lastForteenList", ticketsServiceInt
								.getTicketListByStatus("Escalated", "", "", customerName));
						model.addObject("countOpenTickets", ticketsServiceInt
								.getTicketCount("Open", "", "", customerName));
						model.addObject("countAcknowledgedTickets",
								ticketsServiceInt.getTicketCount("Acknowledged",
										"", "", customerName));
						model.addObject("countTakenTickets", ticketsServiceInt
								.getTicketCount("Taken",  "", "", customerName));
						model.addObject("countEscalatedTickets",
								ticketsServiceInt.getTicketCount("Escalated",
										"", "", customerName));
						model.addObject("countAwaitingSparesTickets",
								ticketsServiceInt.getTicketCount("Awaiting Spares",
										"", "", customerName));
						model.addObject("countBridgedTickets", ticketsServiceInt
								.getTicketCount("SLA Bridged", "", "", customerName));
						model.addObject("countResolvedTickets", ticketsServiceInt
								.getTicketCount("Resolved",  "", "", customerName));
						model.addObject("countClosedTickets", ticketsServiceInt
								.getTicketCount("Closed",  "", "", customerName));
					
					}
				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Escalated", selectedDateRange, "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", selectedDateRange, "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									 selectedDateRange, "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken",  selectedDateRange, "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									 selectedDateRange, "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									 selectedDateRange, "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", selectedDateRange, "", ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved",  selectedDateRange, "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed",  selectedDateRange, "", ""));
				
					
				} else if (tempEmployee != null) {
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Escalated", "", tempEmployee.getEmail(), ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "", tempEmployee.getEmail(), ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "", tempEmployee.getEmail(), ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "", tempEmployee.getEmail(), ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "", tempEmployee.getEmail(), ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "", tempEmployee.getEmail(), ""));
					model.addObject("selectedTechnician", tempEmployee);
				} else {

					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Escalated", "Last 14 Days", "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "Last 14 Days", "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"Last 14 Days", "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "Last 14 Days", "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"Last 14 Days", "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"Last 14 Days", "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "Last 14 Days", "",
									""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "Last 14 Days", "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "Last 14 Days", "", ""));

				}
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));

				model.setViewName("ticketmanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}

	// Resolved Tickets
	@RequestMapping(value = "resolvedTickets", method = RequestMethod.GET)
	public ModelAndView resolvedTickets() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Technician")) {

				if (customerName != null) {

					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysClosedOrdersForTechnicianCustomer(
											userName.getEmail(), customerName));

				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(userName.getEmail(),
									selectedDateRange));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("orderList", ordersServiceInt
							.getLastFourteenDaysClosedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));

				} else {

					model.addObject("countOpenTickets", ticketsServiceInt
							.countOpenTickets(userName.getEmail()));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.countAcknowledgedTickets(userName
									.getEmail()));
					model.addObject("countTakenTickets", ticketsServiceInt
							.countTakenTickets(userName.getEmail()));
					model.addObject("countEscalatedTickets", ticketsServiceInt
							.countEscalatedTickets(userName.getEmail()));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt
									.countAwaitingSparesTickets(userName
											.getEmail()));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.countBridgedTickets(userName.getEmail()));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.countResolvedTickets(userName.getEmail()));
					model.addObject("countClosedTickets", ticketsServiceInt
							.countClosedTickets(userName.getEmail()));
				}
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers(userName.getEmail()));
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.setViewName("techticketmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() >= 2) {
						model.addObject("selectedName", customerName);
						model.addObject("lastForteenList", ticketsServiceInt
								.getTicketListByStatus("Resolved", "", "", customerName));
						model.addObject("countOpenTickets", ticketsServiceInt
								.getTicketCount("Open", "", "", customerName));
						model.addObject("countAcknowledgedTickets",
								ticketsServiceInt.getTicketCount("Acknowledged",
										"", "", customerName));
						model.addObject("countTakenTickets", ticketsServiceInt
								.getTicketCount("Taken",  "", "", customerName));
						model.addObject("countEscalatedTickets",
								ticketsServiceInt.getTicketCount("Escalated",
										"", "", customerName));
						model.addObject("countAwaitingSparesTickets",
								ticketsServiceInt.getTicketCount("Awaiting Spares",
										"", "", customerName));
						model.addObject("countBridgedTickets", ticketsServiceInt
								.getTicketCount("SLA Bridged", "", "", customerName));
						model.addObject("countResolvedTickets", ticketsServiceInt
								.getTicketCount("Resolved",  "", "", customerName));
						model.addObject("countClosedTickets", ticketsServiceInt
								.getTicketCount("Closed",  "", "", customerName));
					
					}
				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Resolved", selectedDateRange, "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", selectedDateRange, "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									 selectedDateRange, "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken",  selectedDateRange, "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									 selectedDateRange, "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									 selectedDateRange, "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", selectedDateRange, "", ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved",  selectedDateRange, "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed",  selectedDateRange, "", ""));
				
					
				} else if (tempEmployee != null) {
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Resolved", "", tempEmployee.getEmail(), ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "", tempEmployee.getEmail(), ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "", tempEmployee.getEmail(), ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "", tempEmployee.getEmail(), ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "", tempEmployee.getEmail(), ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "", tempEmployee.getEmail(), ""));
					model.addObject("selectedTechnician", tempEmployee);
				} else {

					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Resolved", "Last 14 Days", "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "Last 14 Days", "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"Last 14 Days", "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "Last 14 Days", "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"Last 14 Days", "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"Last 14 Days", "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "Last 14 Days", "",
									""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "Last 14 Days", "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "Last 14 Days", "", ""));

				}
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));

				model.setViewName("ticketmanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}


	// SLA Bridged Tickets
	@RequestMapping(value = "sLABridgedTickets", method = RequestMethod.GET)
	public ModelAndView sLABridgedTickets() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Technician")) {

				if (customerName != null) {

					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysClosedOrdersForTechnicianCustomer(
											userName.getEmail(), customerName));

				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(userName.getEmail(),
									selectedDateRange));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("orderList", ordersServiceInt
							.getLastFourteenDaysClosedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));

				} else {

					model.addObject("countOpenTickets", ticketsServiceInt
							.countOpenTickets(userName.getEmail()));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.countAcknowledgedTickets(userName
									.getEmail()));
					model.addObject("countTakenTickets", ticketsServiceInt
							.countTakenTickets(userName.getEmail()));
					model.addObject("countEscalatedTickets", ticketsServiceInt
							.countEscalatedTickets(userName.getEmail()));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt
									.countAwaitingSparesTickets(userName
											.getEmail()));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.countBridgedTickets(userName.getEmail()));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.countResolvedTickets(userName.getEmail()));
					model.addObject("countClosedTickets", ticketsServiceInt
							.countClosedTickets(userName.getEmail()));
				}
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers(userName.getEmail()));
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.setViewName("techticketmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() >= 2) {
						model.addObject("selectedName", customerName);
						model.addObject("lastForteenList", ticketsServiceInt
								.getTicketListByStatus("SLA Bridged", "", "", customerName));
						model.addObject("countOpenTickets", ticketsServiceInt
								.getTicketCount("Open", "", "", customerName));
						model.addObject("countAcknowledgedTickets",
								ticketsServiceInt.getTicketCount("Acknowledged",
										"", "", customerName));
						model.addObject("countTakenTickets", ticketsServiceInt
								.getTicketCount("Taken",  "", "", customerName));
						model.addObject("countEscalatedTickets",
								ticketsServiceInt.getTicketCount("Escalated",
										"", "", customerName));
						model.addObject("countAwaitingSparesTickets",
								ticketsServiceInt.getTicketCount("Awaiting Spares",
										"", "", customerName));
						model.addObject("countBridgedTickets", ticketsServiceInt
								.getTicketCount("SLA Bridged", "", "", customerName));
						model.addObject("countResolvedTickets", ticketsServiceInt
								.getTicketCount("Resolved",  "", "", customerName));
						model.addObject("countClosedTickets", ticketsServiceInt
								.getTicketCount("Closed",  "", "", customerName));
					
					}
				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("SLA Bridged", selectedDateRange, "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", selectedDateRange, "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									 selectedDateRange, "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken",  selectedDateRange, "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									 selectedDateRange, "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									 selectedDateRange, "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", selectedDateRange, "", ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved",  selectedDateRange, "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed",  selectedDateRange, "", ""));
				
					
				} else if (tempEmployee != null) {
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("SLA Bridged", "", tempEmployee.getEmail(), ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "", tempEmployee.getEmail(), ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "", tempEmployee.getEmail(), ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "", tempEmployee.getEmail(), ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "", tempEmployee.getEmail(), ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "", tempEmployee.getEmail(), ""));
					model.addObject("selectedTechnician", tempEmployee);
				} else {

					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("SLA Bridged", "Last 14 Days", "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "Last 14 Days", "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"Last 14 Days", "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "Last 14 Days", "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"Last 14 Days", "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"Last 14 Days", "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "Last 14 Days", "",
									""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "Last 14 Days", "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "Last 14 Days", "", ""));

				}
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));

				model.setViewName("ticketmanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}


	// Closed Tickets
	@RequestMapping(value = "closedTickets", method = RequestMethod.GET)
	public ModelAndView forClosedTickets() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Technician")) {

				if (customerName != null) {

					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysClosedOrdersForTechnicianCustomer(
											userName.getEmail(), customerName));

				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(userName.getEmail(),
									selectedDateRange));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("orderList", ordersServiceInt
							.getLastFourteenDaysClosedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));

				} else {

					model.addObject("countOpenTickets", ticketsServiceInt
							.countOpenTickets(userName.getEmail()));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.countAcknowledgedTickets(userName
									.getEmail()));
					model.addObject("countTakenTickets", ticketsServiceInt
							.countTakenTickets(userName.getEmail()));
					model.addObject("countEscalatedTickets", ticketsServiceInt
							.countEscalatedTickets(userName.getEmail()));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt
									.countAwaitingSparesTickets(userName
											.getEmail()));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.countBridgedTickets(userName.getEmail()));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.countResolvedTickets(userName.getEmail()));
					model.addObject("countClosedTickets", ticketsServiceInt
							.countClosedTickets(userName.getEmail()));
				}
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers(userName.getEmail()));
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.setViewName("techticketmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() >= 2) {
						model.addObject("selectedName", customerName);
						model.addObject("lastForteenList", ticketsServiceInt
								.getTicketListByStatus("Closed", "", "", customerName));
						model.addObject("countOpenTickets", ticketsServiceInt
								.getTicketCount("Open", "", "", customerName));
						model.addObject("countAcknowledgedTickets",
								ticketsServiceInt.getTicketCount("Acknowledged",
										"", "", customerName));
						model.addObject("countTakenTickets", ticketsServiceInt
								.getTicketCount("Taken",  "", "", customerName));
						model.addObject("countEscalatedTickets",
								ticketsServiceInt.getTicketCount("Escalated",
										"", "", customerName));
						model.addObject("countAwaitingSparesTickets",
								ticketsServiceInt.getTicketCount("Awaiting Spares",
										"", "", customerName));
						model.addObject("countBridgedTickets", ticketsServiceInt
								.getTicketCount("SLA Bridged", "", "", customerName));
						model.addObject("countResolvedTickets", ticketsServiceInt
								.getTicketCount("Resolved",  "", "", customerName));
						model.addObject("countClosedTickets", ticketsServiceInt
								.getTicketCount("Closed",  "", "", customerName));
					
					}
				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Closed", selectedDateRange, "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", selectedDateRange, "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									 selectedDateRange, "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken",  selectedDateRange, "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									 selectedDateRange, "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									 selectedDateRange, "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", selectedDateRange, "", ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved",  selectedDateRange, "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed",  selectedDateRange, "", ""));
				
					
				} else if (tempEmployee != null) {
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Closed", "", tempEmployee.getEmail(), ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "", tempEmployee.getEmail(), ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "", tempEmployee.getEmail(), ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "", tempEmployee.getEmail(), ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "", tempEmployee.getEmail(), ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "", tempEmployee.getEmail(), ""));
					model.addObject("selectedTechnician", tempEmployee);
				} else {

					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Closed", "Last 14 Days", "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "Last 14 Days", "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"Last 14 Days", "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "Last 14 Days", "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"Last 14 Days", "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"Last 14 Days", "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "Last 14 Days", "",
									""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "Last 14 Days", "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "Last 14 Days", "", ""));

				}
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));

				model.setViewName("ticketmanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}

	// Acknowledged Ticket
	@RequestMapping(value = "acknowledgedTicket")
	public ModelAndView receive(@RequestParam("recordID") int recordID) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Technician")) {

				if (customerName != null) {

					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysClosedOrdersForTechnicianCustomer(
											userName.getEmail(), customerName));

				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(userName.getEmail(),
									selectedDateRange));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("orderList", ordersServiceInt
							.getLastFourteenDaysClosedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));

				} else {

					model.addObject("countOpenTickets", ticketsServiceInt
							.countOpenTickets(userName.getEmail()));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.countAcknowledgedTickets(userName
									.getEmail()));
					model.addObject("countTakenTickets", ticketsServiceInt
							.countTakenTickets(userName.getEmail()));
					model.addObject("countEscalatedTickets", ticketsServiceInt
							.countEscalatedTickets(userName.getEmail()));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt
									.countAwaitingSparesTickets(userName
											.getEmail()));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.countBridgedTickets(userName.getEmail()));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.countResolvedTickets(userName.getEmail()));
					model.addObject("countClosedTickets", ticketsServiceInt
							.countClosedTickets(userName.getEmail()));
				}
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers(userName.getEmail()));
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.setViewName("techticketmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() >= 2) {
						model.addObject("selectedName", customerName);
						model.addObject("lastForteenList", ticketsServiceInt
								.getTicketListByStatus("Acknowledged", "", "", customerName));
						model.addObject("countOpenTickets", ticketsServiceInt
								.getTicketCount("Open", "", "", customerName));
						model.addObject("countAcknowledgedTickets",
								ticketsServiceInt.getTicketCount("Acknowledged",
										"", "", customerName));
						model.addObject("countTakenTickets", ticketsServiceInt
								.getTicketCount("Taken",  "", "", customerName));
						model.addObject("countEscalatedTickets",
								ticketsServiceInt.getTicketCount("Escalated",
										"", "", customerName));
						model.addObject("countAwaitingSparesTickets",
								ticketsServiceInt.getTicketCount("Awaiting Spares",
										"", "", customerName));
						model.addObject("countBridgedTickets", ticketsServiceInt
								.getTicketCount("SLA Bridged", "", "", customerName));
						model.addObject("countResolvedTickets", ticketsServiceInt
								.getTicketCount("Resolved",  "", "", customerName));
						model.addObject("countClosedTickets", ticketsServiceInt
								.getTicketCount("Closed",  "", "", customerName));
					
					}
				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Acknowledged", selectedDateRange, "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", selectedDateRange, "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									 selectedDateRange, "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken",  selectedDateRange, "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									 selectedDateRange, "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									 selectedDateRange, "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", selectedDateRange, "", ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved",  selectedDateRange, "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed",  selectedDateRange, "", ""));
				
					
				} else if (tempEmployee != null) {
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Acknowledged", "", tempEmployee.getEmail(), ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "", tempEmployee.getEmail(), ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "", tempEmployee.getEmail(), ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"", tempEmployee.getEmail(), ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "", tempEmployee.getEmail(), ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "", tempEmployee.getEmail(), ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "", tempEmployee.getEmail(), ""));
					model.addObject("selectedTechnician", tempEmployee);
				} else {

					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByStatus("Acknowledged", "Last 14 Days", "", ""));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", "Last 14 Days", "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									"Last 14 Days", "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken", "Last 14 Days", "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									"Last 14 Days", "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("Awaiting Spares",
									"Last 14 Days", "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", "Last 14 Days", "",
									""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved", "Last 14 Days", "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed", "Last 14 Days", "", ""));

				}
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));

				model.setViewName("ticketmanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}


	// Re-assign ticket
	@RequestMapping(value = "reAssign")
	public ModelAndView reAssign(@RequestParam("recordID") int recordID) {
		model = new ModelAndView();

		String reAssign = "reAssign";

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage",
					ordersServiceInt.approveShipment(recordID));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("reAssign", reAssign);

			model.setViewName("confirmation");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	// Re-open
	@RequestMapping(value = "reOpen")
	public ModelAndView reOpen(@RequestParam("recordID") int recordID) {
		model = new ModelAndView();

		String reOpen = "reOpen";

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage",
					ordersServiceInt.approveShipment(recordID));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("reOpen", reOpen);

			model.setViewName("confirmation");
		} else {
			model.setViewName("login");
		}
		return model;
	}
	
	
	@RequestMapping(value = "getTicketByCustomer", method = RequestMethod.GET)
	public ModelAndView getCustomerName(@RequestParam("customerName") String localCustomerName) {
		customerName = localCustomerName;
		selectedDateRange = null;
		tempEmployee = null;
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Technician")) {

				if (customerName != null) {

					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForTechnicianCustomer(
									userName.getEmail(), customerName));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForTechnician_Customer(
									userName.getEmail(), customerName));
					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysClosedOrdersForTechnicianCustomer(
											userName.getEmail(), customerName));

				} 
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers(userName.getEmail()));
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.setViewName("techticketmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() >= 2) {
						model.addObject("selectedName", customerName);
						model.addObject("lastForteenList", ticketsServiceInt
								.getTicketListByCustomerName(customerName));
						model.addObject("countOpenTickets", ticketsServiceInt
								.getTicketCount("Open", "", "", customerName));
						model.addObject("countAcknowledgedTickets",
								ticketsServiceInt.getTicketCount("Acknowledged",
										"", "", customerName));
						model.addObject("countTakenTickets", ticketsServiceInt
								.getTicketCount("Taken",  "", "", customerName));
						model.addObject("countEscalatedTickets",
								ticketsServiceInt.getTicketCount("Escalated",
										"", "", customerName));
						model.addObject("countAwaitingSparesTickets",
								ticketsServiceInt.getTicketCount("Awaiting Spares",
										"", "", customerName));
						model.addObject("countBridgedTickets", ticketsServiceInt
								.getTicketCount("SLA Bridged", "", "", customerName));
						model.addObject("countResolvedTickets", ticketsServiceInt
								.getTicketCount("Resolved",  "", "", customerName));
						model.addObject("countClosedTickets", ticketsServiceInt
								.getTicketCount("Closed",  "", "", customerName));
					
					}
				} 
				model.addObject("lastForteenList", ticketsServiceInt
						.getTicketListByCustomerName(customerName));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers());
				model.setViewName("ticketmanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}

	@RequestMapping(value = "getTicketBySelectedDate", method = RequestMethod.GET)
	public ModelAndView getTicketBySelectedDate(@RequestParam("selectedDate") String localSelectedDate) {
		selectedDateRange = localSelectedDate;
		customerName = null;
		tempEmployee = null;
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Technician")) {

				 if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(userName.getEmail(),
									selectedDateRange));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("countOrdersReceive", ordersServiceInt
							.countOrdersReceiveForSelectedDate(
									userName.getEmail(), selectedDateRange));
					model.addObject("orderList", ordersServiceInt
							.getLastFourteenDaysClosedOrdersForSelectedDate(
									userName.getEmail(), selectedDateRange));

				}
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers(userName.getEmail()));
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.setViewName("techticketmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("lastForteenList", ticketsServiceInt
							.getTicketListByDateRange(selectedDateRange));
					model.addObject("countOpenTickets", ticketsServiceInt
							.getTicketCount("Open", selectedDateRange, "", ""));
					model.addObject("countAcknowledgedTickets",
							ticketsServiceInt.getTicketCount("Acknowledged",
									 selectedDateRange, "", ""));
					model.addObject("countTakenTickets", ticketsServiceInt
							.getTicketCount("Taken",  selectedDateRange, "", ""));
					model.addObject("countEscalatedTickets",
							ticketsServiceInt.getTicketCount("Escalated",
									 selectedDateRange, "", ""));
					model.addObject("countAwaitingSparesTickets",
							ticketsServiceInt.getTicketCount("AwaitingSpares",
									 selectedDateRange, "", ""));
					model.addObject("countBridgedTickets", ticketsServiceInt
							.getTicketCount("SLA Bridged", selectedDateRange, "", ""));
					model.addObject("countResolvedTickets", ticketsServiceInt
							.getTicketCount("Resolved",  selectedDateRange, "", ""));
					model.addObject("countClosedTickets", ticketsServiceInt
							.getTicketCount("Closed",  selectedDateRange, "", ""));
				
				} 
				model.addObject("newDate", selectedDateRange);
				model.addObject("lastForteenList", ticketsServiceInt
						.getTicketListByDateRange(selectedDateRange));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("dates", ordersServiceInt.getDates());
				model.addObject("technicians",
						employeeServiceInt.getAllTechnicians());
				model.addObject("orderNumbers",
						ordersServiceInt.getOrderNumbers());

				model.setViewName("ticketmanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}
	
		

}
