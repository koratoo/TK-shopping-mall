package org.innobl.exception.constants;

import org.springframework.http.HttpStatus;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ErrorCode {
    // category (카테고리 관련 예외)
    INVALID_CATEGORY_DATA("카테고리 데이터가 유효하지 않습니다.", HttpStatus.BAD_REQUEST),

    // product (상품 관련 예외)
    PRODUCT_NOT_FOUND("해당 상품이 존재하지 않습니다.", HttpStatus.BAD_REQUEST);

    private final String message;
    private final HttpStatus httpStatus;
}