<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/css">
.more-box .more:hover {
	cursor: pointer; color: #2524ff; font-weight: 500;
}
</script>

	<div class="col-12 col-md-6 order-md-1 order-last">
	    <h3><span><i class="icofont-archive"></i></span> ${dto.studyName}의 스터디 공간</h3>
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
			           			<button type="button" class="btn btn-danger btnAddQuestCount">목표달성</button>
			           			<button type="button" class="btn btn-success btnCheckTimes" data-bs-toggle="modal" data-bs-target="#checkTimes" >달성회수확인</button><br>
			         			<button type="button" class="btn btn-primary btnUpdateStudy" onclick="updateStudy('${dto.studyNum}')">이름 및 목표 수정</button>
			            		<button type="button" class="btn btn-primary btnAddCategory">카테고리 관리</button>
			         			<button type="button" class="btn btn-primary btnManageMember">구성원관리</button>
			         		<hr>
			         			<h6><span class="align-middle"><i class="bi bi-exclamation-square"></i></span> DANGEROUS ZONE</h6>
			         			<p class="m-3 fw-bold">스터디 비활성화 후 활성화를 위해서는 관리자에게 쪽지로 요청해야합니다. 활성화를 위해서는 최소 몇 일이 걸릴 수도 있습니다. 신중하게 선택해주세요.</p>
			         			<p class="m-3 fw-bold">스터디 삭제 시 모든 정보들이 삭제됩니다.</p>
			         			<button type="button" class="btn btn-dark" onclick="inactiveStudy('${dto.studyNum}')">스터디 비활성화</button>
			         			<button type="button" class="btn btn-dark" onclick="deleteStudy('${dto.studyNum}')">스터디 삭제</button>
			           		</div>
			           	</c:when>
			           	<c:when test="${dto.role > 1 }">
			           		<div class="buttons text-center p-2">
			           		<h6><span class="align-middle"><i class="bi bi-gear-wide-connected"></i></span> 관리자 메뉴</h6>
			           			<button type="button" class="btn btn-danger btnAddQuestCount">목표달성</button>
			           			<button type="button" class="btn btn-success btnCheckTimes" data-bs-toggle="modal" data-bs-target="#checkTimes" >달성회수확인</button><br>
			           			<button type="button" class="btn btn-primary btnManageMember">구성원관리</button>
				           		<hr>
			           			<h4>${dto.studyName}</h4>
			           			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">스터디신고</button>
			           			<button type="button" class="btn btn-primary btnWithdraw">스터디탈퇴</button>
			           		</div>
			           	</c:when>
			           	<c:when test="${dto.role == '1' }">
		           			<div class="text-center p-2">
		           				<hr>
			           			<h4>${dto.studyName}</h4>
			           			<button type="button" class="btn btn-success btnCheckTimes" data-bs-toggle="modal" data-bs-target="#checkTimes" >달성회수확인</button>
			           			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">스터디신고</button>
			           			<button type="button" class="btn btn-primary btnWithdraw">스터디탈퇴</button>
			           		</div>
			           	</c:when>
			           	<c:when test="${mode=='visit'}">
			           		<div class="text-center p-2">
			        	   		<hr>	
			           			<h4><span class="align-middle"><i class="bi bi-exclamation-square"></i></span> 일반멤버가 아니므로 기능이 제한됩니다.</h4>
			           			<hr>
			           			<h4>${dto.studyName}</h4>
			           			<button type="button" class="btn btn-success btnCheckTimes" data-bs-toggle="modal" data-bs-target="#checkTimes" >달성회수확인</button>
			           			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">스터디신고</button>
			           		</div>
			           	</c:when>
						<c:otherwise> <!-- 대기일때 dto.role 이 0이라서.. -->
			           		<div class="text-center p-2">
			        	   		<hr>	
			           			<h4><span class="align-middle"><i class="bi bi-exclamation-square"></i></span> 일반멤버가 아니므로 기능이 제한됩니다.</h4>
			           			<hr>
			           			<h4>${dto.studyName}</h4>
			           			<button type="button" class="btn btn-success btnCheckTimes" data-bs-toggle="modal" data-bs-target="#checkTimes">달성회수확인</button>
			           			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">스터디신고</button>
			           			<button type="button" class="btn btn-primary btnWithdraw">스터디탈퇴</button>
			           		</div>
			           	</c:otherwise>
		           	</c:choose>
				</div>
			</div>
		</div>
		<div class="col-md-2">
		    <div class="card" id="listMember">
		    	<div class="card-header list-header pb-0 px-0">
		    		<h5 class="card-title text-center">
		    			<span class="align-middle"><i class="bi bi-person-lines-fill"></i></span> 스터디 구성원
		    		</h5>
		    		<span class="member-count" data-pageNo="1" data-totalPage="1"></span>
		    		<p class="text-center fw-bold p-3 m-0"><span class="member-title">총 -명</span></p>
		    	</div>
	    		<table class="table table-borderless member-list">
	    			<thead>
	    			<tr class="text-center">
	    				<th>구성원</th>
	    				<th>역할</th>
	    			</tr>
	    			</thead>
	    			<tbody class="member-list-body">
	    			
	    			</tbody>
	    		</table>
	    		<div class="more-box text-center buttons">
					<span class="more"><button type="button" class="btn btn-sm btn-primary btnMore">더보기 <i class="icofont-plus"></i></button></span>
				</div>
		    </div>
		</div>
	</div>
