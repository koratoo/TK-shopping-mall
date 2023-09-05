package org.innobl.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.innobl.domain.dto.CartMainDTO;
import org.innobl.domain.vo.Cart;

public interface CartService {
	public List<CartMainDTO> getCartList();
	public void delCartItems(String PRDCTNO);

}
