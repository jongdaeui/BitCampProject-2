package com.helloworld.controller.diary;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.dao.DiaryDAO;
import com.helloworld.vo.MemberVO;

@WebServlet("/DiaryDeleteController")
public class DiaryDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");		
		HttpSession session = request.getSession();
		int d_idx = (Integer) session.getAttribute("d_idx"); //다이어리 인덱스
		int result = DiaryDAO.deleDiary(d_idx);
		if (result == 1) {
			System.out.println("삭제 성공~~~~~~!!!!!!!!!!!!!!!!!!!");
		}
		
		String path = "DiaryListController";
		request.getRequestDispatcher(path).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
