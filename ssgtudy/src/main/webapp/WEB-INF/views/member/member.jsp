<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<head>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>ssg</title>
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
	<link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css//bold.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/perfect-scrollbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/auth.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/jquery/js/jquery.min.js"></script>

		
		
<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>


</head>


<body>
	<div id="auth">

        <div class="row h-100">
            <div class="col-lg-7 col-12">
                <div id="auth-left">       
                    <h1 class="auth-title">
                    ${mode}
                    </h1>

                    <form name="memberForm"  method="post">
                        <div class="form-group position-relative has-icon-left mb-3">               
                        	<div class="form-group position-relative has-icon-left input-group mb-3">                        										
									<input type="text" name="userId" id="userId" value="${dto.userId}" ${mode=="update" ? "readonly='readonly' ":""}  class="form-control form-control-lg" placeholder="아이디">								
								<div class="form-control-icon">
	                                <i class="bi bi-person"></i>
	                            </div>
	                            <c:if test="${mode=='join'}">
									<button class="btn btn-outline-secondary" type="button" onclick="idck();" id="button-addon2">아이디 중복검사</button>	                                                    
	                       		</c:if>
                        	</div>
                        
                        </div>
                         <div class="form-group position-relative has-icon-left mb-3">
                            <input type="password" name="pwd" value="${dto.pwd}" class="form-control form-control-lg" placeholder="비밀번호">
                            <div class="form-control-icon">
                                <i class="bi bi-person"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-3">
                            <input type="text" name="userName" value="${dto.userName}" class="form-control form-control-lg" placeholder="이름">
                            <div class="form-control-icon">
                                <i class="bi bi-person"></i>
                            </div>
                        </div>
                         <div class="form-group position-relative has-icon-left mb-3">
                            <input type="text" name="nickName" value="${dto.nickName}" class="form-control form-control-lg" placeholder="닉네임">
                            <div class="form-control-icon">
                                <i class="bi bi-person"></i>
                            </div>
                        </div>
                        
                          <div class="form-group position-relative has-icon-left mb-3">
                            <div class="input-group mb-3">
                            	<select class="form-select form-control form-control-lg"  name="tel1">
	                                 <option value="010"  ${dto.tel1=="010" ?  "selected='selected'" : "" }  >010</option>
									<option value="070" ${dto.tel1=="070" ?  "selected='selected'" : "" }  >070</option>
									<option value="011" ${dto.tel1=="011" ?  "selected='selected'" : "" }  >011</option>					
	                            </select>  
	                            <span class="input-group-text" >-</span>	                            
	  							<input type="text" value="${dto.tel2}" name="tel2" class="form-control form-control-lg" maxlength="4">                          
	                            <span class="input-group-text" >-</span>
								<input type="text" name="tel3" value="${dto.tel3}" class="form-control form-control-lg" maxlength="4">                          								                                                        
                             </div>
                            
                            <div class="form-control-icon">
                                <i class="bi bi-Telephone"></i>
                            </div>
                        </div>
                        
                         <div class="form-group position-relative has-icon-left mb-3">
                            <input type="date" name="birth" value="${dto.birth}" class="form-control form-control-lg" placeholder="birth">
                            <div class="form-control-icon">
                                <i class="bi bi-Calendar-date"></i>
                            </div>
                        </div>
                        
                         <div class="form-group position-relative has-icon-left mb-3">
                            <div class="input-group mb-3">
	  							<input type="text" name="email1" value="${dto.email1}" class="form-control form-control-lg" placeholder="email">                          
	                            <span class="input-group-text" id="basic-addon1">@</span>
								<select class="form-select form-control form-control-lg" name="email2" id="email2">
	                                <option value="naver.com" ${dto.email2=="naver.com" ?  "selected='selected'" : "" } >네이버 메일</option>
									<option value="gmail.com"  ${dto.email2=="gmail.com" ?  "selected='selected'" : "" } >지 메일</option>
									<option value="hanmail.net"  ${dto.email2=="hanmail.net" ?  "selected='selected'" : "" } >한 메일</option>
									<option value="hotmail.com"  ${dto.email2=="hotmail.com" ?  "selected='selected'" : "" } >핫 메일</option>
	                            </select>                                                          
                             </div>
                            
                            <div class="form-control-icon">
                                <i class="bi bi-envelope"></i>
                            </div>
                        </div>
                        
                        
                        
                        <div class="form-group position-relative has-icon-left input-group mb-3">								
								<input type="text" name="zip_code" id="zip_code" value="${dto.zip_code}" class="form-control form-control-lg" readonly="readonly" placeholder="우편번호 검색">
								<div class="form-control-icon">
                                	<i class="bi bi-search"></i>
                            	</div>
								<button class="btn btn-outline-secondary" type="button" onclick="daumPostcode();" id="button-addon2">우편번호검색</button>	                                                    
                        </div>
                        
                        <div class="form-group position-relative has-icon-left mb-3">
                            <input type="text" name="addr1" id="addr1" value="${dto.addr1}" class="form-control form-control-lg" placeholder="주소">
                            <div class="form-control-icon">
                                <i class="bi bi-House-door"></i>
                            </div>
                        </div>
                        
                        <div class="form-group position-relative has-icon-left mb-3">
                            <input type="text" name="addr2" id="addr2" value="${dto.addr2}" class="form-control form-control-lg" placeholder="상세주소">
                            <div class="form-control-icon">
                                <i class="bi bi-House-door"></i>
                            </div>
                        </div>
                        
                        <div class="form-group position-relative has-icon-left input-group mb-3">								
								<input type="text" name="schoolName" id="schoolName" value="${dto.schoolName}" class="form-control form-control-lg" readonly="readonly" placeholder="학교 검색">
								<input type="hidden" name="schoolstr" id="schoolstr" value="${dto.schoolCode}" class="form-control form-control-lg" readonly="readonly" placeholder="학교 검색">
								<div class="form-control-icon">
                                	<i class="bi bi-search"></i>
                            	</div>
								<button class="btn btn-outline-secondary" type="button" onclick="$('#schoolModal').modal('show');" >학교검색</button>	                                                    
                        </div>
                        
                    <%--     <div class="form-group position-relative has-icon-left mb-3">
                        	<div class="input-group mb-3">                         
                            	<select class="form-select form-control form-control-lg" name="schoolstr" id="schoolstr" >
                                       <option ${dto.schoolCode==null ?  "selected='selected'" : "" } value="" >없음</option>                                    
                                       <c:forEach var="vo" items="${list}">
                                       	<option value="${vo.schoolCode}" ${dto.schoolCode==vo.schoolCode ?  "selected='selected'" : "" } >${vo.schoolName}</option>
                                       </c:forEach>
                                 </select>
                                 <div class="form-control-icon">
	                                <i class="bi bi-Book"></i>
	                            </div>
                            </div>                                
                        </div> --%>
                      
                        <button type="button" class="btn btn-primary btn-block btn-lg shadow-lg mt-5" onclick="memberOk()">${mode} Up</button>
                  		<input type="hidden" name="userIdValid" id="userIdValid" value="false">
		
                    </form>
                    <div class="text-center mt-5 text-lg fs-4">
                    	<c:if test="${mode=='join'}">
                        	<p class="text-gray-600">아이디가 있으십니까? <a href="${pageContext.request.contextPath}/member/login" class="font-bold">Log
                            	    in</a>.</p>
                    	</c:if>
                    </div>
                </div>
            </div>
            <div class="col-lg-5 d-none d-lg-block">
                <div id="auth-right">

                </div>
            </div>
        </div>

    </div>

 <!-- Modal -->
		<div class="modal fade" id="schoolModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" >학교 검색</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      		<div class="form-group position-relative input-group   mb-3">
		      			<div class="form-check mx-1">
		      				<input class="form-check-input" type="radio" name="school" value="고등학교" >
	                          <label class="form-check-label" for="flexRadioDefault1">
	                              	고등학교
	                           </label>
		      			</div>
                        <div class="form-check mx-1">
                          <input class="form-check-input" type="radio" name="school" value="중학교">
                          <label class="form-check-label" for="flexRadioDefault1">
                              	중학교
                           </label>
                         </div>  
                        <div class="form-check mx-1">   
                           <input class="form-check-input" type="radio" name="schoolnull" value="없음" >
                          <label class="form-check-label" for="flexRadioDefault1">
                              	없음
                           </label>
                          </div>    
                     </div>
		  
		      		 <div class="form-group position-relative has-icon-left input-group mb-3">								
								<input type="text" name="schooltitle" id="schooltitle" value="" class="form-control form-control-lg" placeholder="학교 검색">
								<div class="form-control-icon">
                                	<i class="bi bi-search"></i>
                            	</div>
								<button class="btn btn-outline-secondary" type="button" id="findSchool" >학교검색</button>	                                                    
                     </div>
                     
                    <div class="schoolresult" style="overflow-y:auto; max-height: 300px;">
                    
                    </div>
		      	
		      </div>
		      <div class="modal-footer">
		     
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>		       
		      </div>
		    </div>
		  </div>
		</div>    

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip_code').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr2').focus();
            }
        }).open();
    }
