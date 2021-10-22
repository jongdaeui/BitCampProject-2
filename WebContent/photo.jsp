<%@page import="com.helloworld.vo.CommentsPVO"%>
<%@page import="com.helloworld.common.PhotoPaging"%>
<%@page import="java.util.List"%>
<%@page import="com.helloworld.vo.PhotoVO"%>
<%@page import="com.helloworld.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%

// 호스트 정보 가져오기
MemberVO host = (MemberVO) session.getAttribute("host");

// 로그인 정보 가져오기
MemberVO login = (MemberVO) session.getAttribute("login");

// 호스트와 로그인 정보 비교에서 홈페이지 주인 여부 확인
int owner = 0;
if (login != null) {
	if (login.getU_idx() == host.getU_idx()) {
		owner = 1;
	}
}

// 리스트 가져오기
List<PhotoVO> photoVO = (List) request.getAttribute("photoVO");
List<CommentsPVO> commentsList = (List) request.getAttribute("cList");
PhotoPaging p = (PhotoPaging) request.getAttribute("pvo");
String path = "upload/image";
String realPath = request.getServletContext().getRealPath(path);
// 컨트롤러 경유 여부 확인용 
String flag = (String) request.getAttribute("flag");

System.out.println("flag: " + flag);

//EL, JSTL 사용을 위해 page scope 등록
pageContext.setAttribute("owner", owner); // 홈페이지 주인 여부 확인 결과
pageContext.setAttribute("pList", photoVO); // 사진첩 리스트 
pageContext.setAttribute("cList", commentsList); // 코멘트 리스트
pageContext.setAttribute("flag", flag); // 플래그 구분 여부 
pageContext.setAttribute("pvo", p); // 사진첩 페이징 정보
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진첩</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="form.css" rel="stylesheet" type="text/css" />
<script>
	function init(){
	<%if (photoVO == null) {%>
		location.href = "photoController?type=pListAll&u_idx=<%=host.getU_idx()%>";
	<%} else {%>
		//return false;
		//alert('not null');
	<%}%>
	}
	
	function del(p_idx){
		var yn = confirm("정말로 삭제하시겠습니까?");
		if(yn){
			console.log("photo.jsp, p_idx : " + p_idx);
			location.href = "photoController?type=delete&p_idx=" + p_idx;
		}else{
			return false;	
		}
	}
	function modify(p_idx){
		location.href = "photoController?type=modifyInfo&p_idx=" + p_idx;
	}
	
	// 댓글 삭제 버튼 함수
	function cmntDelete(c_idx, p_idx){
		var yn = confirm("정말로 해당 댓글을 삭제하시겠습니까?");
		if(yn){
			$.ajax({
				url: "photoController",
				type: "post",
				data: {"c_idx": c_idx, "p_idx" : p_idx, type: "cmntDelete"},
				dataType: "json",
				success: function(data) {
					console.log("data : " + data);
					if (data != null) {
						var tbody="";
						var list = data.list; //JSON 객체의 속성명 "list"의 값 추출
						document.getElementById("pCmntCntn").value = "";
						$.each(list, function(){
							tbody += "<tr id=normal>";
							tbody += "<td>" + this.nickname + "</td>";
							tbody += "<td>" + this.content + "</td>";
							tbody += "<td>" + this.regdate + "</td>";
							if(this.nickname == '<%=login.getNickname()%>' && '<%=owner%>' == 0){
								tbody += "<td><label class=x onclick=cmntDelete("+this.c_idx+ "," + this.p_idx +")></label></td>";	
							}else if('<%=owner%>' == 1){
								tbody += "<td><label class=x onclick=cmntDelete("+this.c_idx+ "," + this.p_idx +")></label></td>";	
							}else{
								tbody += "<td></td>";	
							}
							tbody += "</tr>"; 
						});
					} else if (data == null) {
						tbody += "<tr>";
						tbody += "<td colspan='4'>등록된 코멘트가 없습니다.</td>";
						tbody += "</tr>"; 
					}
					$("#commentsTbody").html(tbody);
				},
				error: function(request, status, error) {
					alert("ajax 오류!");
					alert("code = " + request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				}
			});
		}else{
			return false;	
		}
		
	}
	
	// 댓글 입력 버튼 함수
	function pCmntCntnSubmit(p_idx){
		var fr = document.getElementById("pCmntCntn").value;
		if(fr.trim() == ""){
			alert("댓글 내용을 입력해주세요!");
			return false;
		}
		$.ajax({
			url: "photoController",
			type: "post",
			data: {"p_idx": p_idx, nickname: "${login.getNickname()}", comment: fr, type: "pCmntInsert"},
			dataType: "json",
			success: function(data) {
				console.log("data : " + data);
				if (data != null) {
					var tbody="";
					var list = data.list; //JSON 객체의 속성명 "list"의 값 추출
					document.getElementById("pCmntCntn").value = "";
					$.each(list, function(){
						tbody += "<tr id=normal>";
						tbody += "<td>" + this.nickname + "</td>";
						tbody += "<td>" + this.content + "</td>";
						tbody += "<td>" + this.regdate + "</td>";
						if(this.nickname == '<%=login.getNickname()%>' && '<%=owner%>' == 0){
							tbody += "<td><label class=x onclick=cmntDelete("+this.c_idx+ "," + this.p_idx +")></label></td>";
						}else if('<%=owner%>' == 1){
							tbody += "<td><label class=x onclick=cmntDelete("+this.c_idx+ "," + this.p_idx +")></label></td>";
						}else{
							tbody += "<td></td>";	
						}
						tbody += "</tr>"; 
					});
					$("#commentsTbody").html(tbody);
				} else if (data == null) {
					alert("실패");
					alert("댓글 등록에 실패하였습니다.\n 지속적으로 문제 발생시 관리자에게 문의해주세요.");
				}
			},
			error: function(request, status, error) {
				alert("ajax 오류!");
				alert("code = " + request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
			}
		});
	}

</script>
<style>
#navigation>li:nth-child(5)>a { /* 현재 페이지 버튼 스타일 변경 */
	background-color: white;
	color: black;
	border-left: none;
}

#photo {
	width: 550px;
	height: 300px;
	margin-left: 30px;
	margin-top: 10px;
	padding-left: 10px;
}

