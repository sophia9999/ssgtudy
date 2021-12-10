<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
.col-md-2 {
	text-align: center;
}
</style>
</head>
<body>
	<div class="col-md-12 col-12">
		<div class="card">
			<div class="card-header">
				<h4 class="card-title">글 작성하기</h4>
			</div>
			<div class="card-content">
				<div class="card-body">
					<form class="form form-horizontal">
						<div class="form-body">
							<div class="row">
								<div class="col-md-2">
									<label>제목</label>
								</div>
								<div class="col-md-10 form-group">
									<input type="text" id="first-name" class="form-control" name="fname" placeholder="제목을 작성하세요.">
								</div>
								<div class="col-md-2">
									<label>작성자</label>
								</div>
								<div class="col-md-10 form-group">
									<input type="email" id="email-id" class="form-control" name="email-id" placeholder="Email">
								</div>
								<div class="col-md-2" style="height:300px" >
									<label>내용</label>
								</div>
								<div class="col-md-10 form-group">
									<input type="number" id="contact-info" class="form-control" name="contact"  style="height:300px" placeholder="내용을 작성하세요.">
								</div>
								<div class="col-md-2">
									<label>Password</label>
								</div>
								<div class="col-md-10 form-group">
									<input type="password" id="password" class="form-control" name="password" placeholder="Password">
								</div>
								<div class="col-12 col-md-10 offset-md-2 form-group">
									<div class="form-check">
										<div class="checkbox">
											<input type="checkbox" id="checkbox1" class="form-check-input" checked="">
											<label for="checkbox1">Remember Me</label>
										</div>
									</div>
								</div>
								<div class="col-sm-12 d-flex justify-content-end">
									<button type="submit" class="btn btn-primary me-1 mb-1">글 등록</button>
									<button type="reset" class="btn btn-light-secondary me-1 mb-1">다시작성</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>		
</body>
</html>