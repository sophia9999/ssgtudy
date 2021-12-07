<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-main {
	max-width: 800px;
}

#chart-container {
	width: 476px;
	box-sizing: border-box;
	padding: 20px;
	height: 400px;
	border: 1px solid #ccc;
	text-align: center;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tabs.css" type="text/css">

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>

<script type="text/javascript">
$(function(){
	$("#tab-1").addClass("active");

	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		var url="${pageContext.request.contextPath}/admin/memberManage/list";	
		location.href=url;
	});
});

</script>

<main>
	<h1>Admin Page</h1>
	
	<div class="body-container">
	    <div class="body-title">
			<h2><i class="icofont-users"></i> 회원 관리 </h2>
	    </div>
	    
	    <div class="body-main ms-30">
			<div>
				<ul class="tabs">
					<li id="tab-0" data-tab="0"><i class="icofont-waiter-alt"></i> 회원 리스트</li>
					<li id="tab-1" data-tab="1"><i class="icofont-spreadsheet"></i> 회원분석</li>
				</ul>
			</div>
			<div id="tab-content" style="clear:both; padding: 20px 10px 0;">
				<div id="chart-container"></div>
			</div>
	    </div>
	</div>
	
</main>