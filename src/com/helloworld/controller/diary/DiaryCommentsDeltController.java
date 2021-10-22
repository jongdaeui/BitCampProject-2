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

@WebServlet("/DiaryCommentsDeltController")
public class DiaryCommentsDeltController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		MemberVO login = (MemberVO) session.getAttribute("login");
		System.out.println("DiaryCommentsDeltController  - login : " + login);
		
		int c_idx =  Integer.parseInt(request.getParameter("c_idx"));
		int cPage = (Integer) session.getAttribute("cPage");
		int d_idx = (Integer) session.getAttribute("d_idx");
		
		//전닯받은 c_idx, d_idx데이터로 해당 댓글 조회 후 삭제
		int result = DiaryDAO.delDiaryComment(c_idx, d_idx);
		
		if (result != 0) {
			System.out.println("DiaryCommentsDeltController \n c_idx : " + c_idx + ", d_idx : " + d_idx + " ->>  " + result + "개의 댓글 삭제 성공!!");
		}
		String path = "DiaryViewController?d_idx=" + d_idx;
		request.getRequestDispatcher(path).forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
