<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dateUtil.js"></script>

<script type="text/javascript">
function sendOk() {
    var f = document.scheduleForm;
	var str;
	
	if( ! f.scheduleName.value.trim() ) {
		f.scheduleName.focus();
		return;
	}
	
	if( ! f.startDate.value ) {
		f.startDate.focus();
		return;
	}
	
	if( f.endDate.value ) {
		var s1 = f.startDate.value.replace(/-/g, "");
		var s2 = f.endDate.value.replace(/-/g, "");
		if(s1 > s2) {
			f.startDate.focus();
			return;
		}
	}

	if( f.endTime.value ) {
		var s1 = f.startTime.value.replace(/:/g, "");
		var s2 = f.endTime.value.replace(/:/g, "");
		if(s1 > s2) {
			f.startTime.focus();
			return;
		}
	}
	
	if( ! f.repeat_cycle.value ) {
		f.repeat_cycle.value = "0";
	}
	
	if( f.repeat.value !=  "0" && ! /^(\d){1,2}$/g.test(f.repeat_cycle.value) ) {
		f.repeat_cycle.focus();
		return;
	}
	
	if( f.repeat.value !=  "0" && f.repeat_cycle.value < 1 ) {
		f.repeat_cycle.focus();
		return;
	}	

	// 종일일정의 경우 종료일자는 종료일자+1로 저장해서 불러와야 함
	if($("#form-eday").val() && $("#form-all_day").is(":checked")) {
		$("#form-eday").val(daysLater($("#form-eday").val(), 2));
	}
	
    f.action = "${pageContext.request.contextPath}/communitySch/${mode}";
    f.submit();
}

$(function(){
	$("#form-all_day").click(function(){
		if(this.checked === true) {
			$("#form-stime").val("").hide();
			$("#form-etime").val("").hide();
		} else if(this.checked === false && $("#form-repeat").val() === "0"){
			$("#form-stime").val("00:00").show();
			$("#form-etime").val("00:00").show();
		}
	});

	$("#form-sday").change(function(){
		$("#form-eday").val($("#form-sday").val());
	});
	
	var repeat_cycle = "${dto.repeat_cycle}";
	if(repeat_cycle && repeat_cycle != "0") {
		$("#form-all_day").prop("checked", true);
		$("#form-all_day").prop("disabled", true);

		$("#form-stime").val("").hide();
		$("#form-etime").val("").hide();
		$("#form-eday").val("");
		$("#form-etime").val("");
		$("#form-eday").closest("tr").hide();
	}
	
	$("#form-repeat").change(function(){
		if($(this).val() === "0") {
			$("#form-repeat_cycle").val("0").hide();
			
			$("#form-all_day").prop("checked", true);
			$("#form-all_day").prop("disabled", false);
			
			$("#form-eday").val($("#form-sday").val());
			$("#form-eday").closest("tr").show();
		} else {
			$("#form-repeat_cycle").show();
			
			$("#form-all_day").prop("checked", true);
			$("#form-all_day").prop("disabled", true);

			$("#form-stime").val("").hide();
			$("#form-etime").val("").hide();
			$("#form-eday").val("");
			$("#form-etime").val("");
			$("#form-eday").closest("tr").hide();
		}
	});
});

$(function(){
	$("#form-color").css("background-color", $("#form-color").val());
	$("#form-color").css("color", "#fff");
	$("#form-color").change(function(){
		$(this).css("background-color", $(this).val());
	});
});
</script>