</script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">


function ajaxfun(type,url,query,fn){
	$.ajax({
		type:type,
		url:url,
		data:query,
		dataType:"json",
		success:function(data) {
			fn(data);
		},
		error:function(jqXHR) {
			
	    	
			console.log(jqXHR.responseText);
		}
	});
}


function memberOk() {
	const f = document.memberForm;
	var str;
/* 
	str = f.userId.value;
	if( !/^[a-z][a-z0-9_]{4,9}$/i.test(str) ) { 
		alert("아이디를 다시 입력 하세요. ");
		f.userId.focus();
		return false;
	}

	var mode = "${mode}";
	if(mode === "join" && f.userIdValid.value === "false") {
		alert("아이디 중복 검사가 실행되지 않았습니다.");
		f.userId.focus();
		return false;
	} 
	
	str = f.pwd.value;
	if( !/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str) ) { 
		alert("패스워드를 다시 입력 하세요. ");
		f.pwd.focus();
		return false;
	}

	
    str = f.userName.value;
    if( !/^[가-힣]{2,5}$/.test(str) ) {
        alert("이름을 다시 입력하세요. ");
        f.userName.focus();
        return false;
    }
    
    str = f.nickName.value;
    if( !/^[가-힣]{2,5}$/.test(str) ) {
        alert("닉네임을 다시 입력하세요. ");
        f.nickName.focus();
        return false;
    }

    str = f.birth.value;
    if( !str ) {
        alert("생년월일를 입력하세요. ");
        f.birth.focus();
        return false;
    }
        
    str = f.email1.value.trim();
    if( !str ) {
        alert("이메일을 입력하세요. ");
        f.email1.focus();
        return;
    }
	
    
    
    str = f.zip_code.value.trim();
    if( !str ) {
        alert("우편번호을 입력하세요. ");
        f.zip_code.focus();
        return;
    }
    
    str = f.addr1.value.trim();
    if( !str ) {
        alert("주소을 입력하세요. ");
        f.addr1.focus();
        return;
    }

    str = f.addr2.value.trim();
    if( !str ) {
        alert("상세 주소을 입력하세요. ");
        f.addr2.focus();
        return;
    } */
	
	f.action = "${pageContext.request.contextPath}/member/${mode}";
    f.submit();
}

