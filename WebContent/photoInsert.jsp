<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//System.out.println(session.getAttribute("vo"));
//request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진첩</title>
</head>
<link href="form.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
li:nth-child(5)>a {  /* 현재 페이지 버튼 스타일 변경 */
	background-color: white; 
	color: black;
	border-left: none;
}

#right3 {
	overflow: auto;
}

/* 사진첩 */
#photoTable {  /* 사진첩 작성 테이블 */
	width: 550px;
	height: 350px;
	margin-top: 10px;
	margin-left: 15px;
}
#photoTable th:first-child {
	text-align: left;
}
#form_text {  /* 사진첩 내용물 작성 부분 */
	resize: none;
	width: 550px;
	height: 330px;
	padding: 20px;
	font-size: 17px;
	font-weight: 600;
	border: 1px solid #E2E8EA;
	border-radius: 5px;
}

#form_Title {  /* 사진첩 제목 작성 부분 */
	width: 400px;
	height: 30px;
	border-radius: 5px;
	border: 1px solid #E2E8EA;
	padding-left: 10px;
	font-size: 16px;
}
#btnDiv {  /* 버튼을 감싸고 있는 div */
	margin: 10px;
	padding-left: 415px;
}
#btnDiv input, button{  /* 버튼 부분 */
	margin-left: 7px;
	width: 80px;
	height: 30px;
	margin-left: 10px;
	border-radius: 7px;
	border: none;
	font-weight: bold;
	background-color: #4FBAEA;
	color: white;
	cursor: pointer;
}
</style>
<body>
<script type="text/javascript">
var imgValidation = ["JPG", "JPEG", "GIF", "PNG", ""];
$(function(){
	$("#frm").submit(function(){
		var fn = $("#form_file").val();
		var fileExt = fn.substring(fn.lastIndexOf(".")+1).toUpperCase();
		var chkImg = false;
		for(i=0; i < imgValidation.length; i++){
			if(fileExt == imgValidation[i]){
				chkImg = true;
				break;
			}
		}
		if(!chkImg){
			alert("이미지 파일(JPG, JPEG, GIF, PNG)만 가능합니다.");
			$("#form_file").focus();
			return false;
		}
	});
	
});
</script>
<div id="wrap">
	<div id="wrap1">
		<div id="left1" class="box1">
			<div id="left2" class="box2">
					<div id="today">
						TODAY <span style="color: #EE5D1A; font-size: 13px;">${today }</span> |
						TOTAL <span style="font-size: 13px;">${total }</span>
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
				<div id="nickname">${host.nickname }님의 홈페이지입니다.</div>
				<div id="openBtnDiv" OnClick="location.href='open.jsp'" style="cursor:pointer;">
               		<img id="helloImg" src="images/helloworld2.png" alt="헬로월드">
               		<span>메인으로</span>
            	</div>
				<div id="right3" class="box3">
					<div id="title">
						사진첩
					</div>
					<div>
					<!-- 사진 나오는 곳 -->
					<!--------------- 사진첩 내용 --------------->
						<form method="post" encType="multipart/form-data" id="frm" action="photoInsert_ok.jsp" accept-charset="UTF-8">
							<table id="photoTable">
								<tbody>
									<tr>
										<td><input type="text" class="form" id="form_Title" placeholder="제목" name="photoTitle" maxlength="50"></td>
									</tr>
									<tr>
										<td><textarea class="form" id="form_text" placeholder="내용" name="photoContent" maxlength="2048"></textarea></td>
									</tr>
									<tr>
										<td><input class="form" id="form_file" type="file" name="fileName"></td>
									</tr>
								</tbody>
							</table>
						<!-- writeDiv -->
							<div id="btnDiv">
							<!-- <input type="submit" id="btn_submit" class="form_btn" value="등록"> -->
							<button>등록</button>
							<input type="button" class="form_btn" value="취소" onclick="history.back()">
							</div>
						</form>
					<!--------------- 사진첩 내용 끝--------------->
					</div>
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