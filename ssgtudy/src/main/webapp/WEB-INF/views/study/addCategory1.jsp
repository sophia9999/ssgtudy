<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="table-responsive table">
	<div class="m-3 p-2">
		<table class="table mb-0">
			<thead class="thead-dark">
				<tr class="text-center">
					<th>카테고리이름</th>
					<th class="col-3">변경</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty categoryList}">
					<tr class="text-center">
						<td colspan="2">카테고리가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="list" items="${categoryList}">
					<tr class="text-center">
						<td>
							${list.CATEGORYNAME}
						</td>
						<td>
							<button type="button" class="btn btn-outline-primary" onclick="updateCtgr('${list.CATEGORYNUM}');">이름수정</button>
							<button type="button" class="btn btn-outline-primary" onclick="deleteCtgr('${list.CATEGORYNUM}');">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="text-center pt-3">
		<form name="myForm" method="post">
			<div class="btn-group">
				<input type="text" class="categoryName form-control " name="categoryName" placeholder="카테고리이름">
				<input type="hidden" class="studyNum" name="studyNum" value="${dto.studyNum}">
				<button type="button" class="input-group-text btn btn-primary" onclick="add();">추가</button>
			</div>
			<div class="p-2 text-center">
				<button type="button" class="btn btn-primary" onclick="javascript:location.href='${pageContext.request.contextPath}/study/home/${dto.studyNum}';">홈으로</button>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">

function categoryList() { // 새로고침
	var url = "${pageContext.request.contextPath}/study/addCategory";
	var selector = "#home";
	var query = "studyNum=${dto.studyNum}";
	var fn = function(data) {
		$(selector).html(data);
	};
	// 카테고리 수정 / 삭제 후 탭에 업데이트 해야함
	ajaxFun(url, "get", query, "HTML", fn);
};

function add() {
	var f = document.myForm;
	var $categoryName = $(".categoryName").val();
	var $studyNum = $(".studyNum").val();
	if(! $categoryName.trim() ){
		$(".categoryName").focus();
		return false;
	}
	var query = "studyNum=" + $studyNum + "&categoryName=" + $categoryName;
	
	var url = "${pageContext.request.contextPath}/study/addCategory";
	var fn = function() {
		categoryList();
	};
	
	ajaxFun(url, "post", query, "html", fn);
}

function updateCtgr(categoryNum) {
	var $categoryName = $(".categoryName").val();
	var query = "categoryNum=" + categoryNum + "categoryName=" + $categoryName;
	var url = "${pageContext.request.contextPath}/study/updateCategory";
	var fn = function() {
		categoryList();
	};
	ajaxFun(url, "get", query, "json", fn);
}

function deleteCtgr(categoryNum) {
	var query = "categoryNum=" + categoryNum;
	var url = "${pageContext.request.contextPath}/study/deleteCategory";
	var fn = function() {
		categoryList();
	};
	ajaxFun(url, "get", query, "json", fn);
}
</script>