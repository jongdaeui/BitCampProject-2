package com.helloworld.controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.helloworld.dao.BoardDAO;
import com.helloworld.vo.BoardVO;

@WebServlet("/BoardUpdateController")
public class BoardUpdateController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//게시글 상세보기를 위해 게시글 번호를 받아온다
		String b_idx = request.getParameter("b_idx");
		
		//해당 게시글의 객체를 받아오기 위한 메서드 호출
		BoardVO bvo = BoardDAO.detail(b_idx);
		System.out.println("update의 bvo : " + bvo);
		request.setAttribute("bvo", bvo);
		
		request.getRequestDispatcher("board_update.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		System.out.println(">> FrontControllerCommand doPost() 실행!!!");
		doGet(req, resp);
	}
}
