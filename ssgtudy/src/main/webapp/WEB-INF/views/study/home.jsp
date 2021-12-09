<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="p-3">
	<h3><i class="fas fa-home"></i>
	[${dto.studyName}]의 스터디 공간</h3>
</div>
<div class="card">
	<ul class="nav nav-tabs" id="myTab" role="tablist">
       <li class="nav-item" role="presentation">
           <a class="nav-link active navbar-brand h1" id="home-tab" data-bs-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Home</a>
       </li>
   </ul>
   <div class="tab-content" id="myTabContent">
         <div class="tab-pane fade active show" id="home" role="tabpanel" aria-labelledby="home-tab">
         
             <c:choose>
             	<c:when test="${dto.role > 10 }">
             		<div class="buttons text-center">
	             		<a href="#" class="btn btn-primary">스터디장 변경하기</a>
			         	<a href="#" class="btn btn-primary">구성원관리</a>     	
	             		<a href="${pageContext.request.contextPath}/study/addCategory" class="btn btn-primary btnAddCategory">카테고리 추가하기</a>
             		</div> 
             	</c:when>
             	<c:when test="${dto.role > 1 }">
             		<div class="buttons text-center">
			         	<a href="#" class="btn btn-primary">구성원관리</a>     	
	             		<a href="#" class="btn btn-primary">카테고리 추가하기</a>
             		</div> 
             	</c:when>
             </c:choose>
		</div>
	</div>
</div>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

function ajaxFun(url, method, query, dataType, fn) {
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
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

$(function() {
	
});

$(function() {
	$(".btnAddCategory").click(function() {
		var url = "${pageContext.request.contextPath}/study/addCategory";
		var selector = "#home";
		var fn = function() {
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "HTML", fn);
	});
});

</script>