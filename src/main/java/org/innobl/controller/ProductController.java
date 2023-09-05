package org.innobl.controller;

import javax.validation.Valid;

import org.innobl.domain.vo.Product;
import org.innobl.service.FileService;
import org.innobl.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/product")
@RequiredArgsConstructor
public class ProductController {

	private final ProductService productService;
	private final FileService fileService;
	
	@GetMapping("/bestitem")
	public String showBestItemPage(Model model) {
		model.addAttribute("bestitem", productService.getBestItem());
		return "/product/bestitem";
	}
	
	//장바구니 버튼 클릭시 한개만 장바구니에 등록되는 로직
	@ResponseBody
	@GetMapping("/cart")
	public void putItemsIntoCartByBtnClick(@RequestParam("PRDCTNO") String PRDCTNO){
		productService.putItemsIntoCartByBtnClick(PRDCTNO);
	}
	
	@GetMapping("/add")
	public String showProductAddPage(Model model) {
		model.addAttribute("product", new Product());
		return "/product/add";
	}
	
	@PostMapping("/add")
	public String addProduct(@Valid Product product, BindingResult result, Model model, MultipartFile[] uploadFile) {
	    if(result.hasErrors()) {
	        return "/product/add";
	    }
	    log.info(product);
	    
	    String[] productImages = new String[3]; // 이미지 경로 저장용 배열
	    
	    for (int i = 0; i < uploadFile.length; i++) {
	        MultipartFile multipartFile = uploadFile[i];
	        String filePath = fileService.storeFile(multipartFile);
	        
	        if (i < productImages.length) { // 배열 범위 체크
	            productImages[i] = filePath;
	            log.info((i+1) + "번째 이미지 등록");
	            log.info("syso : "+filePath);
	        }
	    }

	    // Product 객체에 이미지 경로 설정
	    product.setPRDCTIMG1(productImages[0]);
	    product.setPRDCTIMG2(productImages[1]);
	    product.setPRDCTIMG3(productImages[2]);

	   return "redirect:/product/bestitem";  // 상품 목록 페이지로 리다이렉트
	}
}
