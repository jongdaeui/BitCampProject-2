<%@page import="com.helloworld.vo.DiaryVO"%>
<%@page import="com.helloworld.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	
	MemberVO login = (MemberVO) session.getAttribute("login");
	System.out.println("diary_view.jsp  - login : " + login);
	MemberVO host = (MemberVO) session.getAttribute("host");
	System.out.println("diary_view.jsp - host : " + host);
	int cPage = (Integer) session.getAttribute("cPage");
	int d_idx = (Integer) session.getAttribute("d_idx");
	
	DiaryVO dvo = (DiaryVO)request.getAttribute("dvo");
	System.out.println("diary_view.jsp - cPage : " + cPage);
	System.out.println("diary_view.jsp - d_idx: " + d_idx);
	System.out.println("---------------------------------------- ");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다이어리</title>
<link href="form.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
li:nth-child(3)>a {  /* 현재 페이지 버튼 스타일 변경 */
	background-color: white; color: black;
	border-left: none;
}
.diary {  /* 제목, 내용 공통 부분 */
	width: 510px;
	border: 1px solid #CAD2D5;
	border-radius: 5px;
	margin-left: 40px;
	padding-left: 15px;
	padding-right: 5px;
	padding-top: 10px;
}

#title2 {  /* 제목 부분 */
	margin-top: 15px;
	height: 20px;
	background-color: #f2f2f2;
	line-height: 10px;
	font-weight: bold;
}
#content {  /* 내용 부분 */
	padding-top: 20px;
	padding-bottom: 20px;
	height: auto;
	border-top: none;
	white-space: normal;
	word-break: break-all;
}
#dName_dDate {  /* 다이어리 작성자,작성일 부분 */
	margin-left: 40px;
	width: 530px;
	height: 20px;
	background-color: #fcfcfc; 
	border: 1px solid #CAD2D5;
	border-top: none;
	line-height: 21px;
}
#dName { /* 다이어리 작성자 */
	float: left;
	padding-left: 15px;
	color: orange;
	font-size: 0.8em;
	
}
#dDate { /* 다이어리 작성일 */
	float: right; 
	padding-right: 15px;
	color: #595959;
	font-size: 0.8em;
}
#commentDiv p { padding: 0; margin: 0; } /* 댓글입력창 위 댓글작성자 부분 */
#btnDiv {  /* 버튼 부분 */
	margin-top: 15px;
	margin-bottom: -15px;
	position: relative;
	left: 62%;
}

.get_comment_div { /* 댓글 출력 부분 */
	width: 500px;
	height: auto;
	border-bottom: 1px solid #CAD2D5;
	white-space: normal;
	word-break: break-all;
}
.get_comment_div:last-child { border: none; } /* 마지막 댓글 border제거 */
#comment_regdate { 	color: #999; font-size: 0.8em; } /* 댓글 작성일 */
#comment_modify_btn a { text-decoration: none; 	color: white; } /* 댓글 수정 버튼 */
#comment_modify_btn, #comment_del_btn {  /* 댓글 수정, 삭제 버튼 부분 */
	width: 70px;
	height: 25px;
	margin-right: 10px;
	margin-bottom: 10px;
	border-radius: 7px;
	border: none;
	font-size: 0.8em;
	font-weight: bold;
	background-color: #4FBAEA;
	color: white;
} 
#input2 {  /* 댓글수정 클릭시 나오는 수정/취소 버튼 부분 */
	width: 40px;
	height: 30px;
	margin-left: 10px;
	border-radius: 7px;
	border: none;
	font-weight: bold;
	background-color: #4FBAEA;
	color: white;
}
#right3 {  overflow: auto; 	overflow-x:hidden; } /* 다이어리 영역 스크롤 */

#btnDiv a {  /* 입력, 수정, 삭제 a 태그 부분 */
	text-decoration: none;
	color: orange;
	margin-left: 10px;
	margin-bottom: 0;
}
#commentDiv {  /* 댓글 입력 부분을 감싸는 div */
	margin-top: 20px;
	margin-left: 40px;
}
#comment {  /* 댓글입력창 */
	width: 420px;
	height: 25px;
	padding-left: 10px;
	border-radius: 7px;
	border: 1px solid #CAD2D5;
	font-weight: bold;
}
#input {  /* 댓글입력 버튼 부분 */
	width: 80px;
	height: 30px;
	margin-left: 10px;
	border-radius: 7px;
	border: none;
	font-weight: bold;
	background-color: #4FBAEA;
	color: white;
}

