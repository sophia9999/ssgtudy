<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

function ajaxfun(type,url,query,fn,el){
	$.ajax({
		type:type,
		url:url,
		data:query,
		dataType:"json",
		success:function(data) {
			fn(data,el)
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

function createEl(vo){
	const el =
	"<div class='recent-message d-flex px-4 py-3'>"
    	+"<div class='avatar avatar-lg'>"        
    	+"</div>"
    	+"<div class='name ms-4'>"
        	+"<h5 class='mb-1'>"+vo.userName+"</h5>"
        	+"<h6 class='text-muted mb-0'>@"+vo.userId+","+vo.nickName+"</h6>"       	
            +"<button data-friendId='"+vo.userId+"' class='btn btn-sm btn-outline-primary add'>친구추가</button>"        
        +"</div>"
    +"</div>"
    $("#findlist").append(el);
}

function finduserName(){
	let query = "userName="+$("#userName").val();

	$.ajax({
		type:"get",
		url:"${pageContext.request.contextPath}/friends/finduserName",
		data:query,
		dataType:"json",
		success:function(data) {
			 $("#findlist").empty();
			for(let vo of data.list){
				createEl(vo);
			}
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

$("body").on("click","#finduserName",function(){
	console.log("start");
	finduserName();
});

$("body").on("click",".add",function(){
	const url = "${pageContext.request.contextPath}/friends/insertFriend";
	const query = "friendId="+$(this).attr("data-friendId");
	const $this = $(this).closest("div");
	const fn = function(data,thisel){
		
		thisel.parent().remove();
		sp = thisel.find("h6").text().split(",");
		const userId = sp[0].replace("@","");
		const nickName = sp[1];
		
		const el =
			"<div class='recent-message d-flex px-4 py-3'>"
		    	+"<div class='avatar avatar-lg'>"        
		    	+"</div>"
		    	+"<div class='name ms-4'>"
		        	+"<h5 class='mb-1'>"+nickName+"</h5>"
		        	+"<h6 class='text-muted mb-0'>@"+userId+"</h6>"       			          
		        +"</div>"
		        +"<div class='buttons px-4'>"
	        		+"<button data-registrant='${sessionScope.member.userId}' data-registered='"+userId+"'  class='btn btn-sm btn-outline-primary delete'>삭제</button>"            		
	        	+"</div>"
		     
		    +"</div>";
		    
		 $("#registrant").append(el);
	
	};
	
	
	ajaxfun("post",url,query,fn,$this);
});


$("body").on("click",".delete",function(){
	const url = "${pageContext.request.contextPath}/friends/deleteFriend";
	const query = "registrant="+$(this).attr("data-registrant")+"&registered="+$(this).attr("data-registered");
	const $this = $(this).parent().parent();
	console.log(query);
	const fn = function(data,el){				
		el.remove();
	};
	
	
	ajaxfun("post",url,query,fn,$this);
});

$("body").on("click",".update",function(){
	const url = "${pageContext.request.contextPath}/friends/updateFriend";
	const query = "registrant="+$(this).attr("data-registrant")+"&registered="+$(this).attr("data-registered");
	const $this = $(this).parent().parent();
	console.log(query);
	const fn = function(data,el){				
		
		el.remove();

		const userId =  $this.find("h6").text();
		const nickName = $this.find("h5").text();
		const newel =
			"<div class='recent-message d-flex px-4 py-3'>"
		    	+"<div class='avatar avatar-lg'>"        
		    	+"</div>"
		    	+"<div class='name ms-4'>"
		        	+"<h5 class='mb-1'>"+nickName+"</h5>"
		        	+"<h6 class='text-muted mb-0'>@"+userId+"</h6>"       			          
		        +"</div>"
		        +"<div class='buttons px-4'>"
            		+"<button class='btn btn-sm btn-outline-primary delete' data-registered='${sessionScope.member.userId}' data-registrant='userId' >삭제</button>"            		
            	+"</div>"
		    +"</div>";
		    
		 $("#friends").append(newel);
	};
	
	
	ajaxfun("post",url,query,fn,$this);
});


</script>



<section class="row">
	
		<div class="col-12 col-lg-4">
                        <div class="card">
                            <div class="card-body py-4 px-5">
                                <div class="d-flex align-items-center">
         
                                    <div class="avatar avatar-xl">
                                    <i class="bi bi-person-circle"></i>
                                    </div>
                                    <div class="ms-3 name">
                                    	
                                        <h5 class="font-bold" style="margin: 5px 0px 0px 0px;">친구목록</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                               
                            </div>
                            <div class="card-content pb-4" id="friends">
                                <c:forEach var="vo" items="${friendslist}">
                                	<div class="recent-message d-flex px-4 py-3">
	                                    <div class="avatar avatar-lg">
	                                     
	                                    </div>
	                                    <div class="name ms-4">
	                                        <h5 class="mb-1">${vo.nickName}</h5>
	                                        <h6 class="text-muted mb-0">${vo.userId}</h6>
	                                    </div>
	                                   <div class="buttons px-4">
	                          
	                                    	<a class='btn btn-sm btn-outline-primary' href="${pageContext.request.contextPath}/note/noteWrite?userId=${vo.userId}&nickName=${vo.nickName}" >쪽지쓰기 </a>
	                                       	<button class='btn btn-sm btn-outline-primary delete' data-registered="${sessionScope.member.userId}" data-registrant="${vo.userId}" >삭제</button>	                             			
	                                    </div>
                                	</div>
                                </c:forEach>
                            </div>
                        </div>
                       
                    </div>
                    
              <div class="col-12 col-lg-4">
              	<div class="row">
              		<div class="card">
                            <div class="card-body py-4 px-5">
                                <div class="d-flex align-items-center">
         
                                    <div class="avatar avatar-xl">
                                    	 <i class="bi bi-people-fill"></i>  
                                    </div>
                                    <div class="ms-3 name">
                                        <h5 class="font-bold" style="margin: 5px 0px 0px 0px;">요청 목록</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">   
                            	<h5 class="font-bold">받은 요청 목록</h5>                        
                            </div>
                            <div class="card-content pb-4" >
                                <c:forEach var="vo" items="${registeredlist}">
                                	<div class="recent-message d-flex px-4 py-3">
	                                    <div class="avatar avatar-lg">
	                                        
	                                    </div>
	                                    <div class="name ms-4">
	                                        <h5 class="mb-1">${vo.nickName}</h5>
	                                        <h6 class="text-muted mb-0">${vo.userId}</h6>	                                        
	                                    </div>
	                                    <div class="buttons px-4">
	                                    	<button class='btn btn-sm btn-outline-primary update'data-registered="${sessionScope.member.userId}" data-registrant="${vo.userId}" >수락</button>	                              
	                                    	<button class='btn btn-sm btn-outline-primary delete' data-registered="${sessionScope.member.userId}" data-registrant="${vo.userId}" >삭제</button>
	                                    </div>
                                	</div>
                                </c:forEach>
                            </div>
                        </div>
                        
                         <div class="card">
                            <div class="card-header">  
                            	<h5 class="font-bold">보낸 요청 목록</h5>                                  
                            </div>
                            <div class="card-content pb-4" id ="registrant">
                                <c:forEach var="vo" items="${registrantlist}">
                                	<div class="recent-message d-flex px-4 py-3 test" id="${vo.nickName}">
	                                    <div class="avatar avatar-lg">
	                                        
	                                    </div>
	                                    <div class="name ms-4">
	                                    	<h5 class="mb-1">${vo.nickName}</h5>
		                                    <h6 class="text-muted mb-0">${vo.userId}</h6>                                                                        
	                                    </div>
	                                    <div class="buttons px-4">
	                                    	<button data-registrant="${sessionScope.member.userId}" data-registered="${vo.userId}" class='btn btn-sm btn-outline-primary delete'>삭제</button>
	                                    </div>
	                                           	                                    
                                	</div>
                                </c:forEach>
                            </div>
                        </div>
              	</div>
                        
                       
                    </div>
                    
               <div class="col-12 col-lg-4">
                        <div class="card">
                            <div class="card-body py-4 px-5">
                                <div class="d-flex align-items-center">
         
                                    <div class="avatar avatar-xl">
                                    	 <i class="bi bi-person-plus-fill"></i>  
                                    </div>
                                    <div class="ms-3 name">
                                        <h5 class="font-bold" style="margin: 5px 0px 0px 0px;" >친구 요청하기</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                            	<div class="input-group mb-3">
                                    <span class="input-group-text" id="basic-addon1"><i class="bi bi-search"></i></span>
                                    <input type="text" class="form-control" placeholder="검색할 이름을 입력해주세요" id=userName aria-label="이름을 입력해주세요" aria-describedby="button-addon2">
                                    <button class="btn btn-outline-secondary" type="button" id="finduserName">검색</button>
                                 </div>
                            </div>
                            <div class="card-content pb-4" id="findlist">
                            </div>  
                        </div>
                       
                    </div>                                     
	   
</section>