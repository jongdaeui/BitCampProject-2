<%@page import="com.helloworld.vo.PhotoVO"%>
<%@page import="com.helloworld.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
	//비정상적인 접근 차단용
	//-로그인 정보 가져오기
	MemberVO logIn = (MemberVO) session.getAttribute("logIn");
	//-호스트 정보 가져오기
	MemberVO host = (MemberVO) session.getAttribute("host");
	int result = 1;
	//-호스트와 로그인 정보 비교에서 홈페이지 주인 여부 확인
	if(logIn != null || host != null){
		if(logIn.getU_idx() != host.getU_idx()){
			result = 0;
		}
	}
	if(result == 1){
		%>
		<script>
		alert("비정상적인 접근입니다.");
		location.href="home.jsp?u_idx=<%=host.getU_idx() %>";
		</script><%
	}
--%>
<%	
	//-로그인 정보 가져오기
	MemberVO login = (MemberVO) session.getAttribute("login");
	//-호스트 정보 가져오기
	MemberVO host = (MemberVO) session.getAttribute("host");
	//선택한 게시물에 맞는 photoVO 객체 정보 가져오기
	PhotoVO vo = (PhotoVO)request.getAttribute("photoVO");

	//JSTL 사용을 위해 페이지 스코프에 vo 객체 등록
	pageContext.setAttribute("vo", vo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진첩</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	function photoDelete(){
		var yn = confirm("등록된 사진을 삭제하시겠습니까?");
		if(yn){
			$("#dataName").val("없음");
			$(".close").hide();
			$("#iStatus").val(1);
		}else{
			return false;	
		}
	}
	
	function modify_ok(p_idx){
		var imgValidation = ["JPG", "JPEG", "GIF", "PNG", ""];
		var yn = confirm("해당 게시물을 수정하시겠습니까?");
		if(yn){
			var fn = $("#form_file").val();
			var oriFile = "<%=vo.getOrifilename()%>";
			var dataName = $("#dataName").val();
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
 			if(oriFile != null && oriFile != ""){
 				if(oriFile == dataName){
					$("#iStatus").val(-1);
				}
			}
			if(fn != null && fn != ""){
				$("#iStatus").val(1);
			}
			$("#p_idx").val(p_idx);
			frm.action = "photoModify_ok.jsp";
			frm.submit();	
		}else{
			return false;	
		}
	}
</script>
</head>
<link href="form.css" rel="stylesheet" type="text/css" />
<style>
li:nth-child(5)>a {  /* 현재 페이지 버튼 스타일 변경 */
	background-color: white; color: black;
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
	white-space: pre-wrap;
	word-break: break-all;
}
#form_title {  /* 사진첩 제목 작성 부분 */
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
	cursor: pointer;
}

#dataName {
	border: none;
}
/*X표시 CSS */
.close { display:inline-block;*display:inline; }
.close:after { display: inline-block; content: "\00d7"; font-size:16pt; color: red; }

/*미리보기용 CSS */
.tooltip-inner { max-width: 300px; }

</style>
<body>
<script>
	
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
						<form id="frm" name="frm" method="post" encType="multipart/form-data" accept-charset="UTF-8">
							<table id="photoTable">
								<tbody>
									<tr>
								<!-- 가져온 vo 객체 정보 각각의 위치에 적용 -->
										<td><input type="text" class="form" id="form_title" placeholder="제목" name="photoTitle" maxlength="50" value="<%=vo.getTitle()%>"></td>
									</tr>
									<tr>
										<td><textarea class="form" id="form_text" placeholder="내용" name="photoContent" maxlength="2048"><%=vo.getContent() %></textarea></td>
									</tr>
									<tr>
										<td>
											<label class="form">
											현재 등록된 사진 파일 :  
											<!-- 등록된 사진 파일 유/무에 따른 분기 처리 -->
											<c:choose>
												<c:when test = "${vo.getOrifilename() == null}">
												   <label>없음</label>
												</c:when>
												<c:otherwise>
												<label class="close" onclick="photoDelete()"></label><input type="text" id="dataName" value="${vo.getOrifilename()}" readonly>
												</c:otherwise>
											</c:choose>
											</label>
										</td>
									</tr>
									<tr>
										<td><input class="form" id="form_file" type="file" name="fileName"></td>
									</tr>
								</tbody>
							</table>
							<div id="btnDiv">
							<input type="hidden" id="p_idx" name="p_idx">
							<input type="hidden" name="orifilename">
							<input type="hidden" id="iStatus" name="status" value="-1">
							<input type="submit" id="btn_submit" class="form_btn" value="수정" onclick="modify_ok(${vo.p_idx})">
							<input type="button" class="form_btn" value="취소" onclick="history.back()">
							</div>
						</form>
					<!--------------- 사진첩 내용 끝--------------->
					</div>
<!-- 					
					<div id="btnDiv">
						
					</div> -->
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