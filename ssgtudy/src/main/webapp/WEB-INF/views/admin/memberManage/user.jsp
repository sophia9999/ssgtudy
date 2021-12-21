<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<script type="text/javascript">

const stateCode = ['로그인 가능','패스워드 5회이상 실패','불법적인 방법으로 로그인','불건전 게시물 등록',
					'다른 유저 비방','타계정 도용','1년이상 로그인하지 않음'];


function ajaxfun(type,url,query,fn){
	$.ajax({
		type:type,
		url:url,
		data:query,
		dataType:"json",
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

$(function(){
	const url = "${pageContext.request.contextPath}/membermanage/stateCodelist";
	const fn = function(data){
		const list = data.list;
		console.log(list);
		
	  
		
		for(const vo of list){
			const el =	'<tr>'
					        +'<td class="text-bold-500">'+vo.userId+'</td>'
					        +'<td>'+vo.join_date+'</td>'
					        +'<td class="text-bold-500">'+vo.edit_date+'</td>'
					        +'<td>'+vo.last_date+'</td>'
					        +'<td>'+stateCode[vo.stateCode]+'</td>'
				     	+'</tr>';
	     	
	     	$(".table tbody").append(el);
		}
		
	};
	 ajaxfun("get",url,"",fn);
});

$("body").on("click","tbody tr",function(){
	$td = $(this).find("td");
	console.log();
	if(!confirm($td[0].innerText+"를 수정하시겠습니까?")){
		return;
	}
	let el = "<select class='form-select'>";
	
	for(const idx in stateCode){
		el +="<option value='"+idx+"'>"+stateCode[idx]+"</option>";
	}
	
	el += "</select>";

	$($td[4]).html(el);
});

</script>

<section class="row">
	
		<div class="col-12 col-lg-12">
                        <div class="card">
                            <div class="card-body py-4 px-5">
                                <div class="d-flex align-items-center">
         
                                    <div class="avatar avatar-xl">
                                    <i class="bi bi-person-circle"></i>
                                    </div>
                                    <div class="ms-3 name">
                                    	
                                        <h5 class="font-bold" style="margin: 5px 0px 0px 0px;">관리자 목록</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                               
                            </div>
                            <div class="card-content pb-4" >
                                <div class="table-responsive">
                                        <table class="table table-hover mb-0">
                                           	<colgroup>
                                           		<col width="15%">
                                           		<col width="20%">
                                           		<col width="20%">
                                           		<col width="20%">
                                           		<col/>	
                                           	</colgroup>
                                            <thead>
                                                <tr>
                                                    <th>아이디</th>
                                                    <th>가입 날짜</th>
                                                    <th>수정 날짜</th>
                                                    <th>최근 로그인 날짜</th>
                                                    <th>계정 상태</th>                                                   
                                                </tr>
                                            </thead>
                                            <tbody>                                               
                                               
                                            </tbody>
                                        </table>
                                    </div>
                            </div>
                        </div>
                       
                    </div>                                     
	   
</section>