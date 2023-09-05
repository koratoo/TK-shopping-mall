package org.innobl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("bbs")
@RequiredArgsConstructor
public class BbsController {

	@GetMapping("notice")
	public String showNoticePage(Model model) {
		
		return "/bbs/notice";
	}
}
