<%@page import="com.helloworld.vo.DiaryVO"%>
<%@page import="com.helloworld.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	
	MemberVO login = (MemberVO)session.getAttribute("login");
	System.out.println("diary_list.jsp - login : " + login);
	MemberVO host = (MemberVO) session.getAttribute("host");
	System.out.println("diary_list.jsp - host : " + host);
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
#navigation>li:nth-child(3)>a {  /* 현재 페이지 버튼 스타일 변경 */
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

#right3 { /* 다이어리 영역 스크롤 */
	overflow: auto;
	overflow-x:hidden;
} 

#diaryList table { /* 다이어리 목록 테이블 */
		width: 530px;
		margin-left: 40px;
		margin-top:  20px;
		padding-left: 15px;
		border-collapse: collapse;
		table-layout: fixed;
}

#diaryList th, td { /* 테이블 th,td처리 */
		text-align: center;
		border-bottom: 1px solid #CAD2D5;
		padding: 4px 10px;
		text-overflow: ellipsis;
		overflow: hidden;
 	 	white-space: nowrap;
}

#diaryList table thead { /* thead 박스처리 */
		margin-top: 10px;
		height: 30px;
		border: 1px solid #CAD2D5;
		/* border-radius: 15px; */
		background-color: #f2f2f2;
}
	
#diaryList td:nth-child(1) a { /* 제목 */
		color: black;
		text-decoration: none;
		font-size: 0.9em;
}
#diaryList td:nth-child(1) a:hover { /* 제목 호버 */
		color: #10C0D5;
}
#diaryList td:nth-child(2) { /* 작성자(닉네임) */
		color: orange;
		font-size: 0.9em;
}
#diaryList td:nth-child(3) { /* 작성일 */
		color: #595959;
		font-size: 0.8em;
}	
.writer { width: 15%; } /* 작성자 칸 비율 */
.regdate { width: 20%; } /* 작성일 칸 비율 */
	
#diaryList .align-left { text-align: left; } /* 제목 왼쪽정렬 */

/************** 페이지 표시 영역 스타일(시작) ***************/
.paging { list-style: none; } 
.paging li { /* 페이지넘버 리스트 한줄로 나오게 */
		float: left;
		margin-right: 8px;
}
.paging li a { /* 페이지넘버 */
		text-decoration: none;
		display: block;
		padding: 3px 7px;
		border: none;		
		font-weight: bold;
		color: black;
		background-color: white;
}
.paging li a:hover { color: #10C0D5; } /* 페이지넘버 호버 됐을떼 */
	
.paging .disable { /* 처음으로,다음으로 비활성화 처리 */
		border-radius: 5px; 
		padding: 3px 7px;
		color: silver;
}
.paging  .now { /* 현재 페이지 일때 페이지번호 처리 */
		padding: 3px 7px;
		background-color: #4FBAEA;
		border-radius: 5px; 
		color: white;
}
#pagingBOX { /* 하단 페이징 영역 */
		display: inline-block;
		left: 5px;
		width: 100%;
		font-size: 0.8em;
		text-align: center;
		position: relative;
}
#write_btn { /* 글쓰기 버튼 */
		width: 60px;
		height: 25px;
		border-radius: 7px;
		border: none;
		font-weight: bold;
		background-color: #4FBAEA;
		color: white;
		font-size: 1em;
		position: absolute;
		top: 13px;
		right: 77px;
}

</style>
<body>
<script>
	var loginUIdx = '<%=login.getU_idx() %>';
	var hostUIdx = '<%=host.getU_idx() %>';
	$(function() {
		//글쓰기 버튼 호스트만 보이게
		if (loginUIdx != hostUIdx) {
			$("#write_btn").hide();
		} else {
			$("#write_btn").show();
		}
	});

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
				<!-- ==================================================== -->				
				
				<div id="right3" class="box3">
					<div id="title">
						다이어리
					</div>					
					
					<div id="diaryList">	
						<table>
							<thead>
								<th class="subject">제목</th>
								<th class="writer">작성자</th>
								<th class="regdate">작성일</th>
							</thead>
								<c:choose>
									<c:when test="${empty list }">
										<tr>
											<td colspan="3">
												<h2>현재 등록된 게시글이 없습니다.</h2>
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="dvo" items="${list }">
											<tr>
												<td class="align-left"> <!-- 다이어리 목록 제목부분 -->
													<a href="DiaryViewController?d_idx=${dvo.d_idx }&cPage=${pvo.nowPage }">${dvo.title }</a>
												</td>
												<td>${host.nickname }</td>
												<td>${dvo.regdate }</td> 
											</tr>									
										</c:forEach>
									</c:otherwise>
								</c:choose>
								
							</table>	
							<!--==================== 페이징 처리 ===========================-->
							<div id="pagingBOX">
								<tr>
									<td colspan="2">
										<ol class="paging">
										<c:choose><%-- [이전으로]에 대한 사용 여부 처리 --%>
										<c:when test="${pvo.beginPage == 1 }">				
											<li class="disable">이전으로</li>
										</c:when>
										<c:otherwise>
											<li>
												<a href="DiaryListController?cPage=${pvo.beginPage - 1 }">이전으로</a>
											</li>
										</c:otherwise>
										</c:choose>		
										
										<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
										<c:choose>		
											<c:when test="${pageNo == pvo.nowPage }">
												<li class="now">${pageNo }</li>				
											</c:when>
											<c:otherwise>
												<li><a href="DiaryListController?cPage=${pageNo }">${pageNo }</a></li>		
											</c:otherwise>									
										</c:choose>
										</c:forEach>
											
										<%-- [다음으로]에 대한 사용 여부 처리 --%>	
										<c:if test="${pvo.endPage < pvo.totalPage }">
											<li><a href="DiaryListController?cPage=${pvo.endPage + 1 }">다음으로</a></li>					
										</c:if>	
										<c:if test="${pvo.endPage >= pvo.totalPage }">
											<li class="disable">다음으로</li>					
										</c:if>								
										</ol>	
									</td>
									<td>
										<input type="button" value="글쓰기" id="write_btn"
											onclick="javascript:location.href='diary_write.jsp?cPage=${pvo.nowPage }'">
									</td>
								</tr>
							</div>
						
						<!-- ======================================================== -->
						
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