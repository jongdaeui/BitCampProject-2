package com.helloworld.controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.helloworld.dao.BoardDAO;

@WebServlet("/BoardDeleteController")
public class BoardDeleteCotroller extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String u_idx = request.getParameter("u_idx");
		String b_idx = request.getParameter("b_idx");
		BoardDAO.delete(b_idx);
		request.getRequestDispatcher("BoardAllController").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		System.out.println(">> FrontControllerCommand doPost() 실행!!!");
		doGet(req, resp);
	}
	
}
