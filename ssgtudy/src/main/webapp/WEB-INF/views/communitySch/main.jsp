<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/fullcalendar5/lib/main.min.css">

<section class="row">
	<div class="card">
			<div class="card-header">
               	<c:choose>
					<c:when test="${sessionScope.member.membership > 50}">
						<h3><i class="bi bi-calendar-event"></i><span> 학교별 일정 관리자 모드 </span></h3>
					</c:when>
					<c:otherwise>
						<h3><i class="bi bi-calendar-event"></i><span> ${sessionScope.member.schoolName} 학사일정 </span></h3>
					</c:otherwise>
				</c:choose> 
            </div>		
			<div class="card-body">
				<div class="row">	
					<div class="col-sm-1 px-0 text-center">
						<a class="btn" data-bs-toggle="offcanvas" href="${pageContext.request.contextPath}/communitySch/write" role="button" aria-controls="offcanvasExample">
							<i class="bi bi-layout-text-sidebar-reverse" style="font-size : 25px;"></i>
						</a>
					</div>
					<div class="col-12 px-2">
						<div id="calendar"></div>
					</div>
				</div>
				
				<div id='scheduleLoading' style="display: none;">loading...</div>
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

</section>

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
			var url = "${pageContext.request.contextPath}/communitySch/month";
			var startDate = info.startStr.substr(0,10);
			var endDate = info.endStr.substr(0,10);
			var query = "start="+startDate+"&end="+endDate;
			
			var fn = function(data){
				console.log(data.list);
				successCallback(data.list);
			};			
			ajaxFun(url,"get",query,"json",fn);
		},
		selectable: true,
		selectMirror: true,
		select: function(info) {
			insertSchedule(info.startStr, info.endStr, info.allDay);
			
			calendar.unselect();
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
//

// 일정 등록 폼
function insertSchedule(startStr, endStr, allDay) {
	var query;
	
	if(allDay) {
		// 종일 일정
		query = "startDate="+startStr;
		if(endStr) {
			endStr = daysLater(endStr, 0); // 종일 일정은 끝나는 날짜가 +1로 선택되므로 -1
										// daysLater() : dateUtil.js에 존재
			query += "&endDate="+endStr;
		}
		query += "&all_day=1";
		
	} else {
		// 시간 일정
		query = "startDate="+startStr.substr(0, 10);
		query += "&endDate="+endStr.substr(0, 10);
		query += "&startTime="+startStr.substr(11, 5);
		query += "&endTime="+endStr.substr(11, 5);
		query += "&all_day=0";
	}
	
	location.href = "${pageContext.request.contextPath}/communitySch/write?"+query;
	
}

// 일정 상세 보기
function viewSchedule(calEvent) {
	// console.log(calEvent);
	
	$("#myDialogModal").modal("show");
	
	var scheduleNum = calEvent.id;
	var title = calEvent.title;
	var color = calEvent.backgroundColor;
	var start = calEvent.startStr;
	var end = calEvent.endStr;
	var allDay = calEvent.allDay;
	
	var startDate = calEvent.extendedProps.startDate;
	var endDate = calEvent.extendedProps.endDate;
	var startTime = calEvent.extendedProps.startTime;
	var endTime = calEvent.extendedProps.endTime;
	
	var scNote = calEvent.extendedProps.scNote;
	if(! scNote) scNote = "";
	var repeat = calEvent.extendedProps.repeat;
	var repeat_cycle = calEvent.extendedProps.repeat_cycle;	
	
	var reg_date = calEvent.extendedProps.reg_date;
	
	$(".btnScheduleUpdate").attr("data-num", scheduleNum);
	$(".btnScheduleDelete").attr("data-num", scheduleNum);
	
	var s;
	$(".view-subject").html(title);
	
	s = allDay ? "종일일정" : "시간일정";
	
	s = startDate;
	if(startTime) {
		s += " " + startTime;
	}
	if(endDate && allDay) {
		console.log(endDate);
		endDate = daysLater(endDate, 0);
		if(startDate < endDate) {
			s += " ~ " + endDate;
		}
	} else if(endDate) {
		s += " ~ " + endDate;
	}
	if(endTime) s += " " + endTime;
	$(".view-period").html(s);
	
	$(".view-reg_date").html(reg_date);
	
	s = repeat != 0 && repeat_cycle != 0 ? "반복일정, 반복주기" + repeat_cycle + "년" : "반복안함";
	$(".view-repeat").html(s);
	
	$(".view-memo").html(scNote);
}

$(function(){
	// 일정 수정 화면
	$(".btnScheduleUpdate").click(function(){
		var scheduleNum = $(this).attr("data-num");
		location.href = "${pageContext.request.contextPath}/communitySch/update?scheduleNum="+scheduleNum;
	});
	
	$(".btnScheduleDelete").click(function(){
		if(! confirm('일정을 삭제하시겠습니까?')) {
			return false;
		}
		
		var fn = function(data) {
			var event = calendar.getEventById(scheduleNum);
			event.remove();
			$("#myDialogModal").modal("hide");
		};
		
		var scheduleNum = $(this).attr("data-num");
		var url = "${pageContext.request.contextPath}/communitySch/delete";
		var query = "scheduleNum="+scheduleNum;
		
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

// 일정을 드래그한 경우 일정 수정
function updateDrag(calEvent) {
	var scheduleNum = calEvent.id;
	var title = calEvent.title;
	var color = calEvent.backgroundColor;
	var start = calEvent.startStr;
	var end = calEvent.endStr;
	var allDay = calEvent.allDay;
	
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
	
	var query = "scheduleNum="+scheduleNum+"&scheduleName="+title
				+"&color="+color+"&all_day="+all_day
			+ "&startDate="+startDate+"&endDate="+endDate
			+ "&startTime="+startTime+"&endTime="+endTime
			+ "&repeat="+repeat+"&repeat_cycle="+repeat_cycle;
			+ "&scNote="+scNote
	
	var url = "${pageContext.request.contextPath}/communitySch/updateDrag";

	var fn = function(data) {
		// 모든 소스의 이벤트를 다시 가져와 화면에 다시 렌더링
		calendar.refetchEvents();
	};
	ajaxFun(url, "post", query, "json", fn);
}

</script>