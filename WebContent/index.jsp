<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>Hello World!</title>
<!-- 폰트 스타일 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<style> 
	body {  /* body 태그 부분 */
		background-color: #EEEEEE; 
	}
	#head_img {  /* 싸이월드 로고 부분 */
		position: relative;
		width: 50px; 
		top: 15px;
	}
	h1 {  /* HELLO WORLD 부분 */
		display: inline;
		font-family: "Nanum Gothic";
		
	 }
	#top {  /* 싸이월드 로고 + HELLO WORLD */
		position: relative;
		left: 75%;
		transform: translate(-40%);
	}
	#wrap {  /* top 바로 밑에 내용 부분 */
		position: relative;
		left:55%;
		transform: translate(-20%);
	}
	#today {  /* today 박스 부분 */
		border: none;
		width: 300px;
		padding: 20px;
		background-color: #0096c6;
		color: white;
		border-radius: 15px;
	}
	#wrap>p>span {
		color: orange;
	}
	#hi { /* 헬로월드 미니홈피에 오신것을 환영합니다. */
		position: relative;
		left: 10px;
	}
	#kimhello {  /* 김헬로 박스 부분 */
		background-color: white;
		width: 350px;
		height: 200px;
		border-radius: 15px;
	}
	#character1 {  /* 캐릭터 이미지 */
		position: relative;
		width: 80px;
		left: 10px;
		top: 10px;
		border-radius: 20px;
	}
	#kim {  /* 김헬로 */
		position: relative;
		left: 20px;
		top: -80px;
		font-weight: bold;
	}
	#content1 {  /* 우리 그 때 헬로월드 여기는 여러분의 헬로월드입니다. */
		position: relative;
		left: 100px;
		top: -80px;
	}
	#content2 {  /* Today is.. */
		position: relative;
		left: 15px;
		top: -60px;
	}
	#sun {  /* 태양 이미지 부분 */
		width: 30px;
	}
	#content2 span {
		color: #0096c6;
		font-weight: bold;
	}
	
	#form1 {  /* ul태그 부분 */
		padding-left: 0;
	}
	#form1 li {  /* ul태그 밑에 로그인, 회원가입, 아이디/비밀번호 찾기 부분 */
		list-style: none;
		border: none;
		width: 300px;
		padding: 20px;
		background-color: #ff6939;
		color: white;
		border-radius: 15px;
		text-align: center;
		margin-bottom: 10px;
	}
</style>
</head>
<body>
	<!-- 로고와 페이지 이름 부분 -->
	<div id="top">
		<img id="head_img" src="images/helloworld2.png" alt="hello world">
		<h1>HELLOWORLD</h1>
	</div>
	
	<!-- 페이지 내용부분을 가장 겉에서 덮고있는 div -->
	<div id="wrap">
		
		<p id="today">
			TODAY <span>999,999</span> | TOTAL 999,999
		</p>
		
		<p id="hi">
			헬로월드 미니홈피에 오신것을 환영합니다.
		</p>
		
		<div id="kimhello">
			<img id="character1" src="images/character1.png">
			<span id="kim">김헬로</span>
			<p id="content1">우리 그 때 헬로월드<br>여기는 여러분의 헬로월드입니다. </p>
			<br>
			<p id="content2">
				<span>Today is..</span><img id="sun" src="images/sun.png">&nbsp;&nbsp;  
				<span>일촌</span> 9,999 &nbsp;&nbsp;  <span>즐겨찾기</span> 9,999
			</p>
		</div>
		<br>
		
		<!-- 로그인, 회원가입, 아이디/비밀번호 찾기 -->
		<ul id="form1">
			<li OnClick="location.href='logIn.jsp'" style="cursor:pointer;">로그인</li>
			<li OnClick="location.href='registry.jsp'" style="cursor:pointer;">회원가입</li>
			<li OnClick="location.href='findPeople.jsp'" style="cursor:pointer;">사람찾기</li>
		</ul>
		
		<!-- 싸이월드 홍보 동영상 -->
		<div>
			<iframe width="340" height="238" src="https://www.youtube.com/embed/WrUv_JyEatM" 
			title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; 
			clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
			allowfullscreen></iframe>
		</div>
		
	</div>
	<!-- wrap -->
</body>
</html>