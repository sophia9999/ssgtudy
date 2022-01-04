<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function search() {
	var f = document.searchForm;
	f.action = "${pageContext.request.contextPath}/event/list";
	f.submit();
}
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
			isRun = false;
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

$(function() {
	$("body").on("click", ".checkWinningList", function() {
		let eventNum = $(this).attr("data-eventNum");
		let eventCategory = $(this).attr("data-eventCategory");
		// console.log(eventCategory);
		
		let query = "eventNum="+eventNum+"&eventCategory="+eventCategory;
		let url = "${pageContext.request.contextPath}/event/showWinningList";
		
		// console.log(query);
		
		let fn = function(data) {
			let status = data.status;
			console.log(data);			

			$(".noticeList tbody").empty();
			
			var winningList = data.list;
			
			if(status == "true") {
				let out = "당첨자 리스트";
				
				for(let i = 0; i<winningList.length ; i++) {
					let info = "";
					if(eventCategory == "group") {
						info += "고유번호: "+winningList[i].studyNum+"<br>이름: "+winningList[i].studyName;
					} else {
						info += "당첨 유저 id: "+winningList[i].userId
					}
					out += "<tr class='text-center'>";
					out += "	<td>"+(i+1)+"등"+"</td>";
					out += "	<td>"+ info +"</td>";
					out += "</tr>";
				}
				
				$(".noticeList tbody").append(out);
			} else if (status =="yet") {
				let out = "아직 발표되지 않았습니다.";
				$(".noticeList tbody").append(out);
			}
		}
		ajaxFun(url, "post", query, "json", fn);
		
	});
});
</script>

<div class="page-title">
	<div class="row">
		<div class="col-12 col-md-6 order-md-1 order-last">
			<h3><span><i class="icofont-magic-alt"></i></span>이벤트</h3>
			<p class="text-subtitle text-muted">개인/스터디(그룹)별로 이벤트에 응모해봐요:)</p>
		</div>
	</div>
</div>
<section class="section">
	<div class="row" id="basic-table">
		<div class="col-12 col-md-12">
			<div>
		        ${dataCount}개(${page}/${total_page} 페이지)
		    </div>
           	<div class="card">
                   <div class="card-content">
                   	<div class="card-body">
                       	<div class="table-responsive">
                           	<table class="table table-lg" style="text-align: center">
                               	<thead>
                                   	<tr>
                                       	<th class="col-md-1">번호</th>
                                       	<th class="col-md-auto">이벤트제목</th>
                                       	<th class="col-md-2">마감일</th>
                                       	<th class="col-md-2">카테고리</th>
                                       	<th class="col-md-2">당첨 확인</th>
                                      </tr>
                                   </thead>
                                   <tbody>
										<c:forEach var="dto" items="${list}">
										<tr>
                           	             	<td class="text-bold-500">${dto.listNum}</td>
                                        	<td class="text-bold-500"><a href="${articleUrl}&eventNum=${dto.eventNum}">${dto.subject}</a></td>
                                        	<td class="text-bold-500">${dto.lottoDate}</td>
                                        	<td class="text-bold-500">${dto.eventCategory == 'group' ? '그룹':'개인'}</td>
											<td class="text-bold-500">
												<button type="button" class="btn btn-primary checkWinningList" data-eventNum="${dto.eventNum}" data-eventCategory="${dto.eventCategory}"  data-bs-toggle="modal" data-bs-target="#checkEvent">확인</button>
											</td>
                                    	</tr>
                                    	</c:forEach>
                                   </tbody>
                               </table>
                               
                               <div class="page-box text-center">
								${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
							</div>
                               
                           </div>
                           
                      <div class="row board-list-footer">
                           <div class="col-md-4">
                           </div>
                           
                           <div class="col-md-4 text-center">
	                           <form class="row" name="searchForm" method="post">
										<div class="col-auto p-1">
											<select name="condition" class="form-select">
												<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
												<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
												<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
											</select>
										</div>                                  
										<div class="col-auto p-1" style="width:200px;">
											<input type="text" class="form-control" name="keyword" value="${keyword}">                                          
										</div>
										<div class="col-auto p-1">                                                     
											<button type="button" class="btn btn-outline-primary me-1 mb-1 btnSearch" onclick="search()"><i class="bi bi-search"></i></button>
										</div>				                                                  
							</form>
						</div>
						<div class="col-md-4">
						</div>
					</div>
						
						
                       </div>
                   </div>
               </div>
           </div>
	</div>
</section>
<div class="modal fade" id="checkEvent" tabindex="-1" aria-labelledby="checkEventLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="checkEventLabel">당첨자 명단</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        	<table class="table table-lg noticeList">
	        		<thead>
	        		</thead>
	        		<tbody>
	        		</tbody>
	        	</table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>
	      </div>
	    </div>
	</div>
</div>
