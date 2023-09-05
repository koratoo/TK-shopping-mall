package org.innobl.controller;

import org.innobl.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/shop")
@RequiredArgsConstructor
public class ShopController {

	private final ProductService productService;
	
	@GetMapping("/item")
	public String showOneItemPage(Model model,@RequestParam("PRDCTNO")String PRDCTNO) {
		
		model.addAttribute("item",productService.getOneItems(PRDCTNO));
		
		return "/shop/item";
	}
}