function idck(){
	
	const userId=$("#userId").val();

	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(userId)) {
		alert("잘못된 아이디형식 입니다");
		$("#userId").focus();
		return;
	}
	
	var url = "${pageContext.request.contextPath}/member/userIdck";
	var query = "userId=" + userId;
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var idck = data.idck;			
			if(idck === "null") {
				alert("사용가능한 아이디입니다");
				$("#userIdValid").val("true");
				$("#userId").prop('readonly',true);
			} else {
				alert("중복된 아이디입니다");
				$("#userIdValid").val("false");
				$("#userId").focus();
			}
		},error:function(jqXHR) {
			console.log(jqXHR);	    	
			console.log(jqXHR.responseText);
		}
	});
}
 

$("body").on('click','#findSchool',function(){
	const url = "${pageContext.request.contextPath}/school/findSchool";

	const query = "schoolType="+$("input[name='school']:checked").val()+"&schoolName="+$("#schooltitle").val();
	
	console.log(query);
	const fn = function(data){
		console.log(data);
		if(data.schoolInfo != null){
			$(".schoolresult div").remove();
			const list = data.schoolInfo.row;
			console.log(list.length);
			for(const sch of list){
			const el = '<div class="form-group position-relative has-icon-left input-group mb-3">'
		  				+'<h5 class="mx-3 my-2">'+sch.SCHUL_NM+'</h5>'
		  				+'<input type="hidden" value="'+sch.SD_SCHUL_CODE+'">'
						+'<button class="btn btn-outline-secondary setSchool" type="button" >적용</button>'	                                                    
		  		 		+'</div>';
		  		 		
		  	$(".schoolresult").append(el);
			}
		}else {
			
			const el = '<div class="form-group position-relative has-icon-left input-group mb-3">'
  				+'<h5 class="mx-3 my-2">'+data.RESULT.MESSAGE+'</h5>'                                                    
  		 		+'</div>';
			$(".schoolresult").append(el);
		}
			
	};
	
	ajaxfun('get',url,query,fn);
});

$("body").on('click','input[name="schoolnull"]:checked',function(){	
	if(confirm("정말로 선택을 안하시겠습니까")){
		$("#schoolName").val("없음");
		$("#schoolstr").val("");
		$("input[name='schoolnull']").prop("checked",false);
		$("#schoolModal").modal('hide');
	}
});

$("body").on('click','.setSchool',function(){
	const $div =  $(this).closest("div");
	
	const schoolname = $($div).find("h5").text();
	const schoolcode = $($div).find("input").val();
	
	console.log(schoolname);
	console.log(schoolcode);
	$("#schoolName").val(schoolname);
	$("#schoolstr").val(schoolcode);
	$("#schoolModal").modal('hide');
});


</script> 
</body>
	
