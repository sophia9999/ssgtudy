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

function createlist(query){
	query +="&row="+$("#row").val();
	const url = "${pageContext.request.contextPath}/membermanage/stateCodelist";
	const fn = function(data){
		console.log(data);
		const list = data.list;
		$(".table tbody tr").remove();
		$(".pagination li").remove();
		for(const idx in list){
			const el =	'<tr class="before">'
					        +'<td class="text-bold-500">'+list[idx].userId+'</td>'
					        +'<td>'+list[idx].join_date+'</td>'
					        +'<td class="text-bold-500">'+list[idx].edit_date+'</td>'
					        +'<td>'+list[idx].last_date+'</td>'
					        +'<td data-codeval="'+list[idx].stateCode+'">'+stateCode[list[idx].stateCode]+'</td>'
				     	+'</tr>';
	     	
	     	$(".table tbody").append(el);
 	
		}
		let pagebtn =    '<li class="page-item"><a class="page-link" href="#">'
        				+	'<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>'
        				+'</a></li>';
        $(".pagination").append(pagebtn);				
		for(let i=0; i<data.totalPage; i++){
			let paging = "<li class='page-item";
	     	if((i+1)==data.now)paging += " active ";
	     	paging +="'><a class='page-link' >"+(i+1)+"</a></li>";
	     	$(".pagination").append(paging);
		}
		pagebtn = '<li class="page-item"><a class="page-link" href="#">'
			      + '<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>'
			      + '</a></li>';
		  $(".pagination").append(pagebtn);
		
	};
	 ajaxfun("get",url,query,fn);
}

$(function(){
	const query = "keyword="+$('.keyword').val();
	createlist(query);
});


$("body").on("click","#findAdmin",function(){
	const query = "keyword="+$('.keyword').val();
	createlist(query);
});

$("body").on("click","li.page-item",function(){
		const query = "keyword="+$('.keyword').val()+"&pageNum="+$(this).text();	
		createlist(query);
});

$("body").on("change","#row",function(){
	const query = "keyword="+$('.keyword').val();	
	createlist(query);
});

$("body").on("click","tbody tr.before",function(){
	$td = $(this).find("td");

	
	if(!confirm($td[0].innerText+"를 수정하시겠습니까?")){
		return;
	}
	
	const update = $(this).parents().find("tr.update");
	if(update.length !=0){
		$(update).removeClass("update");
		$(update).addClass("before");
		
		const lasttd = $(update).find("td").last();
		const state = $(lasttd).attr("data-codeval");
		lasttd.text(stateCode[state]);
	}
	
	
	$(this).removeClass("before");
	$(this).addClass("update");
	let el = "<select class='form-select'>";
	const val = $($td[4]).attr("data-codeval");
	for(const idx in stateCode){
		el +="<option value='"+idx+"'";
		if(idx == val) el += " selected='selected' "
		el+=">"+stateCode[idx]+"</option>";
	}
	
	el += "</select>";
	
	console.log(val);
	$($td[4]).html(el);
	
});

$("body").on("change","tbody select",function(){
	
	const $td = $(this).closest("tr").find("td");
	const url = "${pageContext.request.contextPath}/membermanage/updateStateCode";	
	const query="userId="+$($td[0]).text()+"&stateCode="+$(this).val();
	const fn = function(data){
		const el = $("body").find("table tr select").closest("td");
		$(el).attr("data-codeval",data.state);
		$(el).text(stateCode[data.state]);
		$(el).parents().removeClass("update");
		$(el).parents().addClass("before");
	};
	
	
	ajaxfun("post",url,query,fn);
	

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
	                            <div class="row">
	                            	   <div class="col-lg-4">
	                              	 <div class="input-group mb-3">
	                                    <span class="input-group-text" id="basic-addon1"><i class="bi bi-search"></i></span>
	                                    <input type="text" class="form-control keyword" placeholder="검색할 아이디를 입력해주세요"  name="userId" >
	                                    <button class="btn btn-outline-secondary" type="button" id="findAdmin">검색</button>
	                                </div>
	                              </div>
	                              
	                              <div class="col-lg-2">
	                              	 <div class="input-group mb-3">
	                                    <select class="form-select" id="row">
	                                        <option value="5">5</option>	
	                                         <option value="10" selected="selected">10</option>
	                                         <option value="20">20</option>
	                                         <option value="30">30</option>
	                                         <option value="40">40</option>                                                     
	                                   </select>
	                                </div>
	                              </div>
	                            </div>                       
                            </div>
                            <div class="card-content pb-4" >
                                <div class="table-responsive p-3">
                                        <table class="table table-hover mb-0 ">
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
                                    <ul class="pagination pagination-primary  justify-content-center">
  
                                     </ul>
                            </div>
                        </div>
                       
                    </div>                                     
	   
</section>