<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TraVlog</title>

<link href="/resources/css/main.css" rel="stylesheet">
<link href="/resources/css/mainContainer.css" rel="stylesheet">
<link href="/resources/css/mylist.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://staticassets-a.styleshare.kr/1ea27d2f8b/css/web.scss.css" />


<script type="text/javascript"
   src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<style type="text/css">
.showComment{
    overflow-x: hidden;
    overflow-y: scroll;
    max-height: 550px;
}
.commentNick{
	font-size: 19px; 
	padding-right: 10px;
}
</style>
<script type="text/javascript">
var bodno;
var stmnLEFT = 10; // 오른쪽 여백 
var stmnGAP1 = 0; // 위쪽 여백 
var stmnGAP2 = 10; // 스크롤시 브라우저 위쪽과 떨어지는 거리 
var stmnBASE = 10; // 스크롤 시작위치 
var stmnActivateSpeed = 35; //스크롤을 인식하는 딜레이 (숫자가 클수록 느리게 인식)
var stmnScrollSpeed = 1000; //스크롤 속도 (클수록 느림)
var stmnTimer; 
  
  function RefreshStaticMenu() {
     var stmnStartPoint, stmnEndPoint;
     stmnStartPoint = parseInt(
           document.getElementById('STATICMENU').style.top, 10);
     stmnEndPoint = Math.max(document.documentElement.scrollTop,
           document.body.scrollTop)
           + stmnGAP2;
     if (stmnEndPoint < stmnGAP1)
        stmnEndPoint = stmnGAP1;
     if (stmnStartPoint != stmnEndPoint) {
        stmnScrollAmount = Math.ceil(Math
              .abs(stmnEndPoint - stmnStartPoint) / 15);
        document.getElementById('STATICMENU').style.top =
           parseInt(document.getElementById('STATICMENU').style.top, 10) + ((stmnEndPoint < stmnStartPoint) ? -stmnScrollAmount
                    : stmnScrollAmount) + 'px';
        stmnRefreshTimer = stmnScrollSpeed;
     }
     stmnTimer = setTimeout("RefreshStaticMenu();", stmnActivateSpeed);
  }
  function InitializeStaticMenu() {
     document.getElementById('STATICMENU').style.right = stmnLEFT + 'px'; //처음에 오른쪽에 위치. left로 바꿔도.
     document.getElementById('STATICMENU').style.top = document.body.scrollTop
           + stmnBASE + 'px';
     RefreshStaticMenu();
  }

   function recommend(a){
      var bodno = a;
         console.log("bodno : "+bodno);
         $.ajax({
             type: "get"
             , url: "/traVlog/recommend.do"
             , dataType: "json"
             , data: {
               bodno: bodno
             }
             , success: function(data) {
                console.log(data);

                if(data.result) {
                   $("#like_"+a).prop("src", "/resources/images/icon/liked.png");
                } else {
                   $("#like_"+a).prop("src", "/resources/images/icon/like.png");
                }
                console.log("AJAX a : "+a);
                console.log(data.recommend);
                $("#recommend_"+a).html(data.recommend);
                
             }
             , error: function(e) {
                alert("좋아요 실패. 다음에 이용해주세요.");
                console.log(e.responseText);
             }
          });
   }//function recommend(a) 끝

   function pin(a){
      var bodno = a;
      console.log("bodno : "+bodno);
      $.ajax({
          type: "get"
          , url: "/traVlog/pin.do"
          , dataType: "json"
          , data: {
            bodno: bodno
          }
          , success: function(data) {
             console.log(data);
             

             if(data.result) {
                $("#pin_"+a).prop("src", "/resources/images/icon/pined.png");
             } else {
                $("#pin_"+a).prop("src", "/resources/images/icon/pin.png");
             }
             console.log("AJAX a : "+a);
             console.log(data.pin);
               $("#pin_"+a).html(data.pin);
             
          }
          , error: function(e) {
             alert("보관 실패. 다음에 이용해주세요.");
             console.log(e.responseText);
          }
       });
   }//function pin(a) 끝

