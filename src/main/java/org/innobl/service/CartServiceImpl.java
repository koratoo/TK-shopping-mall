package org.innobl.service;

import java.util.List;

import org.innobl.domain.dto.CartMainDTO;
import org.innobl.domain.vo.Cart;
import org.innobl.mapper.CartMapper;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService{
	
	private final CartMapper cartMapper;
	
	@Override
	public List<CartMainDTO> getCartList() {
		
		
		return cartMapper.getCartList();
	}
	@Override
	public void delCartItems(String PRDCTNO) {
		cartMapper.delCartItems(PRDCTNO);
	}

}
