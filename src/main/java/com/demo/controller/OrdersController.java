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
	
	@RequestMapping(value="order",method=RequestMethod.GET)
	public ModelAndView loadOrder(){
	    model = new ModelAndView("order");
		model.addObject("makeOrder", new OrdersBean());
		model.setViewName("order");
		
		return model;
	}
	@RequestMapping(value="makeOrder",method=RequestMethod.POST)
	public String makeOrder(@ModelAttribute("makeOrder")Orders order)
	{
		String retRedirect ="";
		retMessage =ordersServiceInt.makeOrder(order);
		retRedirect ="redirect:technicianHome";
		return  retRedirect;
	} 
	
	@RequestMapping("approveOrder")
    public ModelAndView getOrderDetails(@RequestParam String id, @ModelAttribute Orders order) {
	    model = new ModelAndView();
		order = ordersServiceInt.getOrder(id);
		session.setAttribute("approveOrder", order);
		if(order !=null){
	        return new ModelAndView("orderUpdate", "orderObject", order);
		}
		else{
			
		}
		return model;
    }
	@RequestMapping("updateOrder")
    public ModelAndView updateOrder(Orders order){
		model = new ModelAndView();
		order= (Orders) session.getAttribute("approveOrder");
		retMessage = ordersServiceInt.updateOrder(order);
       model.addObject("home");
		return model;
		
	}
}