// boardList 갯수 2개씩 추가하기.. +무한스크롤과 ajax 이용해서
var count = ${count};
$(document).ready(function () {
   
 //header.jsp에 있는 검색버튼
   $("#searchBtn").click(function(){
      count =2;
      var search = $("#search").val();
      console.log("검색할 태그 :"+search);
      
      $.ajax({
           type:'GET',
           url:'/traVlog/addBoardList.do',
             dataType:'html',
             data:{"count":count , "search":search},
             success : function(data){
                $("#main").html(data);
             },error:function(data){
                alert("실패");
             }
         }); // ajax 끝
   });
   
   $(document).scroll(function() {
       var maxHeight = $(document).height();
       var currentScroll = $(window).scrollTop() + $(window).height();

       if (maxHeight <= currentScroll+100) {
          var search = $("#search").val();
            console.log("search : "+$("#search").val());
          console.log("스크롤 도달")
           // Append next contents
           //검색 기능 중
           if($("#search").val() != null || $("#search").val() != ""){
              console.log("search 값 존재");
               
              $.ajax({
                  type:'GET',
                  url:'/traVlog/addBoardList.do?search='+search,
                    dataType:'html',
                    data:{"count":count },
                    success : function(data){
                       $("#main").html(data);
                       count += 2;
                       console.log(count);
                    },error:function(data){
                       alert("실패");
                    }
                }); // ajax 끝
           }
           else if($("#search").val() == null || $("#search").val() == ""){
              //일반 페이지 (not 검색)
            $.ajax({
              type:'GET',
              url:'/traVlog/addBoardList.do',
                dataType:'html',
                data:{"count":count},
                success : function(data){
                   $("#main").html(data);
                   count += 2;
                   console.log(count);
                },error:function(data){
                   alert("실패");
                }
            });//ajax 끝
           } //else 끝
       }//스크롤 바닥찍은거 끝
     });
   });

   var win= null;
   function claim(mypage,myname,w,h,scroll,bodno){
      var claimBodno = bodno;
      console.log("claimBodno : "+claimBodno);
     var winl = (screen.width-w)/2;
     var wint = (screen.height-h)/2;
     var settings  ='height='+h+',';
         settings +='width='+w+',';
         settings +='top='+wint+',';
         settings +='left='+winl+',';
         settings +='scrollbars='+scroll+',';
         settings +='resizable=yes';
     win=window.open(mypage,myname,settings);
     if(parseInt(navigator.appVersion) >= 4){win.window.focus();}
   }

   function searchTag(a){
    var search = a;
	$("#search").val(search);
    count = 2;
    console.log("실행 검색어: "+search);
    
     $.ajax({
          type:'GET',
          url:'/traVlog/addBoardList.do?search='+search,
            dataType:'html',
            data:{"count":count},
            success : function(data){
               $("#main").html(data);
            },error:function(data){
               alert("실패");
            }
        }); // ajax 끝
   }
   //댓글 작성function
   function writeComment(bodnumber){
      console.log(bodnumber);
      bodno = bodnumber;
      console.log($("#comment_"+bodno).val());
      var comContent = $("#comment_"+bodno).val();
      
      if(comContent == "" || comContent==null){
         alert("댓글을 입력하세요..");
      }
      else{
      //댓글 작성 ajax...
         $.ajax({
            type:'get',
            url:'/traVlog/writeComment.do',
            dataType:'html',
            data:{"bodno":bodno, "comcontent":comContent},
            success : function(data){
                  console.log("성공?");
                     $("#showComment_"+bodno).html(data);
                     $("#showCommentBtn_"+bodno).text("댓글안보기");
                  },error:function(data){
                     alert("실패");
                  }
         });//ajax end
      }
   }
   //댓글 보여주기
   function showCommentBtn(bodnumber){
      console.log(bodnumber);
      bodno = bodnumber;
      var showStatus = $("#showCommentBtn_"+bodno).text();
      console.log($("#showCommentBtn_"+bodno).text());
      if(showStatus == "댓글보기"){
         $.ajax({
            type:'get',
            url:'/traVlog/writeComment.do',
            dataType:"html",
            data:{"bodno":bodno},
            success :function(data){
               console.log("성공?");
                  $("#showComment_"+bodno).html(data);
                  $("#showCommentBtn_"+bodno).text("댓글안보기");
            },error :function(e){
               alert("댓글이 없습니다. 댓글을 달아주세요!");
            }
         });//ajax 끝
      }else{//댓글감추기일때
         $("#showComment_"+bodno).html(" ");      
         $("#showCommentBtn_"+bodno).text("댓글보기");
      }
   }
 
