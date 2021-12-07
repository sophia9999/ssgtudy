<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                      		 <a href="index.html"><img src="${pageContext.request.contextPath}/resources/images/ssg2.png" alt="Logo" ></a>                     		
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">관리자</li>

                                                   
						<li class="sidebar-item  has-sub active">
                            <a href="#" class="sidebar-link">
                                <i class="bi bi-grid-fill"></i>		
							      <span>메인</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="component-alert.html">전체페이지</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="component-badge.html">최신글</a>
                                </li>      
                                <li class="submenu-item ">
                                    <a href="component-badge.html">인기글</a>
                                </li>    
                                <li class="submenu-item ">
                                    <a href="component-badge.html">공지글 관리</a>
                                </li>   
                                <li class="submenu-item ">
                                    <a href="component-badge.html">신고글 관리</a>
                                </li>    
                                <li class="submenu-item ">
                                    <a href="component-badge.html">오늘의 문제</a>
                                </li> 	
								</ul>
								
                        </li>
							<li class="sidebar-item has-sub  ">
                            <a href="index.html" class="sidebar-link">
								<i class="icofont-search-user"></i>     
                      	
                          
                                
                              <span>유저관리</span>
                            </a>
                             <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="component-alert.html">신고당한 유저 목록</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="component-badge.html">관리자 리스트</a>
                                </li>  
                                               
                            </ul> 
                             </li>   
                                
                                
                           <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
								<i class="icofont-clip-board"></i>                                <span>게시판</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">자유게시판</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">질문답변게시판</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">공지사항</a>
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
                                    <a href="extra-component-avatar.html">홍보게시판</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">스터디 정지</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">스터디 순위</a>
                                </li>  
                          
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">스터디 목록</a>
                                </li>  
                              
                                 <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">신고된 스터디 목록</a>
                                </li>  
                                 <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">스터디 추첨</a>
                                </li>  
                                
                              </ul>
                             </li>
                                
                                   
                                
		                          <li class="sidebar-item  has-sub">
		                           <a href="#" class="sidebar-link">
										<i class="icofont-ui-messaging"></i>
		                                <span>쪽지함</span>
		                           </a>
		                                
		                                	<ul class="submenu ">
			                                <li class="submenu-item ">
			                                    <a href="component-alert.html">받은쪽지함</a>
			                                </li>
			                                <li class="submenu-item ">
			                                    <a href="component-badge.html">보낸쪽지함</a>
			                                </li>      
			                                <li class="submenu-item ">
			                                    <a href="component-badge.html">쪽지보내기</a>
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
                                    <a href="extra-component-avatar.html">시험일정</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">일정보기</a>
                                </li>  
                                          
                            </ul>
                        </li>
                        
                 	</ul>
                </div>
                <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
            </div>