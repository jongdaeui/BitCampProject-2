<%@page import="java.net.InetAddress"%>
<%@page import="com.helloworld.dao.MemberDAO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.helloworld.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String u_idx = request.getParameter("u_idx");
	//넘어온 u_idx값으로 host객체 생성
	MemberVO mvo = MemberDAO.selectByIdx(u_idx);
	session.setAttribute("host", mvo);
	
	//비회원으로 홈페이지 들어왔을 때 login객체가 생성되지 않으므로
	//임시 login객체를 만든다.
	MemberVO lvo = (MemberVO)session.getAttribute("login");
	System.out.println("home lvo : " + lvo);
	if (lvo == null) {
		lvo = new MemberVO(-1);
		session.setAttribute("login", lvo);
	}
	
	// ----------- today 데이터 --------------
	InetAddress local = InetAddress.getLocalHost();
	String ip = local.getHostAddress();

	//홈페이지 접속했을때 한번만 실행
	//홈페이지 접속했을때 exist는 null 
	//controller처리를 하고 돌아오면 exist는 DB추가했으면 1 안했으면 0
	String exist= String.valueOf(request.getAttribute("existIp"));
	String today= String.valueOf(request.getAttribute("today"));
	String total= String.valueOf(request.getAttribute("total"));


	System.out.println("home.jsp에 돌려준 DB저장했으면1 아니면0:"+exist);
	System.out.println("home.jsp에 돌려준 today값:"+today);
	System.out.println("home.jsp에 돌려준 total값:"+total);
	session.setAttribute("today",today);
	session.setAttribute("total",total);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈페이지</title>
</head>
<link href="form.css" rel="stylesheet" type="text/css" />
<style>
#navigation>li:first-child>a {  /* 현재 페이지 버튼 스타일 변경 */
	background-color: white; color: black;
	border-left: none;
}

.update {  /* 최근게시물 밑에 사진첩, 게시판 공통 부분 */
	width: 70px;
	height: 25px;
	border: none;
	border-radius: 7px;
	text-align: center;
	margin-left: 40px;
	font-weight: bold;
	color: white;
}
#newDiary {
	margin-top: 8px;
	margin-bottom: 8px;
	background-color: #92D1F0;
}
#newPhoto {
	margin-top: 8px;
	margin-bottom: 8px;
	background-color: #F08DB3;
}
#newBoard {
	margin-top: 8px;
	margin-bottom: 8px;
	background-color: #55E5D0;
}
#newGuestBook {
	margin-top: 8px;
	margin-bottom: 8px;
	background-color: #E891F0;
}
#homeimage {  /* 오른쪽에 있는 이미지 */
	width: 500px;
	margin-left: 70px;
	margin-top: 50px;
	height: 200px;
}
#searchDiv {  /* 검색창을 감싸고 있는 div */
	border: 1px solid black;
	position:relative;
	top: 30px;
}
#newBox {  /* 새로 업데이트된 내용을 감싸고 있는 div */
	position: relative;
	left: 30px;
	margin-top: 10px;
}
#newTable {
	/* white-space: pre-wrap;
	word-break: break-all; */
}
#newTable td {
	
}
.newTitle {
	padding-left: 20px;
	width: 450px;
}
.newTitle a {
	text-decoration: none;
	color: orange;
}

</style>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	window.onload = function(){
		go();
	}
	function go(){
		if(<%=exist%>==null){
			location.href="CheckIpController?ip=<%=ip%>&u_idx=<%=u_idx%>";
		}	
	} 
</script>
<div id="wrap">
	<div id="wrap1">
		<div id="left1" class="box1">
			<div id="left2" class="box2">
				<div id="today">
					TODAY <span style="color:#EE5D1A; font-size:13px;"><%=today %></span> | TOTAL <span style="font-size:13px;"><%=total %></span>
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
					<%=mvo.getNickname() %>님의 홈페이지입니다.
				</div>
				<div id="openBtnDiv" OnClick="location.href='open.jsp'" style="cursor:pointer;">
					<img id="helloImg" src="images/helloworld2.png" alt="헬로월드">
					<span>메인으로</span>
				</div>
				<div id="right3" class="box3">
					<div id="title">
						최근게시물
					</div>
					
					<div id="newBox">
						<table id="newTable">
							<tr>
								<td id="newDiary" class="update">다이어리</td>
								<c:choose>
									<c:when test="${empty dvo }">
										<td class="newTitle">
											새로운 다이어리가 없습니다.
										</td>
									</c:when>
									<c:otherwise>
										<td class="newTitle">
											<a href="DiaryViewController?d_idx=${dvo.d_idx }&cPage=0">${dvo.title }</a>
										</td>
									</c:otherwise>
								</c:choose>
							</tr>
							<tr>
								<td id="newBoard" class="update">게시판</td>
									<c:choose>
										<c:when test="${empty bvo }">
											<td class="newTitle">
												새로운 게시글이 없습니다.
											</td>
										</c:when>
										<c:otherwise>
											<td class="newTitle">
												<a href="BoardDetailController?b_idx=${bvo.b_idx }">${bvo.title }</a>
											</td>
										</c:otherwise>
									</c:choose>
							</tr>
							<tr>
								<td id="newPhoto" class="update">사진첩</td>
								<c:choose>
									<c:when test="${empty pvo }">
										<td class="newTitle">
											새로운 사진이 없습니다.
										</td>
									</c:when>
									<c:otherwise>
										<td class="newTitle">
											<a href="#">${pvo.title }</a>
										</td>
									</c:otherwise>
								</c:choose>
							</tr>
							<tr>
								<td id="newGuestBook" class="update">방명록</td>
								<c:choose>
									<c:when test="${empty gvo }">
										<td class="newTitle">
											새로운 방명록이 없습니다.
										</td>
									</c:when>
									<c:otherwise>
										<td class="newTitle">
											
										</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</table>
					</div>
					
					<img id="homeimage" src="images/homeimage.jpeg" alt="homeimage">
					
				</div>
				<!-- right3 -->
			</div>
			<!-- right2 -->
		</div>
		<!-- right1 -->
		
		<ul id="navigation">
			<li><a href="home.jsp?u_idx=<%=mvo.getU_idx()%>">홈</a></li>
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