//  댓글 업데이트
 function comUpdate(comno){
   console.log("수정버튼 눌림");
   var content = $("#showUpdateTag_"+comno).val();
   var commentDo = 'update';
   if(content == "" || content==null){
      alert("내용을 입력하세요..");
   }else{
      $.ajax({
         type:'get',
         url:'/traVlog/writeComment.do',
         data:{"comno":comno,"comcontent":content,"commentDo":commentDo,"bodno":bodno},
         dataType:"html",
         success:function(data){
             console.log("수정 성공");
            $("#showComment_"+bodno).html(data);
         },error:function(e){
             alert("실패");
         }
      });
   }//else 끝
 }
 //댓글 삭제
 function comDelete(comno){
    console.log("삭제버튼 눌림 comno: "+comno+"bodno:"+bodno);
    var commentDo = 'delete';
    $.ajax({
       type:'get',
       url:'/traVlog/writeComment.do',
       data:{"comno":comno,"commentDo":commentDo,"bodno":bodno},
       dataType:"html",
       success:function(data){
            $("#showComment_"+bodno).html(data);
          console.log("삭제 성공");
       },error:function(e){
           alert("삭제버튼 실패");
       }
    });
 }
//대댓글 파트 시작 ..
//대댓글 작성 (insert)
   function writeComments(comno){
      
      console.log(comno);
      console.log($("#comments_"+comno).val());
      var coscontent = $("#comments_"+comno).val();
      if(coscontent =="" || coscontent == null){
         alert("대댓글(답글)을 입력하세요..");
      }else{
         $.ajax({
            type:'get',
            url:'/traVlog/writeComment.do',
            data:{"comno":comno, "coscontent":coscontent,"bodno":bodno},
            dataType:'html',
            success:function(data){
               $("#showComment_"+bodno).html(data);
               console.log("대댓글 입력 성공");
            },error:function(e){
               alert("대댓글 입력 오류");
            }
         });//ajax끝
      }
   }
   
   //대댓글 삭제
    function cosDelete(cosno){
       console.log("삭제버튼 눌림 cosno: "+cosno+"bodno:"+bodno);
       var commentsDo = 'delete';
       $.ajax({
          type:'get',
          url:'/traVlog/writeComment.do',
          data:{"cosno":cosno,"commentsDo":commentsDo,"bodno":bodno},
          dataType:"html",
          success:function(data){
               $("#showComment_"+bodno).html(data);
             console.log("대댓글 삭제 성공");
          },error:function(e){
              alert("삭제버튼 실패");
          }
       });
    }
 
    function cosUpdate(cosno){
         console.log("대댓글 수정버튼 눌림");
         var content = $("#showUpdateCos_"+cosno).val();
         var commentsDo = 'update';
         if(content == "" || content==null){
            alert("내용을 입력하세요..");
         }else{
            $.ajax({
               type:'get',
               url:'/traVlog/writeComment.do',
               data:{"cosno":cosno,"coscontent":content,"commentsDo":commentsDo,"bodno":bodno},
               dataType:"html",
               success:function(data){
                   console.log("대댓글 수정 성공");
                  $("#showComment_"+bodno).html(data);
               },error:function(e){
                   alert("실패");
               }
            });
         }//else 끝
       }
 //대댓글 파트 끝
 
 
 // 화면 넘기기 페이징 <><><>
 
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


