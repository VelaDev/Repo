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
import com.demo.model.Employee;
import com.demo.model.OrderHeader;
import com.demo.model.OrderDetails;
import com.demo.service.CustomerContactDetailsServiceInt;
import com.demo.service.CustomerServiceInt;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.OrderDetailsInt;
import com.demo.service.OrdersServiceInt;
import com.demo.service.HOStockServeceInt;


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
	private HttpSession session;
	private ModelAndView model = null;
	private String retMessage =null;
	private Employee userName = null;
	private String retPage = null;
	
	@RequestMapping(value="order",method=RequestMethod.GET)
	public ModelAndView loadOrder(){
		
		model = new ModelAndView("order");
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			
			model.addObject("makeOrder", new OrdersBean());
			model.addObject("compatibility", spareParts.getAllSpareParts());
			model.addObject("managersList", employeeServiceInt.getAllManagers());
			model.addObject("customerList", customerServiceInt.getClientList());
			model.setViewName("order");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="makeOrder",method=RequestMethod.POST)
	public ModelAndView makeOrder(@ModelAttribute("makeOrder")OrdersBean order)
	{
		System.out.println("We here now");
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			retMessage =ordersServiceInt.prepareOrderMaking(order);
			model.addObject("retMessage", retMessage);
			model.setViewName("order");
		}
		else{
			model.setViewName("login");
		}
		return  model;
	} 
	
	@RequestMapping("approveOrder")
    public ModelAndView getOrderDetails(@RequestParam Integer recordID, @ModelAttribute OrderHeader orderHeader) {
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
		      orderHeader = ordersServiceInt.getOrder(recordID);
		      if(orderHeader !=null){
		    	  model.setViewName("orderUpdate");
		          model.addObject("orderObject", orderHeader);
		      }
		else{
			
		    }
		}
		else{
			model.setViewName("login");
		}
		return model;
    }
	@RequestMapping("updateOrder")
    public ModelAndView updateOrder(OrdersBean order){
		model = new ModelAndView();
		 userName = (Employee) session.getAttribute("loggedInUser");
			if(userName != null){
		
				retMessage = ordersServiceInt.updateOrder(order);
		        model.addObject("retMessage",retMessage);
		        model.setViewName("orderUpdate");
			}
			else{
				model.setViewName("login");
			}
		return model;
		
	}
	@RequestMapping("approvedOrders")
	public ModelAndView approvedOrders(){
		model = new ModelAndView();
	    
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			model.addObject("orderList", ordersServiceInt.getOpenOrders());
			model.setViewName("approvedOrders");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping("displayOrders")
	public ModelAndView displayOrders(){
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			model.addObject("pendingOrderList",ordersServiceInt.getAllOrders(userName.getEmail()));
			model.setViewName("displayOrders");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value ="pendingOrders", method=RequestMethod.GET)
	public ModelAndView displayPendingOrders(){
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			model.addObject("pendingOrderList", ordersServiceInt.pendingOrders(userName.getEmail()));
			model.setViewName("pendingOrders");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="approveOrder",method=RequestMethod.GET)
	public ModelAndView approveOrder(@RequestParam("recordID") Integer recordID,@ModelAttribute OrderDetails orderDetails){
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			model.addObject("pendingOrderList",orderDetailsInt.getOrderDetailsByOrderNum(recordID) );
			model.addObject("RecordID", ordersServiceInt.getOrder(recordID));
			model.setViewName("approveOrder");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="approveOrderItems",method=RequestMethod.POST)
	public ModelAndView approveOrderItems(@RequestParam("recordID") Integer recordID){
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			
			model.addObject("retMessage", ordersServiceInt.approveOrder(recordID));
			model.setViewName("approveOrder");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="detailedOrders",method=RequestMethod.GET)
	public ModelAndView detailedOrders(@RequestParam("recordID") Integer recordID){
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			
			model.addObject("pendingOrderList", orderDetailsInt.getOrderDetailsByOrderNum(recordID));
			model.addObject("OrderNum", ordersServiceInt.getOrder(recordID));
			model.setViewName("detailedOrders");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="deliveryNote",method=RequestMethod.GET)
	public ModelAndView deliveries(@RequestParam("recordID") Integer recordID){
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			OrderHeader order = ordersServiceInt.getOrder(recordID);
			List<OrderDetails> list = orderDetailsInt.getOrderDetailsByOrderNum("key",recordID);
			model.addObject("pendingOrderList",list );
			model.addObject("OrderNum", order);
			model.addObject("contactPerson", contactDetailsServiceInt.getContactPerson(order.getCustomer().getCustomerName()));
			model.setViewName("deliveryNote");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="availableStock",method=RequestMethod.GET)
	public ModelAndView availableStock(){
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			String technician = userName.getFirstName()+" "+ userName.getLastName();
			model.addObject("availableOrders", orderDetailsInt.getAllAvailableOrderDetails(technician));
			model.setViewName("availableStock");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	
	@RequestMapping(value = "viewApprovedOrders",method=RequestMethod.GET)
	public ModelAndView LoadViewApprovedOrders() {

		model = new ModelAndView("viewApprovedOrders");
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.setViewName("viewApprovedOrders");
		} else {
			model.setViewName("login");
		}

		return model;
	}
	
	@RequestMapping(value = "orderHistory",method=RequestMethod.GET)
	public ModelAndView LoadOrderHistory() {

		model = new ModelAndView("orderHistory");
		userName = (Employee) session.getAttribute("loggedInUser");
		if (userName != null) {

			model.setViewName("orderHistory");
		} else {
			model.setViewName("login");
		}

		return model;
	}
	@RequestMapping(value="shipment")
	public String shipment(@RequestParam("recordID") int recordID) {
		model = new ModelAndView();
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			ordersServiceInt.approveShipment(recordID);
			
		retPage="redirect:approvedOrders";
		}
		else{
			retPage="redirect:login";
		}
		
		return retPage;
	}
	@RequestMapping("shippedOrders")
	public ModelAndView shippedOrders(){
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			model.addObject("pendingOrderList",ordersServiceInt.shippedOrders());
			model.setViewName("shippedOrders");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
}
