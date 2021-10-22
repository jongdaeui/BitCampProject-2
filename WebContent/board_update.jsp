<%@page import="com.helloworld.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<link href="form.css" rel="stylesheet" type="text/css" />
<style>
#navigation li:nth-child(4)>a { 
	background-color: white; color: black;
	border-left: none;
}
#boardTable {  /* 게시글 수정 테이블 */
	width: 550px;
	height: 350px;
	margin-top: 10px;
	margin-left: 15px;
}
#boardTable th:first-child {
	text-align: left;
}
#boardContent {  /* 게시글 내용물 수정 부분 */
	resize: none;
	width: 550px;
	height: 350px;
	padding: 10px;
	font-size: 17px;
	border: 1px solid #E2E8EA;
	border-radius: 5px;
}
#boardTitle {  /* 게시글 제목 수정 부분 */
	width: 400px;
	height: 30px;
	border-radius: 5px;
	border: 1px solid #E2E8EA;
}
#btnDiv {  /* 버튼을 감싸고 있는 div */
	margin: 10px;
	padding-left: 300px;
}
#btnDiv input {  /* 버튼 부분 */
	margin-left: 7px;
	width: 80px;
	height: 30px;
	margin-left: 10px;
	border-radius: 7px;
	border: none;
	font-weight: bold;
	background-color: #4FBAEA;
	color: white;
}

</style>
<body>
<script>
function board_go() {  /* 게시글 목록으로 돌아가는 메서드 */
	location.href="BoardAllController";
}
function detail_go() {  /* 해당 글의 상세보기 페이지로 다시 이동 */
	location.href="BoardDetailController?b_idx="+${bvo.b_idx};
}
function update_go() {
	let check = confirm('정말 수정하시겠습니까?');
	if(check == true) {
		let fr = document.updateForm;
		var title = fr.title.value.trim();
		title = title.length;
		
		if (title < 1) {
			alert('제목을 작성하세요!');
			fr.title.focus();
			return false;
		}
		
		document.updateForm.action = "BoardUpdateOkController";
		document.updateForm.submit();
	}
}
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
					${login.nickname }님의 홈페이지입니다.
				</div>
				<div id="openBtnDiv" OnClick="location.href='open.jsp'" style="cursor:pointer;">
					<img id="helloImg" src="images/helloworld2.png" alt="헬로월드">
					<span>메인으로</span>
				</div>
				<div id="right3" class="box3">
					<div id="updateDiv">
					<%-- 수정된 값을 전달하기 위한 form태그 --%>
					<form name="updateForm">
						<%-- 전달받은 BoardVO 객체를 사용하여 결과값 출력  --%>
						<table id="boardTable">
							
							<thead>
								<tr>
									<th>제목  <input id="boardTitle" type="text" name="title" value="${bvo.title }"></th>
									<th>작성자 : ${bvo.nickname }</th>
								</tr>
							</thead>
							<tbody>
								<tr>
								<%-- 출력시에도 줄바꿈을 유지하기 위해 textarea태그 사용 --%>
								<td colspan="2">
									<textarea id="boardContent" name="content" rows="30" cols="70">${bvo.content }</textarea>
								</td>
								</tr>
							</tbody>
						</table>
						<div id="btnDiv">
						<input type="button" value="목록" onclick="board_go()">
						<input type="button" value="취소" onclick="detail_go()">
						<input type="hidden" name="b_idx" value="${bvo.b_idx }">
						<input type="button" value="수정하기" onclick="update_go()">
						</div>
						</form>
					</div>
					<%-- updateDiv --%>
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