#btnDiv { /* 버튼 부분 */
	margin-top: 15px;
	position: relative;
	text-align: right;
	margin-right: 5px;
}

#btnDiv a { /* 입력, 수정, 삭제 a 태그 부분 */
	text-decoration: none;
	color: orange;
	margin-left: 10px;
	cursor: pointer;
}

#commentDiv { /* 댓글 입력 부분을 감싸는 div */
	/* 	margin-top: 20px;
	margin-left: 40px; */
}

#pCmntCntn { /* 댓글입력창 */
	width: 400px;
	height: 25px;
	padding-left: 10px;
	border-radius: 7px;
	border: 1px solid #CAD2D5;
	font-weight: bold;
}

#cmntInput { /* 댓글입력 버튼 부분 */
	width: 100px;
	height: 35px;
	margin-left: 10px;
	border-radius: 7px;
	border: none;
	font-weight: bold;
	background-color: #4FBAEA;
	color: white;
	cursor: pointer;
}

#comments { /* 댓글이 저장되는 부분 */
	width: 525px;
	border: 1px solid #CAD2D5;
	border-radius: 5px;
	/* 	margin-left: 40px;
	margin-top: 10px; */
	/* 	padding-left: 10px;
	padding-top: 10px; */
	height: 130px;
	overflow-y: auto;
	overflow-x: hidden;
}

#right3 {
	overflow: auto;
}

/* 사진첩 테이블 정보 */
#pTable {
	width: 540px;
	table-layout: fixed;
}

thead>tr:first-child {
	background-color: #f2f2f2;
	height: 30px;
}

#th_nick {
	text-align: left;
}

#th_reg {
	text-align: right;
}

/* 내용 */
#content {
	/* border: 3px solid black; */
	/* white-space: pre-wrap; */
	word-break: break-all;
}

pre {
	padding: 10px;
	overflow: auto;
	white-space: pre-wrap;
}

#commentsTbody {
	white-space: pre-wrap;
	word-break: break-all;
	overflow: auto;
}

#normal > td	{
	border-bottom: 1px #CAD2D5 dotted;
}

#normal>td:nth-child(1) {
 	width: 100px;
	/* margin-right: 5px; */
}
#normal>td:nth-child(2) {
 	width: 280px;
	/* margin-right: 5px; */
}
#normal>td:nth-child(3) {
 	width: 115px;
	/* margin-right: 5px; */
}
#normal>td:nth-child(4) {
 	width: 20px;
	/* margin-right: 5px; */
}

