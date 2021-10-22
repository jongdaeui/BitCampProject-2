<%@page import="com.helloworld.vo.GuestBookVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//System.out.println(session.getAttribute("vo"));
//request.getAttribute("list");
	request.setCharacterEncoding("UTF-8");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<link href="form.css" rel="stylesheet" type="text/css" />
<style>
	/* 버튼, 링크 공통 스타일 */
a:link { color: #48ADDA; text-decoration: none;}
a:visited { color: #48ADDA; text-decoration: none;}
a:hover { color: #48ADDA; text-decoration: underline;}
input:hover { background-color: lightgray; text-decoration: none;}

	/* 현재 페이지 버튼 스타일 변경 */
#navigation > li:nth-child(6)>a {  
	background-color: white; color: black;
	border-left: none;
}
	/* 현재 등록된 방명록이 없습니다. */
#gEmpty {  
   border: 1px solid #D4D4DC;
   border-radius: 5px;
   font-size: 20px;
   text-align:center;
   margin-top: 15px;
   width: 400px;
   position: relative;
   left: 50%;
   transform: translate(-50%);
}
/***** 방명록 작성 부분 *****/
#guest_write { /* 방명록 작성 화면 전체 설정 */
	display: flex;
	align-items : flex-start;
	margin-top: 15px;
	margin-left: 40px;
	width: 500px;
	height: 180px;
	padding-left: 10px;
	padding-top: 15px;
	background-color: #D4DADE;
	border-radius: 5px;
}
#guest_write_profile_div { /* 방명록 작성창 프로필 사진 박스 */
	width: 30%; height: 90%;
	margin-left: 10px;
}
#guest_write_profile { /* 방명록 작성창 프로필 사진 내용 */
	width: 100%;
	height: 100%;
	background-image: url("images/character1.png");
	background-position: center;
	background-size: contain;
	background-repeat: no-repeat;
	border: none;
	background-color: white;
	cursor: pointer;
}
#guest_write_form { /* 방명록 작성 폼 */
	width: 60%; height: 75%;
	margin-left: 15px;
}
#guest_write_textarea_div { /* 방명록 textarea 박스 */
	width: 100%; height: 100%;
}
#guest_write_textarea { /* 방명록 textarea 내용 */
	overflow: hidden;
	resize: none;
	border: 1px solid gray;
	border-radius: 3px;
}
#guest_write_button_div { /* 방명록 작성 폼 하단 버튼 박스 */
	margin-top: 10px;
	margin-left: 65px;
	width: 70px;
	height: 30px;
}
#guest_write_button_div input { /* 방명록 작성 폼 하단 버튼 */
	border-radius: 5px;
	border: 1px solid gray;
}
#guest_write_button_div input[type=button], input[type=reset] { /* 방명록 작성 폼 하단 버튼 (확인, 리셋) */
	width: 100%; height: 100%;
	border-radius: 5px;
	border: 1px solid gray;
	cursor: pointer;
}
#checkbox1 { /* 비밀글 설정 체크 박스 */
	width: 12px; height: 12px;
	border-radius: 5px;
	border: 1px solid gray;
}
#label {  /* 비밀글 설정 text */
	font-size: 13px;
}

/***** 방명록 테이블 부분 *****/
#guestBook {  /* 방명록 게시글 각각의 전체 화면 설정 */
	margin-top: 10px;
	margin-left: 30px;
	width: 530px;
	border-spacing: 10px;
	table-layout: fixed;
}
#guestBook td {  /* 방명록 헤더, 내부의 내용 출력 박스 */
	padding-left: 10px;
}
.title2 {  /* 방명록 헤더 부분 */
	margin-bottom: 5px;
	height: 25px;
	border-radius: 5px;
	background-color: #D4DADE;
	border: none;
	color: #48ADDA;
	text-decoration: none;
}
.title2 > :nth-child(1) { /* 방명록 헤더 글 번호 */
	font-size: 12px;
}
.title2 > :nth-child(2) { /* 방명록 헤더 작성자 닉네임 */
	display: inline-block;
	vertical-align: middle;
	width: 150px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	margin-left:10px;
	
}
.title2 > :nth-child(3) { /* 방명록 헤더 (작성일) */
	font-size: 12px;
}
.title2 > :nth-child(n+4) { /* 방명록 헤더 (비공개 ~ 마지막 정보) */
	font-size: 13px;
}
.title2 > :nth-child(4) { /* 방명록 헤더 옵션 메뉴 */
	margin-left: 35px;
}
.image {  /* 방명록 이미지 부분 */
	height: 120px;
	border: 1px solid #D4DADE;
	text-align: center;
}
.content {  /* 방명록 내용 부분 */
	border: 1px solid #D4DADE;
	border-radius: 5px;
}

