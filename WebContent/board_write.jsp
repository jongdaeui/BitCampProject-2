<%@page import="com.helloworld.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>
<link href="form.css" rel="stylesheet" type="text/css" />
<style>
#navigation>li:nth-child(4)>a { 
	background-color: white; color: black;
	border-left: none;
}
#boardTable {  /* 게시글 작성 테이블 */
	width: 550px;
	height: 350px;
	margin-top: 10px;
	margin-left: 15px;
}
#boardTable th:first-child {
	text-align: left;
}
#boardContent {  /* 게시글 내용물 작성 부분 */
	resize: none;
	width: 550px;
	height: 330px;
	padding: 20px;
	font-size: 17px;
	font-weight: 600;
	border: 1px solid #E2E8EA;
	border-radius: 5px;
}
#boardTitle {  /* 게시글 제목 작성 부분 */
	width: 400px;
	height: 30px;
	border-radius: 5px;
	border: 1px solid #E2E8EA;
	padding-left: 10px;
	font-size: 16px;
}
#btnDiv {  /* 버튼을 감싸고 있는 div */
	margin: 10px;
	padding-left: 400px;
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
function insert_go() {
	console.log("insert_go() 실행");
	let check = confirm('작성한 글을 저장하시겠습니까?');
	if (check == true) {
		let fr = document.insertForm;
		let title = fr.title.value.trim();
		//제목의 길이를 확인한다
		if (title == "") {
			alert('제목을 작성하세요!');
			fr.title.focus();
			return false;
		}
		let content = fr.content.value.trim();
		if (content == "") {
			alert('게시글은 한 글자 이상 작성해야 합니다.');
			fr.content.focus();
			return false;
		}
		document.insertForm.action = "BoardInsertController";
		document.insertForm.submit();
	}
}
function list_go() {
	location.href = "BoardAllController";	
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
					<div id="writeDiv">
					<form name="insertForm">
						<%-- 전달받은 BoardVO 객체를 사용하여 결과값 출력  --%>
						<table id="boardTable">
							<thead>
								<tr>
									<th>제목  <input id="boardTitle" type="text" name="title"></th>
								</tr>
							</thead>
							<tbody>
								<tr>
								<%-- 게시글 입력 --%>
								<td colspan="2">
									<textarea id="boardContent" name="content" rows="30" cols="70"></textarea>
								</td>
								</tr>
							</tbody>
						</table>
						</div>
						<!-- writeDiv -->
							<div id="btnDiv">
							<input type="button" value="목록" onclick="list_go()"> 
							<input type="button" value="저장" onclick="insert_go()">
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