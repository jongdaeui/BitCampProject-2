<%@page import="com.helloworld.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	MemberVO mvo = (MemberVO)session.getAttribute("host");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필</title>
</head>
<link href="form.css" rel="stylesheet" type="text/css" />
<style>
#navigation>li:nth-child(2)>a {  /* 현재 페이지 버튼 스타일 변경 */
	background-color: white; color: black;
	border-left: none;
}

#profileTable td {  /* 테이블 td */
	padding: 10px;
}

.content {  /* 테이블내 내용 부분 */
	display: inline-block;
	margin-left: 50px;
	font-weight: 600;
	color: #7A7F81;
	padding-left: 20px;
	padding-top: 10px;
	width: 300px;
	height: 30px;
	border: 1px solid #CAD2D5;
	border-radius: 5px;
}

#profileTable {  /* 테이블 위치 이동 */
	margin-left: 40px;
	margin-top: 30px;
	border-collapse: collapse;
}
#temp {  /* 선긋는 용도로 사용되는 td */
	height: 120px;
}
#update {  /* 수정 버튼 */
	position: relative;
	left: 75%;
	top: -110px;
	width: 75px;
	height: 35px;
	background-color: #32AFDC;
	color: white;
	border: none;
	border-radius: 5px;
}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$.ajax("InformationController?u_idx="+<%=mvo.getU_idx()%>,{
		type: "post",
		datatype: "json",
		success: function(data){
			//alert("Ajax처리 성공 - 응답받은 데이터 :"+ data);
			//console.log(data);
			
			var adata = JSON.parse(data);
			console.log(adata);
			var alist = adata.list;
			console.log(alist);
			
			$.each(alist, function(){
				console.log(this.nickname);
				
				  $(".nick").html(this.nickname);
				  $(".birth").html(this.birth);
				  $(".gender").html(this.gender);
				  $(".email").html(this.email);
				  $(".phone").html(this.phone);  
			});
		},
		error : function(){
			alert("Ajax처리실패!");
		}
	});
	$(function(){
		if (${login.u_idx} != ${host.u_idx}) {
			$('#update').hide();
		}
	});
</script>
<body>
<script>

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
					<%=mvo.getNickname() %>님의 홈페이지입니다.
				</div>
				<div id="openBtnDiv" OnClick="location.href='open.jsp'" style="cursor:pointer;">
					<img id="helloImg" src="images/helloworld2.png" alt="헬로월드">
					<span>메인으로</span>
				</div>
				
				<div id="right3" class="box3">
					<div id="title">
						프로필
					</div>
					<table id="profileTable">
						<colgroup>
							<col width = "150px";>
							<col width = "300px";>
						</colgroup>
						<tr>
							<td class="title">닉네임</td>
							<td><span class="content nick"></span></td>
						</tr>
						<tr>
							<td class="title">생년월일</td>
							<td><span class="content birth"></span></td>
						</tr>
						<tr>
							<td class="title">성별</td>
							<td><span class="content gender"></span></td>
						</tr>
						<tr>
							<td class="title">이메일</td>
							<td><span class="content email"></span></td>
						</tr>
						<tr>
							<td class="title">phone</td>
							<td><span class="content phone"></span></td>
						</tr>
						<tr>
							<td id="temp" class="title"></td> <!-- 선긋는 용도(실제로 안쓰임) -->
						</tr>
					</table>
					<input id="update" type="button" onclick='location.href="profileUpdate.jsp"' value="수정" >
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