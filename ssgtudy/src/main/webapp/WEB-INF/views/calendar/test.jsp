<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/fullcalendar5/lib/main.min.css">

<section class="row">
	<div class="card">
		
			<div class="card-header">
               <h3>
	                <i class="bi bi-calendar-event"></i> 일정관리
                </h3>
            </div>		
			<div class="card-body">
				<div class="row">
				<!-- 	
					<div class="col-sm-1 px-0 text-center">
						<a class="btn" data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample">
							<i class="bi bi-layout-text-sidebar-reverse" style="font-size : 25px;"></i>
						</a>
					</div> 
				-->
					<div class="col-12 px-2">
						<div id="calendar"></div>
					</div>
				</div>
				
				<div id='scheduleLoading' style="display: none;">loading...</div>
			</div>

	
	<!-- 좌측 카테고리 관리 오프캔버스 -->
	<%-- <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
		<div class="offcanvas-header">
			<h5 class="offcanvas-title" id="offcanvasExampleLabel"><i class="bi bi-gear-wide-connected"></i> 내 컬린더 설정</h5>
			<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">
			<div class="row">
				<div class="col">
					<button class="btn" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
						카테고리 추가 <i class="bi bi-plus-lg"></i>
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
				<c:forEach var="vo" items="${listCategory}">
					<div class='row p-2 border category-row'>
						<div class='col-auto'>
							<input class='form-check-input me-1 category-item' type='checkbox' value='${vo.categoryNum}' checked='checked'>
						</div>
						<div class='col ps-0'>
							${vo.category}
						</div>
						<div class='col-auto text-end invisible category-item-minus'>
							<a href='#'><i class='bi bi-dash-square category-item-delete' data-categoryNum='${vo.categoryNum}'></i></a>
						</div>
					</div>
				</c:forEach>
			</div>
			
			<c:if test="${listCategory.size() > 0}">
				<div class="row">
					<div class="col pt-1 text-end">
						<button type="button" class="btn btnCategorySearch" title="검색"><i class="bi bi-search"></i></button>
					</div>
				</div>
			</c:if>
			
		</div>
	</div> --%>
	
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
		navLinks: true,
		dayMaxEvents: true,
		events: function(info, successCallback, failureCallback) {
				// 이벤트가 발생한 경우 호출
			let url = "${pageContext.request.contextPath}/calendar/api";
			let start = info.startStr.substr(0,10);
			let end = info.endStr.substr(0,10);
			let query = "start="+start.replaceAll("-","")+"&end="+end.replaceAll("-","");
			
			let fn = function(data){
				
				let list = data.SchoolSchedule.row;
				let event_list = new Array();
				for(let vo of list){
					
					if(vo.EVENT_NM.indexOf("평가")>-1){
					
						let date = vo.AA_YMD;
						let event = {
							start : date.substr(0, 4)+"-"+date.substr(4, 2)+"-"+date.substr(6, 2)
							,color : "pink"
							,title : vo.EVENT_NM
							,allDay : true
						}						
						event_list.push(event);						
					}
				
				}
				
			
				
				
				successCallback(event_list);
			};			
			ajaxFun(url,"get",query,"json",fn);

		}
		
	
		
	});

	calendar.render();
});

$(function(){
	$("body").on("click",".burger-btn",function(){
		calendar.updateSize();		
	});
});

</script>