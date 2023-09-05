package org.innobl.domain.vo;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Range;

import lombok.Data;

@Data
public class Product {

	   private String PRDCTNO;
	   
	   @Size(min=1,max=30, message="상품명은 1글자에서 30글자이내로 작성해주세요.")
	   @Pattern(regexp = "^[가-힣ㄱ-ㅎㅏ-ㅣ\\s!@#$%^&*(),.?\":{}|<>]*$", message="상품명은 한글 및 특수문자만 가능합니다.")
	   private String PRDCTNM ;
	   
	   
	   private String PRDCTIMG1;
	   
	   private String PRDCTIMG2;
	   
	   private String PRDCTIMG3;
	   
	   private String PRDCTDTL;
	   
	   @Range(min=1000, max=1000000,message="1,000원에서 1,000,000원 사이를 입력해주세요.")
	   private long REALPRICE;
	   
	   @Range(min=1000, max=1000000,message="1,000원에서 1,000,000원 사이를 입력해주세요.")
	   private long SALEPRICE;
	   
	   private long SALESRATE;//판매량
	   private String  REGDATE;
	   
	   private int STOCK;
	   private String DELETE_COL;
}
