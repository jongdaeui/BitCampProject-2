<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<% String id = request.getParameter("id"); 
	System.out.println("id : " + id);
%>

<script src="./js/reset_pwd.js"></script>
<!-- <script>
	function find_send(){
		let fr = document.frm;
		if (validate()){
			fr.birth.value = fr.yyyy.value + "-" + fr.mm.value + "-" + fr.dd.value
			fr.submit();
		}
	}
	
</script> -->
<style>
	/* input 크기, 폰트 지정 */
	.input {
		width: 250px;
		height: 30px;
		text-align: center;
		font-family: 'Nanum Myeongjo', serif;
	}
	
	/* 전체 div relative 설정 */
	.center {
		 position: relative;
	}
	
	/* 버튼류 설정값 */
	.button {
		width: 100px;
		height: 35px;
		background-color: #f8585b;
		border: none;
		color:#fff;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 15px;
		cursor: pointer;
		font-family: 'Poor Story', cursive;
	}
	
	.center > div { left: 50%; transform: translate(-50%); position: absolute; }
	.label { font-family: 'Poor Story', cursive; margin-bottom: 5px; font-size: 1.3em; }
	#mfont { font-family: 'Poor Story', cursive; font-size: 3em; }
	
	#validation { position:relative; ; top: 300px; }
</style>
</head>
<body>
	<div class="center">
		<div>
			<h1 id="mfont">비밀번호 재설정</h1>
			<form name="frm" method="post">
				<p class="label">변경할 비밀번호</p>
				<input type="password" name="pwd" class="input" placeholder="영어 대/소문자 + 숫자 + 특수문자 (6~12)">
				<p class="label">변경할 비밀번호 확인</p>
				<input type="password" name="pwd2" class="input" placeholder="영어 대/소문자 + 숫자 + 특수문자 (6~12)">
				<p>
				<input type="hidden" name="id" value="<%=id %>">
				<input type="hidden" name="type" value="resetPwd">
				<input type="button" value="비밀번호 재설정" class="button" onclick="reset_send()"> <input type="reset" value="초기화" class="button">
				</p>
			</form>
		</div>
	</div>
</body>
</html>