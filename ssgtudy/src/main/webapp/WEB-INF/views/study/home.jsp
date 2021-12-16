<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<div class="col-12 col-md-6 order-md-1 order-last">
	    <h3><i class="icofont-university"></i>[${dto.studyName}]의 스터디 공간</h3>
	</div>
<section class="row">
	<div class="row"> 
		<div class="col-md-10">
			<div class="card p-2 card-main">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
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
			            		<button type="button" class="btn btn-primary btnAddCategory">카테고리 추가하기</button>
			         			<button type="button" class="btn btn-primary btnUpdateStudy" onclick="updateStudy('${dto.studyNum}')">이름 및 목표 수정</button>  	
			         			<button type="button" class="btn btn-primary btnUpdateStudy" onclick="inactiveStudy('${dto.studyNum}')">스터디 비활성화</button>
			           		</div> 
			           	</c:when>
						<c:otherwise>
			           		<div class="text-center p-2">
			           			<h4>아직 스터디관리자의 승인을 받지못했습니다.</h4>
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
		    			<i class="icofont-users-social"></i> 스터디 구성원
		    		</h5>
		    	</div>
		    		<table class="table table-borderless">
		    			<tr>
		    				<th>구성원</th>
		    				<th>역할</th>
		    			</tr>
		    			<c:forEach items="${memberList}" var="dto">
			    			<tr>
			    				<td>${dto.nickName}</td>
			    			<c:choose>
			    				<c:when test="${dto.role > 10}">
			    					<td>스터디장</td>
			    				</c:when>
			    				<c:when test="${dto.role > 1 }">
			    					<td>스터디 관리자</td>
			    				</c:when>
			    				<c:otherwise>
			    					<td>일반멤버</td>
			    				</c:otherwise>
			    			</c:choose>
			    			</tr>
			    		</c:forEach>
		    		</table>
			    
		    	<c:if test="${dto.role > 1 }">
	           		<div class="buttons text-center p-2">
		         		<a href="#" class="btn btn-primary btnManageMember">구성원관리</a>     	
	           		</div> 
	           	</c:if>
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