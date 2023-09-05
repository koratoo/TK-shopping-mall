<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>베스트</title>
<style>

.product-container{
	width: 70%;
	height:2080px;
	background-color:#fff;
	margin:auto;
}
.top-sales-item{
	display:flex;
	flex-wrap:wrap;
	justify-content:center;
	align-items:center;
	padding:100px;
	margin:10px;
	width: 60%;
	height:600px;
	background:#fff;
	border:1px solid #eeeeee;
	position: relative;  
}
.top-sales-item img{
	width:100%;
	height:100%;
}

.hover-active{
    display: none;  /* 기본적으로 .hover-active는 보이지 않음 */
    position: absolute;
    width: 60%;  /* 필요한 경우 크기 조절 */
    height: 60%; /* 필요한 경우 크기 조절 */
}
.top-sales-item:hover .hover-active {
	display:block;   /* .top-sales-item에 hover하면 .hover-active가 보임 */
}
.top-sales-item:hover{
	border:2px solid green;
	cursor:pointer;
}
.jjim_btn img,.cart_btn img{
	width:40px;
	height:40px;
}

.jjim_btn, .cart_btn{
	background:none;
	border:none;
}

.top-container {
    display: flex;
    flex-wrap: wrap;
    justify-content:center;
    align-items:center;
}

.sales-item-contents{
	display:flex;
	padding:100px;
	margin:10px;
	width: 45%;
	height:100%;
	background:white;
	border:1px solid #eeeeee;
}
.sales-item-contents:hover{
	border:2px solid green;
	cursor:pointer;
}
</style>
<link rel="stylesheet" type="text/css" href="../resources/css/product/bestitem.css">
	<script>

		// 카트에 아이템 넣기
	  function putItemsIntoCart(btn) {
		  var productNo = $(btn).data("product-no");
	    $.ajax({
	      method: "GET",
	      url: "/product/cart",
	      data:{ PRDCTNO: productNo },
	      contentType: "application/json; charset=utf-8"
	    })
	    .done(function(result) {
	      // 결과 처리
		  alert('상품이 정상적으로 등록되었습니다.');	   
	      window.location.href = "/cart/cart_main";

	    })
	    .fail(function(xhr, status, error) {
	      // 실패 처리
	      console.error(xhr, status, error);
	    });
	  }
	  
	</script>
</head>
<body>
	<%@ include file="../common/header.jsp" %> 
	<p/>
	<div class="product-container">
	1위
		<div class="top-container">
		<c:forEach var="bestitem" items="${bestitem}" varStatus="status">
		    <c:choose>
		        <c:when test="${status.index == 0}">
		            <div class="top-sales-item" onclick="location.href='/shop/item?PRDCTNO=${bestitem.PRDCTNO}'">
		                <div class="hover-active">
		                    <button class="jjim_btn"><img src="../resources/img/icon/heart.png"></button>
		                    <button class="cart_btn"  onclick="event.stopPropagation(); putItemsIntoCart(this);" data-product-no="${bestitem.PRDCTNO}"><img src="../resources/img/icon/cart.png"></button>
		                </div>
		                <img src="../resources/img/lasagna.jpg">
		
		                <div>
			                <span>${bestitem.PRDCTDTL}</span>
		                </div>
		                <div class="price">
		                	<span style="text-decoration: line-through;">정가 : ${bestitem.REALPRICE}</span> | 판매가 : ${bestitem.SALEPRICE}
		                </div>
		            </div>
		        </c:when>
		      
		        <c:otherwise>
		                <div class="sales-item-contents" onclick="location.href='/shop/item?PRDCTNO=${bestitem.PRDCTNO}'">
			                ${status.index+1}위<br>${bestitem.PRDCTDTL}
		        			<button class="jjim_btn"><img src="../resources/img/icon/heart.png"></button>
		                	<button class="cart_btn"  onclick="event.stopPropagation(); putItemsIntoCart(this);" data-product-no="${bestitem.PRDCTNO}"><img src="../resources/img/icon/cart.png"></button>
		                </div> 	          
		        </c:otherwise>
		    </c:choose>
		</c:forEach>
		</div><!-- top end -->
		<div class="bot-container">
		
		</div>
	</div>
</body>


</html>