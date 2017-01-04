package com.demo.controller;

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
import com.demo.model.Orders;
import com.demo.service.CompatibilityServiceInt;
import com.demo.service.OrdersServiceInt;


@Controller
public class OrdersController {
	
	@Autowired
	private OrdersServiceInt ordersServiceInt;
	@Autowired
	private CompatibilityServiceInt compatibilityServiceInt;
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
    public ModelAndView getOrderDetails(@RequestParam String id, @ModelAttribute Orders order) {
	    model = new ModelAndView();
	    userName = (Employee) session.getAttribute("loggedInUser");
		if(userName != null){
			
		      order = ordersServiceInt.getOrder(id);
		      if(order !=null){
		    	  model.setViewName("orderUpdate");
		          model.addObject("orderObject", order);
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
			model.addObject("ApprovedOrderList", ordersServiceInt.getApprovedOrdersByTechnicianName(userName.getEmail()));
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
			model.addObject("ApprovedOrderList", ordersServiceInt.getAllOrders());
			model.setViewName("displayOrders");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
}
