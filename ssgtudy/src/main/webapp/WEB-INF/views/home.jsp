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
                                                        <th>과목</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td class="col-3">
                                                            <div class="d-flex align-items-center">
                                                                <p class="font-bold ms-3 mb-0">1</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">영사모</p>
                                                        </td>
                                                        <td>영어</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="col-3">
                                                            <div class="d-flex align-items-center">
                                                                <p class="font-bold ms-3 mb-0">2</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">설대 경영 모임</p>
                                                        </td>
                                                        <td>수학</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="col-3">
                                                            <div class="d-flex align-items-center">
                                                                <p class="font-bold ms-3 mb-0">3</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">국어최고스터디</p>
                                                        </td>
                                                        <td>국어</td>
                                                    </tr>
                                                    
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
                                        인기글
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
                                                    <tr>
                                                        <td class="col-3">
                                                            <div class="d-flex align-items-center">
                                                                <p class="font-bold ms-3 mb-0">1011</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">영어 잘하는 법 알려드립니다.</p>
                                                        </td>
                                                        
                                                    </tr>
                                                    <tr>
                                                        <td class="col-3">
                                                            <div class="d-flex align-items-center">
                                                                <p class="font-bold ms-3 mb-0">2023</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">수능 백일의 기적!</p>
                                                        </td>
                                                     
                                                    </tr>
                                                    <tr>
                                                        <td class="col-3">
                                                            <div class="d-flex align-items-center">
                                                                <p class="font-bold ms-3 mb-0">1001</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">스터디 잘 운영하는 법</p>
                                                        </td>
                                                    
                                                    </tr>
                                                    
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
                                        My study
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
                                                    <tr>
                                                        <td class="col-4">
                                                            <div class="d-flex align-items-center">
                                                                <p class="font-bold ms-3 mb-0">영사모</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">영어 1등급 목표!</p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="col-3">
                                                            <div class="d-flex align-items-center">
                                                                <p class="font-bold ms-3 mb-0">수백모</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">서울 고등학교 수학 백점 맞는 사람들의 모임</p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="col-3">
                                                            <div class="d-flex align-items-center">
                                                                <p class="font-bold ms-3 mb-0">설대 국문과</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">서울대학교 국어국문학과 목표!!</p>
                                                        </td>
                                                    </tr>
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
                                        <!-- <img src="assets/images/faces/1.jpg" alt="Face 1"> -->
                                    </div>
                                    <div class="ms-3 name">
                                        <h5 class="font-bold">비회원(ID)</h5>
                                        <h6 class="text-muted mb-0">학생</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                                <h4>Friends</h4>
                            </div>
                            <div class="card-content pb-4">
                                <div class="recent-message d-flex px-4 py-3">
                                    <div class="avatar avatar-lg">
                                        
                                    </div>
                                    <div class="name ms-4">
                                        <h5 class="mb-1">Hank Schrader</h5>
                                        <h6 class="text-muted mb-0">교사</h6>
                                    </div>
                                </div>
                                <div class="recent-message d-flex px-4 py-3">
                                    <div class="avatar avatar-lg">
                                        
                                    </div>
                                    <div class="name ms-4">
                                        <h5 class="mb-1">Dean Winchester</h5>
                                        <h6 class="text-muted mb-0">학생</h6>
                                    </div>
                                </div>
                                <div class="recent-message d-flex px-4 py-3">
                                    <div class="avatar avatar-lg">
                                        
                                    </div>
                                    <div class="name ms-4">
                                        <h5 class="mb-1">John Dodol</h5>
                                        <h6 class="text-muted mb-0">학생</h6>
                                    </div>
                                </div>
                                <div class="recent-message d-flex px-4 py-3">
                                    <div class="avatar avatar-lg">
                                        
                                    </div>
                                    <div class="name ms-4">
                                        <h5 class="mb-1">Hank Schrader</h5>
                                        <h6 class="text-muted mb-0">학생</h6>
                                    </div>
                                </div>
                                <div class="recent-message d-flex px-4 py-3">
                                    <div class="avatar avatar-lg">
                                       
                                    </div>
                                    <div class="name ms-4">
                                        <h5 class="mb-1">Dean Winchester</h5>
                                        <h6 class="text-muted mb-0">학생</h6>
                                    </div>
                                </div>
                                <div class="recent-message d-flex px-4 py-3">
                                    <div class="avatar avatar-lg">
                                        
                                    </div>
                                    <div class="name ms-4">
                                        <h5 class="mb-1">John Dodol</h5>
                                        <h6 class="text-muted mb-0">학생</h6>
                                    </div>
                                </div>
                                 <div class="recent-message d-flex px-4 py-3">
                                    <div class="avatar avatar-lg">
                                        
                                    </div>
                                    <div class="name ms-4">
                                        <h5 class="mb-1">John Dodol</h5>
                                        <h6 class="text-muted mb-0">학생</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                       
                    </div>
                </section>