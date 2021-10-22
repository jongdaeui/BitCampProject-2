package com.helloworld.controller.diary;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.dao.DiaryDAO;
import com.helloworld.vo.DiaryVO;
import com.helloworld.vo.MemberVO;

@WebServlet("/DiaryModifyController")
public class DiaryModifyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		int d_idx = (Integer) session.getAttribute("d_idx");
		DiaryVO dvo = DiaryDAO.getOneDiary(d_idx);//다이어리 인덱스로 다이어리 객체 생성
		request.setAttribute("dvo", dvo);
		
		String path = "diary_modify.jsp"; //다이어리 수정 페이지로 이동
		request.getRequestDispatcher(path).forward(request, response);
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
