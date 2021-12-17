<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<div class="col-12 col-md-6 order-md-1 order-last">
	    <h3><i class="icofont-group-students"></i> ${dto.studyName}의 스터디 공간</h3>
	</div>
<section class="row">
	<div class="row"> 
		<div class="col-md-10">
			<div class="card p-2 card-main">
				<ul class="nav nav-tabs p-2" id="myTab" role="tablist">
			       <li class="nav-item" role="presentation">
			           <a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Home</a>
			       </li>
			       <c:forEach items="${listCategory}" var="vo" varStatus="status">
				       <li class="nav-item" role="presentation">
				       		<a class="nav-link" id="${vo.CATEGORYNUM}-tab" data-bs-toggle="tab" role="tab" aria-controls="${vo.CATEGORYNUM}" 
				       			aria-selected="false" data-categoryNum="${vo.CATEGORYNUM}">${vo.CATEGORYNAME}</a>	           
				       </li>
			       </c:forEach>
			   </ul>
			   <div class="tab-content" id="myTabContent">
			         <div class="tab-pane fade active show" id="home" role="tabpanel" aria-labelledby="home-tab">
			         	<h5 class="text-center p-2">${dto.studyGoal}</h5>
					</div>
				</div>
				<div class="box">
					<c:choose>
		         		<c:when test="${dto.role > 10 }">
			           		<div class="buttons text-center p-2">
			           		<hr>
			           			<h6><span class="align-middle"><i class="bi bi-gear-wide-connected"></i></span> 관리자 메뉴</h6>
			           			<button type="button" class="btn btn-danger btnAddCategory">목표달성</button>
			         			<button type="button" class="btn btn-primary btnUpdateStudy" onclick="updateStudy('${dto.studyNum}')">이름 및 목표 수정</button><br>  	
			            		<button type="button" class="btn btn-primary btnAddCategory">카테고리 관리</button>
			         			<button type="button" class="btn btn-primary btnManageMember">구성원관리</button>
			         		<hr>
			         			<h6><span class="align-middle"><i class="bi bi-exclamation-square"></i></span> DANGEROUS ZONE</h6>
			         			<p class="m-3 fw-bold">스터디 비활성화 후 활성화를 위해서는 관리자에게 쪽지로 요청해야합니다. 활성화를 위해서는 최소 몇 일이 걸릴 수도 있습니다. 신중하게 선택해주세요.</p>
			         			<button type="button" class="btn btn-dark btnUpdateStudy" onclick="inactiveStudy('${dto.studyNum}')">스터디 비활성화</button>
			           		</div>
			           	</c:when>
			           	<c:when test="${dto.role == '1' }">
		           			<div class="text-center p-2">
		           				<hr>
			           			<h4>${dto.studyName}</h4>
			           		</div>
			           	</c:when>
						<c:otherwise>
			           		<div class="text-center p-2">
			        	   		<hr>	
			           			<h4><span class="align-middle"><i class="bi bi-exclamation-square"></i></span> 일반멤버가 아니므로 기능이 제한됩니다.</h4>
			           		</div>
			           	</c:otherwise>
		           	</c:choose>
				</div>
			</div>
		</div>
		<div class="col-md-2">
		    <div class="card friend">
		    	<div class="card-header">
		    		<h5 class="card-title text-center">
		    			<span class="align-middle"><i class="bi bi-person-lines-fill"></i></span> 스터디 구성원
		    		</h5>
		    	</div>
		    		<table class="table table-borderless">
		    			<tr class="text-center">
		    				<th>구성원</th>
		    				<th>역할</th>
		    			</tr>
		    			<c:forEach items="${memberList}" var="dto">
			    			<tr class="text-center">
			    				<td>${dto.nickName}</td>
			    			<c:choose>
			    				<c:when test="${dto.role > 10}">
			    					<td>스터디장</td>
			    				</c:when>
			    				<c:when test="${dto.role > 1 }">
			    					<td>스터디 관리자</td>
			    				</c:when>
			    				<c:when test="${dto.role == '1' }">
			    					<td>일반멤버</td>
			    				</c:when>
			    				<c:otherwise>
			    					<td>대기멤버</td>
			    				</c:otherwise>
			    			</c:choose>
			    			</tr>
			    		</c:forEach>
		    		</table>
		    </div>
		</div>
	</div>
</section>

<form name="searchForm" method="post">
	<input type="hidden" name="condition" value="all">
    <input type="hidden" name="keyword" value="">
</form>

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

// 탭 누르면 해당사항이 나오게끔
$(function() {
	$("a[role='tab']").on("click", function(e){
    	listPage(1);
	});
});

function listPage(page) {
	var $tab = $("a[role='tab'].active");
	var categoryNum = $tab.attr("data-categoryNum");
	console.log(categoryNum);
	
	<c:if test="${mode=='visit'}">
	if(! categoryNum) {
		var url = '${pageContext.request.contextPath}/study/home/${dto.studyNum}';
		location.href = url;
	}
	</c:if>
	if(! categoryNum) {
		var url = '${pageContext.request.contextPath}/study/home/${dto.studyNum}';
		location.href = url;
	} else {
		var url = "${pageContext.request.contextPath}/study/home/${dto.studyNum}/list";
	}
	
	var query = "page="+page+"&categoryNum=" + categoryNum;
	console.log(query);
	
	var search=$('form[name=searchForm]').serialize();
	query=query+"&"+search;
	
	var selector = "#myTabContent";
	
	var fn = function(data){
		$(".box").empty();
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
	
}

$(function() {
	$(".btnAddCategory").click(function() {
		var url = "${pageContext.request.contextPath}/study/addCategory";
		var selector = ".card-main";
		var query = "studyNum=${dto.studyNum}";
		var fn = function(data) {
			$(".card-main").empty();
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "HTML", fn);
	});
});

$(function() {
	$(".btnManageMember").click(function() {
		var url = "${pageContext.request.contextPath}/study/manageMember";
		var selector = ".card";
		var query = "studyNum=${dto.studyNum}";
		var fn = function(data) {
			$(".card").empty();
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "HTML", fn);
	});
});

function updateStudy(studyNum) {
	location.href = "${pageContext.request.contextPath}/study/update?studyNum="+studyNum;
}

function inactiveStudy(studyNum) {
	if(! confirm("비활성화 후 상태변경은 관리자에게 문의해야합니다. 비활성화하시겠습니까 ? ")) {
		return false;
	}
	location.href = "${pageContext.request.contextPath}/study/inactive?studyNum="+studyNum;
}


</script>