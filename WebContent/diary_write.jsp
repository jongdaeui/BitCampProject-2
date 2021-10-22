<%@page import="com.helloworld.vo.DiaryVO"%>
<%@page import="com.helloworld.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	
	MemberVO host = (MemberVO) session.getAttribute("host");
	System.out.println("diary_write.jsp  - host : " + host);
	int cPage;
	String cPage1 = request.getParameter("cPage");
	System.out.println("cPage1 : " + cPage1);
	if (cPage1 == null) {
		cPage = 0;
	} else {
		cPage = Integer.parseInt(request.getParameter("cPage"));
	}
	System.out.println("___cPage : " + cPage);
	request.setAttribute("cPage", cPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다이어리</title>
<link href="form.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
li:nth-child(3)>a {  /* 현재 페이지 버튼 스타일 변경 */
	background-color: white; color: black;
	border-left: none;
}
.diary {  /* 제목, 내용 공통 부분 */
	width: 510px;
	border: 1px solid #CAD2D5;
	border-radius: 5px;
	margin-left: 40px;
	padding-left: 15px;
	padding-right: 5px;
	padding-top: 10px;
}

#title2 {  /* 제목 부분 */
	margin-top: 15px;
	height: 20px;
	background-color: #f2f2f2;
	line-height: 10px;
	font-weight: bold;
}
#content {  /* 내용 부분 */
	padding-top: 20px;
	padding-bottom: 20px;
	height: auto;
	border-top: none;
	white-space: normal;
	word-break: break-all;
}

#btnDiv {  /* 버튼 부분 */
	margin-top: 15px;
	margin-bottom: -15px;
	position: relative;
	left: 77%;
}
#right3 { /* 다이어리 영역 스크롤 */
	overflow: auto;
	overflow-x:hidden;
} 

#btnDiv a {  /* 저장 , 목록 a 태그 부분 */
	text-decoration: none;
	color: orange;
	margin-left: 10px;
	margin-bottom: 0;
}

/* 입력창 부분 */
#title_content, #write_content { 
	width: 510px;
	margin: -15px;
	border: none;
	background: transparent;
	outline: none; 
	padding: 0px 10px;
}

</style>
<body>
<script>
function sendData() {
	var firstForm = document.forms[0];/* 폼객체 비었을때 알림 */
	for (let i = 0; i < firstForm.elements.length; i++) {
		if (firstForm.elements[i].value.trim() == "") {
			alert(firstForm.elements[i].title + "을 입력하세요");
			firstForm.elements[i].focus();
			return;
		}
	}		
	firstForm.submit();		
	alert("등록 완료");
}

function list_go() {
	location.href = "DiaryListController?cPage=<%=cPage %>";		
}	
	
</script>


<div id="wrap">
	<div id="wrap1">
		<div id="left1" class="box1">
			<div id="left2" class="box2">
				<div id="today">
					TODAY <span style="color:#EE5D1A; font-size:13px;">${today }</span> | TOTAL <span style="font-size:13px;">${total }</span>
				</div>
				
				<div id="left3" class="box3">
					<div id="todayIs">
						TODAY IS...
					</div>
					<div id="characterbox">
						<img id="character" src="images/character2.jpg" alt="character">
					</div>
				</div>
				<!-- left3 -->
			</div>
			<!-- left2 -->
		</div>
		<!-- left1 -->
		<!-- ----------------- 좌측 끝 ----------------- -->
		
		<div id="right1" class="box1">
			<div id="right2" class="box2">
				<div id="nickname">
					${host.nickname } 님의 홈페이지입니다.
				</div>	
				<div id="openBtnDiv" OnClick="location.href='open.jsp'" style="cursor:pointer;">
					<img id="helloImg" src="images/helloworld2.png" alt="헬로월드">
					<span>메인으로</span>
				</div>
				<div id="right3" class="box3">
					<div id="title">
						다이어리
					</div>				
					<form action="DiaryWriteOkController?cPage=${cPage }" method="post" >	
						<div id="title2" class="diary">
							<input type="text" id="title_content" name="title" title="제목" placeholder="제목" maxlength="30">				
						</div>					
						<div id="content" class="diary">
							<textarea id="write_content" name="content" rows="17" cols="50" title="내용" placeholder="내용"></textarea>
						</div>
						<div id="btnDiv">
							<a href="#" onclick="sendData()">저장</a>
							<a href="#" onclick="list_go()">목록</a>
						</div>				
					</form>	
				</div>
				<!-- right3 -->
			</div>
			<!-- right2 -->
		</div>
		<!-- right1 -->
		
		<ul id="navigation">
			<li><a href="home.jsp?u_idx=${host.u_idx }">홈</a></li>
			<li><a href="profile.jsp">프로필</a></li>
			<li><a href="DiaryListController">다이어리</a></li>
			<li><a href="BoardAllController">게시판</a></li>
			<li><a href="photo.jsp">사진첩</a></li>
			<li><a href="GetAllCommand">방명록</a></li>
		</ul>
	</div>
	<!-- wrap1 -->
</div>
<!-- wrap -->
</body>
</html>