<section class="row">
	<div class="card">
		<div class="card-header">
			<h3><i class="bi bi-calendar-event"></i> 학교별 일정관리 </h3>
		</div>
		
		<div class="body-main">
		
			<form name="scheduleForm" method="post">
				<table class="table write-form mt-5">
					<tr>
						<td class="table-light col-2" scope="row">학교 코드</td>
						<td>
							<div class="row">
								<div class="col">
									<input type="number" name="schoolCode" id="form-schoolCode" class="form-control" value="${dto.schoolCode}">
								</div>
							</div>
							<small class="form-control-plaintext">* 1 - 하늘고등학교, 2 - 파란고등학교, 3 - 꿈고등학교 </small>
						</td>
					</tr>
				
					<tr>
						<td class="table-light col-2" scope="row">제 목</td>
						<td>
							<div class="row">
								<div class="col">
									<input type="text" name="scheduleName" id="form-subject" class="form-control" value="${dto.scheduleName}">
								</div>
							</div>
							<small class="form-control-plaintext">* 제목은 필수 입니다.</small>
						</td>
					</tr>

					<tr>
						<td class="table-light col-2" scope="row">색 상</td>
						<td>
							<div class="row">
								<div class="col-5">
									<select name="color" id="form-color" class="form-select">
										<option value="Crimson" style="background:Crimson;" ${dto.color=="Crimson"?"selected='selected'":""}></option>
										<option value="tomato" style="background:tomato;" ${dto.color=="tomato"?"selected='selected'":""}></option>
										<option value="orange" style="background:orange;" ${dto.color=="orange"?"selected='selected'":""}></option>
										<option value="DarkSeaGreen" style="background:DarkSeaGreen;" ${dto.color=="DarkSeaGreen"?"selected='selected'":""}></option>
										<option value="Aquamarine" style="background:Aquamarine;" ${dto.color=="Aquamarine"?"selected='selected'":""}></option>
										<option value="Aqua" style="background:Aqua;" ${dto.color=="Aqua"?"selected='selected'":""}></option>
										<option value="CornflowerBlue" style="background:CornflowerBlue;" ${dto.color=="CornflowerBlue"?"selected='selected'":""}></option>
										<option value="pink" style="background:pink;" ${dto.color=="pink"?"selected='selected'":""}></option>
										<option value="PaleVioletRed" style="background:PaleVioletRed;" ${dto.color=="PaleVioletRed"?"selected='selected'":""}></option>
										<option value="RebeccaPurple" style="background:RebeccaPurple;" ${dto.color=="RebeccaPurple"?"selected='selected'":""}></option>
										<option value="LightGray" style="background:LightGray;" ${dto.color=="LightGray"?"selected='selected'":""}></option>
										<option value="black" style="background:black;" ${dto.color=="black"?"selected='selected'":""}></option>
									</select>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td class="table-light col-2" scope="row">종일일정</td>
						<td class="py-3">
							<div class="row">
								<div class="col">
									<input type="checkbox" name="all_day" id="form-all_day" class="form-check-input" 
										 value="1" ${dto.all_day == 1 ? "checked='checked' ":"" } >
									<label class="form-check-label" for="form-all_day"> 하루종일</label>
								</div>
							</div>
						</td>
					</tr>

 					<tr>
						<td class="table-light col-2" scope="row">시작일자</td>
						<td>
							<div class="row">
								<div class="col-5 pe-0">
									<input type="date" name="startDate" id="form-sday" class="form-control" value="${dto.startDate}">
								</div>
								<div class="col-3">
									<input type="time" name="startTime" id="form-stime" class="form-control" value="${dto.startTime}"
										style="display: ${dto.all_day == 1 ? 'none;':'inline-block;'}">
								</div>
							</div>
							<small class="form-control-plaintext">* 시작날짜는 필수입니다.</small>
						</td>
					</tr>

 					<tr>
						<td class="table-light col-2" scope="row">종료일자</td>
						<td>
							<div class="row">
								<div class="col-5 pe-0">
									<input type="date" name="endDate" id="form-eday" class="form-control" value="${dto.endDate}">
								</div>
								<div class="col-3">
									<input type="time" name="endTime" id="form-etime" class="form-control" value="${dto.endTime}"
										style="display: ${dto.all_day==1 ? 'none;':'inline-block;'}">
								</div>
							</div>
							<small class="form-control-plaintext">종료일자는 선택사항이며, 시작일자보다 작을 수 없습니다.</small>
						</td>
					</tr>
					
					<tr>
						<td class="table-light col-2" scope="row">일정반복</td>
						<td>
							<div class="row">
								<div class="col-5 pe-0">
									<select name="repeat" id="form-repeat" class="form-select">
										<option value="0" ${dto.repeat=="0"?"selected='selected'":""}>반복안함</option>
										<option value="1" ${dto.repeat=="1"?"selected='selected'":""}>년반복</option>
									</select>
								</div>
								<div class="col-3">
									<input type="text" name="repeat_cycle" id="form-repeat_cycle" maxlength="2" class="form-control"
										style="display: ${dto.repeat==0 ? 'none;':'inline-block;'}"
										value="${dto.repeat_cycle}"
										placeholder="반복주기">
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td class="table-light col-2" scope="row">메 모</td>
						<td>
							<textarea name="scNote" id="form-memo" class="form-control" style="height: 90px;">${dto.scNote}</textarea>
						</td>
					</tr>
				</table>
				
				<table class="table table-borderless">
 					<tr>
						<td class="text-center">
							<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'일정등록'}&nbsp;<i class="bi bi-check2"></i></button>
							<button type="reset" class="btn btn-light">다시입력</button>
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/communitySch/main';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="scheduleNum" value="${dto.scheduleNum}">
							</c:if>
						</td>
					</tr>
				</table>
			</form>
		
		</div>
	</div>
</section>
