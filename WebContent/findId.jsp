<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script src="./js/find_id.js"></script>
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
	#helloworldImg {  /* hello world 이미지 부분 */
		width: 50px;
		margin-right: 0px;
		transform:rotate(15deg);
		top: 10px;
		position: relative;
	}
	#header {  /* hello world를 감싸고 있는 div */
		position: relative;
		text-align: center;
	}
	/* input 크기, 폰트 지정 */
	.input {
		width: 250px;
		height: 30px;
		text-align: center;
		font-family: 'Nanum Myeongjo', serif;
	}
	
	/* 생년월일 '연도' 크기, 폰트 */
	.bir {
		width: 80px;
		height: 30px;
		font-family: 'Nanum Myeongjo', serif;
	}
	
	/* 생년월일 '월, 일' 크기 */
	.bir_sel {
		width: 78px;
		height: 37px;
	}
	
	/* 전체 div relative 설정 */
	.center {
		 position: relative;
	}
	
	/* 버튼류 설정값 */
	.button {
		width: 80px;
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
	
	#align {  /* 버튼을 감싸고 있는 p */
		position: relative;
		left: 8px;
		margin-top: 50px;
	}
</style>
</head>
<body>
<script type="text/javascript">
	function back() {
		location.href = "logIn.jsp";
	}
</script>
	<div class="center">
		<div id="header">
			<h1 id="mfont"><span>Hello </span><img id="helloworldImg" src="images/helloworld2.png" alt="helloworld">
			<span>World!</span></h1>
		</div>
		<div>
			<h2 id="mfont">ID 찾기</h2>
			<form name="frm" method="post">
				<p class="label">이름</p>
				<input type="text" name="name" class="input">
				<p class="label">휴대전화</p>
				<input type="text" name="phone" class="input"placeholder="010-0000-0000"><br>
               	<p class="label">생년월일</p>
               	<input type="text" id="yyyy" placeholder="연도(4자)" maxlength="4" class="bir">
				<select id="mm" aria-label="월" class="bir_sel">
					<option value="">월</option>
	  	 			<option value="01">1</option>
	  	 			<option value="02">2</option>
	  	 			<option value="03">3</option>
	  	 			<option value="04">4</option>
	  	 			<option value="05">5</option>
	  	 			<option value="06">6</option>
	  	 			<option value="07">7</option>
	  	 			<option value="08">8</option>
	  	 			<option value="09">9</option>
	  	 			<option value="10">10</option>
	  	 			<option value="11">11</option>
	  	 			<option value="12">12</option>
				</select>
				<input type="text" id="dd" placeholder="일" maxlength="2" class="bir">
				<p id="align">
				<input type="hidden" name="birth">
				<input type="button" value="ID 확인하기" class="button" onclick="find_send()"> 
				<input type="reset" value="초기화" class="button">
				<input type="button" value="뒤로가기" class="button" onclick="back()">
				</p>
			</form>
		</div>
	</div>
</body>
</html>