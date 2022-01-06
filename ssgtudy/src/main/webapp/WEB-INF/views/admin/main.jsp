<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<script type="text/javascript">

function ajaxfun(type,url,query,fn,$this){
	$.ajax({
		type:type,
		url:url,
		data:query,
		dataType:"json",
		success:function(data) {
			fn(data);
			if($this != null)$this.remove();
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

$("body").on("click","#findAdmin",function(){
	
	const admins = $("#admins").children();
	const userId = $(".userId").val();
	let adminlist = ",";
	
	for(const admin of admins){
		
		adminlist += $(admin).find('h6').text()+","; 
	}
	
	adminlist = adminlist.replace(userId,"");
	console.log(adminlist);
	const bool = adminlist.indexOf(",,")>=-1 ? true:false;
	
	if(!bool){
		alert("현재 관리자로 설정된 계정입니다.");
		return false;
	}
	
	const query = "userId="+userId;
	const url = "${pageContext.request.contextPath}/membermanage/findAdmin";
	const fn = function(data){
		 if(data.vo != null){
			const vo = data.vo;
			const el =
				"<div class='recent-message d-flex px-4 py-3'>"
			    	+"<div class='avatar avatar-lg'>"        
			    	+"</div>"
			    	+"<div class='name ms-4'>"
			        	+"<h5 class='mb-1'>"+vo.userName+"</h5>"
			        	+"<h6 class='text-muted mb-0'>@"+vo.userId+","+vo.nickName+"</h6>"       	
			            +"<button data-userId='"+vo.userId+"' class='btn btn-sm btn-outline-primary add'>관리자 추가</button>"        
			        +"</div>"
			    +"</div>"
			  $("#findlist").append(el);
		 }
	};
	ajaxfun("get",url,query,fn);
	
});


$("body").on("click",".add",function(){
	const $this = $(this).closest("div .recent-message");
	
	const query = "userId="+$(this).attr("data-userId")+"&membership=98";
	const url = "${pageContext.request.contextPath}/membermanage/updateAdmin";
	const fn = function(data){
		
		const el =
			"<div class='recent-message d-flex px-4 py-3'>"
		    	+"<div class='avatar avatar-lg'>"        
		    	+"</div>"
		    	+"<div class='name ms-4'>"
		        	+"<h5 class='mb-1'>"+data.admin.nickName+"</h5>"
		        	+"<h6 class='text-muted mb-0'>@"+data.admin.userId+"</h6>"       			          
		        +"</div>"
		        +"<div class='buttons px-4'>"
            		+"<button class='btn btn-sm btn-outline-primary delete'  data-userId='"+data.admin.userId+"' >권한 삭제</button>"            		
            	+"</div>"
		    +"</div>";
		if(data.admin != null) $("#admins").append(el);
	};
	
	ajaxfun("post",url,query,fn,$this);
	
});




$("body").on("click",".delete",function(){
	if(!confirm("관리자 권한을 삭제하시겠습니까?")){
		return false;
	}
	
	const $this = $(this).closest("div .recent-message");
	const query = "userId="+$(this).attr("data-userId")+"&membership=1";
	const url = "${pageContext.request.contextPath}/membermanage/updateAdmin";
	const fn = function(data){
		alert("권한이 삭제되었습니다");		
	};
	
	ajaxfun("post",url,query,fn,$this);
	
});


</script>

<section class="row">
	
		<div class="col-12 col-lg-6">
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
                            <div class="card-content pb-4" id="admins">
                                <c:forEach var="vo" items="${adminlist}">
                                	<div class="recent-message d-flex px-4 py-3">
	                                    <div class="avatar avatar-lg">
	                                     
	                                    </div>
	                                    <div class="name ms-4">
	                                        <h5 class="mb-1">${vo.nickName}</h5>
	                                        <h6 class="text-muted mb-0">${vo.userId}</h6>
	                                    </div>
	                                    <c:if test="${sessionScope.member.membership ==99 }">
		                                   <div class="buttons px-4">
		      	                               	<button class='btn btn-sm btn-outline-primary delete'  data-userId='${vo.userId}'>권한 삭제</button>	                             			
		                                    </div>
	                                    </c:if>
                                	</div>
                                </c:forEach>
                            </div>
                        </div>
                       
                    </div>
                    
               <div class="col-12 col-lg-6">
                        <div class="card">
                            <div class="card-body py-4 px-5">
                                <div class="d-flex align-items-center">
         
                                    <div class="avatar avatar-xl">
                                    	 <i class="bi bi-person-plus-fill"></i>  
                                    </div>
                                    <div class="ms-3 name">
                                        <h5 class="font-bold" style="margin: 5px 0px 0px 0px;" >관리자 승인</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                            	<div class="input-group mb-3">
                                    <span class="input-group-text" id="basic-addon1"><i class="bi bi-search"></i></span>
                                    <input type="text" class="form-control userId" placeholder="검색할 아이디를 입력해주세요"  name="userId" >
                                   <c:if test="${sessionScope.member.membership ==99 }"> 
                                    <button class="btn btn-outline-secondary" type="button" id="findAdmin">검색</button>
                                 	</c:if>
                                 </div>
                            </div>
                            <div class="card-content pb-4" id="findlist">
                            </div>  
                        </div>
                       
                    </div>                                     
	   
</section>