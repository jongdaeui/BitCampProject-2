package com.helloworld.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.helloworld.dao.CommentsDAO;

@WebServlet("/CommentInsertController")
public class CommentInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String b_idx = request.getParameter("b_idx");
		String content = request.getParameter("content");
		String nickname = request.getParameter("nickname");
		
		CommentsDAO.boardInsert(b_idx, content, nickname);
		//request.getRequestDispatcher("CommentBoardController?b_idx="+b_idx).forward(request, response);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		System.out.println(">> FrontControllerCommand doPost() 실행!!!");
		doGet(req, resp);
	}
	

}
