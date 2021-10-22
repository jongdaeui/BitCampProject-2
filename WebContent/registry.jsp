<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시 회원가입 폼</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script src="./js/registry.js"></script>
<script>
	function reg_send(){
		let fr = document.frm;
		if (validate()){
			fr.birth.value = fr.yyyy.value + "-" + fr.mm.value + "-" + fr.dd.value
			fr.action = "accountController";
			fr.submit();
		}
	}
	
</script>
<style>
#helloworldImg {
	width: 50px;
	margin-right: 0px;
	transform:rotate(15deg);
	top: 10px;
	position: relative;
}
.input {
	width: 250px;
	height: 30px;
	text-align: center;
	font-family: Poor Story', cursive;
}

.bir {
	width: 80px;
	height: 30px;
	font-family: Poor Story', cursive;
}

.bir_sel {
	width: 78px;
	height: 37px;
	font-family: Poor Story', cursive;
}

.input_div {
	width: 130px;
	height: 30px; 
	text-align: center;
}

.center {
	 position: relative;
}

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

#gender{
	width: 253px;
	height: 35px;
	font-family: 'Poor Story', cursive;
}

select {
	font-family: 'Poor Story', cursive;
}
#align {  /* 버튼을 감싸고 있는 div */
	margin-top: 50px;
	position: relative;
	left: 3px;
}
.center > div { left: 50%; transform: translate(-50%); position: absolute; }
.label { font-family: 'Poor Story', cursive; margin-bottom: 5px; font-size: 1.3em; }
#mfont { font-family: 'Poor Story', cursive; font-size: 3em; }

#validation { position:relative; ; top: 300px; }
</style>
<body>
<script>
	function back() {
		location.href = "logIn.jsp";		
	}
</script>
	<div class="center">
		<div>
			<div>
			<h1 id="mfont"><span>Hello </span><img id="helloworldImg" src="images/helloworld2.png" alt="helloworld">
			<span>World!</span></h1>
			</div>
			<form name="frm" method="post" >
				<p class="label">아이디</p> <input type="text" name="id" class="input" placeholder="영 소문자로 시작, 숫자만 사용 가능 (4~12)">
				<input type="button" name="validation" class="button" value="중복검사" onclick="chkId('id')">
				<p class="label">비밀번호</p> 
				<input type="password" name="pwd" class="input" placeholder="영어 대/소문자 + 숫자 + 특수문자 (6~12)">
				<p class="label">비밀번호 확인</p>
				<input type="password" name="pwd2" class="input" placeholder="영어 대/소문자 + 숫자 + 특수문자 (6~12)">
				<p class="label">닉네임</p> <input type="text" name="nickname" class="input" placeholder="한글, 영어(대/소), 숫자 가능 (2~10)">
				<input type="button" name="validation" class="button" value="중복검사" onclick="chkId('nickname')">
				<p class="label">이메일</p>
                <input type="email" name="email" class="input" placeholder="example@example.com">
                <!--<select id="domain" aria-label="이메일" class="bir_sel">
					<option value="">이메일</option>
					<option value="naver.com">네이버</option>
					<option value="daum.net">다음</option>
					<option value="google.com">구글</option>
					<option value="kakao.com">카카오</option>
					<option onclick="">기타</option>
				</select> -->
				<p class="label">이름</p>
				<input type="text" name="name" class="input" placeholder="한글(2~10)">
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
				<!--  <span class="error_next_box" id="birthdayMsg" style="display:none"></span> -->
				<p class="label">성별</p>
				<select id="gender" name="gender" aria-label="성별">
                	<option value="" selected>성별</option>
                    <option value="남">남자</option>
                    <option value="여">여자</option>
                </select>
				<p class="label">휴대전화</p>
				<input type="text" name="phone" class="input" placeholder="010-0000-0000"><br>
				<p id="align">
				<input type="button" value="회원가입" class="button" onclick="reg_send()"> 
				<input type="reset" value="초기화" class="button">
				<input type="button" value="뒤로가기" class="button" onclick="back()">
				<input type="hidden" name="birth">
				<input type="hidden" name="type" value="registry">
				</p>
			</form>
		</div>
	</div>
</body>
</html>