/*
#commentsTbody>>tr>td:first-child {
 	width: 120px;
	margin-right: 5px;
	border: 4px yellow solid;
}

#commentsTbody>tr>td:nth-child(2) {
	width: 350px;
	border: 3px red solid;
}

#commentsTbody>tr>td:nth-child(3) {
	position: relative;
	width: 115px;
	border: 1px green solid;
	
}

#commentsTbody>tr>td:nth-child(4) {
	width: 20px;
	border: 1px black solid;
	position:relative;
}

*/
#empty {
	width: 300px;
	position: relative;
}
#emptyP {
	text-align: center;
	border: 1px solid black;
}
/*-- 페이지 표시 영역 스타일 --*/
#pagingDiv {
	position: absolute;
	left: 45%;
	transform: translateX(-50%);
	/* width: 400px; */
}

.paging {
	list-style: none;
	text-align: center;
	display: inline-block;
}

.paging .disable {
	float: left;
	padding: 4px;
	margin-right: 3px;
	width: 30px;
	color: #000;
	font: bold 12px tahoma;
	border: 1px solid #eee;
	text-align: center;
	text-decoration: none;
	color: silver;
}

.paging li {
	float: left;
}

.paging li a {
	float: left;
	padding: 4px;
	margin-right: 3px;
	width: 20px;
	color: #000;
	font: bold 12px tahoma;
	border: 1px solid #eee;
	text-align: center;
	text-decoration: none;
	position: inline;
}

.paging li a:hover, .paging .now {
	color: #fff;
	width: 20px;
	margin-right: 3px;
	padding: 4px;
	border: 1px solid #f40;
	font: bold 12px tahoma;
	background-color: #f40;
}

/*X표시 CSS */
.x {
	display: inline-block;
	*display: inline;
	cursor: pointer;
}

