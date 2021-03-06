<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


		<div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                        	쓱터디
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                       	
                    </div>
                   
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">
                        	 <div>
		                   		<c:choose>
			                       	<c:when test="${not empty sessionScope.member}"> 
			                       		${sessionScope.member.nickName}님 환영합니다. 
			                       		<br>
			                       		<a href="${pageContext.request.contextPath}/member/logout"> 
			                       			<i class="icofont-logout"></i>
			                       			<span class="m-auto">로그아웃</span>
			                       		</a>
			                       	</c:when>
			                       	<c:otherwise>
			                       		<a href="${pageContext.request.contextPath}/member/login"> 
			                       			<i class="icofont-login"></i>
			                       			<span>로그인</span>
			                       		</a>
			                       		&nbsp;&nbsp;
			                       		<a href="${pageContext.request.contextPath}/member/join">
											<i class="icofont-bell-alt"></i>
											<span>회원가입</span>
			                         		</a>
			                       	</c:otherwise>
		                      	</c:choose>
		                    </div>
                        </li>

                         <li style="cursor: pointer;" class="sidebar-item has-sub active" onclick="location.href='${pageContext.request.contextPath}' ">
                            <div class="sidebar-link">
                                <i class="bi bi-grid-fill"></i>
                                <span>메인</span>
                            </div>
                            
                        </li>
						
                        <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
							<i class="icofont-user"></i>    
	                            <span>유저관리</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/membermanage/report">신고 유저 목록</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/membermanage/manager">관리자 관리</a>
                                </li>      
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/membermanage/user">유저관리</a>
                                </li>    
                                
                                
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
							<i class="icofont-clip-board"></i>
                                <span>학교커뮤니티관리</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/community/main">학교커뮤니티</a>
                                </li>                                                                                  
                            </ul>
                        </li>
        
                         <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
								<i class="icofont-group-students"></i>
								<span>스터디 관리</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/studyManage/all">스터디 목록</a>
                                </li>      
                            </ul>
                        </li>
                         <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
								<i class="icofont-magic"></i>
								<span>이벤트 관리</span>
                            </a>
                            <ul class="submenu ">
								<li class="submenu-item ">
	                                    <a href="${pageContext.request.contextPath}/studyManage/lotto">이벤트 리스트</a>
	                             </li>   
                                                
                            </ul>
                        </li>                   
                        
                       
                 	</ul>
                </div>
                
            </div>