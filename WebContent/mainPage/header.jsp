<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:requestEncoding value="utf-8"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	/*기본 CSS 및 모바일*/
	#wrap_header{position:fixed; left:10%; top:0; display: flex; flex-flow: column;
					margin: 0 auto;	width: 80%; background-color: #F6F5EF; z-index: 3;}
		.logo{float: left; width: 50px; height: 50px; margin-top: 5px; margin-left: 5px;}
		.header_hr{width: 100%; max-width: 1200px;}
		.heaer_nav {float: right;}
		.header_ul{list-style: none;}
		.header_ul li{float: left; margin: 10px 15px 0px 5px;}
		#li{margin-left: 35%;}
		.header_ul a{text-decoration: none; color: black;}
	
	#test{height: 50px; background-color: rgba(255, 255, 255, 0);}
	
	/*PC용 CSS*/
	@media all and (min-width:960px){		
	#wrap_header{position:fixed; width:100%;  left: 0; z-index: 3;}/*위에서 설정하고 아래서 따로 설정안하면 그 설정 유지. 새로 설정하면 새로 설정한값 적용*/
		.logo{width: 100px; height: 100px; margin-top: 10px; margin-left: 10px;}
		.header_ul li{margin: 50px 20px 0px 15px;}
		#li{margin-left: 55%;}
	
	#test{height: 120px;}
		
</style>

</head>
<body>
<div id="wrap_header">
	<header>
		<img alt="brand_logo" src="../resources/images/starbucks_logo.png" class="logo" onclick="location.href='/MiniProject/mainPage/main.jsp'">
		<nav class="header_nav"><ul class="header_ul">
		
		<c:choose>		
			<c:when test="${sessionScope.loginSuccess == 'Yes' }">
			<li id="li"><a id="" href="">로그아웃</a></li>
			</c:when>
			<c:otherwise>
			<li id="li"><a id="" href="">로그인</a></li>
			</c:otherwise>
		</c:choose>	

		<li><a href="../menu/menu.jsp">메뉴</a></li>
		<li><a href="../news/news.jsp">공지사항</a></li></ul>
		</nav>
	</header>
	<hr class="header_hr">	
</div>
<section id="test"></section>

</body>
</html>
