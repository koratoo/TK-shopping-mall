<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 화면</title>
<link rel="stylesheet" type="text/css" href="../resources/css/cart/main.css">
<!-- jQuery -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<!-- iamport.payment.js -->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<style>
.cart-container{
	width: 70%;
	height:2080px;
	background-color:#fff;
	margin:auto;
}

table{
	text-align:center;
	width:100%;
}
input{
	width:60px;
	text-align:center;
}
.cart-inner{
	height:20%;
	display:flex;
	flex-wrap: wrap;
    justify-content:center;
    align-items:center;
}
.cal-totalprice{
	display:flex;
	flex-wrap: wrap;
    justify-content:center;
    align-items:center;
}
.cal-totalprice th, .cal-totalprice td{
	border:1px solid #eeeeee;
	text-align:left;
	font-size:20px;
} 
.cal-totalprice th{
	background-color:#eeeeee;
}
#paybtn{
	width:200px;
	height:50px;
	color:white;
	background:black;
	font-weight:bold;
	border:1px solid gray;
}
#shopping{
	margin-right:20px;
	width:200px;
	height:50px;
	color:black;
	background:white;
	border:1px solid gray;
}
#shopping a{
	font-weight:bold;
}

.cart-inner button{
	color:gray;
	background:#fff;
	border:1px solid gray;
}
.cart-inner button:hover{
	cursor:pointer;
	border:1px solid green;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp" %> 
	<div class="cart-container">
		<h2>장바구니</h2>
		<div class="cart-inner">
			<table class="table table-hover">
				<thead class="table-dark">
				<tr>
					<th><input type="checkbox"  id="select-all" /></th>
					<th>상품명</th>
					<th>수량</th>
					<th>판매가(할인가)</th>
					<th>합계금액</th>
				</tr>
				</thead>
				<c:forEach var="list" items="${list }">
				<tr>
					<td><input type="checkbox" class="select-checkbox" value="${list.PRDCTNO }"/></td>
					<td style="width:600px;"><a href="/shop/item?PRDCTNO=${list.PRDCTNO }">${list.PRDCTNM }</a></td>
					<td>${list.QUANTITY }</td>
					<td>${list.SALEPRICE}</td>
					<td class="total-price"><strong>${list.SALEPRICE * list.QUANTITY }</strong></td>
				</tr>
				</c:forEach>
			</table>
			<button onclick= "deleteSelectedItems()">선택상품 삭제</button>
			
		</div><!-- cart-inner end -->
		<div class="cal-totalprice" >
			<table class="table table-striped">
				<tr>
					<td style="width:30%">주문금액 : <span id="order-price"></span>  </td>
					<td> + </td> 
					<td style="width:30%">배송비 : <span id="delivery-price">3000</span></td> 
					<td> = </td> 
					<td style="width:30%">결제 금액 : <span id="pay-price"></span> </td>
				</tr>
			</table>
			<button id="shopping"><a href="/product/bestitem" class="btn">계속 쇼핑하기</a></button>
			<button id="paybtn" onclick="requestPay()">상품 결제하기</button>
			
		</div>
		
	</div><!-- cart-container end -->
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<script>
$(document).ready(function(){
	//전체 버튼 클릭시 로직처리
	$("#select-all").click(function(){
        $(".select-checkbox").prop('checked', $(this).prop('checked'));
        updateTotalPrice();
        payPrice();
    });

    $(".select-checkbox").click(function(){
        if (!$(this).prop('checked')){
            $("#select-all").prop('checked', false);
            updateTotalPrice();
            payPrice();
        }
    });
});

function deleteSelectedItems() {
	  console.log('삭제버튼 클릭됨')
	  var checkboxes = document.getElementsByClassName("select-checkbox");
	  console.log(checkboxes)
	  // 선택된 체크박스 확인 및 처리
	  for (var i = checkboxes.length - 1; i >=0 ; i--) {
	    if (checkboxes[i].checked) {
	      
			  var prdctno = checkboxes[i].value;
		    $.ajax({
		      method: "DELETE",
		      url: "/cart/del?prdctno="+prdctno,
		      data:{prdctno:prdctno},
		      contentType: "application/json; charset=utf-8"
		    })
		    .done(function(result) {
		      // 결과 처리    
		      location.reload();
		    })
		    .fail(function(xhr, status, error) {
		      // 실패 처리
		      console.error(xhr, status, error);
		    });
		  
	    }
	  }
	}
	
function requestPay() {
	 IMP.init("imp70574668"); // 예: imp00000000
    console.log("클릭됨");
	 var payPrice = document.getElementById("pay-price").textContent;
	 console.log(payPrice);
    IMP.request_pay({ // param
        pg: "html5_inicis",
        pay_method: "card",
        merchant_uid: "ORD20180131-0000011",
        name: "my shopping",
        amount: payPrice,
        buyer_email: "gildong@gmail.com",
        buyer_name: "홍길동",
        buyer_tel: "010-4242-4242",
        buyer_addr: "서울특별시 강남구 신사동",
        buyer_postcode: "01181"
    }, function (rsp) { // callback
        if (rsp.success) {
            // 결제 성공 시 로직,
        } else {
            // 결제 실패 시 로직,
        }
    });
  }
  
function updateTotalPrice() {
    var checkboxes = document.getElementsByClassName("select-checkbox");
    var totalPrices = document.getElementsByClassName("total-price");
    var orderPrice = 0;

    for (var i = 0; i < checkboxes.length; i++) {
      if (checkboxes[i].checked) {
        // 체크박스가 선택된 경우 해당 행의 총 가격을 더함
        orderPrice += Number(totalPrices[i].textContent);
      }
    }

    // 주문금액 업데이트
    document.getElementById("order-price").textContent = orderPrice;
  }
  
 function payPrice(){
	 var orderPrice = document.getElementById("order-price");
	 var deliveryPrice = document.getElementById("delivery-price");
	 var payPrice = 0;
	 payPrice = Number(orderPrice.textContent) + Number(deliveryPrice.textContent);
    document.getElementById("pay-price").textContent = payPrice; 
 }

</script>
	
 
</html>