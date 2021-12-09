<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="card">
	<form name="myForm">
		<input type="text" class="categoryName" name="categoryName" placeholder="카테고리이름">
		<button type="button" class="btn btn-primary" onclick="add();">만들기</button>
		<input type="hidden" name="studyNum" value="${dto.studyNum}">
	</form>
</div>

<script type="text/javascript">
function add() {
	var f = document.myForm;
	var $categoryName = $(".categoryName").val();
	if(! $categoryName.trim() ){
		$(".categoryName").focus();
		return false;
	}
	
	location.href="${pageContext.request.contextPath}/study/addCategory";
}
</script>