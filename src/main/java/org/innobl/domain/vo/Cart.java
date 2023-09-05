package org.innobl.domain.vo;

import lombok.Data;

@Data
public class Cart {

	private String CARTNO;
	private String PRDCTNO;
	private String USERNO;
	private int QUANTITY;
	private String REGDATE;
}
