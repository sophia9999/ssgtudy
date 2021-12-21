<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<div class="table-responsive">
   	<table class="table table-lg" style="text-align: center">
	<thead>
	   	<tr>
	       	<th class="col-md-1">번호</th>
          	<th class="col-auto">제목</th>
           	<th class="col-md-2">작성자</th>
          	<th class="col-md-2">등록일</th>
          	<th class="col-md-2">조회수</th>
	    </tr>
	</thead>
		<tbody>
			<c:forEach var="dto" items="${listByCategory}">
			 	<tr>
			     	<td class="text-bold-500">${dto.listNum}</td>
			     	<td class="text-start"><a href="${articleUrl}&boardNum=${dto.boardNum}">${dto.subject}</a></td>
			     	<td class="text-bold-500">${dto.nickName}</td>
					<td>${dto.reg_date}</td>
			     	<td class="text-bold-500">${dto.hitCount}</td>
			 	</tr>
			</c:forEach>	
        </tbody>
    </table>
    
    <div class="page-box text-center">
		${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
	</div>
    
</div>

<form class="form form-horizontal" name="listSearch" method="post">
<div class="form-body">
	<div class="row"> 
		<div class="col-md-4">                                                           
		</div>
        <div class="input-group">
        	<div class="col-md-3">                                                           
			</div>
        	<div class="col-md-2" >
				<select name="condition" class="form-select" style="width: 70%">
					<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
					<option value="userName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
					<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
					<option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
					<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
				</select>
			</div>
            <div class="col-md-2">
				<input type="text" class="form-control" name="keyword" placeholder="검색">                                          
			</div>
			<div class="col-md-1">                                                     
				<button type="button" class="btn btn-primary me-1 mb-1" onclick="listSearchBtn()">검색</button>
			</div>				                                                   
			<div class="col-md-4 text-center justify-content-end">
			<c:if test="${studyDto.role > 0}">
				<button type="button" class="btn btn-primary me-1 mb-1" onclick="writeArticle()">등록</button>
			</c:if>
		</div>
        </div>
	</div>
	</div>
</form>

<script type="text/javascript">
function writeArticle() {
	var url ='${pageContext.request.contextPath}/study/home/${studyNum}/list/write';
	var query = "a=";
	var selector = "#myTabContent";
	var fn = function(data){
		$(".box").empty();
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

function listSearchBtn() {
	var f = document.listSearch;
	var condition = f.condition.value;
	var keyword = f.keyword.value.trim();
	var page = ${page};
	if( page == '0') {
		page = 1;
	}
	var categoryNum = ${categoryNum};
	
	
	var url ='${pageContext.request.contextPath}/study/home/${studyNum}/list';
	var query = "page="+page+"&categoryNum="+categoryNum+"&condition="+condition+"&keyword="+keyword;
	console.log(query);
	
	var selector = "#myTabContent";
	var fn = function(data){
		$(".box").empty();
		$(selector).html(data);
	};
	ajaxFun(url, "post", query, "html", fn);
}

</script>