</head>

<body onload="InitializeStaticMenu();">
	<div id="wrap">

		<jsp:include page="/resources/util/Page/header.jsp" />
		<div id="container">
			<!-- Begin #container -->
			<div class="content-wrap-main">
				<div class="main" id="main">
					<!-- BoardList 시작 -->

					<c:forEach items="${boardList }" var="board" varStatus="listNumber"
						begin="0" end="2">
						<div class="board">
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
										src="/resources/images/icon/calender.png">
										${board.startdate } <img class="airplane"
										src="/resources/images/icon/airplane.png">
										${board.enddate }
									</span>
								</c:if>
							</div>
							<!--             06.14 정민 이미지, 동영상 처리 -->

							<div class="boardImg">
								<c:forEach items="${filesList }" var="files"
									varStatus="listNumber">
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

							<div class="Bcontent">
								<label>좋아요 <strong id="recommend_${board.bodno }">${board.recommendCnt }</strong>
									개
								</label>
								<p class="Rcontent">${board.bodcontent }</p>

								<c:forTokens items="${board.bodhashtag }" delims="#" var="item">
									<a href="javascript:void(0);" onclick="javascript:searchTag('${item}');" class="tag">#${item}</a>
								</c:forTokens>

								<!-- 댓글 작성 시작 2018.06.09 -->
								<div class="Bcomment">
									<label><strong class="commentNick">${sessionScope.memnick }</strong></label>
									<input type="text" id="comment_${board.bodno }" name="comment"
										placeholder="댓글을 입력하세요 ..." style="width: 78%"
										required="required"></input> <a href="javascript:void(0);"
										id="commentBtn" style="width: 13%;"
										onclick="javacript:writeComment('${board.bodno}')">댓글입력</a> <br>
									<div class="showComment" id="showComment_${board.bodno }">

									</div>
									<a id="showCommentBtn_${board.bodno }"
										href="javascript:void(0);"
										onclick="showCommentBtn('${board.bodno}')">댓글보기</a>
								</div>

							</div>

						</div>
						</div>
					</c:forEach>
					<!-- boardList 끝 -->

				</div>

				<div class="right" id="STATICMENU">

					<div class="user">
						<!--      정민   06.13 프로필 이미지 넣기 완료 -->
						<c:forEach items="${profile}" var="profile">
							<c:if test="${profile.pfSavefile != null }">
								<img class="userimg"
									src="/resources/upload/${profile.pfSavefile }">
							</c:if>
							<c:if test="${profile.pfSavefile == null }">
								<img class="userimg" src="/resources/upload/icon/user.png">
							</c:if>
						</c:forEach>

						<c:forEach items="${memberInfo}" var="member">
							<span class="nick">${member.memnick}</span>
							<br>
							<span class="id">${member.memid}</span>
						</c:forEach>
					</div>

					<strong>인기 해시태그</strong><br>
         <div class="hashTag">
            <table class="topTag">
               <c:forEach items="${tagList}" var="tag">
                <tbody>
                    <tr>
                        <td class="tagname"><a href="#" onclick="javascript:searchTag('${tag.tagname}');" class="tagA">#${tag.tagname}</a>
                        <td class="taghit">${tag.taghit}</td>
                    </tr>
                </tbody>
               </c:forEach>
              </table>
         </div>
         
         <strong>인기 사용자</strong><br>
         <div class="follower">
         <table class="topMember">
               <c:forEach items="${memberList}" var="mem">
                <tbody>
                    <tr>
                        <td class="memnick"><a href="#" class="memA">${mem.memnick}</a></td>
                        <td class="memfollower">${mem.memfollower}</td>
                    </tr>
                </tbody>
               </c:forEach>
              </table>
					</div>
					<div class="goTop" onclick="window.scrollTo(0,0);">TOP</div>
				</div>
				<!-- End Right -->

			</div>
			<!-- // End content-wrap -->
		</div>
		<!-- End container -->

	</div>
	<!-- // End #wrap -->
</body>

</html>