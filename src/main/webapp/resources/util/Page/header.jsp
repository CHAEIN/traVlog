<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/resources/css/header.css" rel="stylesheet">
<link href="/resources/css/search.css" rel="stylesheet">
</head>
<body>
<!-- Begin #header -->
<div class="header">
	
	<a class="logo" href="/traVlog/main.do"><img alt="traVlog" src="/resources/images/icon/logo.png" width="150px;"></a>
	
	<div class="search">
	 <input id="search" class="search__input" type="text" name="search" placeholder="Search" required="required">

	</div>
	<img id="searchBtn" alt="검색" src="/resources/images/icon/search.png">

	<a class="mypage" href="/traVlog/mypage.do?memnick=${memnick }"><img alt="마이페이지" src="/resources/images/icon/user.png" width="50px;"></a>
	<a class="find" href="/traVlog/followerfind.do"><img alt="친구찾기" src="/resources/images/icon/find.png" width="50px;"></a>
	<a class="feed" href="/traVlog/main.do"><img alt="피드" src="/resources/images/icon/feed.png" width="50px;"></a>
	<a class="write" href="/traVlog/write.do"><img alt="글쓰기" src="/resources/images/icon/write.png" width="50px;"></a>
	

</div><!-- // End #header -->

</body>
</html>