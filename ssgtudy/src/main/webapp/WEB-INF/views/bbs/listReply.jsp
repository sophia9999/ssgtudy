<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="reply-info" style="margin: 15px 0 15px;">
	<span class='reply-count' style="color:#435EBE;font-weight: 700;">댓글 ${replyCount}개</span>
	<span>[목록, ${pageNo}/${total_page} 페이지]</span>
</div>

<table class='table table-borderless'>
	<c:forEach var="vo" items="${listReply}">
		<tr style="background:#F8F9FA">
			<td width='50%'>
				<span class="bold"><i class="bi bi-person-circle text-muted"></i>&nbsp&nbsp${vo.nickName}</span>
			</td>
			<td width='50%' align='right'>
				<span class="text-muted">${vo.reg_date}</span> |
				<c:choose>
					<c:when test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin' }">
						<span class='deleteReply' data-replyNum='${vo.replyNum}' data-pageNo='${pageNo}'
							style="cursor:pointer">삭제</span>
					</c:when>
					<c:otherwise>
						<span class='notifyReply'>신고</span>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td colspan='2' valign='top'>${vo.content}</td>
		</tr>

		<tr>
			<td>
				<button type='button' class='btn btn-light btnReplyAnswerLayout' data-replyNum='${vo.replyNum}'
					style="border: white; background: white">답글 보기<span id="answerCount${vo.replyNum}">(${vo.answerCount})</span></button>
			</td>
			<td align='right'>
				<button type='button' class='btn btn-light btnSendReplyLike' data-replyNum='${vo.replyNum}' title="좋아요"><i class="bi ${userReplyLiked ? 'bi-hand-thumbs-up-fill' : 'bi-hand-thumbs-up'  }"></i> <span id="likeCount">${vo.likeCount}</span></button>
			</td>
		</tr>
	
	    <tr class='reply-answer'>
	        <td colspan='2' class="px-3">
	        	<div class="p-2">
		            <div id='listReplyAnswer${vo.replyNum}' class='p-2'></div>
		            <div class="row px-2">
		                <div class='col'><textarea class='form-control'></textarea></div>
		            </div>
		             <div class='row p-2'>
		             	<div class="col text-end">
		                	<button type='button' class='btn btn-light btnSendReplyAnswer' data-replyNum='${vo.replyNum}'>답글 등록</button>
		                </div>
		            </div>
				</div>
			</td>
	    </tr>
	</c:forEach>
</table>

<div class="page-box">
	${paging}
</div>							
