<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<section class="row">
	<c:forEach var="vo" items="${listReplyAnswer}">
	<div class='border-bottom mb-2'>
		<div class='row py-1'>
			<div class='col-6'><i class="bi bi-person-circle text-muted"></i> <span class="bold">${vo.nickName}</span></div>
			<div class='col text-end'>
				<span class="text-muted">${vo.reg_date}</span> |
				<c:choose>
					<c:when test="${sessionScope.member.userId==vo.userId || sessionScope.member.membership>50}">
						<span class='deleteReplyAnswer' data-replyNum='${vo.replyNum}' data-answer='${vo.answer}'>삭제</span>
					</c:when>
					<c:otherwise>
						<span class='notifyReply'>신고</span>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<div class='row px-2 pb-2'>
			<div class='col'>${vo.content}</div>
		</div>
	</div>
</c:forEach>
</section>