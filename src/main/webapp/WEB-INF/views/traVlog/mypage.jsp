<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TraVlog Mypage</title>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
	
<link href="/resources/css/main.css" rel="stylesheet">
<link href="/resources/css/mypage.css" rel="stylesheet">
<link href="/resources/css/mylist.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://staticassets-a.styleshare.kr/1ea27d2f8b/css/web.scss.css" />


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>



</head>

<body>

	<div id="wrap">

		<jsp:include page="/resources/util/Page/header.jsp" />

		<div id="container">
			<!-- Begin #container -->
			<div class="content-wrap">
				<div class="top">
					<div class="userProfile">
						<img class="userimg" src="/resources/images/icon/user.png">
						<button class="profilebtn"
							onclick="location.href='settingprofile.do'">프로필 편집</button>
						<div class="usernick">${selectMember.memnick }</div>
						<div class="setting">
							<a href="message.do"><img class="messageimg"
								src="/resources/images/icon/message.png"></a><br>
						</div>
						<div class="userinfo">아몰랑 여기는 소개적는 칸. 글자수 제한을 두는것이 좋겠어요 한
							80글자 정도로??? 내려온다. 대한 물방아 수 사람은 귀는 튼튼하며, 어디 살 아름다우냐? 피어나기 되려니와, 뼈
							오아이스도 스며들어 풍부</div>
					</div>

					<div class="userfollower">

						<div class="following">
							<strong>${selectMember.memfollwing }</strong><br /> <span>팔로우</span>
						</div>
						<div class="follower">
							<strong>${selectMember.memfollower }</strong><br /> <span>팔로워</span>
						</div>
						<div class="boardImg">
							<strong>1</strong><br /> <span>게시글</span>
						</div>

						<div class="setting">
							<a href="settingprofile.do"><img class="settingimg"
								src="/resources/images/icon/setting.png"></a><br>
						</div>
	
					</div>
				</div>

				<div class="buttom">

					<div class="mylist-content">
						<div class="row">

							<c:forEach items="${selectpic }" var="i">
								<c:if test="${i.bodno != null }">
									<div class="pic col-md-4">
										<a href="no${i.bodno }" onclick="contentview(${i.bodno });">
											<img class="pic-src"
											src="/resources/upload/${i.filsavefile }" alt="photo">
										</a>
									</div>
								</c:if>
							</c:forEach>


						</div>
					</div>

				</div>

			</div>
			<!-- // End content-wrap -->
		</div>
		<!-- End container -->

	</div>
	<!-- // End #wrap -->

	<div class="setLayer">

		<div class="mask"></div>
		<div class="window"></div>

	</div>

</body>

<script type="text/javascript">

	function wrapWindowByMask() {
		// 화면의 높이와 너비를 변수로 만듭니다.
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();

		// 마스크의 높이와 너비를 화면의 높이와 너비 변수로 설정합니다.
		$('.mask').css({
			'width' : maskWidth,
			'height' : maskHeight
		});

		// fade 애니메이션 : 1초 동안 검게 됐다가 80%의 불투명으로 변합니다.
		$('.mask').fadeIn(500);
		$('.mask').fadeTo("slow", 0.5);

		// 레이어 팝업을 가운데로 띄우기 위해 화면의 높이와 너비의 가운데 값과 스크롤 값을 더하여 변수로 만듭니다.
		var left = ($(window).scrollLeft() + ($(window).width() - $('.window')
				.width()) / 2);
		var top = ($(window).scrollTop() + ($(window).height() - $('.window')
				.height()) / 2);

		// css 스타일을 변경합니다.
		$('.window').css({
			'left' : left,
			'top' : top,
			'position' : 'absolute'
		});
		
		

		// 레이어 팝업을 띄웁니다.
		$('.window').show();
	}

	$(document).ready(function() {
		// showMask를 클릭시 작동하며 검은 마스크 배경과 레이어 팝업을 띄웁니다.
		$('.pic-src').click(function(e) {
			
			// preventDefault는 href의 링크 기본 행동을 막는 기능입니다.
			e.preventDefault();
			wrapWindowByMask();
			
		});

		// 닫기(close)를 눌렀을 때 작동합니다.
		$('.window .close').click(function(e) {
			e.preventDefault();
			$('.mask, .window').hide();
		});

		// 뒤 검은 마스크를 클릭시에도 모두 제거하도록 처리합니다.
		$('.mask').click(function() {
			$(this).hide();
			$('.window').hide();
		});
		
// 		$("a").click(function() {
// 			$("#"+$(this).attr("href")).show();
// 			alert('실행대씀');
// 			return false;
// 		});
	});
	
	function contentview(a){
		   var bodno = a;
		      console.log("bodno : "+bodno);
		      $.ajax({
		          type: "get"
		          , url: "/traVlog/mycontent.do"
		          , dataType: "html"
		          , data: {
		            bodno: bodno
		          }
		          , success: function(data) {
		    
		             $(".window").html(data);
		             
		          }
		          , error: function(e) {
		        	  alert("ajax실패");

		          }
		       });
		
		}
	
	
	
	

</script>

</html>