<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//String check = request.getParameter("check");
	String today= String.valueOf(request.getAttribute("today"));
	String total= String.valueOf(request.getAttribute("total"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<style> 
	body {  /* body 태그 부분 */
		background-color: #EEEEEE; 
		
	}
	#head_img {  /* 싸이월드 로고 부분 */
		position: relative; left: 8px;
		width: 60px; 
		top: 15px;
	}
	h1 {  /* HELLO WORLD 부분 */
		position: relative; left: 8px;
		font-size: 40px;
		display: inline;
		font-family: "Nanum Gothic";
		
	 }
	#top {  /* 싸이월드 로고 + HELLO WORLD */
		position: relative;
		left: 74%;
		transform: translate(-40%);
	}
	#wrap {  /* top 바로 밑에 내용 부분 */
		position: relative;
		left:55%;
		transform: translate(-20%);
	}
	#today {  /* today 박스 부분 */
		border: none;
		width: 300px;
		padding: 20px;
		background-color: #0096c6;
		color: white;
		border-radius: 15px;
		text-align: center;
	}
	#wrap>p>span {
		color: orange;
		
	}
	#hi { /* 헬로월드 미니홈피에 오신것을 환영합니다. */
		position: relative;
		left: 10px;
	}
	#kimhello {  /* 김헬로 박스 부분 */
		background-color: white;
		width: 340px;
		height: 200px;
		border-radius: 15px;
	}
	#character1 {  /* 캐릭터 이미지 */
		position: relative;
		width: 80px;
		left: 10px;
		top: 10px;
		border-radius: 20px;
	}
	#kim {  /* 김헬로 */
		position: relative;
		left: 20px;
		top: -80px;
		font-weight: bold;
	}
	#content1 {  /* 우리 그 때 헬로월드 여기는 여러분의 헬로월드입니다. */
		position: relative;
		left: 100px;
		top: -80px;
	}
	#content2 {  /* Today is.. */
		position: relative;
		left: 15px;
		top: -60px;
	}
	#sun {
		width: 30px;
	}
	#content2 span {
		color: #0096c6;
		font-weight: bold;
	}
	.btn {
		border: none;
		width: 300px;
		padding: 20px;
		background-color: #ff6939;
		color: white;
		border-radius: 15px;
		text-align: center;
	}
	.btn>span {
		right: -10px;
	}
	#youtube {
		position: relative;
		bottom: -40px;
	}
	#newComments {  /* 새로운 댓글을 보여주는 테이블 */
		position: relative;
		/* width: 230px;
		height: 50px;
		left: 95px;
		bottom: 90px;
		overflow:auto; 
		white-space: pre-wrap;
		word-break: break-all; */
	}
	#newComments a {
		text-decoration: none;
		color: orange;
	}
	#newCommentsDiv {
		border: 1px solid #E2E4E5;
		border-radius: 7px;
		height: 110px;
		width: 230px;
		overflow: auto;
		position: relative;
		left: 100px;
		bottom: 90px;
	}
	.header {
		border-bottom: 1px solid black;
	}
</style>

<body onload="today();">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	function today(){
		if(<%=today%>==null){
			location.href="todayController?a=6&u_idx="+${login.u_idx};
		}
	}
	function logOut() {
		let check = confirm('로그아웃 하시겠습니까?');
		if (check == true) {
			location.href = "LogOutController?u_idx="+${login.u_idx};
		}
	}
	
</script>

	<div id="top">
		<img id="head_img" src="images/helloworld_img.png" alt="hello world">
		<h1>HELLOWORLD</h1>
	</div>
	<div id="wrap">
		<p id="today">
		   TODAY<span>&nbsp;&nbsp;<%=today %></span>
		   &nbsp;&nbsp;| &nbsp;&nbsp;TOTAL &nbsp;&nbsp;&nbsp;&nbsp;
		   <span><%=total %></span>
		</p>
		<p id="hi">
			${login.nickname }님 방문을 환영합니다.
		</p>
		<div id="kimhello">
			<img id="character1" src="images/character1.png">
			<span id="kim">${login.nickname }</span>
			<p id="content1"> 새로운 댓글<br></p>
				<div id="newCommentsDiv">
				<table id="newComments">
					<c:if test="${not empty dlist }">
						<tr><td class="header">다이어리</td></tr>
						<c:forEach var="dvo" items="${dlist }">
							<tr>
							<td id="title"></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${not empty blist }">
						<tr><td class="header">게시글</td></tr>
						<c:forEach var="bvo" items="${blist }">
							<tr>
							<td id="title"><a href="BoardDetailController?b_idx=${bvo.b_idx}">${bvo.title }</a></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${not empty plist }">
						<tr><td class="header">사진첩</td></tr>
						<c:forEach var="pvo" items="${plist }">
							<tr>
							<td id="title"></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${not empty glist }">
						<tr><td class="header">방명록</td></tr>
						<c:forEach var="gvo" items="${glist }">
							<tr>
							<td id="title"></td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
				</div>
			<br>
		</div>
		<br>
		
		<div id="homepage" class="btn" OnClick='location.href="home.jsp?u_idx=${login.u_idx}"' style="cursor:pointer;" >
			내 미니홈피 가기
		</div>
		<br>
		
		<div id="find" class="btn" OnClick='location.href="findPeople.jsp"' style="cursor:pointer;">
			내 친구 찾기 
		</div>
		<br>
		
		<div id="logout" class="btn" OnClick="logOut()" style="cursor:pointer;">
			로그아웃
		</div>
		
		<div id="youtube">
			<iframe width="340" height="238" src="https://www.youtube.com/embed/WrUv_JyEatM" 
			title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; 
			clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
			allowfullscreen></iframe>
		</div>
	</div>
</body>
</html>