/***** 방명록 댓글 출력 부분 *****/
.guest_comment_div { /* 방명록 댓글 출력 박스 */
	margin-left: 40px;
	width: 510px;
	background-color: #D4DADE;
	border: none;
	border-radius: 5px;
	color: #48ADDA;
	text-decoration: none;
}
.guest_comment_div > :nth-child(2) { /* 방명록 개별 댓글 출력 박스 */
	display: inline-block;
	vertical-align: middle;
	width: 500px;
	white-space: normal;
	font-size: 12px;
}
.comment_regdate { /* 방명록 댓글 작성일 출력 */
	font-size: 11px;
	margin-left: 20px;
}
.guest_comment_class { /* 방명록 개별 댓글 출력 박스 */
	padding: 5px;
}
.guest_comment_class > div { /* 방명록 개별 댓글 출력 */
	font-size: 13px;
	color: black;
	margin: 3px 5px 0px 5px;
	border-bottom: 1px solid #c8c8c8;
	padding-bottom: 2px;
	padding-left: 5px;
}
.comment_delete_button { /* 방명록 댓글 삭제 버튼 */
	width: 23px; height: 15px;
	margin-left: 10px;
	margin-top: 3px;
	padding: 0px;
	font-size: 11px;
	display: none;
	background-color: #D4DADE;
	border: none;
	border-radius: 3px;
	cursor: pointer;
	color: #48ADDA
}
.comment_delete_button:hover { /* 방명록 댓글 삭제 버튼 호버 */
	text-decoration: underline;
	background-color: #D4DADE;
}

/***** 방명록 하단 댓글 작성 화면 전체 설정 *****/
.guest_reply { /* 방명록 댓글 작성 전체 화면 */
	margin-left: 40px;
	width: 510px;
	background-color: #D4DADE;
	border: none;
	border-radius: 5px;
}
.guest_reply_form { /* 방명록 댓글 작성 폼 */
	height: 70px;
	margin-left: 15px;
	display: flex;
	align-items: center;
}
.guest_reply_form > div > textarea { /* 방명록 댓글 작성 textarea */
	resize: none;
	border-radius: 3px;
}
.guest_reply_form > div > input { /* 방명록 댓글 작성 버튼 */
	margin-left: 10px;
	width: 50px;
	height: 40px;
	border-radius: 5px;
	border:0.5px solid gray;
	cursor: pointer;
}

