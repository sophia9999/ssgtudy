<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<section class="row">
                    <div class="col-12 col-lg-9">
                        
                        <div class="row">
                            <div class="col-6">
                                <div class="card">
                                    <div class="card-header">
                                        <h4>
	                                        <i class="bi bi-trophy fs-3"></i>
	                                        이달의 우수 스터디
                                        </h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-lg">
                                                <thead>
                                                    <tr>
                                                        <th>순위</th>
                                                        <th>스터디명</th>
                                                        <th>달성횟수!</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                
                                                    <c:forEach var="r" items="${ranklist}">
                                                    <tr>                                                  
                                                        <td class="col-3">
                                                            <div class="d-flex align-items-center">
                                                                <p class="font-bold ms-3 mb-0">${r.rank}</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">${r.studyName}</p>
                                                        </td>
                                                        <td>${r.questCount}</td>                                                 
                                                    </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="card">
                                    <div class="card-header">
                                    	<h4>
                                    	<i class="bi bi-hand-thumbs-up fs-3"></i>
                                        공지사항
                                        </h4>
                                    </div>
                                    <div class="card-body">
                                       <div class="table-responsive">
                                            <table class="table table-hover table-lg">
                                                <thead>
                                                    <tr>
                                                        <th>&nbsp;&nbsp;&nbsp;번호</th>
                                                        <th>제목</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                
                                                	<c:forEach var="n" items="${noticelist}">
                                                    <tr>
                                                        <td class="col-3">
                                                            <div class="d-flex align-items-center">
                                                                <p class="font-bold ms-3 mb-0">${n.listNum}</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">
                                                            	<a href="${pageContext.request.contextPath}/notice/article?page=1&nNum=${n.nNum}">[공지]${n.subject}</a>                
                                                          </p>
                                                        </td>
                                                        
                                                    </tr>
                                                	</c:forEach>
                                                   
                                                    
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            
                            <div class="col-6">
                                <div class="card">
                                    <div class="card-header">
                                        <h4>
                                        <i class="bi bi-pencil fs-3"></i>
                                        	스터디 자랑하기
                                        </h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-lg">
                                                <thead>
                                                    <tr>
                                                        <th>&nbsp;&nbsp;Name</th>
                                                        <th>Comment</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                
                                                <c:forEach var="ad" items="${adlist}">
                                                
                                                    <tr>
                                                        <td class="col-4">
                                                            <div class="d-flex align-items-center">
                                                                <p class="font-bold ms-3 mb-0">${ad.subject}</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">${ad.content}</p>
                                                        </td>
                                                    </tr>
                                                    
                                                </c:forEach>
                                                
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-6">
                                <div class="card">
                                    <div class="card-header">
                                        <h4>
	                                        <i class="bi bi-check2-circle fs-3"></i>
	                                        오늘의 문제
                                        </h4>
                                    </div>
                                    <div class="card-body">
                                    	<div class="question m-2">
                                    		<p class="font-bold mb-4">기출 : 2021 6월 모의고사 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 과목 : 영어 </p> 
                                    		<img src="${pageContext.request.contextPath}/resources/images/test1.jpg" alt="Face test1">
                                    	</div>
                                    	<div class="buttons text-center">
                                    		<a href="#" class="btn btn-outline-primary m-4">문제 풀러 가기</a>
                                    	</div>
                                    </div>
                                </div>
                        
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-lg-3">
                        <div class="card">
                            <div class="card-body py-4 px-5">
                                <div class="d-flex align-items-center">
         
                                    <div class="avatar avatar-xl">
                                    </div>
                                    
                                    <div class="ms-3 name">
                                       
                                        <c:choose>
			                       	<c:when test="${not empty sessionScope.member}"> 
                                        <h5 class="font-bold">${sessionScope.member.nickName}님</h5>
                                        <h6 class="text-muted mb-0">${sessionScope.member.userId}</h6>               		
			                       	</c:when>			                                     	
			                       	<c:otherwise>
			                       			<span>로그인이 필요합니다.</span>
			                    	</c:otherwise>
		                      	</c:choose>
                                    </div>
                                  </div>
                                
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                                <h4>Friends</h4>
                            </div>
                            <div class="card-content pb-4">
                            
                            <c:forEach var="f" items="${friendslist}">
                             	<div class="recent-message d-flex px-4 py-3">
                                    <div class="avatar avatar-lg">
                                        
                                    </div>
                                    <div class="name ms-4">
                                        <h5 class="mb-1">${f.nickName}</h5>
                                        <h6 class="text-muted mb-0">${f.userId}</h6>
                                    </div>
                                </div>
                            
                            </c:forEach>
                               
                              
                            </div>
                        </div>
                       
                    </div>
                </section>