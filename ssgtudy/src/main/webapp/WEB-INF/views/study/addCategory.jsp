<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<ul class="nav nav-tabs" id="myTab" role="tablist">
	<li class="nav-item" role="presentation">
	    <a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Home</a>
	</li>
	<c:forEach items="${listCategory}" var="vo" varStatus="status">
		<li class="nav-item" role="presentation">
			<a class="nav-link" id="${vo.CATEGORYNUM}-tab" data-bs-toggle="tab" role="tab" aria-controls="${vo.CATEGORYNUM}" 
			aria-selected="false" data-categoryNum="${vo.CATEGORYNUM}">${vo.CATEGORYNAME}</a>	           
		</li>
</c:forEach>
</ul>
<div class="tab-content" id="myTabContent">
	<div class="tab-pane fade active show" id="home" role="tabpanel" aria-labelledby="home-tab"> 
		<div class="table-responsive table mx-auto" style="width: 700px;">
			<div class="m-3 p-2">
					<table class="table mb-8 col-8">
						<thead class="thead-dark">
							<tr class="text-center">
								<th>카테고리이름</th>
								<th class="col-4">변경</th>
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
										<button type="button" class="btn btn-primary updateCtgr" data-bs-toggle="modal" data-bs-target="#changeModal" data-categoryNum="${list.CATEGORYNUM}">변경</button>
										<button type="button" class="btn btn-danger" onclick="deleteCtgr('${list.CATEGORYNUM}');">삭제</button>
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
	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="changeModal" tabindex="-1" aria-labelledby="changeModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="changeModalLabel">카테고리이름 변경</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center">
      	<form class="form form-horizontal changeCtgrForm btn-group" style="width: 95%;" name="changeCtgrForm" method="post">
        	<input type="text" class="form-control changeCtgrName" name="categoryName" placeholder="변경할 이름을 적어주세요.">
        	<input type="hidden" name="studyNum" value="${studyNum}">
        	<button type="button" class="input-group-text btn btn-primary" onclick="updateCtgr()">변경하기</button>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>
      </div>
    </div>
  </div>
</div>


<script type="text/javascript">


$(function() {
	$("a[role='tab']").on("click", function(e){
    	listPage(1);
	});
});

function listPage(page) {
	var $tab = $("a[role='tab'].active");
	var categoryNum = $tab.attr("data-categoryNum");
	console.log(categoryNum);
	if(! categoryNum) {
		var url = '${pageContext.request.contextPath}/study/home/${dto.studyNum}';
		location.href = url;
	} else {
		var url = "${pageContext.request.contextPath}/study/home/${dto.studyNum}/list";
	}
	
	var query = "pageNo="+page+"&categoryNum=" + categoryNum;
	var search=$('form[name=searchForm]').serialize();
	query=query+"&"+search;
	
	var selector = "#myTabContent";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
	
}
function categoryList() { // 새로고침
	var url = "${pageContext.request.contextPath}/study/addCategory";
	var selector = ".card-main";
	var query = "studyNum=${dto.studyNum}";
	var fn = function(data) {
		$(selector).html(data);
	};
	// 카테고리 수정 / 삭제 후 탭에 업데이트 해야함
	ajaxFun(url, "get", query, "HTML", fn);
};

function add() {
	var f = document.myForm;
	var $categoryName = $(".categoryName").val().trim();
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

function updateCtgr() {
	var categoryNum = $(".updateCtgr").attr("data-categoryNum");
	// console.log(categoryNum);
	var categoryName = $(".changeCtgrName").val().trim();
	// console.log(categoryName);	
	if(! categoryName) {
		alert("변경할 이름을 적어주세요.");
		return false;
	}
	
	var q = $(".changeCtgrForm").serialize();
	// console.log(q);
	
	var url = "${pageContext.request.contextPath}/study/changeCategory";
	var query = q + "&categoryNum=" + categoryNum;
	var fn = function(data) {
		
		if(data.status == 'true') {
			$("#changeModal").modal("hide");
			categoryList();
		}
		
	};
	ajaxFun(url, "post", query, "json", fn);
}

function deleteCtgr(categoryNum) {
	if(! confirm("카테고리를 삭제하면 해당 카테고리의 게시글들은 사라집니다. 삭제하시겠습니까 ? ")) {
		return false;
	}
	
	var query = "categoryNum=" + categoryNum;
	var url = "${pageContext.request.contextPath}/study/deleteCategory";
	var fn = function() {
		
		categoryList();
	};
	ajaxFun(url, "get", query, "json", fn);
}
</script>