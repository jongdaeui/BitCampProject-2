<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>logIn</title>
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->

</head>
<style>
	 #background{
	 	position: absolute;
	 	z-index: -1;
	 }
	 #wrap {
	 	position: relative; left: calc(100%/2.6); top: 80px;
	 	transform: translate(-60%,0%);
	 	z-index: 1;
	 	width: 400px;
	 	height: 30px;
	}
	#circle {
		border-radius: 50%;
		background-color: white;
		z-index: 1;
		position: relative; left: 200px; top:100px;
		height: 400px;
	}
	 #etcContainer {
	 	position: relative; left: 67px; top: 50px;
	 }
	 #head_img {
	 	position: relative; left:60px; top: -10px;
	 	width: 150px;
	 	height: 150px;
	 }

	 #form{
	 	position: relative; left:52%; top: -15px;
	 	transform: translate(-50%,0%);
	 }
	 .id {
	 	border-radius: 3px; 
	 	border: solid 1px;
	 	height: 30px;
	    width: 250px;
	 	margin-bottom: -50px;
	 }
	 .id:hover {
	 	border-radius: 10px; color: #282828;
	 	border: solid 2px;
	 }
	 .pw {
	 	transform: translate(0%,-30%);
	 	margin-top: -100px;
	 }
	 #log {
	 	transform: translate(0%,-40%);
	 	border-radius: 10px;
	 	margin-top: -10px;
	 	width: 255px;
	 	height: 30px;
	 	background-color: #282828;
	 	color: white;
	 	cursor: pointer;
	 }
	 #log:hover {
	 	background-color: #ff6939;
	 }
	 .input {
	 	transform: translate(10%,0%);
	 	border: none;
	 	cursor: pointer;
	 }
	 .input:hover {
	 	color: orange;
	 }
	 .in {
	 	transform: translate(40%,0%);
	 }
	 #findDiv {  /* 아이디/비밀번호 찾기 버튼을 감싸고 있는 div */
	 	position: relative;
	 	left: 55px;
	 	margin-bottom: 10px;
	 }
	 #findDiv a {
	 	text-decoration: none;
	 	color: black;
	 }
	 #findDiv a:hover {
	 	color: orange;
	 }
	 #registBtn {
	 	position: relative;
	 	left: 45px;
	 }
</style>
<script>
	function logIn(frm){
		//location.href="controller?type=logIn";
		console.log("컨트롤러로");
		frm.action = "controller?type=logIn";
		frm.submit();
	}
	//회원가입
	function membership(){
		location.href="registry.jsp"
	}
	
</script>
<body>
	
<div id="wrap">
<div id="background"><img src="images/background.png" width=800px; height=600px;></div>
	<div id="circle">
		<div id="etcContainer">
			<img id="head_img" src="images/helloworld.png" alt="hello world">
			<form id="form" method="post" name="frm">
				<h2><input class="id" type= "text" name="id" placeholder="  아이디"></h2>
				<h2><input class="id pw" type="password" name="pw" placeholder="  비밀번호"></h2>
				<input id="log" type="button" onclick="logIn(this.form)" value="로그인"><br>
				<div id="findDiv">
					<a href="findId.jsp">아이디</a>/<a href="findPwd.jsp">비빌번호 찾기</a>
				</div>
				<input id="registBtn" class="input in" type="button" onclick = "membership()" value="회원가입하기">
			</form>
		</div>
	</div>	
</div>
</body>
</html>