#comments {  /* 댓글이 출력되는 부분 */
	width: 520px;
	border: 1px solid #CAD2D5;
	border-radius: 5px;
	margin-left: 40px;
	margin-top: 10px;
	margin-bottom: 40px;
	padding-left: 10px;
	overflow-y: auto;
}
#comments>p { color: #595959; font-size: 0.8em; } /* 댓글없을대 나오는 멘트 */
#set_content_input input:focus {outline: 1px solid #4FBAEA; } /* 댓글입력창 클릭시 스타일 */

</style>
<body>
<script>
	var loginNickname = "";
	var loginUIdx = '<%=login.getU_idx() %>';
	var hostUIdx = '<%=host.getU_idx() %>';
	//화면시 시작되면 함수 바로 시작
	$(function() {			
		getCommentList(); //댓글 불러오기
		$(".comment_set_btn").click(setComment); //댓글 등록하기
		
		//쓰기 수정 삭제 버튼 호스트만 보이게
		if (loginUIdx != hostUIdx) {
			$(".host_show").hide();
			$("#btnDiv").css({"left" : "84%"}); //목록버튼 하나만 보일시 위치 수정
		} else {
			$(".host_show").show();
		}
	});
	
	//댓글 읽어오기
	function getCommentList() {		
		$.ajax("DiaryCommentsListController", {
			type : 'get',
			dataType : "json",
			success : function(data) {
				console.log(data);
				console.log(data.list);
				
				//전달받은 json데이터 댓글부분에 출력처리
				var comment = "";
				var alist = data.list; 
				$.each(alist, function(index, comments) {
					comment += '<div class="get_comment_div">';
					comment += '<p><b>' + comments.nickname + ' │ </b>' + comments.content + '&nbsp;&nbsp;<span id="comment_regdate">(' + comments.regdate + ')</span></p>'
		 			comment += '<button id="comment_modify_btn" class="hidden" value="'+ comments.nickname + '" onclick="modiCommentForm('+ comments.c_idx + ')"><a href="#title">수정</a></button>'
		 			comment += '<button id="comment_del_btn" class="hidden" value="'+ comments.nickname + '" onclick="delComment('+ comments.c_idx + ')">삭제</button>'
					comment += "</div>";		
				}); 
				$("#wrap #wrap1 #right1 #right2 #right3 #comments").html(comment);
				hidden_btn(); //로그인 한 사람 댓글만 수정/삭제버튼 보이게
			},
			error : function () {
				comment = "";
				comment += "<p>등록된 댓글이 없습니다</p>";
				$("#wrap #wrap1 #right1 #right2 #right3 #comments").html(comment);
			}			
		});			
	}
	
	//댓글 조회시 내가쓴 댓글만 수정,삭제 버튼 보이게 하기
	function hidden_btn() {
		loginNickname = '<%=login.getNickname() %>';		
		for (var i = 0; i <= $(".hidden").length; i++) {
				if ($(".hidden").eq(i).val() != loginNickname) {
					$(".hidden").eq(i).css("display", "none");
				}
		}	
	}	
	
	//댓글 등록하기
	function setComment() {
		var setContent = $(".set_content").val();
		var setNickname = '<%=login.getNickname() %>';
		//서버로 보낼 파라미터
		var send_data = "setContent=" + setContent + "&setNickname=" + setNickname;
		var inputBox = "";
		if (setContent.trim() != "") {//입력창이 비어있지 않으면 등록 진행			
			$.ajax("DiaryCommentsSetController", {
				type : 'post',
				data : send_data,
				success : function(data) {
					alert("댓글 등록 성공");
					console.log(data);
					console.log(data.list);	
					getCommentList();	
					$(".set_content").val("");
				},			
				error : function () {
					alert("setComment - Ajax 처리 실패 다시 입력해주세요");
				}			
			});		
		} else { //비어있으면 경고
			alert("댓글을 입력해주세요");
		}
	}
	
	//댓글 입력창에서 수정할 수 있게 기존 값 넣어주기
	function modiCommentForm(c_idx) {
		$.ajax({
			url : "DiaryCommentsModiFrmController?c_idx=" + c_idx, 
			type : 'get',
			dataType : "json",
			success : function(data) {
				$(".set_content").val(data.content);//댓글 입력창에 기존에 있던 정보 불러오기				
				//입력버튼 -> 수정/취소 버튼으로 바꾸기
				var comment = '<input id="input2" class="comment_modi_ok" type="button" onclick="modiCommentOk(' + c_idx + ')" value="수정">';
				comment += '<button id="input2" onclick="modi_cancel()">취소</button>';
				$("#set_modi_btn").html(comment);
			},
			error : function () {
				alert("modiCommentForm - Ajax 처리 실패");
			}			
		});				
	}
	
	//댓글 수정 취소눌렀을 경우 입력버튼,입력창 기본값 복구
	function modi_cancel() {
		$(".set_content").val("");
		var comment = '<input id="input" class="comment_set_btn" type="button" value="댓글입력">';
		$("#set_modi_btn").html(comment);
		getCommentList();
	}
	
	//댓글 수정하기	
	function modiCommentOk(c_idx) {
		var modi_comm_content = $(".set_content").val();
		alert("c_idx : " + c_idx + ", modi_comm_content : " + modi_comm_content);
		
		//서버로 보낼 파라미터
		var send_data = "c_idx=" + c_idx + "&modi_comm_content=" + modi_comm_content;
		$.ajax("DiaryCommentsModiOkController", {
			type : 'post',
			data : send_data,
			success : function(data) {
				//수정 후 입력버튼,입력창 기본값 복구
				alert("댓글 수정 성공");
				$(".set_content").val("");
				var comment = '<input id="input" class="comment_set_btn" type="button" value="댓글입력">';
				$("#set_modi_btn").html(comment);
				getCommentList();				
			},
			error : function(jqXHR, textStatus, errorThrown){
	            alert("modiCommentOk - Ajax 처리 실패");
	        } 	
		});			
	}	
	
	//댓글 삭제하기		
	function delComment(c_idx) {
		var answer = confirm("댓글을 삭제하시겠습니까?");
		if (answer) {
			/* alert("[삭제완료]");	 */
		
			//서버로 보낼 파라미터
			var send_data = "c_idx=" + c_idx;
			$.ajax("DiaryCommentsDeltController", {
				type : 'post',
				data : send_data,
				success : function(data) {
					alert("댓글 삭제 성공");
					getCommentList();				
				},
				error : function(jqXHR, textStatus, errorThrown){
					getCommentList();
		           alert("delComment - Ajax 처리 실패");
		        } 	
			});			
		} else {
			alert("댓글 삭제가 취소되었습니다.");
		}
	}	
	
	
	//--------------------------- 다이어리 수정 -----------------------------
	
	//다이어리 수정 하기
	function modify_go() {
		location.href = "DiaryModifyController";
	}
	
	//다이어리 삭제 하기
	function delete_go() {
		var answer = confirm("다이어리를 삭제하시겠습니까?");
		if (answer) {
			alert("[삭제완료] 목록으로 이동합니다.");
			location.href = "DiaryDeleteController?d_idx=<%=d_idx %>&cPage=<%=cPage %>";			
		} else {
			alert("취소되었습니다.");
		}
	}
	
	//다이어리 목록 가기
	function list_go() {
		location.href = "DiaryListController?cPage=<%=cPage %>";		
	}	
	
	//다이어리 쓰기
	function write_go() {
		location.href = "diary_write.jsp?cPage=<%=cPage %>";
	}
	
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
					${host.nickname } 님의 홈페이지입니다.
				</div>	
				<div id="openBtnDiv" OnClick="location.href='open.jsp'" style="cursor:pointer;">
					<img id="helloImg" src="images/helloworld2.png" alt="헬로월드">
					<span>메인으로</span>
				</div>
				<!-- =========================================================== -->
				
				<div id="right3" class="box3">
					<div id="title"> <!-- 제목 -->
						다이어리
					</div>					
					<div id="title2" class="diary">
						${dvo.title }					
					</div>					
					<div id="dName_dDate" >
						<span id="dName">${host.nickname }</span>
						<span id="dDate">${dvo.regdate }</span>						
					</div>
					<div id="content" class="diary"> <!-- 내용 -->
						${dvo.content }
					</div>
					<div id="btnDiv">
						<a href="#" onclick="write_go()" class="host_show">쓰기</a>
						<a href="#" onclick="modify_go()" class="host_show">수정</a>
						<a href="#" onclick="delete_go()" class="host_show">삭제</a>
						<a href="#" onclick="list_go()">목록</a>
					</div>				
					<div id="commentDiv"> <!-- 댓글 입력 부분 -->
						<p>${login.nickname }</p>
						<span id="set_content_input"><input id="comment" class="set_content"  type="text" placeholder="댓글입력창"></span>
						<span id="set_modi_btn"><input id="input" class="comment_set_btn" type="button" value="댓글입력"></span>
					</div>					
					<div id="comments"> <!-- 댓글 출력 부분 -->
					</div>			
				</div>
				<!-- right3 -->
				
				<!-- ======================================================== -->
								
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