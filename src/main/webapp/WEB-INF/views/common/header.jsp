<!-- header.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Shopping Mall</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="../resources/css/common/header.css">
</head>
<style>
div, ul, li {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;padding:0;margin:0}
a {text-decoration:none;}
.quickmenu {position:absolute;width:120px;top:50%;margin-top:-50px;right:10px;background:#fff;}
.quickmenu ul {position:relative;float:left;width:100%;display:inline-block;*display:inline;border:1px solid #ddd; margin:auto;}
.quickmenu ul li {float:left;width:100%;border-bottom:1px solid #ddd;text-align:center;display:inline-block;*display:inline;}
.quickmenu ul li a {position:relative;float:left;width:100%;height:30px;line-height:30px;text-align:center;color:#999;font-size:9.5pt;}
.quickmenu ul li a:hover {color:#000;}
.quickmenu ul li:last-child {border-bottom:0;}
</style>
<body>
<div id="header">
    <div class="header-top">
        <div class="container">
            <% if(session.getAttribute("loggedInUser") != null) { %>
                <!-- 로그인된 사용자의 경우 -->
                <a href="/logout">Logout</a>
            <% } else { %>
                <!-- 로그인되지 않은 사용자의 경우 -->
                <a href="/login/login_main">로그인</a> 
                <a href="#">회원가입</a> 
                <a href="/cart/cart_main">장바구니</a> 
                <a href="#">마이페이지</a> 
                <a href="#">고객센터</a> 
                <a href="/product/add">신규상품등록</a> 
            <% } %>
        </div>
    </div>

    <div class="header-middle container">
        <h1><a href="/">My Shopping Mall</a></h1>
    </div>

    <nav id="main-nav" class="container">
        <ul class="header-bottom">
        	<li><button class="all-menu-btn">전체 카테고리</button></li>
           	<li><a href="#">신상품</a></li>
           	<li><a href="/product/bestitem">베스트</a></li>
           	<li><a href="#">추천상품</a></li>
           	<li><a href="#">세트상품</a></li>
           	<li><a href="#">금주의 행사</a></li>
           	<li><a href="#"><strong>EVENT</strong></a></li>
           	<li><a href="/bbs/notice"><strong>NOTICE</strong></a></li>
           	<li><a href="#"><strong>COMPANY</strong></a></li>
        </ul>    
    </nav>  
    <nav id="main-nav" class="container">
    	<ul class="all-menu-active" style="display:none">
    		<li><img src=" ../resources/img/bread.png"><br>빵	</li>
    		<li><img src=" ../resources/img/salad.png"><br>샐러드</li>
    		<li><img src=" ../resources/img/noodles.png"><br>면류</li>
    		<li><img src=" ../resources/img/chinesfood.png"><br>중식</li>
    		<li><img src=" ../resources/img/burger.png"><br>햄버거</li>
    		<li><img src=" ../resources/img/rice.png"><br>밥</li>
    	</ul>
    </nav>
</div>
<div class="quickmenu">
  <ul>
    <li><a href="/cart/cart_main">장바구니</a></li>
    <li><a href="/cart/cart_main">관심상품</a></li>
    <li><a href="/cart/cart_main">쿠폰등록</a></li>
    <li><a href="/cart/cart_main">최근본상품</a></li>
    <li><a href="/product/bestitem">베스트아이템</a></li>
    <li><a href="#header">TOP</a></li>
  </ul>
</div>

<script>
window.onload = function() {
  var allMenuBtn = document.querySelector('.all-menu-btn');
  var allMenuActive = document.querySelector('.all-menu-active');


  allMenuBtn.addEventListener('click', function() {
    // 현재 display 상태를 확인하고, 그에 따라 토글합니다.
    if (allMenuActive.style.display === 'none') {
      allMenuActive.style.display = 'flex';
    } else {
      allMenuActive.style.display = 'none';
    }
  });
  
  var currentPosition = parseInt($(".quickmenu").css("top"));
  $(window).scroll(function() {
    var position = $(window).scrollTop(); 
    $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},1000);
  });
  
  
  if (window.location.pathname === '/cart/cart_main') {
	  var checkboxes = document.getElementsByClassName("select-checkbox");
	
	  for (var i = 0; i < checkboxes.length; i++) {
	    // 체크박스 상태 변경 시 updateTotalPrice 함수 호출
	    checkboxes[i].addEventListener('change', updateTotalPrice);
	    checkboxes[i].addEventListener('change', payPrice);
	  }
	  
	   // 페이지 로드 시 초기 주문금액 업데이트
	   updateTotalPrice();   
	   payPrice();
  }
};
</script>