</section>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">스터디 신고</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<form class="form form-horizontal" name="reportForm" method="post">
        	<textarea class="form-control reason" name="reason" style="height: 200px; resize: none;" placeholder="신고사유를 적어주세요."></textarea>
        	<input type="hidden" name="studyNum" value="${dto.studyNum}">
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>
        <button type="button" class="btn btn-danger btnReport">신고하기</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="checkTimes" tabindex="-1" aria-labelledby="checkTimesLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="checkTimesLabel">달성 횟수 확인</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<table class="times-write table">
					<thead>
						<tr class="text-center">
							<th>달성횟수</th>
							<th>사용횟수</th>
							<th>변경날짜</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
			</div>
				<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}
var isRun = false;
function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
			isRun = false;
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
	// console.log(categoryNum);
	
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
	// console.log(query);
	
	var search=$('form[name=searchForm]').serialize();
	query=query+"&"+search;
	
	var selector = "#myTabContent";
	
	if(isRun == true) {
		return;
	}
	
	isRun = true;
	
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
		var url = "${pageContext.request.contextPath}/study/manageMember?studyNum=${dto.studyNum}";
		location.href = url; 
	});
});

$(function () {
	$(".btnCheckTimes").click(function() {
		var url = "${pageContext.request.contextPath}/study/times";
		var query = "studyNum=${dto.studyNum}";
	
		var fn = function(data) {
			// console.log(data);
			$(".times-write tbody").empty();
			
			var out = "";
			var questCount = data.dto.questCount;
			var usedCount = data.dto.usedCount;
			var updateDate = data.dto.updateDate;
			if(updateDate == null ) {
				updateDate = "변경된 이력이 없습니다.";
			}
			
			if(data.status == 'true') {
				out += "<tr class='text-center'>";
				out += "	<td>"+ questCount +"</td>";
				out += "	<td>"+ usedCount +"</td>";
				out += "	<td>"+ updateDate +"</td>";
				out += "/<tr>";
				$(".times-write tbody").append(out);				
			} else {
				out += "에러가 발생했습니다.";
				$(".times-write tbody").append(out);
			}
		}
		
		ajaxFun(url, "get", query, "json", fn);
	});
})

function updateStudy(studyNum) {
	location.href = "${pageContext.request.contextPath}/study/update?studyNum="+studyNum;
}

function inactiveStudy(studyNum) {
	if(! confirm("비활성화 후 상태변경은 관리자에게 문의해야합니다. 비활성화하시겠습니까 ? ")) {
		return false;
	}
	location.href = "${pageContext.request.contextPath}/study/inactive?studyNum="+studyNum;
}


//더보기 누르면 멤버 리스트 더 불러오게끔
$(function () {
	$("body").on("click", ".btnMore", function() {
		var pageNo = $(".member-count").attr("data-pageNo");
		var total_page = $(".member-count").attr("data-totalPage");
		
		if(pageNo < total_page) {
			pageNo++;
			listMember(pageNo);
		}
	});
})

