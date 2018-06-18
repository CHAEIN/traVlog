<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>TraVlog</title>

<link href="/resources/css/main.css" rel="stylesheet">
<link href="/resources/css/FollowerContainer.css" rel="stylesheet">

<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

</head>
<script type="text/javascript">
$(document).ready(function(){
	$("#searchBtn").click(function(){
		var search = $("#search").val();
		console.log("검색버튼 눌렸고 search는 "+search);
		$.ajax({
			type:'get',
			url:'/traVlog/followerFindBySearch.do?search='+search,
			dataType:'html',
			success:function(data){
				console.log("아작스성공");
				$(".left").html(data);
			},error:function(e){
				console.log("아작스 에러");
			}
		});//ajax끝
	});
});


</script>
<body>
<div id="wrap">
		
<jsp:include page="/resources/util/Page/header.jsp" />

<div id="container"><!-- Begin #container -->
	<div class="content-wrap-ff">
		<div class="left">
		<strong class="title">알 수도 있는 사용자</strong>
		
		<c:if test="${cntRec eq 0 }">
		<div class="left_content">
		
			<span>아직 아무도 팔로잉하지 않으셨네요!<br>
			traVlog의 인기 사용자를 팔로잉 해보세요!</span>
			
				<table class="recomm">
	                <tbody>
		            <c:forEach items="${memList}" var="mem">
	                    <tr>
	                        <td class="Rimg" rowspan="2"><img alt="" src="/resources/images/icon/user.png"></td>
	                        <td class="memnick"><a href="#" class="memA">${mem.memnick}</a></td>
	                    </tr>
	                    <tr>
	                        <td class="memfollower">팔로워수가 무려 <strong>${mem.memfollower}명!</strong> 
	                        	<br>지금 인기 사용자를 팔로잉해보세요! </td>
	                    </tr>
		            </c:forEach>
	                </tbody>
		        	</table>
			</div>
		</c:if>
		
		<c:if test="${cntRec ne 0 }">
			<div class="left_content">
				<table class="recomm">
	                <tbody>
		            <c:forEach items="${recList}" var="rec">
	                    <tr>
	                        <td class="Rimg" rowspan="2" ><img alt="" src="/resources/images/icon/user.png"></td>
	                        <td><a href="#" class="recA">${rec.recommend}</a></td>
	                    </tr>
	                    <tr>
	                        <td class="Rnick">내가 팔로잉하고 있는 사람 <strong>${rec.worth}명</strong>이 팔로잉하고 있어요!</td>
	                    </tr>
		            </c:forEach>
	                </tbody>
		        	</table>
			</div>
		</c:if>
		</div>
		
		<div class="right">
		<strong class="title">나를 팔로잉하는 사용자</strong>
		
		<c:if test="${cntFol eq 0 }">
		<div class="right_content">
		
		<span>아직 팔로워가 없네요!<br>
		traVlog의 관리자를 팔로잉 해보세요!</span>
			
				<table class="recomm">
	                <tbody>
		            <c:forEach items="${adList}" var="ad">
	                    <tr>
	                        <td class="Rimg" rowspan="2"><img alt="" src="/resources/images/icon/user.png"></td>
	                        <td class="memnick"><a href="#" class="memA">${ad.memnick}</a></td>
	                    </tr>
	                    <tr>
	                        <td class="memfollower">팔로워수가 무려 <strong>${ad.memfollower}명!</strong> <br>
	                        		지금 traVlog 공식계정을 팔로잉해보세요! </td>
	                    </tr>
		            </c:forEach>
	                </tbody>
		        	</table>
			</div>
		</c:if>
		
		<c:if test="${cntFol ne 0 }">
			<div class="right_content">
				<table class="recomm">
	                <tbody>
		            <c:forEach items="${folList}" var="fol">
	                    <tr>
	                        <td class="Rimg" rowspan="2" ><img alt="" src="/resources/images/icon/user.png"></td>
	                        <td><a href="#" class="recA">${fol.memid}</a></td>
	                    </tr>
	                    <tr>
	                    <td class="Rnick">나를 팔로잉하는 사람이예요!</td>
	                    </tr>
		            </c:forEach>
	                </tbody>
		        	</table>
			</div>
		</c:if>
		</div>

	</div>	<!-- // End content-wrap -->
	</div> <!-- End container -->
	
</div>	<!-- // End #wrap -->
</body>

</html>