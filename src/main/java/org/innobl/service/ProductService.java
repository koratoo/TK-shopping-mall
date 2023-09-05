package org.innobl.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.innobl.domain.vo.Product;

public interface ProductService {

	public List<Product> getBestItem();
	public void putItemsIntoCartByBtnClick(String PRDCTNO);
	public Product getOneItems(String PRDCTNO);


}
