<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<head>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>ssg</title>
	<link rel="icon" href="data:;base64,iVBORw0KGgo=">
	 <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css//bold.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/perfect-scrollbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/auth.css">
	
	<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

<script type="text/javascript">
function sendLogin() {
    var f = document.loginForm;
	var str;
	
	str = f.userId.value;
    if(!str) {
        f.userId.focus();
        return;
    }

    str = f.userPwd.value;
    if(!str) {
        f.userPwd.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/member/login";
    f.submit();
}
</script>
</head>


<body>
	<div id="auth">
        <div class="row h-100">
            <div class="col-lg-5 col-12">
                <div id="auth-left">                
                    <h1 class="auth-title">log in.</h1>
                    <form name="loginForm" action="" method="post">
                        <div class="form-group position-relative has-icon-left mb-4">
                            <input type="text" name="userId" class="form-control form-control-xl" placeholder="아이디">
                            <div class="form-control-icon">
                                <i class="bi bi-person"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-4">
                            <input type="password" name="userPwd" class="form-control form-control-xl" placeholder="비밀번호">
                            <div class="form-control-icon">
                                <i class="bi bi-shield-lock"></i>
                            </div>
                        </div>
                        <div class="form-check form-check-lg d-flex align-items-end">
                            <input class="form-check-input me-2" type="checkbox" value="" id="flexCheckDefault">
                            <label class="form-check-label text-gray-600" for="flexCheckDefault">
                               	자동 로그인 유지
                            </label>
                        </div>
                        <button class="btn btn-primary btn-block btn-lg shadow-lg mt-5">로그인</button>
                    </form>
                    <div class="text-center mt-5 text-lg fs-4">
                        <p class="text-gray-600">
                        	<a href="${pageContext.request.contextPath}/member/join" class="font-bold">회원가입</a>
                    	</p>
                        <p>
                        	<a class="font-bold" href="${pageContext.request.contextPath}/member/pwdFind">비밀번호 찾기</a>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-lg-7 d-none d-lg-block">
                <div id="auth-right">

                </div>
            </div>
        </div>

    </div>
</body>
	
