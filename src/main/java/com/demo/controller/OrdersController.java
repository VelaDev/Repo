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

import com.demo.bean.OrdersBean;
import com.demo.dao.OrderDetailsDaoInt;
import com.demo.model.Employee;
import com.demo.model.OrderHeader;
import com.demo.model.OrderDetails;
import com.demo.service.BootStockInt;
import com.demo.service.CustomerContactDetailsServiceInt;
import com.demo.service.CustomerServiceInt;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.OrderDeliveryServiceInt;
import com.demo.service.OrderDetailsInt;
import com.demo.service.OrderHistoryInt;
import com.demo.service.OrdersServiceInt;
import com.demo.service.HOStockServeceInt;
import com.demo.service.SiteStockInt;
import com.demo.service.TicketsServiceInt;
import com.demo.service.VelaphandaInt;

@Controller
public class OrdersController {

	@Autowired
	private OrdersServiceInt ordersServiceInt;
	@Autowired
	private HOStockServeceInt spareParts;
	@Autowired
	private EmployeeServiceInt employeeServiceInt;
	@Autowired
	private CustomerServiceInt customerServiceInt;
	@Autowired
	private CustomerContactDetailsServiceInt contactDetailsServiceInt;
	@Autowired
	private OrderDetailsInt orderDetailsInt;
	@Autowired
	private BootStockInt bootStock;
	@Autowired
	private SiteStockInt siteStock;
	@Autowired
	private HttpSession session;
	@Autowired
	private OrderDeliveryServiceInt deliveryServiceInt;
	@Autowired
	private TicketsServiceInt ticketsServiceInt;
	@Autowired
	private OrderDetailsDaoInt detailsDaoInt;
	@Autowired
	private OrderHistoryInt historyInt;
	@Autowired
	private VelaphandaInt profile;
	private ModelAndView model = null;
	private String retMessage = null;
	private Employee userName = null;
	private String retPage, customerName, orderNum, selectDateRange, technicianName,
			selectedDateRange = null;
	public String[] getOrdersNumbers = null;

