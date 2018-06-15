<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<style>
.buttons{
	display: inline;
	float:right;
}

</style>
<script type="text/javascript">

	
//댓글 수정input 보이기
	function showUpdateTag(comno) {
		if ($("#commentUpdateDiv_" + comno).css("display") == "none") {
			$("#commentUpdateDiv_" + comno).css("display", "block");
		} else {
			$("#commentUpdateDiv_" + comno).css("display", "none");
		}
	}
	
	//대댓글 작성폼 보여주기
	function showWriteComments(comno) {
		console.log(comno);
		if ($("#cosPart_" + comno).css("display") == "none") {
			$("#cosPart_" + comno).css("display", "block");
		} else {
			$("#cosPart_" + comno).css("display", "none");
		}
	}
	
	//대댓글 수정input 보이기
	function showUpdateCos(cosno) {
		if ($("#commentsUpdateDiv_" + cosno).css("display") == "none") {
			$("#commentsUpdateDiv_" + cosno).css("display", "block");
		} else {
			$("#commentsUpdateDiv_" + cosno).css("display", "none");
		}
	}
</script>
<c:forEach items="${commentList}" var="comment">
	<label><strong class="commentNick">${comment.comwriter }</strong></label>
	<span style="word-break: break-all; font-size: 16px;">${comment.comcontent }</span>
	
	<div class="buttons">
	<c:if test="${comment.comwriter == sessionScope.memnick }">
		<a href="javascript:void(0);" onclick="showUpdateTag('${comment.comno}')">수정</a>
		<a href="javascript:void(0);" onclick="comDelete('${comment.comno }','${board.bodno }')">삭제</a>
	</c:if>
	<label>
	<a id="writeComments_${comment.comno }" href="javacript:void(0)" onclick="showWriteComments('${comment.comno}')">답글달기</a>
	</label>
	</div>
	<!-- 수정파트(토글) -->
	<div id="commentUpdateDiv_${comment.comno }"style="display:none;">
	<br>
	<label id="showUpdateId_${comment.comno }" ><strong class="commentNick">${comment.comwriter }</strong></label>
	<input style="width:78%;" type="text" id="showUpdateTag_${comment.comno }" value="${comment.comcontent }"></input>
	<a href="javascript:void(0);" onclick="comUpdate('${comment.comno}')">수정완료</a>
	</div>
	<!-- 수정파트(토글) -->
	<br>
	<!-- 	3. 대댓글 삭제/수정 버튼	 -->
	<div style="clear: both;"></div>
	<div id="cosPart_${comment.comno }" style="padding-left:30px; display:none;">
	 <input type="text" id="comments_${comment.comno}" placeholder="답글을 입력하세요 ..." style="width:58%"></input>
     <input type="button" id="commentsBtn" value="답글입력" style="width:13%;" onclick="javacript:writeComments('${comment.comno}')"></input>
	</div>
	
	<div style="padding-left:30px; padding-bottom:5px;">
		<c:forEach items="${commentsList }" var="comments">
		 <c:if test="${comment.comno == comments.comno}">
			<label><strong class="commentNick">${comments.coswriter }</strong></label>
			<span style="word-break: break-all;font-size: 16px;">${comments.coscontent }</span>
			<!-- 대댓글 수정/삭제 버튼 -->
			<div class="buttons">
			<c:if test="${comments.coswriter == sessionScope.memnick }">
				<a href="javascript:void(0);" onclick="showUpdateCos('${comments.cosno}')">수정</a>
				<a href="javascript:void(0);" onclick="cosDelete('${comments.cosno }')">삭제</a>
			</c:if>
			</div>
			<div style="clear: both;"></div>
			<!-- 대댓글수정파트(토글) -->
				<div id="commentsUpdateDiv_${comments.cosno }" style="display:none;">
				<label id="showUpdateIdCos_${comments.cosno }" ><strong class="commentNick">${comments.coswriter }</strong></label>
				<input style="width:78%;" type="text" id="showUpdateCos_${comments.cosno }" value="${comments.coscontent }"></input>
				<a href="javascript:void(0);" onclick="cosUpdate('${comments.cosno}')">수정완료</a>
				</div>
			<!-- 대댓글수정파트(토글) -->
		 </c:if>
		</c:forEach>
	</div>
</c:forEach>