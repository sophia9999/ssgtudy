<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><tiles:insertAttribute name="title"/></title>
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<%-- 	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap5/css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap5/icon/bootstrap-icons.css" type="text/css">
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/icofont/icofont.min.css" type="text/css">
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core.css" type="text/css">
	
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/util-jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/menu.js"></script>
	 --%>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/jquery/js/jquery.min.js"></script>
	<!-- 템플릿 css 모음  -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css//bold.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/perfect-scrollbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/icofont/icofont.css">
    
  <!--  <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon"> -->

<style type="text/css">
.sidebar-wrapper .menu .sidebar-item.active .sidebar-link{
	background-color: #9e47a9;
}

.body_admin{	
    background-color: #fff2f9;
    color: #652c6c;
}

a {
	color: #652c6c;
}

.pagination.pagination-primary .page-item.active .page-link{
	background-color: #9e47a9;
    border-color: #9e47a9;
    box-shadow: 0 2px 5px rgb(67 94 190 / 30%);
}

i:not(.bi) {
	filter: opacity(0.2) drop-shadow(0px 0px 0px red);
}

.btn-outline-primary{
	color: #9e47a9;
    border-color: #9e47a9;
}

.btn-outline-primary:hover{
	color: #ffffff;
    background-color: #9e47a9;
}

</style>


</head>


<!-- 템플릿 현구조  -->

<body class="body_admin">
	<div id="app">
		<div id="sidebar"> 
			 <tiles:insertAttribute name="sidebar"/>
		</div>
		
		<div id="main">
			
			<header>
			    <tiles:insertAttribute name="header"/>
			</header>
			
			<div class="page-content">
				<tiles:insertAttribute name="body"/>
			</div>
			
			<footer>
			    <tiles:insertAttribute name="footer"/>
			</footer>
		
		</div>	
	</div>
   


<!-- 템블릿 js 모음  -->
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script> 

<!-- <script src="assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>

<script src="assets/vendors/apexcharts/apexcharts.js"></script>
<script src="assets/js/pages/dashboard.js"></script>

<script src="${pageContext.request.contextPath}/resources/js/main.js"></script> -->

</body>
</html>