/**
 * 
 */
package com.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author m.s.mokoena
 *
 */

@Controller
public class HTTPErrorHandler {

//	String path = "/error";
	
	@RequestMapping(value="/405")
	public String error405(){
		
		System.out.println("Shit Happens!!!");
		
		return "/405.jsp";
	}
	@RequestMapping(value="/500")
	public String error500(){
		
		System.out.println("Shit Happens!!!");
		
		return "/405.jsp";
	}
	
}
