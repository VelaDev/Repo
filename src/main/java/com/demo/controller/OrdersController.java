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
import com.demo.model.OrdersHeader;
import com.demo.model.OrderDetails;
import com.demo.service.CompatibilityServiceInt;
import com.demo.service.CustomerContactDetailsServiceInt;
import com.demo.service.CustomerServiceInt;
import com.demo.service.EmployeeServiceInt;
import com.demo.service.OrderDetailsInt;
import com.demo.service.OrdersServiceInt;


@Controller
public class OrdersController {
	
	@Autowired
	private OrdersServiceInt ordersServiceInt;
	@Autowired
	private CompatibilityServiceInt compatibilityServiceInt;
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
	
	@RequestMapping(value="order",method=RequestMethod.GET)
	public ModelAndView loadOrder(){
		
		model = new ModelAndView("order");
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
			model.addObject("makeOrder", new OrdersBean());
			model.addObject("compatibility", compatibilityServiceInt.compitabilityList());
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
    public ModelAndView getOrderDetails(@RequestParam String id, @ModelAttribute OrdersHeader ordersHeader) {
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
		      ordersHeader = ordersServiceInt.getOrder(id);
		      if(ordersHeader !=null){
		    	  model.setViewName("orderUpdate");
		          model.addObject("orderObject", ordersHeader);
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
			model.addObject("OrderList",ordersServiceInt.getAllOrders(userName.getEmail()));
			//model.addObject("","")
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
			
			model.addObject("pendingOrderList", ordersServiceInt.getAllOrders());
			model.setViewName("displayOrders");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="approveOrder",method=RequestMethod.GET)
	public ModelAndView approveOrder(@RequestParam("orderNum") String orderNum,@ModelAttribute OrderDetails orderDetails){
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			
			model.addObject("pendingOrderList", orderDetailsInt.getOrderDetailsByOrderNum(orderNum));
			model.addObject("OrderNum", ordersServiceInt.getOrder(orderNum));
			model.setViewName("approveOrder");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="approveOrderItems",method=RequestMethod.POST)
	public ModelAndView approveOrderItems(@RequestParam("orderNum") String orderNum){
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			
			model.addObject("retMessage", ordersServiceInt.approveOrder(orderNum));
			model.setViewName("approveOrder");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="detailedOrders",method=RequestMethod.GET)
	public ModelAndView detailedOrders(@RequestParam("orderNum") String orderNum){
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			
			model.addObject("pendingOrderList", orderDetailsInt.getOrderDetailsByOrderNum(orderNum));
			model.addObject("OrderNum", ordersServiceInt.getOrder(orderNum));
			model.setViewName("detailedOrders");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="deliveryNote",method=RequestMethod.GET)
	public ModelAndView deliveries(@RequestParam("orderNum") String orderNum){
		model = new ModelAndView();
		
		userName = (Employee) session.getAttribute("loggedInUser");
		if(userName !=null){
			OrdersHeader order = ordersServiceInt.getOrder(orderNum);
			List<OrderDetails> list = orderDetailsInt.getOrderDetailsByOrderNum("key",orderNum);
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
}
