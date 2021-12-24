<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/fullcalendar5/lib/main.min.css">

<div class="container">
	<div class="body-container">	
		<div class="body-title">
			<h3><i class="bi bi-calendar-event"></i> 일정관리 </h3>
		</div>
		
		<div class="body-main">
			<div class="row">
				<div class="col-sm-1 px-0 text-center">
					<a class="btn" data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample">
						<i class="bi bi-layout-text-sidebar-reverse" style="font-size : 25px;"></i>
					</a>
				</div>
				<div class="col px-2">
					<div id="calendar"></div>
				</div>
			</div>
			
			<div id='scheduleLoading' style="display: none;">loading...</div>
		</div>
	</div>
</div>

<!-- 좌측 카테고리 관리 오프캔버스 -->
<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
	<div class="offcanvas-header">
		<h5 class="offcanvas-title" id="offcanvasExampleLabel"><i class="bi bi-gear-wide-connected"></i> 내 컬린더 설정</h5>
		<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>
	<div class="offcanvas-body">
		<div class="row">
			<div class="col">
				<button class="btn" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
					스터디 추가 <i class="bi bi-plus-lg"></i>
				</button>
			</div>
			<div class="col-auto text-end">
				<button class="btn btnDeleteIcon" type="button" title="편집">
					<i class="bi bi-three-dots-vertical"></i>
				</button>
			</div>
		</div>
		<div class="collapse" id="collapseExample">
		  <div class="card card-body">
		  	<div class="input-group">
				<input type="text" id="category-input" class="form-control">
				<button type="button" class="btn btn-outline-success btnCategoryAddOk"><i class="bi bi-save"></i></button>
			</div>
		  </div>
		</div>
		
		<div class="d-flex flex-column bd-highlight mt-3 px-2 category-list">
			<c:forEach var="vo" items="${listStudyNum}">
				<div class='row p-2 border category-row'>
					<div class='col-auto'>
						<input class='form-check-input me-1 category-item' type='checkbox' value='${vo.studyNum}' checked='checked'>
					</div>
					<div class='col ps-0'>
						${vo.studyNum}
					</div>
					<div class='col-auto text-end invisible category-item-minus'>
						<a href='#'><i class='bi bi-dash-square category-item-delete' data-categoryNum='${vo.sutdyNum}'></i></a>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<c:if test="${listStudyNum.size() > 0}">
			<div class="row">
				<div class="col pt-1 text-end">
					<button type="button" class="btn btnCategorySearch" title="검색"><i class="bi bi-search"></i></button>
				</div>
			</div>
		</c:if>
		
	</div>
</div>

<!-- 일정 상세 보기 Modal -->
<div class="modal fade" id="myDialogModal" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">일정 상세 보기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-1">
				<table class="table">
					<tr>
						<td colspan="2" class="text-center align-middle">
							<p class="form-control-plaintext view-subject"></p>
						</td>
					</tr>
					<tr>
						<td class="table-light col-2 align-middle">일정분류</td>
						<td>
							<p class="form-control-plaintext view-category"></p>
						</td>
					</tr>

					<tr>
						<td class="table-light col-2 align-middle">날 짜</td>
						<td>
							<p class="form-control-plaintext view-period"></p>
						</td>
					</tr>

					<tr>
						<td class="table-light col-2 align-middle">일정반복</td>
						<td>
							<p class="form-control-plaintext view-repeat"></p>
						</td>
					</tr>

 					<tr>
						<td class="table-light col-2 align-middle">등록일</td>
						<td>
							<p class="form-control-plaintext view-reg_date"></p>
						</td>
					</tr>

 					<tr>
						<td class="table-light col-2 align-middle">메모</td>
						<td>
							<p class="form-control-plaintext view-memo"></p>
						</td>
					</tr>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td class="text-end">
							<button type="button" class="btn btn-outline-primary btnScheduleUpdate">일정 수정</button>
			    			<button type="button" class="btn btn-outline-danger btnScheduleDelete">일정 삭제</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/fullcalendar5/lib/main.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/fullcalendar5/lib/locales-all.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dateUtil.js"></script>

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
			if(jqXHR.status===403) {
				login();
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

var calendar = null;
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');

	calendar = new FullCalendar.Calendar(calendarEl, {
		headerToolbar: {
			left: 'prev,next today',
			center: 'title',
			right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
		},
		initialView: 'dayGridMonth', // 처음 화면에 출력할 뷰
		locale: 'ko',
		editable: true,
		navLinks: true,
		dayMaxEvents: true,
		events: function(info, successCallback, failureCallback) {
			// 이벤트가 발생한 경우 호출
			var url = "${pageContext.request.contextPath}/schedule/month";
			var startDay=info.startStr.substr(0,10);
			var endDay=info.endStr.substr(0,10);
			var query = "start="+startDay+"&end="+endDay;
			
			var a = $(".category-list input:checkbox.studyNum-item").length;
			var b = $(".category-list input:checkbox.studyNum-item:checked").length;
			if(b != 0 && a != b) {
				$(".studyNum-list input:checkbox.studyNum-item:checked").each(function(){
					query += "&studyNums=" + $(this).val();
				});
			}
			
			var fn = function(data) {
				successCallback(data.list);
			};
			ajaxFun(url, "get", query, "json", fn);
			

		},
		selectable: true,
		selectMirror: true,
		select: function(info) {
			// 날짜의 셀을 선택하거나 드래그하면 일정 추가 화면으로 이동
			insertSchedule(info.startStr, info.endStr, info.allDay);
			
			calendar.unselect(); // 선택 영역 지우기
		},
		eventClick: function(info) {
			// 일정 제목을 선택할 경우
			
			// 일정 상세보기
			viewSchedule(info.event);
		},
		eventDrop: function(info) {
			// 일정을 드래그 한 경우
			updateDrag(info.event);

		},
		eventResize: function(info) {
			// 일정의 크기를 변경 한 경우
			updateDrag(info.event);

		},
		loading: function(bool) {
			// document.getElementById('scheduleLoading').style.display = bool ? 'block' : 'none';
		}
	});

	calendar.render();
});

