package com.helloworld.controller.diary;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.dao.DiaryDAO;
import com.helloworld.vo.CommentsVO;
import com.helloworld.vo.MemberVO;

@WebServlet("/DiaryCommentsModiOkController")
public class DiaryCommentsModiOkController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		MemberVO login = (MemberVO) session.getAttribute("login");
		System.out.println("DiaryCommentsModiFrmController  - login : " + login);
		int c_idx = Integer.parseInt(request.getParameter("c_idx"));
		
		String content = request.getParameter("modi_comm_content"); //수정한 댓글 내용 받기
		System.out.println("DiaryCommentsModiOkController - c_idx : " + c_idx + ", content : " + content);
		
		CommentsVO cvo = new CommentsVO();//댓글객체 생성
		cvo.setC_idx(c_idx); //받은정보 넣어주기
		cvo.setContent(content);
		
		//데이터 가져오기
		int result = DiaryDAO.modiDiaryComment(cvo); //수정
		if (result != 0) {
			System.out.println(result + "개의 댓글 수정 성공~~");
		} else {
			System.out.println("댓글 수정 실패...");			
		}
		request.getRequestDispatcher("DiaryViewController").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}