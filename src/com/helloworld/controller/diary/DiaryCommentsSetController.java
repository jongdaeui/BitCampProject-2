package com.helloworld.controller.diary;

import java.io.IOException;
import java.io.PrintWriter;
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

//댓글등록
@WebServlet("/DiaryCommentsSetController")

public class DiaryCommentsSetController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");		
		HttpSession session = request.getSession();
		MemberVO login = (MemberVO) session.getAttribute("login");
		System.out.println("DiaryCommentsSetController  - login : " + login);

		int d_idx = (Integer) session.getAttribute("d_idx");
		String setContent = request.getParameter("setContent");
		String setNickname = request.getParameter("setNickname");
		System.out.println("setContent - > " + setContent);
		System.out.println("setNickname - > " + setNickname);
		
		CommentsVO cvo = new CommentsVO();//댓글객체 생성 후 값 넣어주기
		cvo.setD_idx(d_idx);
		cvo.setNickname(setNickname);
		cvo.setContent(setContent.trim().replace("\n", " ")); //댓글내용에 엔터,스페이스값 있으면 제거
		
		int result = DiaryDAO.setDiaryComment(cvo);
		if (result != 0) {
			System.out.println(result + "개의 댓글 등록 성공!!");
		}
		
		request.getRequestDispatcher("DiaryViewController").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
