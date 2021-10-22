<%@page import="com.helloworld.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<link href="form.css" rel="stylesheet" type="text/css" />
<style>
#navigation>li:nth-child(4)>a { 
	background-color: white; color: black;
	border-left: none;
}
#board {  /* 게시판 부분 */
	width: 600px;
	position: absolute;
	top: 70px;
	margin-left: 10px;
	z-index: 2;
	border-collapse: collapse;
	text-align: center;
}
#board td {
	border-top: 1px solid black;
	border-bottom: 1px solid black;
	font-weight: 600;
	color: #75B8E0;
}
#board th {
	border-top: 1px solid black;
	border-bottom: 1px solid black;
	border-right: 1px solid white;
	height: 20px;
	background-color: #DADFE2;
}
td a {  /* td내 a태그 부분(제목) */
	text-decoration: none;
	color: #75B8E0;
}
#regdate {  /* 작성일 디자인 */
	font-size: 12px;
}
#nickname1 {  /* 작성자 디자인 */
	font-size: 13px;
}
#hit {  /* 조회수 디자인 */
	font-size: 13px;
}
#btn {  /* 삭제, 글쓰기 버튼을 감싸고 있는 div */
	position: absolute;
	top: 430px;
	right: 35px;
}
#btn input {  /* 삭제, 글쓰기 버튼 디자인 */
	width: 80px;
	height: 35px;
	margin-left: 10px;
	border-radius: 7px;
	border: none;
	font-weight: bold;
	background-color: #4FBAEA;
	color: white;
}
.page {
	float: right;
    position: relative;
    left: -50%;
    list-style: none;
}
.page li {
    float: left;
    position: relative;
    left: 50%;
    margin-right: 5px;
}
.now {  /* 현재 페이지의 버튼 디자인 */
	font-weight: bold;
	border: none;
	text-decoration: underline;
}
.others a {  /* 다른 페이지들의 버튼 */
	border: none;
	background-color: white;
	font-weight: 500;
	padding: 0;
}
</style>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	/* 전체 선택시 모든 체크박스 체크되는 메서드 */
	function allChk() { 
		/* 반복문을 사용하기 위해 게시글의 총 개수를 구한다 */
		let clength = document.getElementsByName("b_idx").length;
		
		/* 전체 선택시 모든 체크박스 체크 */
		if(document.getElementById("all").checked==true){  //id 를 사용하여 하나의 객체만을 호출
	         for(var i=0;i<clength;i++) document.getElementsByName("b_idx")[i].checked=true;   //name 을 사용하여 배열 형태로 담아 호출
	    }
		
		/* 전체 선택 해제시 모든 체크박스 체크 해제 */
    	if(document.getElementById("all").checked==false){
	         for(var i=0;i<clength;i++) document.getElementsByName("b_idx")[i].checked=false;  
    	}
	}
	/* 삭제하기 전 정말로 삭제할건지 확인하고 선택된 게시글 모두 삭제 */
	function delChk(frm) { 
		let check = confirm('정말 삭제하시겠습니까?');
		if (check == true) {
			frm.action = "BoardMultiDelController";
			frm.submit();
		}
	}
	
	/* 
		login객체의 u_idx와 host객체의 u_idx 값을 비교하여 일치하는지 확인하고
		일치하지 않으면 삭제, 글쓰기 버튼 감추기 
	*/
	$(function(){
		if (${login.u_idx} != ${host.u_idx}) {
			$('#delete').hide();
			$('#write').hide();
		}
	})
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
					<div id="title">
						게시판
					</div>
					
					<%-- 선택된 게시글의 b_idx를 보내기 위한 form --%>
				<form>
				<table id="board">
					<colgroup>
						<col width="5%">
						<col width="50%">
						<col width="15%">
						<col width="25%">
						<col width="5%">
					</colgroup>
					<thead>
						<tr>
							<th><input id="all" type="checkbox" onclick="allChk();"></th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회</th>
						</tr>
					</thead>
					
					<tbody>
						<c:choose>
							<c:when test="${empty list }">
								<tr>
									<td colspan="5">
										현재 게시글이 없습니다.
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="bvo" items="${list }">
									<tr>
									<td><input type="checkbox" name="b_idx" value="${bvo.b_idx }"></td>
									<td id="title"><a href="BoardDetailController?b_idx=${bvo.b_idx }">${bvo.title }</a></td>
									<td id="nickname1">${bvo.nickname }</td>
									<td id="regdate">${bvo.regdate }</td>
									<td id="hit">${bvo.hit }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="5">
							<ol class="page">
								<c:choose><%-- 이전으로에 대한 사용여부 처리 --%>
									<c:when test="${pvo.beginPage == 1 }">
										<li class="disable">&lt;이전</li>
									</c:when>
									<c:otherwise>
										<li>
											<a href="BoardAllController?cPage=${pvo.beginPage-1 }">&li;이전</a>
										</li>
									</c:otherwise>
								</c:choose>
								
								<%-- 블록 내에 표시할 페이지 태그 작성(시작페이지~끝페이지) --%>
								<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
									<c:choose>
										<c:when test="${pageNo == pvo.nowPage }">
											<li class="now">${pageNo }</li>
										</c:when>
										<c:otherwise>
											<li class="others"><a href="BoardAllController?cPage=${pageNo }">${pageNo }</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${pvo.endPage < pvo.totalPage}">
									<li><a href="BoardAllController?cPage=${pvo.endPage+1 }">다음&gt;</a></li>
								</c:if>
								<c:if test="${pvo.endPage >= pvo.totalPage }">
									<li class="disable">다음&gt;</li>
								</c:if>
							</ol>
						</tr>
					</tfoot>
				</table>
				<div id="btn">
				<input type="hidden" name="u_idx" value=${host.u_idx }>
				<input type="button" id="delete" value="삭제" onclick="delChk(this.form)">
				<input type="button" id="write" value="글쓰기" onclick="javascript:location.href='board_write.jsp'">
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