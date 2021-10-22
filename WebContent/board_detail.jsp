<%@page import="java.net.InetAddress"%>
<%@page import="com.helloworld.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.helloworld.vo.BoardVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//DB에서 받아오는 글을 줄바꿈 처리하기 위해 사용한다.
	BoardVO bvo = (BoardVO)request.getAttribute("bvo");
	
	//jsp파일에서는 db에서 넘어오는 \r\n을 줄바꿈으로 인식하지 못함으로
	// /r/n을 <br>로 치환한다.
	String content = bvo.getContent().replace("\r\n", "<br>");
	bvo.setContent(content);
	
	MemberVO lvo = (MemberVO)session.getAttribute("login");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<link href="form.css" rel="stylesheet" type="text/css" />
<style>
#navigation>li:nth-child(4)>a { 
	background-color: white; color: black;
	border-left: none;
}
#board1 {  /* 게시글 내용을 담고 있는 테이블 */
	width: 580px;
	margin-left: 20px;
	margin-top: 10px;
	border-collapse: collapse;
}
th {  /* 게시글 제목 부분 */
	border-bottom: 2px solid #C1C5C7;
	text-align: left;
}
#writer {  /* 게시글 작성자 부분 */
	text-align: left;
	border-bottom: 1px solid #C1C5C7;
	color: #6AB7DD;
}
#regdate {  /* 게시글 작성일 부분 */
	text-align: right;
	border-bottom: 1px solid #C1C5C7;
}
#content {  /* 게시글 출력 부분 */
	overflow: auto;
	border-bottom: 1px solid #C1C5C7;
}
#content p {
	height: 180px;
}
#btnDiv {  /* 목록, 수정, 삭제 버튼을 감싸고 있는 div */
	position: relative;
	left: 60%;
	margin: 5px;
}
#btnDiv input {  /* 목록, 수정, 삭제 버튼 디자인 */
	width: 60px;
	height: 30px;
	margin-left: 10px;
	border-radius: 7px;
	border: none;
	font-weight: bold;
	background-color: #4FBAEA;
	color: white;
}
#commentbox1 {  /* 댓글 칸을 가장 바깥에서 감싸고 있는 div */
	border: 1px solid #C1C5C7;
	border-radius: 7px;
	margin-left: 18px;
	height: 130px;
	width: 580px;
	overflow: auto;
}
#board2 {  /* 댓글 내용을 담고 있는 테이블 */
	border: none;
	width: 550px;
	margin-left: 10px;
	margin-top: 10px;
	white-space: pre-wrap;
	word-break: break-all;
}
#commentbox2 {  /* 댓글 작성 부분을 감싸고 있는 div */
	position: relation;
	margin-left: 19px;
	border: 1px solid #C1C5C7;
	border-radius: 7px;
	width: 570px;
	padding-left: 10px;
}
#comment {  /* 댓글 입력 input 부분 */
	margin-left: 10px;
	padding-left: 10px;
	font-size: 16px;
	width: 450px;
	border: none;
}
#insert {
	width: 50px;
	height: 25px;
	margin-left: 10px;
	border-radius: 7px;
	border: none;
	font-weight: bold;
	background-color: #4FBAEA;
	color: white;
}
#board2 tr {  /* 댓글 테이블의 폰트 크기 조정 */
	font-size: 13px;
}
.x {
	display: inline-block;
   *display: inline;
   cursor: pointer;
}
.x:after {
	display: inline-block;
   content: "\00d7";
   font-size: 16pt;
   color: red;
}

