<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<!-- BoardList 시작 -->
<div>

	<c:forEach items="${boardList }" var="board" varStatus="listNumber"
		begin="0" end="${count }">
		<%--          <c:forEach items="${boardList }" var="board" varStatus="listNumber">    --%>
		<div class="board">
			<input type="hidden" id="bodno_${board.bodno }" name="bodno"
				value="${board.bodno }">
			<div class="memInfo">
				<!--      정민   06.13 게시글별 프로필 이미지 넣기 완료 -->
				<c:forEach items="${profileList}" var="Bprofile">
					<c:if test="${Bprofile.pfSavefile != null }">
						<img class="userimg"
							src="/resources/upload/${Bprofile.pfSavefile }">
					</c:if>
					<c:if test="${Bprofile.pfSavefile == null }">
						<img class="userimg" src="/resources/upload/icon/user.png">
					</c:if>
				</c:forEach>
				<strong class="nick">${board.bodname }</strong> <a
					href="/traVlog/claim.do?bodno=${board.bodno }"
					id="claim_${board.bodno }"
					onclick="claim(this.href,'name','600','400','yes',${board.bodno});return false"><img
					class="claim" alt="신고하기" src="/resources/images/icon/claim.png"></a>
			</div>

			<div class="boardInfo">
				<strong class="title">${board.bodtitle }</strong>
				<c:if test="${board.startdate != null && board.enddate!=null }">
					<span class="Bdate"> <img class="calender"
						src="/resources/images/icon/calender.png"> ${board.startdate }
						<img class="airplane" src="/resources/images/icon/airplane.png">
						${board.enddate }
					</span>
				</c:if>
			</div>

			<!--             06.14 정민 이미지, 동영상 처리 -->

			<div class="boardImg">
				<c:forEach items="${filesList }" var="files" varStatus="listNumber">
					<c:if test="${files.filsavefile != null }">
						<c:if test="${board.bodno == files.bodno }">
							<c:set var="filetype" value="${files.filtype }" />
							<c:if test="${fn:contains(filetype, 'image')}">
								<img id="img_${files.filsavefile }" class="viewpic"
									src="/resources/upload/${files.filsavefile }" alt="photo">
							</c:if>
							<c:if test="${fn:contains(filetype, 'video')}">
								<video id="video_${files.filsavefile }" class="contentImg"
									src="/resources/upload/${files.filsavefile }" controls></video>
							</c:if>
						</c:if>
					</c:if>
				</c:forEach>
			</div>


			<div class="icon">
				<!-- 좋아요 기능  -->
				<button id="recoBtn_${board.bodno}" class="btnRecommend"
					onclick="recommend(${board.bodno });">
					<c:if test="${board.isExistsLikeData eq '1'}">
						<img id="like_${board.bodno}" class="like" width="30px;"
							src="/resources/images/icon/liked.png">
					</c:if>
					<c:if test="${board.isExistsLikeData eq '0'}">
						<img id="like_${board.bodno}" class="like" width="30px;"
							src="/resources/images/icon/like.png">
					</c:if>
				</button>

				<button>
					<img class="comm" width="30px;"
						src="/resources/images/icon/comment.png">
				</button>

				<!-- 보관기능 -->
				<button id="pinBtn_${board.bodno}" class="btnPin"
					onclick="pin(${board.bodno });">
					<c:if test="${board.isExistsPinData eq '1'}">
						<img id="pin_${board.bodno}" class="pin" width="30px;"
							src="/resources/images/icon/pined.png">
					</c:if>
					<c:if test="${board.isExistsPinData eq '0'}">
						<img id="pin_${board.bodno}" class="pin" width="30px;"
							src="/resources/images/icon/pin.png">
					</c:if>
				</button>
			</div>

			<div class="Bcontent">
				<label>좋아요 <strong id="recommend_${board.bodno }">${board.recommendCnt }</strong>
					개
				</label>
				<p class="Rcontent">${board.bodcontent }</p>
				<c:forTokens items="${board.bodhashtag }" delims="#" var="item">
					<a href="javascript:void(0);"
						onclick="javascript:searchTag('${item}');" class="tag">#${item}</a>
				</c:forTokens>
			</div>
			<!-- 댓글 작성 시작 2018.06.09 -->

			<div class="Bcomment">
				<label><strong class="commentNick">${sessionScope.memnick }</strong></label>
				<input type="text" id="comment_${board.bodno }" name="comment"
					placeholder="댓글을 입력하세요 ..." style="width: 78%" required="required"></input>
				<a href="javascript:void(0);" id="commentBtn" style="width: 13%;"
					onclick="javacript:writeComment('${board.bodno}')">댓글입력</a> <br>
				<div class="showComment" id="showComment_${board.bodno }"></div>
				<a id="showCommentBtn_${board.bodno }" href="javascript:void(0);"
					onclick="showCommentBtn('${board.bodno}')">댓글보기</a>
			</div>

		</div>
	</c:forEach>
	<!-- boardList 끝 -->

</div>
