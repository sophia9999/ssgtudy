<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

 <style type="text/css">
.body-container {
	max-width: 800px;
}

.table .ellipsis {
	position: relative;
	min-width: 200px;
}
.table .ellipsis span {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	position: absolute;
	left: 85px;
	right: 9px;
	cursor: pointer;
}
.table .ellipsis:before {
	content: '';
	display: inline-block;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<style type="text/css">
.reply-form textarea {
	height: 130px;
}
</style>
 
 <script type="text/javascript">
 $(function(){
	 var menu = "${menuItem}";
	 $("#tab-"+menu).addClass("active");
	 
	 $("button[role='tab']").on("click", function(e) {
		var tab = $(this).attr("data-tab");
		var url = "${pageContext.request.contextPath}/note/"+tab+"/noteForm";
		location.href=url;
	});
 });
 
 $(function(){
	 $(".btnReplyNote").click(function(){
		$("#myDialogModal").modal("show"); 
	 });
	 
	 $(".btnSendOk").click(function(){
		var f = document.replyForm;
		if(!f.content.value) {
			alert("내용을 입력하세요. ");
			f.content.focus();
			return false;
		}
		
		$("#myDialogModal").modal("hide");
		
		f.action="${pageContext.request.contextPath}/note/noteForm";
		f.submit();
	 });
 });
 
 function deleteNote() {
	 var query = "nums=${dto.num}&${query}";
	 var url = "${pageContext.request.contextPath}/note/${menuItem}/delete?" + query;
 
 	if(confirm("쪽지를 삭제하시겠습니까?")) {
 		location.href=url;
 	}
 }
 </script>
 
 <div class="container">
 	
 
 </div>