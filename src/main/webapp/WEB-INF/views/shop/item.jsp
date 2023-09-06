<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 메뉴</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>


<script>
	
	$(document).ready(function(){
	var prdctValue = '<c:out value="${item.PRDCTNO}"/>';
	var replyUL = $(".chat");
	var commentUL = $(".commentUL");
	
	showList(1);
	function showList(page) {
		replyService.getList({ prdctno: prdctValue, page: page || 1 }, function (list) {
			var str = "";
			if (list == null || list.length == 0) {
				replyUL.html("");
				return;
			}
			for (var i = 0, len = list.length || 0; i < len; i++) {
				str += "<li class='card' data-rno='" + list[i].rno + "'>";
				str += "<div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>";
				str += "<small class ='pull-right text-muted'>" + list[i].replydate + "</small></div>";
				str += "<p>" + list[i].reply + "</p>";
				str += "<button style=font-size:12px; margin:10px;' id='showReply'>댓글보기</button> ";
	            str += "<button style=font-size:12px; margin:10px;' id='addReply'>댓글쓰기</button>";


				str += "</div></li>"
			}
			replyUL.html(str);
	    });
	

	   
	}//show list end
	
	    
		$("#modalRegisterBtn").on("click",function(e){
			var reply ={
					reply : $("#reply").val(),
					replyer : $("#replyer").val(),
					prdctno : prdctValue
			};
			replyService.add(reply,function(result){
				alert('댓글이 등록되었습니다!');
				location.reload(true);
			})
		});
	
		$(document).on("click", "#showReply", function(e) {
			var rno = $(this).closest('li.card').data('rno');
		    replyService.show(rno, function(data){
		    	var str = "";
				if (data == null || data.length == 0) {
					commentUL.html("");
					return;
				}
				for (var i = 0, len = data.length || 0; i < len; i++) {
					str += "<li class='card' data-rno='" + data[i].rno + "'>";
					str += "<div><div class='header'><strong class='primary-font'>" +" ㄴ " +data[i].replyer + "</strong>";
					str += "<small class ='pull-right text-muted'>" +data[i].replydate + "</small></div>";
					str += "<p>"+ data[i].reply + "</p>";
					str += "<button style=font-size:12px; margin:10px;' id='hideReply'>댓글접기</button> ";

					str += "</div></li>"
				}
				commentUL.html(str);
		    }, function(err){
		       console.error(err);
		    });
		});
		

		$(document).on("click", "#hideReply", function(e) {
			commentUL.html("");

		});
		
		$(document).on("click", "#addReply", function(e) {
		    alert('add!');
		});
	});
	

</script>
<style>
	body {
		font-family: 'Roboto', Arial, sans-serif;
		margin: 0;
		padding: 0;
		background-color: #f4f4f4;
	}
	
	.one-detail-form{
        display:flex;
        width: 70%;
        height:auto; 
        background:#fff; 
        box-shadow: 0px 0px 10px rgba(0,0,0,.1); 
        border-radius:10px; 
        overflow:hidden; 
        margin:auto;
        margin-top:100px; /* 상단 여백 추가 */
    }
    
	img{
	    object-fit: cover;
	    width:50%;
	    height:auto ;
	    padding :20px ;
    }
    
    .right-prd-dtl{
    	width:auto ;
    	padding :40px ;
    	
    }
    
    .one_dtl_info{
    	font-size :24px ; 
    	list-style:none ; 
    	line-height :2.5 ; 
    	
    }
    
    .panel-heading{
    	display:flex;
    	background-color: lightgreen;
    	border-radius: 5px;
    	padding:10px;
    	justify-content: space-between;
    }
    .header, .chat p, .commentUL p{
    	padding:10px;
    }
    #addReplyBtn,#repl-comment{
    	border-radius:5px;
    }
    #addReplyBtn:hover{
    	background-color:rgb(0,127,255);
    	color:white;
    }
    
</style>
</head>
<body>
<%@ include file="../common/header.jsp" %> 
<div id="one-shop-detail">
	<section class="one-detail-form">
		<img src="../resources/img/lasagna.jpg">
		<div class="right-prd-dtl">
			<p>${item.PRDCTNM }</p>
			<div class="one_dtl_prd">
				<h2>${item.PRDCTDTL }</h2>		
			</div>
			<hr/>
			<ul class="one_dtl_info">
				<li>판매가 : ${item.SALEPRICE} </li>
				<li>배송비 : </li>
			</ul>
			<div class="one_opt_qt">
				${item.PRDCTDTL }
			</div>
		</div>
		
	</section>
	
</div><!-- one-shop-detail end -->
<p/>
	<div class="container">
		<div class="row  justify-content-center">
			<div class="col-lg-10">
				<div class="panel panel-success">
					<div class="panel-heading" >
						<div>
							<i class="fa fa-comments fa-fw"></i>Reply
						</div>
						<button id='addReplyBtn' data-bs-toggle="modal" data-bs-target="#commentModal">
							New Reply
						</button>
					</div>
				</div>
			</div>
			<!-- /.panel-heading -->
			<div class= "panel-body col-lg-10">
				<ul class = "chat"></ul>				
				<ul class = "commentUL"></ul>				
			</div>
			<div class="panel-footer"></div>
		</div>
		
		
	</div><!-- container end -->
	<!-- Comment Modal -->
    <div class="modal fade" id="commentModal" tabindex="-1" role="dialog" aria-labelledby="commentModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id='commentModalLabel'>댓글달기</h5>
 				    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>                       
                </div>
                <div class='modal-body'>
                    <!-- Comment Input Form -->
                    <form>
                    	<input type="hidden" name="prdctno" value="${item.PRDCTNO }"/>
                        <div class='form-group'>
                            <label for='replyer'><strong>작성자</strong></label>
                            <input type='text' id='replyer' name ='replyer'  placeholder = '이름을 입력해주세요'class ='form-control' required/>
                        </div>
						<p/>	
                        <div class = 'form-group'>
                           	<label for = 'reply'><strong>댓글 내용</strong></label>
                           	<textarea id = 'reply' name = 'reply'  placeholder ='내용을 입력해주세요' class= 'form-control' required></textarea> 
                      	</div> 
						<div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					        <button type="button" id="modalRegisterBtn" class="btn btn-primary">댓글달기</button>
					      </div>
			     </form> 
                </div> 
            </div>  
        </div>  
    </div><!-- End of Comment Modal -->
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

</body>

</html>