package com.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.demo.service.CompitabilityServiceInt;


@Controller
public class CompitabilityController {

	@Autowired
	private CompitabilityServiceInt compitabilityServiceInt;
}
