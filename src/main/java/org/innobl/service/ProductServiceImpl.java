package org.innobl.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import org.innobl.domain.vo.Product;
import org.innobl.mapper.CartMapper;
import org.innobl.mapper.ProductMapper;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService{

	private final ProductMapper productMapper;
	private final CartMapper cartMapper;
	@Override
	public List<Product> getBestItem() {
		
		return productMapper.getBestItem();
	}
	
	
	@Override
	public void putItemsIntoCartByBtnClick(String PRDCTNO) {
		
		//해당 상품이 이미 카트에 담겨있다면 수량을 늘려주는 로직을 추가한다.
		int chk = cartMapper.checkDuplicateItems(PRDCTNO);
		//System.out.println("chk : "+ chk);
		if(chk==0) {
			productMapper.putItemsIntoCartByBtnClick(PRDCTNO);			
		}else if(chk>0){
			cartMapper.increaseQuantity(PRDCTNO);
		}
	}


	@Override
	public Product getOneItems(String PRDCTNO) {
		return productMapper.getOneItems(PRDCTNO);
	}
	

}
