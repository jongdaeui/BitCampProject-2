<%@page import="com.helloworld.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    //host 객체
	//MemberVO host = (MemberVO)session.getAttribute("host");
	//System.out.println(host);
    
  	//로그인 객체 
    MemberVO login = (MemberVO)session.getAttribute("login");
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필수정</title>
</head>
<link href="form.css" rel="stylesheet" type="text/css" />
<style>
li:nth-child(2)>a {  /* 현재 페이지 버튼 스타일 변경 */
	background-color: white; color: black;
	border-left: none;
}

#profileTable div {  /* 테이블 td */
	padding: 2px;
}

.content {  /* 테이블내 내용 부분 */
	display: inline-block;
	margin-left: 40px;
	font-weight: 700;
	color: #7A7F81;
	padding-left: 30px;
	padding-top: 7px;
	width: 200px;
	height: 20px;
	border: 1px solid #CAD2D5;
	border-radius: 5px;
}


#profileTable {  /* 테이블 위치 이동 */
	width: 700px;
	margin-left: 20px;
	margin-top: 30px;
	border-collapse: collapse;
}
#temp {  /* 선긋는 용도로 사용되는 td */
	height: 120px;
}
#update {  /* 수정 버튼 */
	position: relative;
	left: 60%;
	top: -70px;
	width: 75px;
	height: 35px;
	background-color: #32AFDC;
	color: white;
	border: none;
	border-radius: 5px;
}

#a {
	position: relative;
	transform: translate(100px,50px);
}
#b {
	magin-rigth: 100px;
}
#radiocontainer {
	position: relative; top: 4.3px;
}
#gender {
	position: absolute; left: 100px; top: -17px;
}
.birth {
	position: relative; left: -15px;
}
.phone {
	position: relative; left: 8px; top: 5px;
}
.gender {
	transform: translate(-20.5%,0);
}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$.ajax("todayController?a=7",{
		type: "get",
		datatype: "json",
		success: function(data){
			var adata = JSON.parse(data);
			
			console.log(adata.today);
			
			$("#to").html(adata.today);
			$("#tt").html(adata.total);
			
			/* $.each(data,function(index,e){
				console.log(e);
				$("#tt").html(adata.today);
				$("#to").html(e.total);
			}); */
			
			//성별 라디오 디폴트 설정
			if(<%=login.getGender() == "남"%>){
				$(".male").prop('checked',true);
			}else {
				$(".female").prop('checked',true);
			}
		
		},
		error : function(){
			alert("Ajax처리 실패!");
		}
	});
	
	//프로필 수정
	function up() {
				frm.action="profileUpdateController";
				frm.submit();
	}
	
	
</script>
<body>
<script>

<%-- 
function today(){
	if(<%=today%>==null){
		location.href="today?a=7";

	}else{
	
	}
		
} --%>
/* window.onload=()=>{
	document.
	
} */

</script>
<div id="wrap">
	<div id="wrap1">
		<div id="left1" class="box1">
			<div id="left2" class="box2">
				<div id="today">
					TODAY <span id="to" style="color:#EE5D1A; font-size:13px;"></span> | TOTAL <span id="tt" style="font-size:13px;"></span>
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
					<div id="title">
						프로필
					</div>
					<div id="a">
					<form class="profileTable" name="frm">
						<div>
							<p class="title">닉네임
							<input class="content nick" type="text" name="nickname" value=<%=login.getNickname() %>></p>
						</div>
						<div>
							<p class="title">생년월일
							<input class="content birth" type="text" name="birth" value =<%=login.getBirth() %>></p>
						</div>
						
						<div id="radiocontainer">
							성별<p id="gender">
							<label>남<input class="male" type="radio" name="gender" value="남"></label>
							<label>여<input class="female" type="radio" name="gender" value="여"></label>
							</p>
						</div>

						<div>
							<p class="title">이메일
							<input class="content email" type="email" name="email" value=<%=login.getEmail() %>>
							</p>
						</div>
						<div>
							<p class="title">phone
							<input class="content phone" type="text" name="phone" value=<%=login.getPhone() %>>
							</p>
						</div>
							<p id="temp" class="title"></p> <!-- 선긋는 용도(실제로 안쓰임) -->
						<input id="update" type="button" onclick="up()" value="저장" >
					</form >
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