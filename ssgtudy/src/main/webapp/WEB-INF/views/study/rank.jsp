<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function search() {
	var f = document.searchForm;
	f.action = "${pageContext.request.contextPath}/study/rank/list";
	f.submit();
}

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
				alert("요청 처리가 실패 했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	$(window).scroll(function(){
		if($(window).scrollTop()+100 >= $(document).height()-$(window).height()) {
			var pageNo = $(".guest-count").attr("data-pageNo");
			var total_page = $(".guest-count").attr("data-totalPage");
			if(pageNo < total_page) {
				++pageNo;
				listPage(pageNo);
			}
		}
	});
});

function checkScrollBar() {
	var hContent = $("body").height();
	var hWindow = $(window).height();
	if(hContent > hWindow) {
		return true;
	}
	
	return false;
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
				alert("요청 처리 중 에러가 발생했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}
function memberAdd(studyNum) {
	var userId = "${sessionScope.member.userId}";
	
	var query = "userId="+userId+"&studyNum="+studyNum;
	var url = "${pageContext.request.contextPath}/study/member";
	var fn  = function(data) {

		if(data.status === "400") {
			alert("이미 참여중인 스터디이거나, 대기중입니다.");
		} else {
			alert("스터디 참여 신청이 완료되었습니다:)");
		}
	}
	ajaxFun(url, "get", query, "json", fn);
}

function visitHome(studyNum) {
	var url = "${pageContext.request.contextPath}/study/home/"+studyNum;
	location.href = url;
}

$(function() {
	listPage(1);
});

function listPage(page) {
	var url = "${pageContext.request.contextPath}/study/rank/list"
	var query = "pageNo="+page;
	
	var fn = function(data) {
		printRank(data);
	}
	ajaxFun(url, "get", query, "json", fn);
}

function printRank(data) {

	var dataCount = data.dataCount;
	var pageNo = data.pageNo;
	var total_page = data.total_page;
	
	$(".rank-count").attr("data-totalPage", total_page);
	
	if(dataCount == 0) {
		$("#listRank").hide();
		$(".rank-list-body").empty();
		return;
	}
	
	$("#listRank").show();
	$(".rank-count").html("총 스터디 수 " + dataCount +"개");
	
	var out = "";
	for(var idx = 0; idx<data.rankList.length; idx++) {
		var studyNum = data.rankList[idx].studyNum;
		var studyName = data.rankList[idx].studyName;
		var studyStatus = data.rankList[idx].studyStatus;
		var rank = data.rankList[idx].rank;
		var questCount = data.rankList[idx].questCount;
		
		out += "<tr class='text-center'>";
		out += "	<td>"+rank+"</td>";
		out += "	<td>"+studyName+"</td>";
		out += "	<td>"+questCount+"</td>";
		out += "	<td>";
		out += "		<button type='button' class='btn btn-primary' onclick='visitHome("+studyNum+")'>구경하기</button>";
		out += "		<button type='button' class='btn btn-danger' onclick='memberAdd("+studyNum+")'>참여신청</button>";
		out += "	</td>";
		out += "</tr>";
	}

	$(".rank-list-body").append(out);
	
	if(! checkScrollBar() ) {
		if(pageNo < total_page) {
			++pageNo;
			listPage(pageNo);
		}
	}
}

</script>

<section id="basic-horizontal-layouts">
    <div class="row match-height justify-content-center">
        <div class="col-8">
        <div class="page-title">
			<div class="row">
				<div class="col-12 col-md-6 order-md-1 order-last">
					<h3><span style="color: #ffc800;"><i class="icofont-trophy-alt"></i></span> 스터디 순위</h3>
					<p class="text-subtitle text-muted">
						목표달성횟수에 따른 스터디 순위입니다. <br>
						스터디상태가 비활성화되어있는 경우 순위에 산정되지 않습니다.
					</p>
				</div>
			</div>
		</div>
            <div class="card">
                <div class="card-content">
                    <div class="card-body">
                        <form class="form form-horizontal" name="form" method="post">
                            <div class="form-body">
                                <div class="row" id="listRank" style="display: none;">
	                                <div class='list-header'>
										<span class='rank-count' data-pageNo="1" data-totalPage="1">${dataCount}개(${page}/${total_page} 페이지)</span>
										<span class='rank-title'></span>
									</div>
                                    <table class="table table-responsive rank-list">
                                    	<thead>
	                                    	<tr class="text-center">
	                                    		<th class="col-2">순위</th>
	                                    		<th class="col-auto">스터디이름</th>
	                                    		<th class="col-2">달성횟수</th>
	                                    		<th class="col-3">스터디홈</th>
	                                    	</tr>
                                    	</thead>
                                    	<tbody class="rank-list-body">
										</tbody>
                                    </table>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>