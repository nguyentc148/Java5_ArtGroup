package com.art.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class productController {
	@GetMapping("/product")
	public String product(Model model) {
		model.addAttribute("views", "product-form");
		model.addAttribute("title", "Quản lí sản phẩm");
		return "admin/index";
	}
}
