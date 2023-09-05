package org.innobl.domain.dto;

import lombok.Data;

@Data
public class CartMainDTO {

	private String PRDCTNO;
	private String PRDCTNM;
	private String PRDCTDTL;
	private int QUANTITY;
	private int REALPRICE;
	private int SALEPRICE;
}
