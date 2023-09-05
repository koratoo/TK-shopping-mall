package org.innobl.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.innobl.domain.dto.CartMainDTO;
import org.innobl.domain.vo.Cart;

public interface CartMapper {

	@Select("SELECT "
			+ "C.PRDCTNO AS PRDCTNO ,"
			+ "C.QUANTITY AS QUANTITY, "
			+ "P.PRDCTNM AS PRDCTNM ,"
			+ "P.REALPRICE AS REALPRICE,"
			+ "P.PRDCTDTL AS PRDCTDTL, "
			+ "P.SALEPRICE AS SALEPRICE "
			+ "FROM "
			+ "CART C "
			+ "INNER JOIN "
			+ "PRODUCT P "
			+ "ON "
			+ "P.PRDCTNO = C.PRDCTNO "
			+ "AND QUANTITY != 0")
	public List<CartMainDTO> getCartList();

	@Delete("DELETE FROM CART WHERE PRDCTNO = #{PRDCTNO}")
	public void delCartItems(@Param("PRDCTNO")String PRDCTNO);

	@Select("SELECT COUNT(PRDCTNO) FROM CART WHERE PRDCTNO = #{PRDCTNO}")
	public int checkDuplicateItems(@Param("PRDCTNO")String PRDCTNO);

	@Update("UPDATE CART SET QUANTITY = QUANTITY + 1 WHERE PRDCTNO = #{prdctNo}")
	void increaseQuantity(@Param("prdctNo") String prdctNo);

}
