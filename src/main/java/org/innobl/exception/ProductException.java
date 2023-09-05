package org.innobl.exception;

import org.innobl.exception.constants.ErrorCode;

import lombok.Getter;

@Getter
public class ProductException extends RuntimeException{

	private final ErrorCode errorCode;
	
	public ProductException(ErrorCode errorCode) {
		this.errorCode = errorCode;
	}
	
	public ProductException(String message,ErrorCode errorCode) {
		super(message);
		this.errorCode=errorCode;
	}
	
}
