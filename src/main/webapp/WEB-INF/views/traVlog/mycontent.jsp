<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="pic">
	<c:forEach items="${selectContentPic }" var="p">
		<img class="viewpic" src="/resources/upload/${p.filsavefile }"
			alt="photo">
	</c:forEach>

	<button class="w3-button w3-black w3-display-left"
		onclick="plusDivs(-1)">&#10094;</button>
	<button class="w3-button w3-black w3-display-right"
		onclick="plusDivs(1)">&#10095;</button>
</div>

<div class="info">


	<div class="contents">
	
	<div class="dropdown">
    <button class="morebutton dropdown-toggle" id="menu1" type="button" data-toggle="dropdown">
    <img class="more" width="30px;" src="/resources/images/icon/more.png">
    </button>
    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
      <li role="presentation"><a role="menuitem" tabindex="-1" href="traVlog/update.do">수정</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">삭제</a></li>
      <li role="presentation" class="divider"></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">로그아웃</a></li>    
    </ul>
  </div>
	
	    <div class="user-card format-1-1 clearfix op-follow"
       >
      <div class="profile-picture left">
        <a href="/naeun9564" target="_blank">
          
            
    <img src="https://usercontents-c.styleshare.kr/images/25997874/40x40"
         width="40px" height="40px">
  
          
        </a>
      </div>
	
	     <div class="user-information nickname-alone">
        <div class="clearfix">
          <a class="nickname" href="/naeun9564" target="_blank">${selectContent.bodname }</a>

        </div>
        
    </div>
    
                <div class="scroll-bar-component op-scroll-bar-component">
              <div class="description-wrapper op-scrollable">
                <p class="description op-scroll-contents">
                ${selectContent.bodcontent }  내용 내용 내용 샬라샬라 
                </p>
              </div>
            </div>
    
	<div class="Bcomment">
		<label><strong class="commentNick">${sessionScope.memnick }</strong></label>
		<input type="text" id="comment_${selectContent.bodno }" name="comment"
			placeholder="댓글을 입력하세요 ..." style="width: 78%" required="required"></input>
		<a href="javascript:void(0);" id="commentBtn" style="width: 13%;"
			onclick="javacript:writeComment('${selectContent.bodno }')">입력</a> <br>
		<div class="showComment" id="showComment_${selectContent.bodno }"></div>
	</div>

</div>

 
</div>

        <div class="action">

 <div class="like-action op-like-action not-like"
               data-context="style_fullview"
               data-count="716"
               data-add-like-url="/me/likes/112280775?__method__=PUT"
               data-cancel-like-url="/me/likes/112280775?__method__=DELETE"
               data-like-url="/resources/images/icon/like.png">
            <button class="like-btn op-like-btn btn sprite"
                    data-update-count-target="< .op-like-action .op-list-of-likes"></button>
            <button class="list-of-likes op-list-of-likes op-likes-count op-show-user-list btn"
                    data-user-list-url="/naeun9564/112280775/likes"
                    data-modal-title-text="좋아요한 사용자"
                    data-get-url="/naeun9564/112280775/likes">716</button>
          </div></div>
          
          <div class="comment-wrapper op-comment-component">
           
           야오야오야오야오ㅑㅇ
           


           </div>  
          
</div>

      

<script>

var slideIndex = 1;
	showDivs(slideIndex);

	function plusDivs(n) {
	  showDivs(slideIndex += n);
	}

	function showDivs(n) {
	  var i;
	  var x = document.getElementsByClassName("viewpic");
	  if (n > x.length) {slideIndex = 1}    
	  if (n < 1) {slideIndex = x.length}
	  for (i = 0; i < x.length; i++) {
	     x[i].style.display = "none";  
	  }
	  x[slideIndex-1].style.display = "block";  
	}

</script>