function listMember(page) {
	var url = "${pageContext.request.contextPath}/study/memberList";
	var query ="pageNo="+page+"&studyNum="+${dto.studyNum};
	
	var fn = function(data) {
		printMember(data);
	};
	
	ajaxFun(url, "get", query, "json", fn);	
}

function printMember(data) {
	// console.log(data);
	var dataCount = data.dataCount;
	var pageNo = data.pageNo;
	var total_page = data.total_page;
		
	$(".member-count").attr("data-pageNo", pageNo);
	$(".member-count").attr("data-totalPage", total_page);
	
	if(dataCount == 0) {
		$(".member-list-body").empty();
		return;
	}
	
	if(pageNo < total_page) {
		$(".more-box").show();
	}
	
	var out = "";
	for(var idx = 0; idx < data.memberList.length; idx++) {
		var nickName = data.memberList[idx].nickName;
		var role = data.memberList[idx].role;
		
		if(role > 10) {
			role = "스터디장";
		} else if(role > 1) {
			role = "관리자";
		} else if(role == '1') {
			role = "일반멤버";
		} else {
			role = "대기멤버";
		}
		
		out += "<tr class='text-center'>";
		out += "	<td>"+nickName+"</td>";
		out += "	<td>"+role+"</td>";
		out += "</tr>";
	}
	
	$(".member-list-body").append(out);
	
	var out = "";
	out += (dataCount) + "명과 함께하고 있습니다.<br>";

	$(".member-title").html(out);
}

$(function () {
	listMember(1);
})

function addLotto(studyNum) {
	// console.log(studyNum);
	// TODO
};

function deleteStudy(studyNum) {
	// console.log(studyNum);
	if(! confirm("스터디 삭제를 삭제하시겠습니까 ? ")) {
		return false;
	}
	location.href = "${pageContext.request.contextPath}/study/purge?studyNum="+studyNum;
}

$(function() {
	$(".btnAddQuestCount").click(function() {
		var studyNum = ${dto.studyNum};
		if(${dto.role} <= 1) {
			return false;
		}

		if(! confirm("목표달성횟수를 추가하시겠습니까 ? ") ) {
			return false;
		}
		var url = "${pageContext.request.contextPath}/study/questCount";
		var query = "studyNum=" + studyNum
		
		var fn = function(data) {
			// console.log(data);
			var questCount = data.questCount;
			if( data.status == "true") {
				alert("목표달성횟수 추가가 완료되었습니다. 총 "+questCount+"일 목표달성을 완료했습니다:)");
			} else if( data.status == "false") {
				alert("하루에 한번만 추가할 수 있습니다.");
			}
		}
		
		ajaxFun(url, "get", query, "json", fn);	
	});
});

$(function() {
	$(".btnReport").click(function() {
		var f = document.reportForm;
		var reason = f.reason.value.trim();
		if(! reason) {
			alert("사유는 필수 입력입니다.");
			return false;
		}
		
		var query = $(f).serialize();
		var url = "${pageContext.request.contextPath}/study/report"; 
		 var fn = function(data) {
			// console.log(data);
			if(data.status == 'true') {
				alert("신고 접수가 완료되었습니다.");
				$("#exampleModal").modal("hide");
				$(".reason").val("");
			} else if(data.status == '1') {
				alert("이미 신고한 이력이 있습니다.");
				$("#exampleModal").modal("hide");
				$(".reason").val("");
			}
		}
		
		ajaxFun(url, "post", query, "json", fn); 
		
	});
});

$(function() {
	$(".btnWithdraw").click(function() {
		// console.log(${dto.memberNum});
		if(! confirm( "${dto.studyName}에서 탈퇴하시겠습니까 ? ") ) {
			return false;
		}
		
		if(${dto.memberNum} == '0') { // 0은 방문자
			alert("이 스터디의 멤버가 아닙니다.");
			return false;
		}
			
		var query = "memberNum="+${dto.memberNum}+"&studyNum="+${studyNum};
		var url = "${pageContext.request.contextPath}/study/withdraw";
		var fn = function(data) {
			if(data.status == 'true') {
				alert("탈퇴가 완료되었습니다. ");
				location.href = "${pageContext.request.contextPath}/study/home/"+data.studyNum;
			} else if(data.status == '1') {
				alert("이 스터디의 멤버가 아닙니다.")
			}
		}
		ajaxFun(url, "get", query, "json", fn); 
	});
});


</script>