.x:after {
	display: inline-block;
	content: "\00d7";
	font-size: 16pt;
	color: red;
}
</style>
<body onLoad="init();">
	<div id="wrap">
		<div id="wrap1">
			<div id="left1" class="box1">
				<div id="left2" class="box2">
					<div id="today">
						TODAY <span style="color: #EE5D1A; font-size: 13px;">${today }</span> |
						TOTAL <span style="font-size: 13px;">${total }</span>
					</div>

					<div id="left3" class="box3">
						<div id="todayIs">TODAY IS...</div>
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
						<div id="title">사진첩</div>
						<div id="photo">
							<!-- 사진 나오는 곳 -->
							<c:if test="${flag eq 'y'}">
								<c:choose>
									<c:when test="${empty pList }">
										<tabel>
										<tr>
											<td id="emptyP" colspan="4">등록된 게시물이 없습니다.</td>
										</tr>
										<tr>
											<td colspan="4">
											<c:if test="${owner != 0 }">
											<div id="btnDiv">
												<a href="photoInsert.jsp">쓰기</a>
											</c:if>
											</div></td>
										</tr>
									</c:when>
									<c:otherwise>
										<table id="pTable">
											<c:forEach var="vo" items="${pList }">
												<thead>
													<tr>
														<th colspan="3">${vo.title }</th>
													</tr>
													<tr>
														<th colspan="2" id="th_nick">${host.nickname}</th>
														<td id="th_reg">${vo.regdate}</td>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td colspan="3"><c:if
																test="${vo.filesysname != null && vo.filesysname != ''}">
																<img src="upload/image/${vo.filesysname }" width="100%">
															</c:if>
															<div id="content">
																<pre>${vo.content }</pre>
															</div></td>
													</tr>
													<tr>
														<td colspan="3"><c:if test="${owner != 0 }">
																<div id="btnDiv">
																	<a onclick="modify(${vo.p_idx})">수정</a> 
																	<a onclick="del(${vo.p_idx})">삭제</a>
																	<a href="photoInsert.jsp">쓰기</a>
															</c:if>
															</div></td>
													</tr>
													<c:if test="'<%=login.getU_idx() %>'">
														<tr>
															<td colspan="3">
																<div id="commentDiv">
																	<input id="pCmntCntn" type="text" placeholder="댓글입력창">
																	<input id="cmntInput" type="button" value="댓글입력"
																		onclick="pCmntCntnSubmit(${vo.p_idx})">
																</div>
															</td>
														</tr>
													</c:if>
													<tr>
														<td colspan="3">
															<div id="comments">
																<table id="commentsTable">
																	<tbody id="commentsTbody">
																		<c:if test="${flag eq 'y'}">
																			<c:choose>
																				<c:when test="${empty cList }">
																					<tr>
																						<td id="empty" colspan="4">등록된 코멘트가 없습니다.</td>
																					</tr>
																				</c:when>
																				<c:otherwise>
																					<c:forEach var="cVO" items="${cList }">
																						<tr id="normal">
																							<td>${cVO.nickname }</td>
																							<td>${cVO.content }</td>
																							<td>${cVO.regdate }</td>
																							<c:choose>
																								<c:when
																									test="${cVO.nickname == login.nickname && owner == 0}">
																									<td><label class="x"
																										onclick="cmntDelete(${cVO.c_idx}, ${vo.p_idx })"></label></td>
																								</c:when>
																								<c:when test="${owner != 0 }">
																									<td><label class="x"
																										onclick="cmntDelete(${cVO.c_idx}, ${vo.p_idx })"></label></td>
																								</c:when>
																								<c:otherwise>
																									<td>&nbsp;</td>
																								</c:otherwise>
																							</c:choose>
																						</tr>
																					</c:forEach>
																				</c:otherwise>
																			</c:choose>
																		</c:if>
																		<!-- 작업 끝단부 -->
																	</tbody>
																</table>
															</div>
														</td>
													</tr>
													<tr>
														<td colspan="3">&nbsp;</td>
													</tr>
												</tbody>
											</c:forEach>
										</table>
									</c:otherwise>
								</c:choose>
								<div id="pagingDiv">
									<ol class="paging">
										<c:choose>
											<%--[이전으로]에 대한 사용여부 처리 --%>
											<c:when test="${pvo.beginPage == 1 }">
												<li class="disable">이전</li>
											</c:when>
											<c:otherwise>
												<li><a
													href="photoController?type=pListAll&u_idx=<%=host.getU_idx()%>&cPage=1">처음</a>
												</li>
												<li><a
													href="photoController?type=pListAll&u_idx=<%=host.getU_idx()%>&cPage=${pvo.beginPage - 1 }">이전</a>
												</li>
											</c:otherwise>
										</c:choose>

										<%--블록내에 표시할 페이지 태그 작성(시작페이지~끝페이지) --%>
										<c:forEach var="pageNo" begin="${pvo.beginPage }"
											end="${pvo.endPage }">
											<c:choose>
												<c:when test="${pageNo == pvo.nowPage }">
													<li class="now">${pageNo }</li>
												</c:when>
												<c:otherwise>
													<li><a
														href="photoController?type=pListAll&u_idx=<%=host.getU_idx()%>&cPage=${pageNo }">${pageNo }</a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>

										<%--[다음으로]에 대한 사용여부 처리 --%>
										<c:if test="${pvo.endPage < pvo.totalPage }">
											<li><a
												href="photoController?type=pListAll&u_idx=<%=host.getU_idx()%>&cPage=${pvo.endPage + 1 }">다음</a></li>
											<li><a
												href="photoController?type=pListAll&u_idx=<%=host.getU_idx()%>&cPage=${pvo.totalPage }">끝</a></li>
										</c:if>
										<c:if test="${pvo.endPage >= pvo.totalPage }">
											<li class="disable">다음</li>
										</c:if>
									</ol>
								</div>

							</c:if>
						</div>
					</div>
					<!-- right3 -->
				</div>
				<!-- right2 -->
			</div>
			<!-- right1 -->

			<ul id="navigation">
				<li><a href="home.jsp?u_idx=<%=host.getU_idx()%>">홈</a></li>
				<li><a href="profile.jsp">프로필</a></li>
				<li><a href="DiaryListController">다이어리</a></li>
				<li><a href="BoardAllController">게시판</a></li>
				<li><a href="photo.jsp">사진첩</a></li>
				<li><a href="guest_book.jsp">방명록</a></li>
			</ul>
		</div>
		<!-- wrap1 -->
	</div>
	<!-- wrap -->
</body>
</html>