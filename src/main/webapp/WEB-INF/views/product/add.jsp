<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<style>
.product-add-container{
	width: 50%;
	background-color:#fff;
	margin:auto;
	display:flex;
	justify-content:center;
	align-items:center;
	border:1px solid lightgray;
	border-radius:10px;
	padding:30px;
}

#product{
	width:100%;
}
#product>input{
	width:100%;
	height:35px;
	border:1px solid lightgray;
	border-radius:10px;
}
#product>label{
	font-weight:bold;
	font-size:24px;
}
input#REALPRICE,input#SALEPRICE{
	width: 50%;
}
textarea{
	width:100%;
	border:1px solid lightgray;
	border-radius:10px;
}
input#uploadFile{
	padding:10px;
	height:50px;
}
img{
	width:400px;
	height:300px;
	object-fit: cover;
}
.button-container {
    display: flex;
    justify-content: center;
}
.button-container>button{
	color:blue;
	font-weight:bold;
	background-color:#fff;
}
.button-container>button:hover{
	background-color:#eeeeee;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp" %> 
<div class="product-add-container">
	 <form:form action="/product/add" method="post" modelAttribute="product" enctype="multipart/form-data" >
	 
		 <h2><strong>신규상품 등록</strong></h2>
		 <h6 style="color:red;font-size:14px;">*는 필수입력 값 입니다.</h6>
		 <hr/>
	 	 <form:label path="PRDCTNM" >*상품명</form:label><br/>
	     <form:input path="PRDCTNM" placeholder="상품명을 입력해 주세요."/><br/>
		 <form:errors path ="PRDCTNM" style="color:red"/><br/>
		 
 		 <form:label path="PRDCTDTL">상품상세정보</form:label><br/>
         <form:textarea path ="PRDCTDTL" rows="5" cols="30"/><br/>
	     <form:errors path ="PRDCTDTL" style="color:red"/><br/>

		 <form:label path="REALPRICE">*원가</form:label><br/>
	     <form:input path ="REALPRICE" maxlength="11" />
		 <form:errors path ="REALPRICE" style="color:red"/><br/><br/>

	     <form:label path="SALEPRICE">*할인가격</form:label><br/>
         <form:input path ="SALEPRICE" maxlength="11" />
	     <form:errors path ="SALEPRICE" style="color:red"/><br/><br/>

	     <form:label path="PRDCTIMG1">*대표이미지</form:label><br/>
	     <img id="previewImage" alt="Preview">
         <input type="file" id="uploadFile" name="uploadFile" multiple required/>
	     
	     <form:label path="PRDCTIMG2">추가이미지1</form:label><br/>
	     <img id="previewImage" alt="Preview">
         <input type="file" id="uploadFile" name="uploadFile" multiple />
	     
	     <form:label path="PRDCTIMG3">*추가이미지2</form:label><br/>
	     <img id="previewImage" alt="Preview">
         <input type="file" id="uploadFile" name="uploadFile" multiple />

		<div class="button-container">
	       <form:button >등록</form:button>
		</div>
	</form:form >
	
	</div>
	<script>
		  document.getElementById("uploadFile").addEventListener("change", function () {
		    var file = this.files[0];
		    var reader = new FileReader();
		
		    reader.onload = function (e) {
		      // 파일을 읽어서 미리보기 이미지에 설정합니다.
		      var previewImage = document.getElementById("previewImage");
		      previewImage.src = e.target.result;
		    };
		
		    // 선택한 파일을 읽습니다.
		    reader.readAsDataURL(file);
		  });		
	</script>
</body>
</html>