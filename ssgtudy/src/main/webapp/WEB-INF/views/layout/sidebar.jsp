<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">사용자</li>

                        <li class="sidebar-item has-sub active ">
                            <a href="index.html" class="sidebar-link">
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
                                    <a href="component-badge.html">공지글</a>
                                </li>    
                                <li class="submenu-item ">
                                    <a href="component-badge.html">일정</a>
                                </li>    
                                <li class="submenu-item ">
                                    <a href="component-badge.html">오늘의 포도알</a>
                                </li>                         
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
							<i class="icofont-user"></i>                                <span>내 페이지</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="component-alert.html">내가 쓴 글</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="component-badge.html">내가 쓴 댓글</a>
                                </li>      
                                <li class="submenu-item ">
                                    <a href="component-badge.html">내가 추천한 글</a>
                                </li>    
                                <li class="submenu-item ">
                                    <a href="component-badge.html">나의 할 일</a>
                                </li>   
                                <li class="submenu-item ">
                                    <a href="component-badge.html">나의 일정</a>
                                </li>    
                                <li class="submenu-item ">
                                    <a href="component-badge.html">정보수정</a>
                                </li>    
                                
                                <li class="submenu-item ">
		                          </li><li class="sidebar-item  has-sub">
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
                                
                                    	     
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
							<i class="icofont-clip-board"></i>
                                <span>게시판</span>
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
								<i class="icofont-school-bag"></i>								<span>학교 커뮤니티</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="layout-default.html">커뮤니티</a>
                                </li>     
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">일정</a>
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
                                    <a href="extra-component-avatar.html">스터디 등록</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">스터디 순위</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">스터디 홍보 게시판</a>
                                </li>  
                          
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">스터디 홍보 게시판</a>
                                </li>  
                                
	                                <li class="submenu-item ">
			                          </li><li class="sidebar-item  has-sub">
			                           <a href="#" class="sidebar-link">
			                                <i class="bi bi-stack"></i>
			                                <span>나의 스터디</span>
			                           </a>
			                                
			                                	<ul class="submenu ">
				                                <li class="submenu-item ">
				                                    <a href="component-alert.html">스터디 공지사항</a>
				                                </li>
				                                <li class="submenu-item ">
				                                    <a href="component-badge.html">스터디 게시판</a>
				                                </li>      
				                                <li class="submenu-item ">
				                                    <a href="component-badge.html">스터디 목표</a>
				                                </li>   
				                                 <li class="submenu-item ">
				                                    <a href="component-badge.html">스터디 탈퇴</a>
				                                </li>   
						                                
						                            
	                                    		</ul>
	                                </li>    
                                                    
                            </ul>
                        </li>
                        
                         <li class="sidebar-item  has-sub">
                            <a href="#" class="sidebar-link">
							<i class="icofont-users-social"></i>								<span>친구관리</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">친구목록</a>
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
								<i class="icofont-ui-calendar"></i>
                                <span>일정</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">시험일정</a>
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
							<i class="icofont-bell-alt"></i>
							<span>회원가입</span>
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
                               
							<i class="icofont-speech-comments"></i>                                
								<span>채팅방</span>

                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">자유채팅방</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">단체채팅방</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">1:1채팅방</a>
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
                                    <a href="extra-component-avatar.html">과목멸 모의고사</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">평가원 모의고사</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">수능 문제풀이</a>
                                </li>  
                                <li class="submenu-item ">
                                    <a href="extra-component-avatar.html">푼 모의고사</a>
                                </li>  
                                                    
                            </ul>
                        </li>
                        
                        
                       
                 	</ul>
                </div>
                
            </div>