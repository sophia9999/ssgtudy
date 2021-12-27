<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<div class="page-title">
		<div class="row">
			<div class="col-12 col-md-6 order-md-1 order-last">
				<h3>내가 쓴 글</h3>
				<p class="text-subtitle text-muted">내가 작성한 글</p>
			</div>
		</div>
	</div>
	<section class="section">
		<div class="row" id="basic-table">
			<div class="col-12 col-md-12">
            	<div class="card">
                    <div class="card-content">
                    	<div class="card-body">
                        	<div class="table-responsive">

								<table class="table mb-0 table-lg">
									<thead>
										<tr>
											<td colspan="2" align="center">
												<h5>${dto.subject}</h5>
											</td>
										</tr>
									</thead>
									
									<tbody>
										<tr>
											<td width="50%">
												구분 : ${dto.boardTitle}
											</td>
											<td align="right">
												${dto.reg_date} | 조회 ${dto.hitCount}
											</td>
										</tr>
										
										<tr>
											<td colspan="2" valign="top" height="200" style="padding-top: 5px;">
												${dto.content}
											</td>
										</tr>
									</tbody>
								</table>
											
								<table class="table table-borderless mb-2 table-lg">
									<tr>
										<td width="50%">
										</td>
										<td class="text-end">
											<button type="button" class="btn btn-outline-primary me-1 mb-1" onclick="location.href='${pageContext.request.contextPath}/my/list?page=${page}';">리스트</button>
										</td>
									</tr>
								</table>
                                	
                            </div>
                        </div>
                    </div>
                </div>
            </div>

		</div>
	</section>
