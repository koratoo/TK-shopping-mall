package org.innobl.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.innobl.domain.vo.Product;

public interface ProductMapper {

	@Select("SELECT "
			+ "PRDCTNO, "
			+ "PRDCTNM, "
			+ "PRDCTIMG1,"
			+ "PRDCTIMG2,"
			+ "PRDCTDTL,"
			+ "REALPRICE,"
			+ "SALEPRICE,"
			+ "SALESRATE "
			+ "FROM "
			+ "PRODUCT "
			+ "WHERE "
			+ "DELETE_COL=1 "
			+ "ORDER BY SALESRATE")
	public List<Product> getBestItem();
	
	
	@Insert("INSERT INTO CART (PRDCTNO,QUANTITY,REGDATE) VALUES(#{PRDCTNO},1,SYSDATE)")
	public void putItemsIntoCartByBtnClick(@Param("PRDCTNO") String PRDCTNO);
	
	@Select("SELECT * FROM PRODUCT WHERE PRDCTNO=#{PRDCTNO}")
	public Product getOneItems(@Param("PRDCTNO")String PRDCTNO);
	

	
}