// 일정 등록 폼
function insertSchedule(startStr, endStr, allDay) {
	var query;
	
	if(allDay) {
		// 종일 일정
		query = "startday="+startStr;
		if(endStr) {
			endStr = daysLater(endStr, 0);	//  종일 일정은 끝나는 날짜가 +1로 선택되므로 -1
											//  daysLater() : dateUtil.js 에 존재
			query += "&endday="+endStr;
		}
		query += "&all_day=1";
	} else {
		// 시간 일정
		query = "startday="+startStr.substr(0, 10);
		query += "&endday="+endStr.substr(0, 10);
		query += "&starttime="+startStr.substr(11, 5);
		query += "&endtime="+endStr.substr(11, 5);
		query += "&all_day=0";
	}

	location.href = "${pageContext.request.contextPath}/schedule/write?"+query;
}

$(function(){
	$("body").on("click",  ".btnstudyNumSearch", function(){
		var a = $(".studyNum-list input:checkbox.studyNum-item:checked").length;
		if(a === 0) {
			return false;
		}	
		// 모든 소스의 이벤트를 다시가져와 화면에 다시 렌더링
		calendar.refetchEvents();
		
		$("#offcanvasExample").offcanvas('hide');
	});
});
// 일정 상세 보기
function viewSchedule(calEvent) {
	//	console.log(calEvent);
	
	$("#myDialogModal").modal("show");
	
	var num = calEvent.id;
	var title = calEvent.title;
	var color = calEvent.backgroundColor;
	var start = calEvent.startStr;
	var end = calEvent.endStr;
	var allDay = calEvent.allDay;
	
	var studyNum = calEvent.extendedProps.studyNum;
	if(! studyNum) studyNum = 0;
	var studyNum = calEvent.extendedProps.studyNum;
	if(! studyNum) studyNum = " 설정하지 않음 ";
	
	var startday = calEvent.extendedProps.startday;
	var endday = calEvent.extendedProps.endday;
	var starttime = calEvent.extendedProps.starttime;
	var endtime = calEvent.extendedProps.endtime;
	
	
	var ncNote = calEvent.extendedProps.ncNote;
	if(! ncNote) ncNote = "";
	var repeat = calEvent.extendedProps.repeat;
	var repeat_cycle = calEvent.extendedProps.repeat_cycle;
	
	var reg_date = calEvent.extendedProps.reg_date;
	
	$(".btnScheduleUpdate").attr("data-num", num);
	$(".btnScheduleDelete").attr("data-num", num);
	
	var s;
	$(".view-subject").html(title);
	
	s = allDay ? "종일일정" : "시간일정";
	$(".view-studyNum").html(studyNum + "," + s);
	
	s = startday;
	if(starttime) {
		s += " " + starttime;
	}
	if(endday && allDay) {
		endday = daysLater(endday, 0);
		if(sday < eday) {
			s += " ~ " + endday;
		}
	} else if( endday ) {
		s += " ~ " + endday;
	}
	if( endtime ) s += " " + endtime;
	$(".view-period").html(s);
	
	$(".view-reg_date").html(reg_date);
	
	s = repeat != 0 && repeat_cycle != 0 ? "반복일정, 반복주기 " + repeat_cycle + "년" : "반복안함"; 
	$(".view-repeat").html(s);
	
	$(".view-scNote").html(scNote);
	
	
}