</style>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	function board_go() {  /* 게시글 목록으로 돌아가는 메서드 */
		location.href="BoardAllController";
	}
	function delete_go(b_idx) {  /* 해당 게시글 삭제를 위한 메서드 */
		let check = confirm('해당 게시글을 삭제하시겠습니까?');
		if (check == true) {
			location.href="BoardDeleteController?b_idx="+b_idx+"&u_idx="+${host.u_idx};	
		}
	}
	function update_go(b_idx) {  /* 게시글을 수정하기 위한 메서드 */
		location.href="BoardUpdateController?b_idx="+b_idx;		
	}
	
	/* 댓글을 저장하고 출력하는 과정을 ajax로 처리 */
	function CommentBoardController() {
		var frm = document.commentForm;
		console.log("먼저실행");
		/* alert(">> CommentBoardController 실행~"); */
		
		$.ajax("CommentBoardController", {
			type : "get",
			dataType : "json", //응답받을 데이터 타입 지정
			data: {b_idx : frm.b_idx.value, nickname : frm.nickname.value, content : frm.content.value },
			success : function(data){
				alert("Ajax 처리 성공 - 응답받은 데이터 : " + data);
				console.log(data);
				document.commentForm.content.value = "";  /* 입력창 빈칸으로 만들기 */
				
				//전달받은 JSON 데이터 처리
				var tbody = "";
				var alist = data.list;  //Json 객체의 속성명 "list"의 값 추출
				$.each(alist, function(index, member){
					tbody += "<tr>";
					/* tbody += "<td><input id='c_idx' type='hidden' name='c_idx' value='${cvo.c_idx }'>";
					tbody += "<td><input id='b_idx' type='hidden' name='b_idx' value='${bvo.b_idx }'>"; */
					tbody += "<td>" + this.nickname + "</td>";
					tbody += "<td class='output'>" + this["content"] + "</td>";
					tbody += "<td>" + this["regdate"] + "</td>";
					console.log("this.nickname : " + this.nickname);
					if (${login.nickname == host.nickname} || this.nickname == '<%=lvo.getNickname()%>') {
						tbody += "<td class='x' onclick='CommentDeleteController("+this.c_idx+", ${bvo.b_idx })'></td>";
					}
					/* tbody += "<c:if test='${("+this.nickname+" == login.nickname) || (login.nickname == host.nickname)}'>";
					tbody += "<td class='x' onclick='CommentDeleteController("+this.c_idx+", ${bvo.b_idx })'></td>";
					tbody += "</c:if>";*/
					tbody += "</tr>";
				});
				$("#tbody").html(tbody);
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert("Ajax 처리 실패 : \n"
					+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
					+ "textStatus : " + textStatus + "\n"
					+ "errorThrown : " + errorThrown);
			}
		});
	}
	function commentDelete_go(c_idx, b_idx) {
		console.log("commentDelete_go~");
		console.log("c_idx : " + c_idx);
		console.log("b_idx : " + b_idx);
	}
	/* 댓글을 삭제하고 출력하는 과정을 ajax로 처리 */
	function CommentDeleteController(c_idx, b_idx) {
		console.log("CommentDeleteController~");
		console.log("c_idx : " + c_idx);
		console.log("b_idx : " + b_idx);
		let check = confirm('정말 삭제하시겠습니까?');
		/* 예를 누를 시에만 작용 */
		if (check == true) {
			/* var frm = document.commentForm1; */
			
			alert(">> CommentDeleteController 실행~");
			
			$.ajax("CommentDeleteController", {
				type : "get",
				dataType : "json", //응답받을 데이터 타입 지정
				data: {b_idx : b_idx, c_idx : c_idx },
				success : function(data){
					alert("Ajax 처리 성공 - 응답받은 데이터 : " + data);
					
					//전달받은 JSON 데이터 처리
					var tbody = "";
					var alist = data.list;  //Json 객체의 속성명 "list"의 값 추출
					$.each(alist, function(index, member){
						tbody += "<tr>";
						tbody += "<td>" + this.nickname + "</td>";
						tbody += "<td class='output'>" + this["content"] + "</td>";
						tbody += "<td>" + this["regdate"] + "</td>";
						if (${login.nickname == host.nickname} || this.nickname == '<%=lvo.getNickname()%>') {
							tbody += "<td class='x' onclick='CommentDeleteController("+this.c_idx+", ${bvo.b_idx })'></td>";
						}
						tbody += "</tr>";
					});
					$("#tbody").html(tbody);
				},
				error : function(jqXHR, textStatus, errorThrown){
					alert("Ajax 처리 실패 : \n"
						+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown);
				}
			});
		}
	}
	
	$(function(){
		/* login객체와 host객체가 다르면 삭제, 수정버튼 숨김 */
		if (${login.u_idx} != ${host.u_idx}) {
			$('#delete').hide();
			$('#update').hide();
		}
		/* 로그인된 객체가 없으면 댓글 작성부분 숨김 */
		if (${login.u_idx} == -1) {
			$('#comment').hide();
			$('#insert').hide();
		}
		
		//$('#insert').click(CommentBoardController);
	});
