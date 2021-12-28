<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<script type="text/javascript">

const stateCode = ['로그인 가능','패스워드 5회이상 실패','불법적인 방법으로 로그인','불건전 게시물 등록',
					'다른 유저 비방','타계정 도용','1년이상 로그인하지 않음'];

let reportdata;

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

	const url = "${pageContext.request.contextPath}/membermanage/reportcomm";
	const fn = function(data){
		console.log(data);
		 const list = data.list;
		$(".table tbody tr").remove();
		$(".pagination li").remove();
		for(const idx in list){
	     	
			let tr = document.createElement('tr'); 		     	
			tr.className = 'text-center before';
			
			let td = document.createElement('td');
			td.className = 'text-bold-500';
			let texttd = document.createTextNode(list[idx].reportedUserId);
			td.appendChild(texttd);
			tr.appendChild(td);
			
			td = document.createElement('td');
			texttd = document.createTextNode(list[idx].userId);
			td.appendChild(texttd);
			tr.appendChild(td);
			
			td = document.createElement('td');
			td.className = 'text-bold-500';
			texttd = document.createTextNode(list[idx].reason);
			td.appendChild(texttd);
			tr.appendChild(td);
			
			td = document.createElement('td');
			let button = document.createElement('button');
			let textbutton = document.createTextNode('설정 변경');
			button.className = 'btn btn-outline-secondary';
			button.appendChild(textbutton);
			button.addEventListener('click',function(){
				$("#reportedreason").text("사유 : "+list[idx].reason);
				$("#reporteduserId").text("계정 : "+list[idx].reportedUserId);
				
				$("#stateModal").modal('show');
				reportdata=list[idx];
			});
			td.appendChild(button);
			tr.appendChild(td);
			
			td = document.createElement('td');
			button = document.createElement('button');
			textbutton = document.createTextNode('바로가기');
			button.className = 'btn btn-outline-secondary';
			button.appendChild(textbutton);
			button.addEventListener('click',function(){
				location.href = "${pageContext.request.contextPath}/"+list[idx].url + list[idx].num;
			});
			td.appendChild(button);
			tr.appendChild(td);
			
			$(".table tbody").append(tr);
			
			
	     	
 	
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
	

	let el = "";
	for(const idx in stateCode){
		el +="<option value='"+idx+"'>"+stateCode[idx]+"</option>";
	}
	$("#stateCode").append(el);
	createlist();
});




$("body").on("click","li.page-item",function(){
		const query = "pageNum="+$(this).text();	
		createlist(query);
});


 

$("body").on("click",".btnReport",function(){
	
	
	const url = "${pageContext.request.contextPath}/membermanage/updateReport";	
	
	 let query = reportdata;
	 
	const fn = function(data){
		console.log(data);
		$("#stateModal").modal('hide');
		createlist();
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
                                    	
                                        <h5 class="font-bold" style="margin: 5px 0px 0px 0px;">신고 당한 유저 관리</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
          
                            </div>
                            <div class="card-content pb-4" >
                                <div class="table-responsive p-3">
                                        <table class="table table-hover mb-0 ">
                                           	<colgroup>
                                           		<col width="15%">
                                           		<col width="15%">
                                           		<col width="40%">
                                           		<col width="20%">
                                           		<col/>	
                                           	</colgroup>
                                            <thead>
                                                <tr class="text-center">
                                                    <th>신고 당한 아이디</th>
                                                    <th>신고 한 아이디</th>
                                                    <th>신고 사유</th>
                                                    <th>계정 상태 변경</th>
                                                    <th>게시글 바로가기</th> 
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

 <!-- Modal -->
		<div class="modal fade" id="stateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">계정 신고 처리</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      	<div class="input-group mb-3" id="reporteduserId">
		      		계정 :
		      	</div>
		      	<div class="input-group reason mb-3" id="reportedreason">
		      		신고 사유 :
		      	</div>
		      	<div class="input-group mb-3">
                      <label class="input-group-text" for="inputGroupSelect01">계정 상태</label>
                      <select class="form-select" id="stateCode">               
                      </select>
                  </div>
                  <input type="hidden" id="reportdata" value="">
		      </div>
		      <div class="modal-footer">
		      	 <button type="button" class="btn btn-danger btnReport">처리</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>		       
		      </div>
		    </div>
		  </div>
		</div>