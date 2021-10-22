package com.helloworld.controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.helloworld.dao.BoardDAO;

@WebServlet("/BoardMultiDelController")
public class BoardMultiDelController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//u_idx를 받아온다.
		String u_idx = request.getParameter("u_idx");
		//선택된 b_idx를 받아온다.
		String[] b_idx = request.getParameterValues("b_idx");
		//System.out.println("b_idx : " + b_idx[0]);
		
		for (int i = 0; i < b_idx.length; i++) {
			BoardDAO.delete(b_idx[i]);
		}
		
		request.getRequestDispatcher("BoardAllController?u_idx="+u_idx).forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		System.out.println(">> FrontControllerCommand doPost() 실행!!!");
		doGet(req, resp);
	}
	
}