</script>
<body>
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
					${host.nickname }님의 홈페이지입니다.
				</div>
				<div id="openBtnDiv" OnClick="location.href='open.jsp'" style="cursor:pointer;">
					<img id="helloImg" src="images/helloworld2.png" alt="헬로월드">
					<span>메인으로</span>
				</div>
				<div id="right3" class="box3">
					<div id="contentDiv">
						<%-- 전달받은 BoardVO 객체를 사용하여 결과값 출력  --%>
						<table id="board1">
							<colgroup>
								<col width="300px;">
								<col width="300px;">
							</colgroup>
							<thead>
								<tr>
									<th colspan="2">제목 : ${bvo.title }</th>
								</tr>
								<tr>
									<td id="writer">작성자 : ${bvo.nickname }</td>
									<td id="regdate">${bvo.regdate }</td>
								</tr>
							</thead>
							<tbody>
								<tr>
								<%-- 출력시에도 줄바꿈을 유지하기 위해 textarea태그 사용 --%>
								<td colspan="2" id="content">
									<p>${bvo.content }</p>
								</td>
								</tr>
							</tbody>
						</table>
					</div>
					<%-- content --%>
					<div id="btnDiv">
					<input id="delete" type="button" value="삭제" onclick="delete_go(${bvo.b_idx})">
					<input id="update" type="button" value="수정" onclick="update_go(${bvo.b_idx})">
					<input type="button" value="목록" onclick="board_go()">
					</div>
				<div id="commentbox1">
					<form name="commentForm1">  <%-- c_idx를 넘기기위한 form 태그 --%>
					<table id="board2">
						<colgroup>
							<col width="10%">
							<col width="50%">
							<col width="20%">
							<col width="10%">
						</colgroup>
						<tbody id="tbody">
						<c:choose >
							<c:when test="${empty list }">
							<tr>
								<td colspan="5">
									현재 댓글이 없습니다.
								</td>
							</tr>
							</c:when>
						
							<c:otherwise>
								<c:forEach var="cvo" items="${list }">
									<tr>
										<td class="commentNickname">${cvo.nickname }</td>
										<td><div class="output" style="word-wrap:break-word">${cvo.content }</div></td>
										<td>(${cvo.regdate })</td>
										<c:if test="${(cvo.nickname == login.nickname) || (login.nickname == host.nickname)}">
										<td class="x" onclick="CommentDeleteController(${cvo.c_idx }, ${bvo.b_idx })"></td>
										</c:if>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						</tbody>
						
					</table>
					</form>
				</div>
				<!-- contentbox1 -->
				
				<div id="commentbox2">  <!-- 댓글 입력창 -->
				<form name="commentForm">
					<input type="hidden" name="b_idx" value="${bvo.b_idx }"> 
					<input type="hidden" name="nickname" value="${login.nickname }">
					<span>댓글</span><input id="comment" type="text" name="content">
					<input id="insert" type="button" value="저장" onclick="CommentBoardController()">
				</form>
				</div>
				<!-- contentbox2 -->
				
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
			<li><a href="guest_book.jsp">방명록</a></li>
		</ul>
	</div>
	<!-- wrap1 -->
</div>
<!-- wrap -->
</body>
</html>