	@RequestMapping(value = "order", method = RequestMethod.GET)
	public ModelAndView loadOrder() {

		model = new ModelAndView("order");
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("makeOrder", new OrdersBean());
			model.addObject("compatibility",
					spareParts.getAllSparePartsWithoutZero());
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("customerList", customerServiceInt.getClientList());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("order");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "makeOrder", method = RequestMethod.POST)
	public ModelAndView makeOrder(@ModelAttribute("makeOrder") OrdersBean order) {
		model = new ModelAndView();
		String orders = "orders";
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			retMessage = ordersServiceInt.prepareOrderMaking(order);
			if (retMessage.startsWith("Order cannot be")) {
				String retErrorMessage = retMessage;
				model.addObject("retErrorMessage", retErrorMessage);
			} else {
				model.addObject("retMessage", retMessage);

			}
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				model.addObject("orders", orders);
				model.setViewName("confirmations");
				// model.setViewName("placeOrderForTechnician");
			} else if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("orders", orders);
				model.setViewName("confirmation");
				// model.setViewName("order");
			} else {
				model.setViewName("confirm");
				model.addObject("orders", orders);
				// model.setViewName("userPlaceOrder");
			}

		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("approveOrder")
	public ModelAndView getOrderDetails(@RequestParam Integer recordID,
			@ModelAttribute OrderHeader orderHeader) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			orderHeader = ordersServiceInt.getOrder(recordID);
			if (orderHeader != null) {
				model.setViewName("orderUpdate");
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("orderObject", orderHeader);
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
			} else {

			}
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping("updateOrder")
	public ModelAndView updateOrder(OrdersBean order) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			retMessage = ordersServiceInt.updateOrder(order);
			model.addObject("retMessage", retMessage);
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("orderUpdate");
		} else {
			model.setViewName("login");
		}
		return model;

	}

	@RequestMapping("approvedOrders")
	public ModelAndView approvedOrders() {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("orderList", ordersServiceInt.getOpenOrders());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("approvedOrders");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping("displayOrders")
	public ModelAndView displayOrders() {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("pendingOrderList",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.setViewName("displayOrders");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "pendingOrders", method = RequestMethod.GET)
	public ModelAndView displayPendingOrders() {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("pendingOrderList",
					ordersServiceInt.pendingOrders(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.setViewName("pendingOrders");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "approveOrder", method = RequestMethod.GET)
	public ModelAndView approveOrder(
			@RequestParam("recordID") Integer recordID,
			@ModelAttribute OrderDetails orderDetails) {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("pendingOrderList",
					orderDetailsInt.getOrderDetailsByOrderNum(recordID));
			model.addObject("RecordID", ordersServiceInt.getOrder(recordID));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.setViewName("approveOrder");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "approveOrderItems")
	public ModelAndView approveOrderItems(
			@RequestParam("recordID") Integer recordID) {
		model = new ModelAndView();
		String approverOrders = "approverOrders";

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage",
					ordersServiceInt.approveOrder(recordID));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("approverOrders", approverOrders);
			model.setViewName("confirmations");
			// model.setViewName("approveOrder");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "detailedOrders", method = RequestMethod.GET)
	public ModelAndView detailedOrders(
			@RequestParam("recordID") Integer recordID) {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("pendingOrderList",
					orderDetailsInt.getOrderDetailsByOrderNum(recordID));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("OrderNum", ordersServiceInt.getOrder(recordID));
			model.setViewName("detailedOrders");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "deliveryNote", method = RequestMethod.GET)
	public ModelAndView deliveries(@RequestParam("recordID") Integer recordID) {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			System.out.println("Re sa sheba fela " + recordID);
			OrderHeader order = ordersServiceInt.getOrder(recordID);
			List<OrderDetails> list = orderDetailsInt
					.getOrderDetailsByOrderNum("key", recordID);
			model.addObject("pendingOrderList", list);
			model.addObject("OrderNum", order);

			model.addObject("recordID", recordID);
			model.addObject("contactPerson", contactDetailsServiceInt
					.getContactPerson(userName.getFirstName()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			// model.setViewName("deliveryNote");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "printdeliveryNote", method = RequestMethod.GET)
	public ModelAndView deliveriesNote(
			@RequestParam("recordID") Integer recordID) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			deliveryServiceInt.createPdf(recordID);
			OrderHeader order = ordersServiceInt.getOrder(recordID);
			List<OrderDetails> list = orderDetailsInt
					.getOrderDetailsByOrderNum("key", recordID);
			model.addObject("pendingOrderList", list);
			model.addObject("OrderNum", order);

			model.addObject("recordID", recordID);
			model.addObject("contactPerson", contactDetailsServiceInt
					.getContactPerson(userName.getFirstName()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.setViewName("deliveryNote");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "availableStock", method = RequestMethod.GET)
	public ModelAndView availableStock() {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("availableOrders", siteStock.getAllOrders());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.setViewName("availableStock");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "availableBootStock", method = RequestMethod.GET)
	public ModelAndView availableBootStock() {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			String technician = userName.getFirstName() + " "
					+ userName.getLastName();
			model.addObject("availableOrders",
					bootStock.getAllOrders(technician));
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.setViewName("availableBootStock");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "viewApprovedOrders", method = RequestMethod.GET)
	public ModelAndView LoadViewApprovedOrders() {

		model = new ModelAndView("viewApprovedOrders");
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("shipment",
					ordersServiceInt.shippedOrders(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.setViewName("viewApprovedOrders");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "adminOrderHistory", "techOrderHistory" })
	public ModelAndView LoadOrderHistoryByDate(
			@RequestParam("startDate") String startDate,
			@RequestParam("endDate") String endDate) {
		model = new ModelAndView("orderHistory");
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("orderList",
					ordersServiceInt.getAllOrders(userName.getEmail()));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));

			if (userName.getRole().equalsIgnoreCase("Technician")) {
				model.addObject("orderList", ordersServiceInt.getAllOrders(
						startDate, endDate, userName.getEmail()));
				model.setViewName("orderHistory");
			}

			else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("orderList",
						ordersServiceInt.getAllOrders(startDate, endDate));
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());

				model.setViewName("ordersHistory");
			}

		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "orderHistory", "ordersHistory" }, method = RequestMethod.GET)
	public ModelAndView LoadOrderHistory() {

		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));

			if (userName.getRole().equalsIgnoreCase("Technician")) {
				List<OrderHeader> list = ordersServiceInt
						.getAllOrdersByDate(userName.getEmail());
				System.out.println();
				model.addObject("orderList", list);
				model.setViewName("orderHistory");
			}

			else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("orderList",
						ordersServiceInt.getAllOrdersByDate());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));

				model.setViewName("ordersHistory");
			}

		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "shipment")
	public ModelAndView shipment(@RequestParam("recordID") int recordID) {
		model = new ModelAndView();
		String shipOrder = "shipOrder";

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage",
					ordersServiceInt.approveShipment(recordID));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("shipOrder", shipOrder);
			model.setViewName("confirmations");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	@RequestMapping(value = "receive")
	public ModelAndView receive(@RequestParam("recordID") int recordID) {
		model = new ModelAndView();

		String receiveOrder = "receiveOrder";

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("retMessage",
					ordersServiceInt.approveShipment(recordID));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("receiveOrder", receiveOrder);
			model.setViewName("confirmation");
		} else {
			model.setViewName("login");
		}
		return model;
	}

	/*
	 * @RequestMapping("shippedOrders") public ModelAndView shippedOrders() {
	 * model = new ModelAndView();
	 * 
	 * userName = (Employee) session.getAttribute("loggedInUser"); if (userName
	 * != null) { model.addObject("pendingOrderList",
	 * ordersServiceInt.shippedOrders()); model.addObject("inboxCount",
	 * ordersServiceInt.pendingOrdersCount(userName.getEmail()));
	 * model.addObject("escalatedTickets",
	 * ticketsServiceInt.countEscalatedTickets());
	 * model.addObject("awaitingSparesTickets",
	 * ticketsServiceInt.countAwaitingSparesTickets());
	 * model.setViewName("shippedOrders"); } else { model.setViewName("login");
	 * }
	 * 
	 * return model; }
	 */

	@RequestMapping(value = "shipmentReceived")
	public ModelAndView shipmentReceived(@RequestParam("recordID") int recordID) {
		String receiveOrder = "receiveOrder";
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("retMessage",
					ordersServiceInt.approveShipment(recordID));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());

			model.addObject("receiveOrder", receiveOrder);
			model.setViewName("confirmations");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = { "orderItemHistory", "ordersItemHistory" }, method = RequestMethod.GET)
	public ModelAndView orderHistory(@RequestParam("recordID") Integer recordID) {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			OrderHeader ord = ordersServiceInt.getOrder(recordID);
			Employee appoer = employeeServiceInt.getEmployeeByEmpNumber(ord
					.getApprover());
			String approverName = appoer.getFirstName() + " "
					+ appoer.getLastName();
			model.addObject("pendingOrderList",
					orderDetailsInt.getOrderDetailsByOrderNum(recordID));
			model.addObject("OrderNum", ordersServiceInt.getOrder(recordID));
			model.addObject("status",
					historyInt.getAllOrderHistoryByOrderNumber(recordID));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("ticketCount", ticketsServiceInt
					.ticketCountForTechnician(userName.getEmail()));
			model.addObject("velaphandaAddres", profile
					.getVelaphandaAddress("Velaphanda Trading & Projects"));
			model.addObject("approver", approverName);

			if (userName.getRole().equalsIgnoreCase("Technician")) {

				model.setViewName("orderItemHistory");
			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				model.addObject("pendingOrderList",
						orderDetailsInt.getOrderDetailsByOrderNum(recordID));
				model.addObject("OrderNum", ordersServiceInt.getOrder(recordID));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("velaphandaAddres", profile
						.getVelaphandaAddress("Velaphanda Trading & Projects"));
				model.addObject("status",
						historyInt.getAllOrderHistoryByOrderNumber(recordID));

				model.setViewName("ordersItemHistory");
			}

		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "declineOrder", method = RequestMethod.GET)
	public ModelAndView displayDeclineOrders(
			@RequestParam("recordID") Integer recordID) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("declinedOrder", new OrdersBean());
			model.addObject("OrderNum", ordersServiceInt.getOrder(recordID));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.setViewName("declineOrder");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "declinedOrder", method = RequestMethod.POST)
	public ModelAndView declineOrders(
			@ModelAttribute("declinedOrder") OrdersBean order) {
		String declineOrder = "declineOrder";
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			retMessage = ordersServiceInt.declineOrder(order.getOrderNum(),
					order.getComments());
			model.addObject("retMessage", retMessage);
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("declineOrder", declineOrder);
			model.setViewName("confirmations");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "viewAllOrders", method = RequestMethod.GET)
	public ModelAndView viewOrders() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("orders", ordersServiceInt.getAllOrders());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.setViewName("viewAllOrders");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "viewAllUserOrders", method = RequestMethod.GET)
	public ModelAndView viewUserOrders() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("orders", ordersServiceInt.getAllOrders());
			model.setViewName("viewAllUserOrders");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "placeOrderForTechnician", method = RequestMethod.GET)
	public ModelAndView loadMakeOrder() {

		model = new ModelAndView("placeOrderForTechnician");
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("placeOrderForTechnician", new OrdersBean());
			model.addObject("compatibility",
					spareParts.getAllSparePartsWithoutZero());
			model.addObject("technicianList",
					employeeServiceInt.getAllTechnicians());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.addObject("customerList", customerServiceInt.getClientList());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("placeOrderForTechnician");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "userPlaceOrder", method = RequestMethod.GET)
	public ModelAndView loaduserMakeOrder() {

		model = new ModelAndView("userPlaceOrder");
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.addObject("placeOrderForTechnician", new OrdersBean());
			model.addObject("compatibility",
					spareParts.getAllSparePartsWithoutZero());
			model.addObject("technicianList",
					employeeServiceInt.getAllTechnicians());
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("customerList", customerServiceInt.getClientList());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("userPlaceOrder");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "viewAllOrderDetails", method = RequestMethod.GET)
	public ModelAndView displayOrderDeails(
			@RequestParam("recordID") Integer recordID,
			@ModelAttribute OrderDetails orderDetails) {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("pendingOrderList",
					orderDetailsInt.getOrderDetailsByOrderNum(recordID));
			model.addObject("RecordID", ordersServiceInt.getOrder(recordID));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.setViewName("viewAllOrderDetails");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "viewAllUserOrderDetails", method = RequestMethod.GET)
	public ModelAndView displayUserOrderDeails(
			@RequestParam("recordID") Integer recordID,
			@ModelAttribute OrderDetails orderDetails) {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("pendingOrderList",
					orderDetailsInt.getOrderDetailsByOrderNum(recordID));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("RecordID", ordersServiceInt.getOrder(recordID));
			model.setViewName("viewAllUserOrderDetails");
		} else {
			model.setViewName("login");
		}

		return model;
	}
	@RequestMapping(value = "ordermanagement", method = RequestMethod.GET)
	public ModelAndView displayOrderManagement() {
		model = new ModelAndView();
		customerName = null;
		selectedDateRange = null;
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("pendingOrderList",
					ordersServiceInt.pendingOrders(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("orderList",
					ordersServiceInt.getLastFourteenDaysOrders());
			model.addObject("customers", customerServiceInt.getClientList());
			model.addObject("countNewOrders",
					ordersServiceInt.countNewOrders(""));
			model.addObject("countApprovedOrder",
					ordersServiceInt.countApprovedOrders(""));
			model.addObject("countShippedOrder",
					ordersServiceInt.countShippedOrders(""));
			model.addObject("countClosedOrder",
					ordersServiceInt.countClosedOrder(""));
			model.addObject("countRejectedOrder",
					ordersServiceInt.countRejectedOrders(""));
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("orderNumbers", ordersServiceInt.getOrderNumbers());
			model.addObject("technicians",employeeServiceInt.getAllTechnicians());
			model.setViewName("ordermanagement");
		} else {
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value = "ordertechmanagement", method = RequestMethod.GET)
	public ModelAndView displayOrderTechManagement() {
		customerName = null;
		selectedDateRange = null;
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
			model.addObject("inboxCount",ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
			model.addObject("orderList",ordersServiceInt.getLastFourteenDaysOrders(userName.getEmail()));
			model.addObject("customers",customerServiceInt.getClientList());
			model.addObject("countNewOrders",ordersServiceInt.countNewOrders("", userName.getEmail()));
			model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceive("", userName.getEmail()));
			model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrders(""));
			model.addObject("countShippedOrder",ordersServiceInt.countShippedOrders(""));
			model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrders(userName.getEmail()));
			// model.addObject("countClosedOrder",ordersServiceInt.countClosedOrderForCustomer(userName.getEmail()));
			model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForTechnician(userName.getEmail()));
			model.addObject("ticketCount", ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("orderNumbers", ordersServiceInt.getOrderNumbers());
			model.setViewName("ordertechmanagement");
		} else {
			model.setViewName("login");
		}
		return model;
	}
	@RequestMapping(value = "searchOrderNumber")
	public ModelAndView searchOrderNumber(
			@RequestParam("orderNumber") String localOrderNum) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		orderNum = localOrderNum;
		
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("orderList", ordersServiceInt.getLastFourteenDaysOrdersNumber(orderNum));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("countNewOrders", ordersServiceInt.countNewOrders(orderNum));
				model.addObject("countApprovedOrder", ordersServiceInt.countApprovedOrders(orderNum));
				model.addObject("countShippedOrder", ordersServiceInt.countShippedOrders(orderNum));
				model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrder("",orderNum));
				model.addObject("countClosedOrder", ordersServiceInt.countClosedOrder(orderNum));
				model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
				model.setViewName("ordermanagement");
			} else if (userName.getRole().equalsIgnoreCase("Technician")) {

				model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("orderList", ordersServiceInt.getLastFourteenDaysOrdersNumber(orderNum));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("countNewOrders", ordersServiceInt.countNewOrders("", userName.getEmail()));
				model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceive("",userName.getEmail()));
				model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrders(""));
				model.addObject("countShippedOrder",ordersServiceInt.countShippedOrders(""));
				model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrder("",userName.getEmail()));
				model.addObject("countClosedOrder",ordersServiceInt.countClosedOrder(""));
				model.addObject("ticketCount", ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
				model.setViewName("ordertechmanagement");
			}
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "ordersToApprove", method = RequestMethod.GET)
	public ModelAndView ordersToApprove() {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (customerName != null) {
				if (customerName.length() > 3) {
					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForCustomer(customerName));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForCustomer(customerName));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForCustomer(customerName));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForCustomer(customerName));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForCustomer(customerName));
					System.err.println(customerName);
					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysPendingOrdersForCustomer(customerName));

				}
			} else if (selectedDateRange != null) {
				model.addObject("newDate", selectedDateRange);
				model.addObject("countNewOrders", ordersServiceInt
						.countNewOrdersForSelectedDate(selectedDateRange));
				model.addObject("countApprovedOrder", ordersServiceInt
						.countApprovedOrdersForSelectedDate(selectedDateRange));
				model.addObject("countShippedOrder", ordersServiceInt
						.countShippedOrdersForSelectedDate(selectedDateRange));
				model.addObject("countClosedOrder", ordersServiceInt
						.countClosedOrderForSelectedDate(selectedDateRange));
				model.addObject("countRejectedOrder", ordersServiceInt
						.countRejectedOrderForSelectedDate(selectedDateRange));
				model.addObject("countOrdersReceive", ordersServiceInt
						.countOrdersReceiveForSelectedDate(selectedDateRange));

				model.addObject(
						"orderList",
						ordersServiceInt
								.getLastFourteenDaysPendingOrdersForSelectedDate(selectedDateRange));

				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
			} else {

				model.addObject("countNewOrders",
						ordersServiceInt.countNewOrders(""));
				model.addObject("countApprovedOrder",
						ordersServiceInt.countApprovedOrders(""));
				model.addObject("countShippedOrder",
						ordersServiceInt.countShippedOrders(""));
				model.addObject("countClosedOrder",
						ordersServiceInt.countClosedOrder(""));
				model.addObject("countRejectedOrder",
						ordersServiceInt.countRejectedOrders(""));
				model.addObject("orderList",
						ordersServiceInt.getLastFourteenDaysPendingOrders());

			}

			model.addObject("pendingOrderList",
					ordersServiceInt.pendingOrders(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("customers", customerServiceInt.getClientList());

			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.setViewName("ordermanagement");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "ordersToShip", method = RequestMethod.GET)
	public ModelAndView ordersToShip() {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (customerName != null) {
				if (customerName.length() > 3) {
					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForCustomer(customerName));
					model.addObject("countApprovedOrder", ordersServiceInt
							.countApprovedOrdersForCustomer(customerName));
					model.addObject("countShippedOrder", ordersServiceInt
							.countShippedOrdersForCustomer(customerName));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForCustomer(customerName));
					model.addObject("countRejectedOrder", ordersServiceInt
							.countRejectedOrderForCustomer(customerName));
					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysApprovedOrdersForCustomer(customerName));

				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countApprovedOrder",
							ordersServiceInt
									.countApprovedOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countShippedOrder",
							ordersServiceInt
									.countShippedOrdersForSelectedDate(selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countRejectedOrder",
							ordersServiceInt
									.countRejectedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countOrdersReceive",
							ordersServiceInt
									.countOrdersReceiveForSelectedDate(selectedDateRange));

					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysApprovedOrdersForSelectedDate(selectedDateRange));

					model.addObject("pendingOrderList",
							ordersServiceInt.pendingOrders(userName.getEmail()));
					model.addObject("inboxCount", ordersServiceInt
							.pendingOrdersCount(userName.getEmail()));
					model.addObject("escalatedTickets",
							ticketsServiceInt.countEscalatedTickets());
					model.addObject("customers",
							customerServiceInt.getClientList());
					model.addObject("ticketCount", ticketsServiceInt
							.ticketCountForTechnician(userName.getEmail()));
					model.addObject("awaitingSparesTickets",
							ticketsServiceInt.countAwaitingSparesTickets());
				}
			} else {
				model.addObject("countNewOrders",
						ordersServiceInt.countNewOrders(""));
				model.addObject("countApprovedOrder",
						ordersServiceInt.countApprovedOrders(""));
				model.addObject("countShippedOrder",
						ordersServiceInt.countShippedOrders(""));
				model.addObject("countClosedOrder",
						ordersServiceInt.countClosedOrder(""));
				model.addObject("countRejectedOrder",
						ordersServiceInt.countRejectedOrders(""));

				model.addObject("orderList",
						ordersServiceInt.getLastFourteenDaysApprovedOrders());
			}
			model.addObject("pendingOrderList",
					ordersServiceInt.pendingOrders(userName.getEmail()));
			model.addObject("inboxCount",
					ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",
					ticketsServiceInt.countEscalatedTickets());
			model.addObject("customers", customerServiceInt.getClientList());
			model.addObject("awaitingSparesTickets",
					ticketsServiceInt.countAwaitingSparesTickets());
			model.setViewName("ordermanagement");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "ShippedOrders", method = RequestMethod.GET)
	public ModelAndView shippedOrderDetails() {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() > 3) {
						model.addObject("selectedName", customerName);
						model.addObject("countNewOrders", ordersServiceInt
								.countNewOrdersForCustomer(customerName));
						model.addObject("countApprovedOrder", ordersServiceInt
								.countApprovedOrdersForCustomer(customerName));
						model.addObject("countShippedOrder", ordersServiceInt
								.countShippedOrdersForCustomer(customerName));
						model.addObject("countClosedOrder", ordersServiceInt
								.countClosedOrderForCustomer(customerName));
						model.addObject("countRejectedOrder", ordersServiceInt
								.countRejectedOrderForCustomer(customerName));
						model.addObject(
								"orderList",
								ordersServiceInt
										.getLastFourteenDaysShippedOrdersForCustomer(customerName));

					}
				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countApprovedOrder",
							ordersServiceInt
									.countApprovedOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countShippedOrder",
							ordersServiceInt
									.countShippedOrdersForSelectedDate(selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countRejectedOrder",
							ordersServiceInt
									.countRejectedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countOrdersReceive",
							ordersServiceInt
									.countOrdersReceiveForSelectedDate(selectedDateRange));

					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysShippedOrdersForSelectedDate(selectedDateRange));

					model.addObject("pendingOrderList",
							ordersServiceInt.pendingOrders(userName.getEmail()));
					model.addObject("inboxCount", ordersServiceInt
							.pendingOrdersCount(userName.getEmail()));
					model.addObject("escalatedTickets",
							ticketsServiceInt.countEscalatedTickets());
					model.addObject("customers",
							customerServiceInt.getClientList());
					model.addObject("ticketCount", ticketsServiceInt
							.ticketCountForTechnician(userName.getEmail()));
					model.addObject("awaitingSparesTickets",
							ticketsServiceInt.countAwaitingSparesTickets());
				}

				else {
					model.addObject("countNewOrders",
							ordersServiceInt.countNewOrders(""));
					model.addObject("countApprovedOrder",
							ordersServiceInt.countApprovedOrders(""));
					model.addObject("countShippedOrder",
							ordersServiceInt.countShippedOrders(""));
					model.addObject("countClosedOrder",
							ordersServiceInt.countClosedOrder(""));
					model.addObject("countRejectedOrder",
							ordersServiceInt.countRejectedOrders(""));

					model.addObject("orderList",
							ordersServiceInt.getLastFourteenDaysShippedOrders());
				}
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.setViewName("ordermanagement");
			}
		} else {
			model.setViewName("login");
		}

		return model;
	}

	@RequestMapping(value = "closedOrders", method = RequestMethod.GET)
	public ModelAndView closedOrders() {
		model = new ModelAndView();
		System.err.println(" Inside closed orders for manager " + customerName);
		System.err.println(" Inside closed orders for manager "
				+ selectedDateRange);
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			if (userName.getRole().equalsIgnoreCase("Technician")) {
				if (customerName != null) {
					model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForTechnician_Customer(userName.getEmail(),customerName));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrdersForTechnician_Customer(userName.getEmail(),customerName));
					model.addObject("countShippedOrder",ordersServiceInt.countShippedOrdersForTechnicianCustomer(userName.getEmail(),customerName));
					model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForTechnician_Customer(userName.getEmail(),customerName));
					model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrderForTechnicianCustomer(userName.getEmail(),customerName));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceiveForTechnician_Customer(userName.getEmail(),customerName));
					model.addObject("orderList",ordersServiceInt.getLastFourteenDaysClosedOrdersForTechnicianCustomer(userName.getEmail(),customerName));
					
				}else if(selectedDateRange!=null){
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countShippedOrder",ordersServiceInt.countShippedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceiveForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("orderList",ordersServiceInt.getLastFourteenDaysClosedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					
				}else{
					
					model.addObject("orderList", ordersServiceInt.getLastFourteenDaysClosedOrders(userName.getEmail()));
					
					model.addObject("countNewOrders", ordersServiceInt.countNewOrders("", userName.getEmail()));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceive("",userName.getEmail()));
					
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrders("",userName.getEmail()));
					model.addObject("countShippedOrder",ordersServiceInt.countShippedOrders("",userName.getEmail()));
					model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForTechnician(userName.getEmail()));
					model.addObject("countRejectedOrder", ordersServiceInt.countRejectedOrders(userName.getEmail()));
				}
				model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("ticketCount", ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.setViewName("ordertechmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() > 3) {
						model.addObject("selectedName", customerName);
						model.addObject("countNewOrders", ordersServiceInt
								.countNewOrdersForCustomer(customerName));
						model.addObject("countApprovedOrder", ordersServiceInt
								.countApprovedOrdersForCustomer(customerName));
						model.addObject("countShippedOrder", ordersServiceInt
								.countShippedOrdersForCustomer(customerName));
						model.addObject("countClosedOrder", ordersServiceInt
								.countClosedOrderForCustomer(customerName));
						model.addObject("countOrdersReceive", ordersServiceInt
								.countOrdersReceiveForCustomer(customerName));
						model.addObject("countRejectedOrder", ordersServiceInt
								.countRejectedOrders(customerName));
						model.addObject(
								"orderList",
								ordersServiceInt
										.getLastFourteenDaysClosedOrdersForCustomer(customerName));
					}
				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countApprovedOrder",
							ordersServiceInt
									.countApprovedOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countShippedOrder",
							ordersServiceInt
									.countShippedOrdersForSelectedDate(selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countRejectedOrder",
							ordersServiceInt
									.countRejectedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countOrdersReceive",
							ordersServiceInt
									.countOrdersReceiveForSelectedDate(selectedDateRange));

					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysClosedOrdersForSelectedDate(selectedDateRange));

					model.addObject("pendingOrderList",
							ordersServiceInt.pendingOrders(userName.getEmail()));
					model.addObject("inboxCount", ordersServiceInt
							.pendingOrdersCount(userName.getEmail()));
					model.addObject("escalatedTickets",
							ticketsServiceInt.countEscalatedTickets());
					model.addObject("customers",
							customerServiceInt.getClientList());
					model.addObject("ticketCount", ticketsServiceInt
							.ticketCountForTechnician(userName.getEmail()));
					model.addObject("awaitingSparesTickets",
							ticketsServiceInt.countAwaitingSparesTickets());
				} else {

					model.addObject("countNewOrders",
							ordersServiceInt.countNewOrders(""));
					model.addObject("countApprovedOrder",
							ordersServiceInt.countApprovedOrders(""));
					model.addObject("countShippedOrder",
							ordersServiceInt.countShippedOrders(""));
					model.addObject("countClosedOrder",
							ordersServiceInt.countClosedOrder(""));
					model.addObject("countOrdersReceive",
							ordersServiceInt.countOrdersReceive(""));
					model.addObject("countRejectedOrder",
							ordersServiceInt.countRejectedOrders(""));

					model.addObject("orderList",
							ordersServiceInt.getLastFourteenDaysClosedOrders());
				}

				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());

				model.setViewName("ordermanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}

	@RequestMapping(value = "rejectedOrders", method = RequestMethod.GET)
	public ModelAndView rejectedOrders() {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {
				if (customerName != null) {
					if (customerName.length() > 3) {
						model.addObject("selectedName", customerName);
						model.addObject("countNewOrders", ordersServiceInt
								.countNewOrdersForCustomer(customerName));
						model.addObject("countApprovedOrder", ordersServiceInt
								.countApprovedOrdersForCustomer(customerName));
						model.addObject("countShippedOrder", ordersServiceInt
								.countShippedOrdersForCustomer(customerName));
						model.addObject("countClosedOrder", ordersServiceInt
								.countClosedOrderForCustomer(customerName));
						model.addObject("countRejectedOrder", ordersServiceInt
								.countRejectedOrderForCustomer(customerName));
						model.addObject(
								"orderList",
								ordersServiceInt
										.getLastFourteenDaysRejectedOrdersForCustomer(customerName));

					}
				} else if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countApprovedOrder",
							ordersServiceInt
									.countApprovedOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countShippedOrder",
							ordersServiceInt
									.countShippedOrdersForSelectedDate(selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countRejectedOrder",
							ordersServiceInt
									.countRejectedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countOrdersReceive",
							ordersServiceInt
									.countOrdersReceiveForSelectedDate(selectedDateRange));

					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysRejectedOrdersForSelectedDate(selectedDateRange));

					model.addObject("pendingOrderList",
							ordersServiceInt.pendingOrders(userName.getEmail()));
					model.addObject("inboxCount", ordersServiceInt
							.pendingOrdersCount(userName.getEmail()));
					model.addObject("escalatedTickets",
							ticketsServiceInt.countEscalatedTickets());
					model.addObject("customers",
							customerServiceInt.getClientList());
					model.addObject("ticketCount", ticketsServiceInt
							.ticketCountForTechnician(userName.getEmail()));
					model.addObject("awaitingSparesTickets",
							ticketsServiceInt.countAwaitingSparesTickets());
				} else {
					model.addObject("countNewOrders",
							ordersServiceInt.countNewOrders(""));
					model.addObject("countApprovedOrder",
							ordersServiceInt.countApprovedOrders(""));
					model.addObject("countShippedOrder",
							ordersServiceInt.countShippedOrders(""));
					model.addObject("countClosedOrder",
							ordersServiceInt.countClosedOrder(""));
					model.addObject("countRejectedOrder",
							ordersServiceInt.countRejectedOrders(""));

					model.addObject("orderList", ordersServiceInt
							.getLastFourteenDaysRejectedOrders());
				}
				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.setViewName("ordermanagement");
			} else if (userName.getRole().equalsIgnoreCase("Technician")) {
				
				
                 if (customerName != null) {
                	 model.addObject("selectedName", customerName);
					model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForTechnician_Customer(userName.getEmail(),customerName));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrdersForTechnician_Customer(userName.getEmail(),customerName));
					model.addObject("countShippedOrder",ordersServiceInt.countShippedOrdersForTechnicianCustomer(userName.getEmail(),customerName));
					model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForTechnician_Customer(userName.getEmail(),customerName));
					model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrderForTechnicianCustomer(userName.getEmail(),customerName));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceiveForTechnician_Customer(userName.getEmail(),customerName));
					model.addObject("orderList",ordersServiceInt.getLastFourteenDaysRejectedOrdersForTechnicianCustomer(userName.getEmail(),customerName));
					
				}else if(selectedDateRange!=null){
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countShippedOrder",ordersServiceInt.countShippedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceiveForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("orderList",ordersServiceInt.getLastFourteenDaysRejectedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					
				}else{
					
					model.addObject("orderList", ordersServiceInt.getLastFourteenDaysRejectedOrders(userName.getEmail()));
					
					model.addObject("countNewOrders", ordersServiceInt.countNewOrders("", userName.getEmail()));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceive("",userName.getEmail()));
					
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrders("",userName.getEmail()));
					model.addObject("countShippedOrder",ordersServiceInt.countShippedOrders("",userName.getEmail()));
					model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForTechnician(userName.getEmail()));
					model.addObject("countRejectedOrder", ordersServiceInt.countRejectedOrders(userName.getEmail()));
				}
				model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("ticketCount", ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.setViewName("ordertechmanagement");
				
			}
		} else {
			model.setViewName("login");
		}

		return model;
	}

	// 24Hours
	@RequestMapping(value = "24Hours", method = RequestMethod.GET)
	public ModelAndView twofourHours(
			@RequestParam("selectedDate") String localSelectedDate) {
		model = new ModelAndView();
		selectedDateRange = localSelectedDate;
		System.err.println(selectedDateRange);
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			if (userName.getRole().equalsIgnoreCase("Technician")) {
				if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countShippedOrder",ordersServiceInt.countShippedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceiveForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("orderList",ordersServiceInt.getLastFourteenDaysOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("newDate", selectedDateRange);
				}else{
					
					model.addObject("orderList", ordersServiceInt.getLastFourteenDaysClosedOrders(userName.getEmail()));
				
					model.addObject("countNewOrders", ordersServiceInt.countNewOrders("", userName.getEmail()));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceive("",userName.getEmail()));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrders("",userName.getEmail()));
					model.addObject("countShippedOrder", ordersServiceInt.countShippedOrdersForSelectedDate("24Hours"));
					model.addObject("countClosedOrder",ordersServiceInt.countClosedOrder(userName.getEmail()));
					model.addObject("countRejectedOrder", ordersServiceInt.countRejectedOrder(userName.getEmail(), customerName));
					
				}
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("ticketCount", ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
				

				model.setViewName("ordertechmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				if (selectedDateRange != null) {
					
					model.addObject("selectedDate","Last 24 Hours");
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countApprovedOrder",
							ordersServiceInt
									.countApprovedOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countShippedOrder",
							ordersServiceInt
									.countShippedOrdersForSelectedDate(selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countRejectedOrder",
							ordersServiceInt
									.countRejectedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countOrdersReceive",
							ordersServiceInt
									.countOrdersReceiveForSelectedDate(selectedDateRange));

					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysOrdersForSelectedDate(selectedDateRange));

					model.addObject("pendingOrderList",
							ordersServiceInt.pendingOrders(userName.getEmail()));
					model.addObject("inboxCount", ordersServiceInt
							.pendingOrdersCount(userName.getEmail()));
					model.addObject("escalatedTickets",
							ticketsServiceInt.countEscalatedTickets());
					model.addObject("customers",
							customerServiceInt.getClientList());
					model.addObject("ticketCount", ticketsServiceInt
							.ticketCountForTechnician(userName.getEmail()));
					model.addObject("awaitingSparesTickets",
							ticketsServiceInt.countAwaitingSparesTickets());
				} else {

					model.addObject("countNewOrders",
							ordersServiceInt.countNewOrders(""));
					model.addObject("countApprovedOrder",
							ordersServiceInt.countApprovedOrders(""));
					model.addObject("countShippedOrder",
							ordersServiceInt.countShippedOrders(""));
					model.addObject("countClosedOrder",
							ordersServiceInt.countClosedOrder(""));
					model.addObject("countOrdersReceive",
							ordersServiceInt.countOrdersReceive(""));
					model.addObject("countRejectedOrder",
							ordersServiceInt.countRejectedOrders(""));

					model.addObject("orderList",
							ordersServiceInt.getLastFourteenDaysOrders());
				}

				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());

				model.setViewName("ordermanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}

	// Last7Days
	@RequestMapping(value = "Last7Days", method = RequestMethod.GET)
	public ModelAndView Last7Days(
			@RequestParam("selectedDate") String localSelectedDate) {
		model = new ModelAndView();
		selectedDateRange = localSelectedDate;
		System.err.println(selectedDateRange);
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			if (userName.getRole().equalsIgnoreCase("Technician")) {
                if (selectedDateRange != null) {
                	model.addObject("newDate", "Last 7 Days");
					model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countShippedOrder",ordersServiceInt.countShippedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceiveForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("orderList",ordersServiceInt.getLastFourteenDaysOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
				}else{
					
					model.addObject("orderList", ordersServiceInt.getLastFourteenDaysClosedOrders(userName.getEmail()));
				
					model.addObject("countNewOrders", ordersServiceInt.countNewOrders("", userName.getEmail()));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceive("",userName.getEmail()));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrders("",userName.getEmail()));
					model.addObject("countShippedOrder", ordersServiceInt.countShippedOrdersForSelectedDate("24Hours"));
					model.addObject("countClosedOrder",ordersServiceInt.countClosedOrder(userName.getEmail()));
					model.addObject("countRejectedOrder", ordersServiceInt.countRejectedOrder(userName.getEmail(), customerName));
					
				}
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("ticketCount", ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
				

				model.setViewName("ordertechmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				if (selectedDateRange != null) {
					model.addObject("newDate", "Last 7 Days");
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countApprovedOrder",
							ordersServiceInt
									.countApprovedOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countShippedOrder",
							ordersServiceInt
									.countShippedOrdersForSelectedDate(selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countRejectedOrder",
							ordersServiceInt
									.countRejectedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countOrdersReceive",
							ordersServiceInt
									.countOrdersReceiveForSelectedDate(selectedDateRange));

					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysOrdersForSelectedDate(selectedDateRange));

					model.addObject("pendingOrderList",
							ordersServiceInt.pendingOrders(userName.getEmail()));
					model.addObject("inboxCount", ordersServiceInt
							.pendingOrdersCount(userName.getEmail()));
					model.addObject("escalatedTickets",
							ticketsServiceInt.countEscalatedTickets());
					model.addObject("customers",
							customerServiceInt.getClientList());
					model.addObject("ticketCount", ticketsServiceInt
							.ticketCountForTechnician(userName.getEmail()));
					model.addObject("awaitingSparesTickets",
							ticketsServiceInt.countAwaitingSparesTickets());
				} else {

					model.addObject("countNewOrders",
							ordersServiceInt.countNewOrders(""));
					model.addObject("countApprovedOrder",
							ordersServiceInt.countApprovedOrders(""));
					model.addObject("countShippedOrder",
							ordersServiceInt.countShippedOrders(""));
					model.addObject("countClosedOrder",
							ordersServiceInt.countClosedOrder(""));
					model.addObject("countOrdersReceive",
							ordersServiceInt.countOrdersReceive(""));
					model.addObject("countRejectedOrder",
							ordersServiceInt.countRejectedOrders(""));

					model.addObject("orderList",
							ordersServiceInt.getLastFourteenDaysOrders());
				}

				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());

				model.setViewName("ordermanagement");

			} else {
				model.setViewName("login");
			}
		}

		return model;
	}

	// Last14Days
	@RequestMapping(value = "Last14Days", method = RequestMethod.GET)
	public ModelAndView Last14Days(
			@RequestParam("selectedDate") String localSelectedDate) {
		model = new ModelAndView();
		selectedDateRange = localSelectedDate;
		System.err.println(selectedDateRange);
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			if (userName.getRole().equalsIgnoreCase("Technician")) {
                 if (selectedDateRange != null) {
                	 model.addObject("newDate", "Last 14 Days");
					model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countShippedOrder",ordersServiceInt.countShippedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceiveForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("orderList",ordersServiceInt.getLastFourteenDaysOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
				}else{
					
					model.addObject("orderList", ordersServiceInt.getLastFourteenDaysClosedOrders(userName.getEmail()));
				
					model.addObject("countNewOrders", ordersServiceInt.countNewOrders("", userName.getEmail()));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceive("",userName.getEmail()));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrders("",userName.getEmail()));
					model.addObject("countShippedOrder", ordersServiceInt.countShippedOrdersForSelectedDate("24Hours"));
					model.addObject("countClosedOrder",ordersServiceInt.countClosedOrder(userName.getEmail()));
					model.addObject("countRejectedOrder", ordersServiceInt.countRejectedOrder(userName.getEmail(), customerName));
					
				}
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("ticketCount", ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
				

				model.setViewName("ordertechmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				if (selectedDateRange != null) {
					model.addObject("newDate", "Last 14 Days");
					model.addObject("countNewOrders", ordersServiceInt
							.countNewOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countApprovedOrder",
							ordersServiceInt
									.countApprovedOrdersForSelectedDate(selectedDateRange));
					model.addObject(
							"countShippedOrder",
							ordersServiceInt
									.countShippedOrdersForSelectedDate(selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt
							.countClosedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countRejectedOrder",
							ordersServiceInt
									.countRejectedOrderForSelectedDate(selectedDateRange));
					model.addObject(
							"countOrdersReceive",
							ordersServiceInt
									.countOrdersReceiveForSelectedDate(selectedDateRange));

					model.addObject(
							"orderList",
							ordersServiceInt
									.getLastFourteenDaysOrdersForSelectedDate(selectedDateRange));

					model.addObject("pendingOrderList",
							ordersServiceInt.pendingOrders(userName.getEmail()));
					model.addObject("inboxCount", ordersServiceInt
							.pendingOrdersCount(userName.getEmail()));
					model.addObject("escalatedTickets",
							ticketsServiceInt.countEscalatedTickets());
					model.addObject("customers",
							customerServiceInt.getClientList());
					model.addObject("ticketCount", ticketsServiceInt
							.ticketCountForTechnician(userName.getEmail()));
					model.addObject("awaitingSparesTickets",
							ticketsServiceInt.countAwaitingSparesTickets());
				} else {

					model.addObject("countNewOrders",
							ordersServiceInt.countNewOrders(""));
					model.addObject("countApprovedOrder",
							ordersServiceInt.countApprovedOrders(""));
					model.addObject("countShippedOrder",
							ordersServiceInt.countShippedOrders(""));
					model.addObject("countClosedOrder",
							ordersServiceInt.countClosedOrder(""));
					model.addObject("countOrdersReceive",
							ordersServiceInt.countOrdersReceive(""));
					model.addObject("countRejectedOrder",
							ordersServiceInt.countRejectedOrders(""));

					model.addObject("orderList",
							ordersServiceInt.getLastFourteenDaysOrders());
				}

				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());

				model.setViewName("ordermanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}

	// Last30Days
	@RequestMapping(value = "Last30Days", method = RequestMethod.GET)
	public ModelAndView Last30Days(
			@RequestParam("selectedDate") String localSelectedDate) {
		model = new ModelAndView();
		selectedDateRange = localSelectedDate;
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			if (userName.getRole().equalsIgnoreCase("Technician")) {
                 if (selectedDateRange != null) {
                	 
                	 model.addObject("newDate", "Last 30 Days");
					model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countShippedOrder",ordersServiceInt.countShippedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceiveForSelectedDate(userName.getEmail(),selectedDateRange));
					model.addObject("orderList",ordersServiceInt.getLastFourteenDaysOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
				}else{
					
					model.addObject("orderList", ordersServiceInt.getLastFourteenDaysClosedOrders(userName.getEmail()));
				
					model.addObject("countNewOrders", ordersServiceInt.countNewOrders("", userName.getEmail()));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceive("",userName.getEmail()));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrders("",userName.getEmail()));
					model.addObject("countShippedOrder", ordersServiceInt.countShippedOrdersForSelectedDate("24Hours"));
					model.addObject("countClosedOrder",ordersServiceInt.countClosedOrder(userName.getEmail()));
					model.addObject("countRejectedOrder", ordersServiceInt.countRejectedOrder(userName.getEmail(), customerName));
					
				}
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("ticketCount", ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
				
				
				model.setViewName("ordertechmanagement");

			} else if (userName.getRole().equalsIgnoreCase("Manager")
					|| userName.getRole().equalsIgnoreCase("Admin")) {

				if (selectedDateRange != null) {
					model.addObject("newDate", selectedDateRange);
					model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForSelectedDate(selectedDateRange));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrdersForSelectedDate(selectedDateRange));
					model.addObject("countShippedOrder",ordersServiceInt.countShippedOrdersForSelectedDate(selectedDateRange));
					model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForSelectedDate(selectedDateRange));
					model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrderForSelectedDate(selectedDateRange));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceiveForSelectedDate(selectedDateRange));

					model.addObject("orderList",ordersServiceInt.getLastFourteenDaysOrdersForSelectedDate(selectedDateRange));

					model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
					model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
					model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
					model.addObject("customers",customerServiceInt.getClientList());
					model.addObject("ticketCount", ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
					model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
				} else {model.addObject("countNewOrders",ordersServiceInt.countNewOrders(""));
					model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrders(""));
					model.addObject("countShippedOrder",ordersServiceInt.countShippedOrders(""));
					model.addObject("countClosedOrder",ordersServiceInt.countClosedOrder(""));
					model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceive(""));
					model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrders(""));

					model.addObject("orderList",ordersServiceInt.getLastFourteenDaysOrders());
				}

				model.addObject("pendingOrderList",
						ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt
						.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",
						ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("ticketCount", ticketsServiceInt
						.ticketCountForTechnician(userName.getEmail()));
				model.addObject("awaitingSparesTickets",
						ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("newDate", "Last 30 Days");
				model.setViewName("ordermanagement");
			} else {
				model.setViewName("login");
			}
		}

		return model;
	}

	@RequestMapping(value = "OrdersToReceive", method = RequestMethod.GET)
	public ModelAndView receiveOrders() {
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			
			if (customerName != null) {
				model.addObject("selectedName", customerName);
				model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForTechnician_Customer(userName.getEmail(),customerName));
				model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrdersForTechnician_Customer(userName.getEmail(),customerName));
				model.addObject("countShippedOrder",ordersServiceInt.countShippedOrdersForTechnicianCustomer(userName.getEmail(),customerName));
				model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForTechnician_Customer(userName.getEmail(),customerName));
				model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrderForTechnicianCustomer(userName.getEmail(),customerName));
				model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceiveForTechnician_Customer(userName.getEmail(),customerName));
				model.addObject("orderList",ordersServiceInt.getLastFourteenDaysShippedOrdersForTechnicianCustomer(userName.getEmail(),customerName));
				
			}else if(selectedDateRange!=null){
				model.addObject("newDate", selectedDateRange);
				model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
				model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
				model.addObject("countShippedOrder",ordersServiceInt.countShippedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
				model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
				model.addObject("countRejectedOrder",ordersServiceInt.countRejectedOrderForSelectedDate(userName.getEmail(),selectedDateRange));
				model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceiveForSelectedDate(userName.getEmail(),selectedDateRange));
				model.addObject("orderList",ordersServiceInt.getLastFourteenDaysShippedOrdersForSelectedDate(userName.getEmail(),selectedDateRange));
				
			}else{
				
				model.addObject("orderList", ordersServiceInt.getLastFourteenDaysShippedForTechnicianOrders(userName.getEmail()));
				
				model.addObject("countNewOrders", ordersServiceInt.countNewOrders("", userName.getEmail()));
				model.addObject("countOrdersReceive",ordersServiceInt.countOrdersReceive("",userName.getEmail()));
				
				model.addObject("countApprovedOrder",ordersServiceInt.countApprovedOrders("",userName.getEmail()));
				model.addObject("countShippedOrder",ordersServiceInt.countShippedOrders("",userName.getEmail()));
				model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForTechnician(userName.getEmail()));
				model.addObject("countRejectedOrder", ordersServiceInt.countRejectedOrders(userName.getEmail()));
			}
			model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
			model.addObject("ticketCount", ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
			model.addObject("customers", customerServiceInt.getClientList());
			model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
			model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
			model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
			model.setViewName("ordertechmanagement");
		} else {
			model.setViewName("login");
		}

		return model;
	}

	
	@RequestMapping(value = "getCustomerName", method = RequestMethod.GET)
	public ModelAndView getCustomerName(
			@RequestParam("customerName") String localCustomerName) {
		customerName = localCustomerName;
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Manager")|| userName.getRole().equalsIgnoreCase("Admin")) {
				model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForCustomer(customerName));
				model.addObject("countApprovedOrder", ordersServiceInt.countApprovedOrdersForCustomer(customerName));
				model.addObject("countShippedOrder", ordersServiceInt.countShippedOrdersForCustomer(customerName));
				model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForCustomer(customerName));
				model.addObject("countRejectedOrder", ordersServiceInt.countRejectedOrderForCustomer(customerName));

				model.addObject("orderList",ordersServiceInt.getLastFourteenDaysOrdersForCustomer(localCustomerName));
				model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("selectedName", customerName);
				model.setViewName("ordermanagement");

			} else if (userName.getRole().equalsIgnoreCase("Technician")) {

				model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForTechnician_Customer(userName.getEmail(), customerName));

				model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForTechnician_Customer(userName.getEmail(), customerName));
				model.addObject("countRejectedOrder", ordersServiceInt.countRejectedOrderForTechnicianCustomer(userName.getEmail(), customerName));
				model.addObject("countOrdersReceive", ordersServiceInt.countOrdersReceiveForTechnician_Customer(userName.getEmail(), customerName));
				model.addObject("orderList", ordersServiceInt.getLastFourteenDaysOrdersForTechnicianCustomer(userName.getEmail(), customerName));

				model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
				model.addObject("ticketCount", ticketsServiceInt.ticketCountForTechnician(userName.getEmail()));
				model.addObject("selectedName", customerName);
				model.setViewName("ordertechmanagement");
			}
		} else {
			model.setViewName("login");
		}

		return model;
	}
	@RequestMapping(value = "getTechnicianName", method = RequestMethod.GET)
	public ModelAndView getTehnnicianName(
			@RequestParam("technicianName") String localTechnicianName) {
		technicianName = localTechnicianName;
		model = new ModelAndView();

		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {
			if (userName.getRole().equalsIgnoreCase("Manager")|| userName.getRole().equalsIgnoreCase("Admin")) {
				model.addObject("countNewOrders", ordersServiceInt.countNewOrdersForCustomerNewSearch(technicianName));
				model.addObject("countApprovedOrder", ordersServiceInt.countApprovedOrdersForCustomerNewSearch(technicianName));
				model.addObject("countShippedOrder", ordersServiceInt.countShippedOrdersForCustomerNewSearch(technicianName));
				model.addObject("countClosedOrder", ordersServiceInt.countClosedOrderForCustomerNewSearch(technicianName));
				model.addObject("countRejectedOrder", ordersServiceInt.countRejectedOrderForCustomerNewSearch(technicianName));

				model.addObject("orderList",ordersServiceInt.getLastFourteenDaysOrdersForCustomer(localTechnicianName));

				model.addObject("pendingOrderList",ordersServiceInt.pendingOrders(userName.getEmail()));
				model.addObject("inboxCount", ordersServiceInt.pendingOrdersCount(userName.getEmail()));
				model.addObject("escalatedTickets",ticketsServiceInt.countEscalatedTickets());
				model.addObject("customers", customerServiceInt.getClientList());
				model.addObject("awaitingSparesTickets",ticketsServiceInt.countAwaitingSparesTickets());
				model.setViewName("ordermanagement");

			}
		} else {
			model.setViewName("login");
		}

		return model;
	}
	
	
}
