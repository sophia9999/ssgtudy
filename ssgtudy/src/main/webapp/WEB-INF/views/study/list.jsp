<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="page-heading">
	<div class="page-title">
	    <div class="row">
	        <div class="col-12 col-md-6 order-md-1 order-last">
	            <h3>나의 스터디 리스트</h3>
	        </div>
	    </div>
	</div>
	<section class="section">
	    <div class="card">
	        <div class="card-header">
	        	${dataCount}개(${page}/${total_page} 페이지)
	        </div>
	        <div class="card-body">
	            <table class="table table-lg" id="table1">
	                <thead>
	                    <tr class="text-center">
	                    	<th class="col-md-1">번호</th>
	                        <th class="col-md-3">스터디이름</th>
	                        <th class="col-auto">스터디목표</th>
	                        <th class="col-md-1">상태</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:forEach var="dto" items="${list}">
	                		<tr class="text-center">
	                			<td>${dto.listNum}</td>
	                			<c:choose>
	                				<c:when test="${dto.studyStatus > 0 }">
	                					<td>${dto.studyName}</td>
	                				</c:when>
	                				<c:when test="${dto.role < 1 }">
	                					<td>${dto.studyName}</td>
	                				</c:when>
	                				<c:otherwise>
		                				<td>
			                				<a href="${articleUrl}/${dto.studyNum}">${dto.studyName}</a>
			                			</td>
	                				</c:otherwise>
	                			</c:choose>
	                			<td class="text-truncate">${dto.studyGoal}</td>
	                			<c:choose>
	                				<c:when test="${dto.studyStatus > 0 }">
	                					<td class="text-center"><a href="#" onclick="alert('스터디 상태에 관해서는 관리자에게 문의하세요.')" class="btn icon btn-danger"><i data-feather="times"></i></a></td>
	                				</c:when>
	                				<c:when test="${dto.role < 1 }">
	                					<td class="text-center"><a href="${articleUrl}/${dto.studyNum}" onclick="alert('스터디관리자의 허락 후 활동이 가능합니다.')" class="btn icon btn-warning"><i data-feather="times"></i></a></td>
	                				</c:when>
	                				<c:otherwise>
		                				<td class="text-center"><a href="#" class="btn icon btn-success"><i data-feather="check"></i></a></td>
	                				</c:otherwise>
	                			</c:choose>
	                		</tr>
	                	</c:forEach>
	                </tbody>
	            </table>
	        </div>
	        <div class="page-box">
				${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>
	    </div>
	</section>
</div>

<script type="text/javascript">
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
			if(jqXHR.status === 403) {
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

</script>
