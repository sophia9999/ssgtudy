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
                        <c:if test="${sessionScope.member.membership >= 50}">
                        	<li class="sidebar-item ">
								 <a href="${pageContext.request.contextPath}/membermanage/user" class="sidebar-link">
	                                <i class="bi bi-gear-wide-connected"></i>
	                                <span>관리자페이지</span>
	                            </a>
							</li>
                        </c:if>
						
                        <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
							<i class="icofont-user"></i>                                <span>내 페이지</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/my/list">내가 쓴 글</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/my/recommend">내가 추천한 글</a>
                                </li>    
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/todo/list">나의 할 일</a>
                                </li>   
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/member/member">정보수정</a>
                                </li>    
                                
                                <li class="submenu-item ">
		                          </li><li class="sidebar-item  has-sub">
		                           <a href="#" class="sidebar-link">
										<i class="icofont-ui-messaging"></i>
		                                <span>쪽지함</span>
		                           </a>
	                                	<ul class="submenu ">
		                                <li class="submenu-item ">
		                                    <a href="${pageContext.request.contextPath}/note/receive/noteForm">보낸쪽지함</a>
		                                </li>
		                                 
		                                <li class="submenu-item ">
		                                    <a href="${pageContext.request.contextPath}/note/noteWrite">쪽지보내기</a>
		                                </li>    
                                   		</ul>
                                </li>    
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
							<i class="icofont-clip-board"></i>
                                <span>게시판</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/bbs/list">자유게시판</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/qna/list">QnA</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/notice/list">공지사항</a>
                                </li>  
                                                    
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
								<i class="icofont-school-bag"></i>								<span>학교 커뮤니티</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/community/main">커뮤니티</a>
                                </li>     
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/communitySch/main">일정</a>
                                </li>                        
                            </ul>
                        </li>
                        
                         <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
								<i class="icofont-group-students"></i>
								<span>스터디</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/study/enroll">스터디 등록</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/study/rank">스터디 순위</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/study/ad">스터디 홍보</a>
                                </li>
                                <c:if test="${not empty sessionScope.member}">
									<li class="submenu-item ">
	                                    <a href="${pageContext.request.contextPath}/study/list">나의 스터디</a>
	                                </li>   
                                </c:if>                    
                            </ul>
                        </li>
                        
                         <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
							<i class="icofont-users-social"></i>								<span>친구관리</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/friends/list">친구목록</a>
                                </li>       
                            </ul>
                        </li>
                        
                         <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
								<i class="icofont-ui-calendar"></i>
                                <span>일정</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/calendar/test">시험일정</a>
                                </li>  
                                                    
                            </ul>
                        </li>
                        
                        <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
								<i class="icofont-magic"></i>
                                <span>이벤트</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/event/list">이벤트 응모 및 확인</a>
                                </li>  
                                                    
                            </ul>
                        </li>
                        
                         <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
                               
							<i class="icofont-speech-comments"></i>                                
								<span>채팅방</span>

                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/chat/main">자유채팅방</a>
                                </li>  
                                                      
                            </ul>
                        </li>
                        
                         <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
								<i class="icofont-edit"></i>
                                <span>모의고사</span>
                            </a>
                            <ul class="submenu ">
                                
                                <li class="submenu-item ">
                                    <a href="${pageContext.request.contextPath}/test/mock">평가원 모의고사</a>
                                </li>  
                                                      
                            </ul>
                        </li>
                        
                        
                       
                 	</ul>
                </div>
                
            </div>