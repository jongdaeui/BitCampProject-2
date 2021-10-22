package com.helloworld.controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.helloworld.dao.BoardDAO;

@WebServlet("/BoardUpdateOkController")
public class BoardUpdateOkController extends HttpServlet{
	//실제로 수정된 값을 db에 저장하는 컨트롤러
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String b_idx = request.getParameter("b_idx");
		
		System.out.println("UpdateOk : " + title + ", " + content + ", " + b_idx);
		BoardDAO.update(title, content, b_idx);
		request.getRequestDispatcher("BoardDetailController?b_idx="+b_idx).forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		System.out.println(">> FrontControllerCommand doPost() 실행!!!");
		doGet(req, resp);
	}
}
