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
	#wrap_news{display: flex; flex-flow: column; margin: 0 auto; width: 80%; max-width: 1200px;}
	.table_fram{text-align: center; table-layout: 80%; width:90%; font-size: 13px; margin: 0 auto;}
	
	/*테이블 내부 선*/
	#intableHr{background-color: black; height: 1px;}
	/*테이블 내부 제목 링크*/
	#intableA{text-decoration: none; color: black;}
	
	/*PC용 CSS*/
	@media all and (min-width:960px){		
	#wrap_news{position:relative; width:80%;}/*위에서 설정하고 아래서 따로 설정안하면 그 설정 유지. 새로 설정하면 새로 설정한값 적용*/
	.table_fram{text-align: center; table-layout: 80%; width:70%; font-size: 15px;}
	
</style>

</head>
<body>

<jsp:useBean id="dao" class="members.newsDAO"/>
<%-- 페이징 --%>
<c:set var="totalPage" value="${dao.getTotalPage() }"/>	
<c:set var="pageResult" value="${dao.page(totalPage) }"/>

<jsp:include page="../mainPage/header.jsp"/>
<div id="wrap_news">

<h2>공지사항</h2>
<table class="table_fram">
		<tr><td colspan="4"><hr id="intableHr"  noshade="noshade"></td></tr>
		<tr>	<th>No</th><th>제목</th><th>날짜</th><th>조회수</th>		</tr>
		<tr><td colspan="4"><hr id="intableHr"  noshade="noshade"></td></tr>	
		
		<c:forEach var="dto" items="${dao.list(param.start) }">
		<tr>
			<td id="td_center">${dto.id }</td>
			<td style="text-align: left;"><a id="intableA" href="content_view.jsp?id=${dto.id }">${dto.title }</a></td>
			<td><fmt:formatDate value="${dto.savedate}" pattern="yyyy.MM.dd" /></td>
			<td id="td_right">${dto.hit }</td>
		</tr>
		<tr><td colspan="4"><hr></td></tr>
		</c:forEach>
		<%-- 페이징 --%>
			<tr><td colspan="4" align="center">
				<c:choose>
					<c:when test="${param.start == null }">	<%--페이지를 처음 들어온거면 1페이지로 --%>
						<c:set var="start" value="1"/>
					</c:when>
					<c:otherwise>
						<c:set var="start" value="${param.start }"/>	<%--특정 페이지로 들어온거면 그 페이지로 --%>
					</c:otherwise>
				</c:choose>
				
		<%-- 페이징 --%>
				<%--이전 버튼. 현 페이지에서 -1. 1이면 버튼 비활성화 --%>
				<c:choose>
					<c:when test="${start > 1 }">
						<button type="button" style="margin-right: 5px; visibility: visible;" onclick="location.href='news.jsp?start=${start-1}'">이전</button>
					</c:when>
					<c:otherwise>
						<button type="button" style="margin-right: 5px; visibility: hidden;">이전</button>
					</c:otherwise>
				</c:choose>
				
				<%--페이지 목록 --%>
				<c:forEach begin="1" end="${pageResult }" step="1" var="cnt">
					<a href="news.jsp?start=${cnt }" 
					style="text-decoration: ${start == cnt ? 'underline' : 'none'}; 
					color: ${start == cnt ? 'black' : 'gray'};"> &nbsp; ${cnt }&nbsp; </a>
				</c:forEach>
				
				<%--다음 버튼. 현 페이지에서 +1. 마지막이면 버튼 비활성화 --%>
				<c:choose>
					<c:when test="${start < pageResult }">
						<button type="button" style="margin-left: 5px; visibility: visible;" onclick="location.href='news.jsp?start=${start+1}'">다음</button>
					</c:when>
					<c:otherwise>
						<button type="button" style="margin-left: 5px; visibility: hidden;">다음</button>
					</c:otherwise>
				</c:choose>
				
				<%--현재 페이지 표시 --%>
				${start } / ${pageResult }				
			</td></tr>
	</table>

</div>
<jsp:include page="../mainPage/footer.jsp"/>

</body>
</html>