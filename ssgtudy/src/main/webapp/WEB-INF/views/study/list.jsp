<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="page-heading">
	<div class="page-title">
	    <div class="row">
	        <div class="col-12 col-md-6 order-md-1 order-last">
	            <h3><span class="align-middle"><i class="bi bi-stack"></i></span> 나의 스터디 리스트</h3>
	        </div>
	    </div>
	</div>
	<section class="section">
		 <div>
	        ${dataCount}개(${page}/${total_page} 페이지)
	     </div>
	    <div class="card">
	        <div class="card-body">
	            <table class="table table-lg" id="table1">
	                <thead>
	                    <tr class="text-center">
	                    	<th class="col-md-1">번호</th>
	                        <th class="col-md-2">스터디이름</th>
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
	                					<td>${dto.studyName}<br>고유번호: ${dto.studyNum}</td>
	                				</c:when>
	                				<c:when test="${dto.role == '0' }">
	                					<td>
	                						<a href="${articleUrl}/${dto.studyNum}">${dto.studyName}</a><br>고유번호: ${dto.studyNum}
	                					</td>
	                				</c:when>
	                				<c:otherwise>
		                				<td>
			                				<a href="${articleUrl}/${dto.studyNum}">${dto.studyName}</a><br>고유번호: ${dto.studyNum}
			                			</td>
	                				</c:otherwise>
	                			</c:choose>
	                			<td class="text-truncate"><textarea class="text-truncate" style="resize: none; border: none; width: 100%; background: #fff" readonly="readonly" disabled="disabled">${dto.studyGoal}</textarea></td>
	                			<c:choose>
	                				<c:when test="${dto.studyStatus > 0 }">
	                					<td class="text-center"><a href="#" onclick="alert('스터디 상태에 관해서는 관리자에게 문의하세요.')" class="btn icon btn-danger"><i data-feather="times"></i></a></td>
	                				</c:when>
	                				<c:when test="${dto.role < 1 }">
	                					<td class="text-center"><a href="#" onclick="alert('스터디관리자의 허락 후 활동이 가능합니다.')" class="btn icon btn-warning"><i data-feather="times"></i></a></td>
	                				</c:when>
	                				<c:otherwise>
		                				<td class="text-center"><a href="#" onclick="alert('활성화되어있는 스터디입니다.')" class="btn icon btn-success"><i data-feather="check"></i></a></td>
	                				</c:otherwise>
	                			</c:choose>
	                		</tr>
	                	</c:forEach>
	                </tbody>
	            </table>
	        </div>
	        <div class="page-box text-center">
				${dataCount == 0 ? "등록된 스터디가 없습니다. 스터디에 가입해 보세요:)" : paging}
			</div>
			<c:if test="${dataCount == '0' }">
				<div class="p-3"></div>
			</c:if>
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
