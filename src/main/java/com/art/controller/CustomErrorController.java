package com.art.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

@Controller
public class CustomErrorController implements ErrorController {

	@RequestMapping("/error")
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404Error(Model model) {
		model.addAttribute("error", "404");
		System.out.println(404);
		return "error";
	}

	@RequestMapping("/500error")
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR) 
	public String handle500Error(Model model) {
		model.addAttribute("error", "500");
		System.out.println(500);
		return "error";
	}

	public String getErrorPath() {
		return "/error";
	}
}