/***** 삭제, 수정 요청시 비밀번호 입력 요청 창 *****/
.guestBook_div { /* 정보 요청 창 숨기기처리를 위한 relative */
	position: relative;
}
.guest_body_requestpassword_div { /* 입력 요청 화면 전체 설정 */
	box-shadow: 1px 1px 5px 0.5px gray;
	background-color: lightgray;
	width: 250px; height: 50px;
	position: absolute;
	top: 50px; left: 300px;
	display: none;
}
.guest_body_requestpassword_div > form { /* 입력 요청 화면 폼 */
	width: 100%; height: 55%;
	display: flex;
	justify-content: center;
	align-items: flex-end;
}
.guest_body_requestpassword > :nth-child(1) { /* 입력 요청 textarea */
	border: 1px solid gray;
}
.guest_body_requestpassword_sumbit { /* 입력 요청 버튼 박스 */
	margin-left: 5px;
}
.guest_body_requestpassword_sumbit > input { /* 입력 요청 버튼 */
	height: 23px;
	border-radius: 3px;
	border: 1px solid gray;
}
.guest_body_wrongpassword_div { /* 암호 미일치 안내 메세지 전체 */
	width: 94%; height: 40%;
	display: flex;
	padding-left: 15px;
	visibility: hidden; 
}
.guest_body_wrongpassword_v { /* 암호 미일치 이미지 박스 */
	width: 12px; height: 12px;
}
.guest_body_wrongpassword_v > img { /* 암호 미일치 이미지 박스 */
	width: 100%; height: 100%;
	object-fit: cover;
	
}
.guest_body_wrongpassword_message { /* 암호 미일치 메세지 출력 */
	font-size: 11px;
	padding-top: 3px;
} 
/***** 게시글 수정 입력 창 *****/
.guest_body_update_div { /* 방명록 수정 화면 전체 설정 */
	position: absolute;
	top: 9px; left: 199px;
	width: 350px; height: 190px;
	display: none;
}
.guest_body_update_form { /* 방명록 수정 폼 */
	display: flex;
	flex-wrap: wrap;
	width: 100%; height: 100%;
}
.guest_body_update_form > textarea { /* 방명록 수정 textarea */
	width: 100%; height: 74%;
	resize: none;
	margin-top: 5px;
	border: 1px solid gray;
	border-radius: 5px;
}
.guest_body_update_form :nth-child(2) { /* 방명록 수정 화면 확정 버튼 */
	margin-left: 230px;
}
.guest_body_update_form > input { /* 방명록 수정 화면 버튼 */
 	width: 50px; height: 22px;
	margin: 3px 3px 3px 0px;
	border: 1px solid gray;
	border-radius: 5px;
}
/***** 페이징 처리 *****/
#pagingOption_div {
	margin-left: 40px;
	margin-top: 10px;
}
#btnDiv {  /* 페이지 이동 버튼 감싸고 있는 div */
	position: relative;
	left: 40%;
	bottom: -35%;
	width: 130px;
}
#paging > a {  /* 페이지 이동 버튼 디자인 */
	margin-right: 7px;
	border: none;
	border-radius: 5px;
	text-decoration: none;
	background-color: white;
	color: black;
}
#img {
	width: 100px;
}
.pagingHide {
	pointer-events: none;
	cursor: default;
}
</style>
<body>
<script>
	window.onpageshow = function(event) {
		if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
			location.href="home.jsp";
        }
	}
	/* 홈페이지 소유자 접속시 모든 게시글 댓글 창 show, 방명록 작성 창 hide */
	$(function () {
		if (${host.u_idx} == ${login.u_idx}) {
			$(".guest_reply").show();
			$(".guest_write_class").hide();
		}
	});
	
	/* 비회원 로그인 시 방명록 작성창, 게시글 메뉴 선택 창 hide */
	$(function (){
		if(${login.u_idx} == -1) {
			$("#guest_write").hide();
			$(".option").hide();
			$(".separate").hide();
		}
	});
	
	
	/* 로그인한 계정 확인 후 본인 댓글 삭제 버튼 활성화 */
	$(function (){
		$(".comment_" + "${login.nickname}").find('input').show();
	});
	
	/* 본인이 작성한 게시글에만 댓글 입력 창 show, 다른 게시물 댓글 작성창, 옵션 메뉴 hide */
	function hideReply(nickname, g_idx) {
		if (nickname === '${login.nickname}') {
			$("#guest_reply_" + g_idx).show();
			$("#title2_" + g_idx + " > :nth-child(n+4)").show();
		}
		if (nickname !== '${login.nickname}') {
			$("#guest_reply_" + g_idx).hide();
			$("#title2_" + g_idx + " > :nth-child(n+4)").hide();
		}
	};
	
	
	/* 댓글 작성 요청시 내용 공백 확인 */
	function checkReplyContentEmpty(g_idx) {
		var content = $("#guest_reply_form_" + g_idx + " [name='content']").val();
		if ( content ) {
			location.href="InsertReply?g_idx=" + g_idx + "&content=" + content;
			$("#guest_reply_textarea_div_" + g_idx).find("textarea").val("");
		} else {
			alert("입력된 내용이 없습니다.\n내용을 입력해주세요");
			$("#guest_reply_textarea_div_" + g_idx).find("textarea").focus();
		}
	}
	
	/* 방명록 작성, 수정시 개행 처리 */
	function getNewContent(formId, g_idx) {
		var newContent = $("#" + formId + " [name='content']").val().replace(/(?:\r\n|\r|\n)/g, '<br />');
		if (button == 'update') {
			checkUpdate(g_idx, newContent, formId);
		} else {
			checkContentEmpty(newContent, formId);
		}
	}
	
	/* 수정할 게시글 내용 입력 후 공백확인 처리 */
	function checkUpdate(g_idx, newContent, formId) {
		if (newContent) {
			alert("방명록을 수정합니다.");
			$("#" + formId + " [name='content']").val(newContent);
			$("#" + formId).submit();
			$("#guest_reply_" + g_idx).show();
			$("#title2_" + g_idx + " > :nth-child(n+4)").show();
			button = "";
		} else {
			alert("입력된 내용이 없습니다.\n내용을 입력해주세요");
			$("#guest_body_update_textarea_" + g_idx).focus();
		}
	}
	
	/* 방명록 작성 요청시 내용 공백 확인 */
	function checkContentEmpty(newContent, formId) {
		if ( newContent ) {
			alert("방명록을 작성합니다.");
			$("#guest_write_textarea").val(newContent);
			$("#" + formId).submit();
		} else {
			alert("입력된 내용이 없습니다.\n내용을 입력해주세요");
			$("#guest_write_textarea").focus();
		}
	}
	
	/* 삭제, 수정 선택시 비밀 번호 입력 창 출력 */
	let button = "";
	function deleteContent(g_idx) {
		button = "delete";
		$("#guest_body_requestpassword_" + g_idx).show();
		$("#updateButton").css("visibility", "hidden");
		
	}
	
	function updateContent(g_idx) {
		button = "update";
		$("#guest_body_requestpassword_" + g_idx).show();
		$("#deleteButton").hide();
	}
	
	/* 삭제, 수정 버튼, 비밀번호 입력 창 이외의 부분 클릭시 비밀번호 입력 요청 창 숨김 */
	function handleClicks(e) {
		var click = e.target;
		if ((click.className != "guest_body_requestpassword_div") &&
			(click.className != "guest_body_requestpassword_sumbit") &&
			(click.className != "guest_body_requestpassword") &&
			(click.className != "guest_body_wrongpassword_div") &&
			(click.className != "notIn") &&
			(click.id != "updateButton") &&
			(click.id != "deleteButton"))
		{
			$(".guest_body_requestpassword_div").hide();
			$(".guest_body_requestpassword > input:nth-child(1)").val("");
			$(".guest_body_wrongpassword_div").css("visibility", "hidden");
			if (${host.u_idx} == ${login.u_idx}) {
				$("#deleteButton").hide();
				$("#updateButton").css("visibility", "hidden");
			} else {
				$("#deleteButton").show();
				$("#updateButton").css("visibility", "visible");
			}
		}
    }
	
	/* 삭제, 수정시 비밀번호 검증 후 해당 작업 진행 */
	function checkPassword(g_idx) {
		var password = $("#guest_body_requestpassword_input_" + g_idx).val();
		if (password != '${login.pwd}') {
			$(".guest_body_wrongpassword_div").css("visibility", "visible");
			$("#guest_body_requestpassword_input_" + g_idx).focus();
		} else {
			if (button == "delete") {
				deleteProcess(g_idx);
				button = "";
			}
			if (button == "update") {
				$("#guest_body_requestpassword_" + g_idx).hide();
				$("#guest_reply_" + g_idx).hide();
				$("#title2_" + g_idx + " > :nth-child(n+4)").hide();
				$("#guest_body_update_" + g_idx).show();
			}
		}
	}
	
	/* 암호 검증 완료된 게시물 삭제 처리 */
	function deleteProcess(g_idx) {
		if (confirm("방명록 게시물을 삭제하시겠습니까?")) {
			alert("게시물 삭제 완료");
			location.href="DeleteGuestBook?g_idx=" + g_idx;
		} else {
			alert("게시물 삭제를 취소합니다.");
		}
	}
	
	/* 댓글 삭제 확인 및 실행 */
	function deleteComment(c_idx) {
		if (confirm("댓글을 삭제하시겠습니까?")) {
			location.href="DeleteComment?c_idx=" + c_idx;
		} else {
			alert("게시물 삭제를 취소합니다.");
		}
	}
	
	/* 페이징 옵션 변경시 value 값 넘기기 */
	function pagingOptionChanged(option) {
		var maxContent = option.value
		$("#pagingOptionForm [name=maxContent]").attr("value", maxContent);
		$("#pagingOptionForm").submit();
	}
	
	/* 페이지 번호 선택시 해당 페이지 번호와 페이징 옵션 값 전달 */
	function sendPage(selected) {
		var page = $(selected).text();
		$("#pagingForm [name=currentPage]").attr("value", page);
		$("#pagingForm [name=maxContent]").attr("value", $("#pagingOption > option:selected").val());
		$("#pagingForm").submit();
		
	}
	
	/* 게시물 출력 max값 고정 */
	$(function () {
		var maxContent = ${maxContent}
		$("#pagingOption").val(maxContent).attr("selected", "selected");

		var currentPage = ${currentPage}
		$("#paging > a:contains('" + currentPage + "')").attr("class", "pagingHide");
	});
	
	/* 방명록 각 게시글별 댓글 출력을 위한 ajax 처리 */
	function getCommentList(g_idx) {
		$.ajax({
			url : "GetComment",
			type : "get",
			data : "content=" + g_idx,
			dataType : "xml", 
			success : function(data){
				let tbody = "";
				if (!data) {
					$("#guest_comment_" + g_idx).html("등록된 댓글이 없습니다.");
				}
				$(data).find("comment").each(function(){
						let nickname = $(this).find("nickname").text();
						let c_idx = $(this).find("c_idx").text();
						tbody += "<div class='comment_" + nickname + "';>";
						tbody += "<span><a href='#'>";
						tbody += nickname;
						tbody += "</a></span>" + " : ";
						tbody += "<span>";
						tbody += $(this).find("content").text();
						tbody += "</span>";
						tbody += "<span class='comment_regdate'>(" + $(this).find("regdate").text() + ")</span>";
						tbody += "<input class='comment_delete_button' type=" + "'button'" + " value=" + "'삭제'" + " onclick=" + "'deleteComment(" + c_idx + ")'>";				
						tbody += "</div>";
						$("#guest_comment_" + g_idx).html(tbody);
				});

			},
			error : function(){
				alert("Ajax 처리 실패 : \n"
						+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThorwn);
			}
		});
	}
	
	
	document.addEventListener('click', handleClicks, false);
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
		
		<div id="right1" class="box1">
			<div id="right2" class="box2">
				<div id="nickname">
					${host.nickname }님의 홈페이지입니다.
				</div>
				<div id="openBtnDiv" OnClick="location.href='open.jsp'" style="cursor:pointer;">
					<img id="helloImg" src="images/helloworld2.png" alt="헬로월드">
					<span>메인으로</span>
				</div>
				<div id="right3" class="box3" style="overflow: scroll;">
					<div id="title">
						방명록
					</div>
					<!-------- 방명록 작성 부분 ---------->
					<div class="guest_write_class" id="guest_write">
						<!-- 프로필 사진 -->																					
						<div id="guest_write_profile_div"> 
							<input type="button" id="guest_write_profile">
						</div>
						<!-- 방명록 작성 폼 -->
						<form action="InsertContent" method="post" id="guest_write_form">
							<div id="guest_write_textarea_div">
								<textarea id="guest_write_textarea" name="content" style="width:100%; height:100%;"></textarea>
								<input type="hidden" name="u_idx" value="${host.u_idx }">
								<input type="hidden" name="nickname" value="${login.nickname }">
							</div>
							<div id="guest_write_button_div">
								<input style="visibility: hidden;" type="checkbox" name="private" id="checkbox1"><label style="visibility: hidden;" id="label" for="checkbox1">비밀로 하기</label>
								<input type="button" value="확인" onclick="javascript:getNewContent('guest_write_form')">
								<input type="reset" value="새로작성">
							</div>
						</form>
					</div>
					<!-- 방명록 게시글 출력 갯수 선택 -->
					<div id="pagingOption_div">
						<form id="pagingOptionForm" name="pagingOptionForm" action="GetAllCommand" method="post">
							<input type="hidden" name="maxContent">
						</form>
						<select id="pagingOption" onchange="javascript:pagingOptionChanged(this);">
							<option value="" disabled="disabled">선택</option>
							<option value="5">5개씩</option>
							<option value="10">10개씩</option>
							<option value="20">20개씩</option>
						</select>
					</div>
					<!-------방명록 출력 부분------->
             		<c:if test="${empty list }">
                  		<div id="gEmpty">현재 등록된 방명록이 없습니다.</div>
                  		<script>$("#pagingOption_div").hide();</script>
               		</c:if>
					<!-------방명록 출력 부분------->
					<c:forEach var="vo" items="${list }">
					<div class="guestBook_div">
					<table id="guestBook">
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tbody>
							<!-- 방명록 게시글 헤더 -->
							<tr>
								<td id="title2_${vo.g_idx }" class="title2" colspan="2">
									<span>.${vo.g_idx }</span>
									<span><a href="#">${vo.nickname }</a></span>
									<span>(${vo.regdate })</span>
									<a style="visibility: hidden;" href="#">비공개</a>
									<span style="visibility: hidden;">|</span>
									<a href="#" onclick="updateContent(${vo.g_idx});" id="updateButton">수정</a>
									<span class="separate">|</span>
									<a href="#" onclick="deleteContent(${vo.g_idx});" id="deleteButton">삭제</a>
								</td>
							</tr>
							<!-- 방명록 게시글 내용 -->
							<tr>
								<td id="td1" class="image"><img id="img" src="images/character1.png"></td>
								<td id="td2_${vo.g_idx }" class="content" style="white-space:normal;">
									${vo.content}
								</td>
							</tr>
						</tbody>
					</table>
					<!-- 삭제, 수정 요청시 비밀번호를 입력받는 부분 show / hide 처리 -->
					<div class="guest_body_requestpassword_div" id="guest_body_requestpassword_${vo.g_idx }">
		 				<form action="javascript:checkPassword(${vo.g_idx });" method="post" class="notIn" id="guest_body_requestpassword_form">
		 					<div class="guest_body_requestpassword">
		 						<input id="guest_body_requestpassword_input_${vo.g_idx }" class="notIn" type="password" name="password" placeholder="암호를 입력해주세요"/>
		 					</div>
		 					<div class="guest_body_requestpassword_sumbit">
		 						<input class="notIn" type="submit" value="확인">
		 					</div>
		 				</form>
		 				<div class="guest_body_wrongpassword_div">
		 					<div class="guest_body_wrongpassword_v">
		 						<img class="notIn" src="img/red_v2.png">
		 					</div>
		 					<div class="guest_body_wrongpassword_message">
		 						<span class="notIn">암호를 확인해주세요!!</span>
		 					</div>
		 				</div>
					</div>
						<!-- 방명록 수정을 위해 새로운 텍스트를 입력받는 창 -->
						<div class="guest_body_update_div" id="guest_body_update_${vo.g_idx }">
							<form action="UpdateContent" class="guest_body_update_form" id="guest_body_update_form_${vo.g_idx }" method="post" name="updateForm">
								<input type="hidden" name="g_idx" value="${vo.g_idx }">
								<input type="button" value="수정" onclick="javascript:getNewContent('guest_body_update_form_${vo.g_idx }', ${vo.g_idx });">
								<input type="button" value="취소" onclick="javascript:$('#guest_body_update_' + ${vo.g_idx}).hide(); 
								$('#guest_reply_' + ${vo.g_idx}).show(); $('#title2_' + ${vo.g_idx} + ' > :nth-child(n+4)').show();">
								<textarea id="guest_body_update_textarea_${vo.g_idx }" name="content"></textarea>
							</form>
						</div>
					</div>
					<!-- 방명록 댓글 표시창 -->
					<div class="guest_comment_div" id="guest_comment_div_${vo.g_idx }">
						<script>getCommentList(${vo.g_idx});</script>
						<div id="guest_comment_${vo.g_idx }" class="guest_comment_class">등록된 댓글이 없습니다.</div>
					</div>
					<!-- 방명록 하단 댓글 작성 창(방명록 소유자에게만 표시) -->
					<div class="guest_reply" id="guest_reply_${vo.g_idx }">
						<script>hideReply('${vo.nickname}', ${vo.g_idx});</script>
						<form action="javascript:checkReplyContentEmpty(${vo.g_idx })" method="post" class="guest_reply_form" id="guest_reply_form_${vo.g_idx }">
							<div id="guest_reply_textarea_div_${vo.g_idx }" class="guest_reply_textarea_div">
								<textarea class="guest_reply_textarea" name="content" cols="55" rows="3"></textarea>
 							</div>
							<div id="guest_reply_button_div">
								<input type="submit" value="확인">
							</div>
						</form>
					</div>
					</c:forEach>
					<!-- 페이징 버튼 -->
					<div id="btnDiv">
						<form id="pagingForm" name="pagingForm" action="GetAllCommand" method="post">
							<input type="hidden" name="currentPage" />
							<input type="hidden" name="maxContent" />
						</form>
						<div id="paging">
							<a href="#">&lt;</a>
							<a href="#" onclick="javascript:sendPage(this)">1</a>
							<a href="#" onclick="javascript:sendPage(this)">2</a>
							<a href="#" onclick="javascript:sendPage(this)">3</a>
							<a href="#" onclick="javascript:sendPage(this)">4</a>
							<a href="#">&gt;</a>
						</div>
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