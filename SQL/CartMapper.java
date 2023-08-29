public interface CartMapper {

	@Select("SELECT "
			+ "C.PRDCTNO AS PRDCTNO ,"
			+ "C.QUANTITY AS QUANTITY, "
			+ "P.PRDCTNM AS PRDCTNM ,"
			+ "P.REALPRICE AS REALPRICE, "
			+ "P.SALEPRICE AS SALEPRICE "
			+ "FROM "
			+ "CART C "
			+ "INNER JOIN "
			+ "PRODUCT P "
			+ "ON "
			+ "P.PRDCTNO = C.PRDCTNO ")
	public List<CartMainDTO> getCartList();
	
	@Delete("DELETE FROM CART WHERE PRDCTNO = #{PRDCTNO}")
	public void delCartItems(@Param("PRDCTNO")String PRDCTNO);
	
	@Select("SELECT COUNT(PRDCTNO) FROM CART WHERE PRDCTNO = #{PRDCTNO}")
	public int checkDuplicateItems(@Param("PRDCTNO")String PRDCTNO);
	
	@Update("UPDATE CART SET QUANTITY = QUANTITY + 1 WHERE PRDCTNO = #{prdctNo}")
	void increaseQuantity(@Param("prdctNo") String prdctNo);

}
