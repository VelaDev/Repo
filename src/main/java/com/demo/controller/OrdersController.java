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
import com.demo.model.Orders;
import com.demo.service.OrdersServiceInt;


@Controller
public class OrdersController {
	
	@Autowired
	private OrdersServiceInt ordersServiceInt;
	@Autowired
	private HttpSession session;
	private ModelAndView model = null;
	@SuppressWarnings("unused")
	private String retMessage =null;
	private String userName = null;
	
	@RequestMapping(value="order",method=RequestMethod.GET)
	public ModelAndView loadOrder(){
		
		model = new ModelAndView("order");
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
			
			model.addObject("makeOrder", new OrdersBean());
			model.setViewName("order");
		}
		else{
			model.setViewName("login");
		}
		
		return model;
	}
	@RequestMapping(value="makeOrder",method=RequestMethod.POST)
	public ModelAndView makeOrder(@ModelAttribute("makeOrder")Orders order)
	{
		
		model = new ModelAndView();
		userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
			retMessage =ordersServiceInt.makeOrder(order);
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
	    userName = (String) session.getAttribute("loggedInUser");
		if(userName != null){
			
		      order = ordersServiceInt.getOrder(id);
		      if(order !=null){
	           return new ModelAndView("orderUpdate", "orderObject", order);
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
    public ModelAndView updateOrder(Orders order){
		model = new ModelAndView();
		 userName = (String) session.getAttribute("loggedInUser");
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
}
