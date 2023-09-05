package org.innobl.controller;

import org.innobl.domain.dto.CartMainDTO;
import org.innobl.service.CartService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("cart")
@RequiredArgsConstructor
public class CartController {

	private final CartService cartService;
	
	@GetMapping("cart_main")
	public String showCartMainPage(Model model) {
		model.addAttribute("list", cartService.getCartList());
		return "/cart/cart_main";
	}
	
	@ResponseBody
	@DeleteMapping("del")
	public void delCartItems(@RequestParam("prdctno")String prdctno) {
		
		cartService.delCartItems(prdctno);
		log.info(prdctno+"번 성공적으로 삭제");
	}
}
