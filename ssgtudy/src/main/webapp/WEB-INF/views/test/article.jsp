<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style type="text/css">
.content {
	text-align: center;
    display: flex;
    flex-flow: row nowrap;
    align-items: center;
}
.replyContent {
	min-height : 70px;
	min-width: 1000px;
}
.testFrame{
	width : 100%;
	height : 700px;
}
</style>
<script type="text/javascript">
function deleteBoard(){
	if(confirm("게시글을 삭제하시겠습니까?")){
		var query = "testNum=${dto.testNum}&${query}";
		var url = "${pageContext.request.contextPath}/test/delete?" + query;
		location.href=url;
	}
}

function ajaxFun(url, method, query, dataType, fn){
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			alert("요청 처리가 실패 했습니다.");
			return false;
	    	
			console.log(jqXHR.responseText);
		}
	});
}
//페이징 처리
$(function(){
	listPage(1);
});

function listPage(page){
	var url = "${pageContext.request.contextPath}/test/listReply";
	var query = "testNum=${dto.testNum}&pageNo="+page;
	var selector = "#listReply";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

//리플 등록
$(function(){
	$(".btnSendReply").click(function(){
		var testNum = "${dto.testNum}";
		var $tb = $(this).closest("table");
		var content = $tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "${pageContext.request.contextPath}/test/insertReply";
		var query = "testNum=" + testNum + "&content=" + content + "&answer=0";
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state = data.state;
			if(state === "true") {
				listPage(1);
			} else if(state === "false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

//댓글 삭제
$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("댓글을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var replyNum = $(this).attr("data-replyNum");
		var page = $(this).attr("data-pageNo");
		
		var url = "${pageContext.request.contextPath}/test/deleteReply";
		var query = "replyNum="+replyNum;
		
		var fn = function(data){
			// var state = data.state;
			listPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

//댓글 좋아요 
$(function(){
	$("body").on("click", ".btnSendReplyLike", function(){
		var replyNum = $(this).attr("data-replyNum");
		var $i = $(this).find("i");
		var userReplyLiked = $i.hasClass("bi-hand-thumbs-up-fill");
		var msg = userReplyLiked ? "댓글 공감을 취소하시겠습니까?" : "댓글에 공감하십니까?";
		var $btn = $(this);
		
		if(! confirm(msg)) {
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/test/insertReplyLike";
		var query = "replyNum=" + replyNum + "&userReplyLiked=" + userReplyLiked;
		
		var fn = function(data){
			var state = data.state;
			if(state==="true") {
				if( userReplyLiked ) {
					$i.removeClass("bi-hand-thumbs-up-fill").addClass("bi-hand-thumbs-up");
				} else {
					$i.removeClass("bi-hand-thumbs-up").addClass("bi-hand-thumbs-up-fill");
				}
				
				var count = data.replyLikeCount;
				$("#likeCount").text(count);
			} else if(state==="liked") {
				alert("댓글 공감은 한번만 가능합니다.");
			} else if(state==="false") {
				alert("댓글 공감 추가에 실패했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

//댓글별 답글 리스트
function listReplyAnswer(answer) {
	var url = "${pageContext.request.contextPath}/test/listReplyAnswer";
	var query = "answer=" + answer;
	var selector = "#listReplyAnswer" + answer;
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

//댓글별 답글 개수
function countReplyAnswer(answer) {
	var url = "${pageContext.request.contextPath}/test/countReplyAnswer";
	var query = "answer=" + answer;
	
	var fn = function(data){
		var count = data.count;
		var selector = "#answerCount"+answer;
		$(selector).html(count);
	};
	
	ajaxFun(url, "post", query, "json", fn);
}

//답글 버튼(댓글별 답글 등록폼 및 답글리스트)
$(function(){
	$("body").on("click", ".btnReplyAnswerLayout", function(){
		var $trReplyAnswer = $(this).closest("tr").next();
		// var $trReplyAnswer = $(this).parent().parent().next();
		// var $answerList = $trReplyAnswer.children().children().eq(0);
		
		var isVisible = $trReplyAnswer.is(':visible');
		var replyNum = $(this).attr("data-replyNum");
			
		if(isVisible) {
			$trReplyAnswer.hide();
		} else {
			$trReplyAnswer.show();
            
			// 답글 리스트
			listReplyAnswer(replyNum);
			
			// 답글 개수
			countReplyAnswer(replyNum);
		}
	});
	
});

//댓글별 답글 등록
$(function(){
	$("body").on("click", ".btnSendReplyAnswer", function(){
		var testNum = "${dto.testNum}";
		var replyNum = $(this).attr("data-replyNum");
		var $td = $(this).closest("td");
		
		var content = $td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "${pageContext.request.contextPath}/test/insertReply";
		var query = "testNum=" + testNum + "&content=" + content + "&answer=" + replyNum;
		
		var fn = function(data){
			$td.find("textarea").val("");
			
			var state = data.state;
			if(state === "true") {
				listReplyAnswer(replyNum);
				countReplyAnswer(replyNum);
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

//댓글별 답글 삭제
$(function(){
	$("body").on("click", ".deleteReplyAnswer", function(){
		if(! confirm("댓글을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var replyNum = $(this).attr("data-replyNum");
		var answer = $(this).attr("data-answer");
		
		var url = "${pageContext.request.contextPath}/test/deleteReply";
		var query = "replyNum=" + replyNum;
		
		var fn = function(data){
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

</script>
</head>
<body>
	<div class="page-title">
		<div class="row">
			<div class="col-12 col-md-6 order-md-1 order-last">
				<h3>공지사항</h3>
				<p class="text-subtitle text-muted">공지사항을 확인해주세요</p>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-12">
       <div class="card">
           <div class="card-content">
               <div class="card-body">
                   <div class="table-responsive">
                       <table class="table table-lg">
                           <tr>
	                           <td colspan="2" align="center">${dto.testName} - ${dto.subName}(${dto.isOdd})</td>
                           </tr>
                           <tr>
                           		<td width="50%">
                           			작성자 : ${dto.nickName}
                           		</td>
                           		<td align="right">
                           			${dto.reg_date} &nbsp|&nbsp 조회 ${dto.hitCount}
                           			<!-- <span class='btnReport' style="cursor:pointer"> &nbsp|&nbsp 신고</span> 
                           			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal"
                           				style="border: white; background: white; color: #F15F5F">신고</button>-->
                           		</td>
                           </tr> 
                           <tr style="border-bottom:white">
	                           <td colspan="2" height="300px">
	                           		 <iframe src="${pageContext.request.contextPath}/uploads/mock/${dto.saveFilename}" class="testFrame" frameborder="0"></iframe> 
                           				<hr>
                           			${dto.content}
                           		</td>
                           </tr>
                           <c:forEach var="vo" items="${listFile}">
                           		<tr>
                           			<td colspan="2">
                           				파일 : 
                           				<a href="${pageContext.request.contextPath}/test/download?test_fileNum=${vo.test_fileNum}">${vo.originalFilename}</a>
                           				(<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> kb)
                           			</td>
                           		</tr>
                           </c:forEach>
                           
                           <tr>
                           		<td colspan="2">
                           			이전글 :
                           			<c:if test="${not empty preReadDto}">
                           				<a href="${pageContext.request.contextPath}/test/article?testNum=${preReadDto.testNum}&${query}">${preReadDto.testName} - ${preReadDto.subName}(${preReadDto.isOdd})</a>
                           			</c:if>
                           		</td>
                           </tr>  
                           <tr>
                           		<td colspan="2">
                           			다음글 :
                           			<c:if test="${not empty nextReadDto}">
                           				<a href="${pageContext.request.contextPath}/test/article?testNum=${nextReadDto.testNum}&${query}">${nextReadDto.testName} - ${nextReadDto.subName}(${nextReadDto.isOdd})</a>
                           			</c:if>
                           		</td>
                           </tr>  
                       </table>
	                  
                      	<div class="col-md-2 justify-content-start">
                      		<button type="button"  class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/test/mock?${query}';">리스트</button>	
                      		<c:choose>
                      			<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.membership>50}">
									<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/test/update?testNum=${dto.testNum}&page=${page}';">수정</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-outline-primary me-1 mb-1" style="visibility: hidden;">수정</button>							
								</c:otherwise>
							</c:choose>	
							<c:choose>
                      			<c:when test="${sessionScope.member.membership>50}">
									<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="deleteBoard();">삭제</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-outline-primary me-1 mb-1" style="visibility: hidden;">삭제</button>							
								</c:otherwise>
							</c:choose>	
						</div>
                   </div>
               </div>
               <hr>
               <div class="card-body reply" style="margin-top:20px;">
		           <div class="table-responsive">
		           	   <form name="replyForm" method="post">
		           	   		<table class="table reply-form" style="border-color: white;">
		           	   			<th><i class="bi bi-person-circle text-muted"></i>&nbsp&nbsp${sessionScope.member.nickName}</th>
		           	   			<tr>
		           	   				<td>
		           	   					<textarea class="form-control replyContent" name="content" placeholder="댓글을 남겨보세요"></textarea>
		           	   				</td>
       	   		 					<td align='right'>
       	   		 						<button type="button" class='btn btn-outline-primary me-1 mb-1 btnSendReply'>댓글 등록</button>
       	   		 					</td>
       	   		 				</tr>
		           	   		</table>
		           	   </form>
		               <div id="listReply"></div>
		          </div>
		      </div> 
           </div>
       </div>
   </div>
   
</body>