$(function(){
	// 일정 수정화면
	$(".btnScheduleUpdate").click(function(){
		var num = $(this).attr("data-num");
		location.href = "${pageContext.request.contextPath}/schedule/update?num="+num;
	});
	
	$(".btnScheduleDelete").click(function(){
		if(! confirm('일정을 삭제하시겠습니가')) {
			return false;
		}
		
		var fn = function(data) {
			var event = calendar.getEventById(num);
			event.remove();
			$("#myDialogModal").modal("hide");
		};
		
		var num = $(this).attr("data-num");
		var url = "${pageContext.request.contextPath}/schedule/delete";
		var query = "num="+num;
		
		ajaxFun(url, "post", query, "json", fn);
	});
	
	
});

// 일정을 드래그한 경우 일정 수정
function updateDrag(calEvent) {
	var num = calEvent.id;
	var title = calEvent.title;
	var color = calEvent.backgroundColor;
	var start = calEvent.startStr;
	var end = calEvent.endStr;
	var allDay = calEvent.allDay;
	
	var studyNum = calEvent.extendedProps.studyNum;
	if(! studyNum) studyNum = 0;
	var studyNum = calEvent.extendedProps.studyNum;
	if(! studyNum) studyNum = " 설정하지 않음 ";
	
	
	var scNote = calEvent.extendedProps.scNote;
	if(! scNote) scNote = "";
	var repeat = calEvent.extendedProps.repeat;
	var repeat_cycle = calEvent.extendedProps.repeat_cycle;
		
	var startDate="", endDate="", startTime="", endTime="", all_day="";
	if(allDay) {
		startDate = start;
		endDate = end;
		all_day = "1";
	} else {
		startDate = start.substr(0, 10);
		endDate = end.substr(0, 10);
		startTime = start.substr(11, 5);
		endTime = end.substr(11, 5);
	}
	
	var query = "num="+num+"&subject="+title
			+ "&studyNum="+studyNum+"&color="+color
			+ "&all_day="+all_day
			+ "&startday="+startDate+"&endday="+endDate
			+ "&starttime="+startTime+"&endtime="+endTime
			+ "&repeat="+repeat+"&repeat_cycle="+repeat_cycle;
			+ "&scNote="+scNote
	
	var url = "${pageContext.request.contextPath}/schedule/updateDrag";

	var fn = function(data) {
		// 모든 소스의 이벤트를 다시 가져와 화면에 다시 렌더링
		calendar.refetchEvents();
	};
	ajaxFun(url, "post", query, "json", fn);
}

$(function(){
	// 카테고리 추가
	$(".btnCategoryAddOk").click(function(){
		var category = $("#studyNum-input").val().trim();
		if(! studyNum) {
			return false;
		}
		
		category = encodeURIComponent(category);
		var query = "category="+category;
		var url="${pageContext.request.contextPath}/schedule/categoryAdd";
		
		var fn = function(data) {
			if(data.state === "true") {
				$("#category-input").val("");
			
				$(".category-list").empty();
				
				var out = "";
				for(var idx = 0; idx < data.listCategory.length; idx++) {
					var item = data.listCategory[idx];
					out += "<div class='row p-2 border category-row'>";
					out += "  <div class='col-auto'>";
					out += "    <input class='form-check-input me-1 category-item' type='checkbox' value='"+item.categoryNum+"' checked='checked'>";
					out += "  </div>";
					out += "  <div class='col ps-0'>"+item.category+"</div>";
					out += "  <div class='col-auto text-end invisible category-item-minus'>";
					out += "    <a href='#'><i class='bi bi-dash-square category-item-delete' data-categoryNum='"+item.categoryNum+"'></i></a>";
					out += "  </div>";
					out += "</div>";
				}

				$(".category-list").html(out);
			};
		};
		ajaxFun(url, "post", query, "json", fn);
	});
	
	$(".btnDeleteIcon").click(function(){
		$(".category-item-minus").toggleClass("invisible");
	});
	
	$("body").on("click", ".category-item-delete", function(){
		if(! confirm("카테고리를 삭제 하시겠습니까 ? ")) {
			return false;
		}
		
		var $i = $(this);
		var query = "categoryNum="+$(this).attr("data-categoryNum");
		var url="${pageContext.request.contextPath}/schedule/categorydelete";
		var fn = function(data) {
			if(data.state === "true") {
				$i.closest(".category-row").remove();
				
				calendar.refetchEvents();
			}
		};
		ajaxFun(url, "post", query, "json", fn);
	});
});
</script>
