package com.helloworld.controller.guest_book;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.helloworld.dao.GuestBookDAO;
import com.helloworld.vo.CommentsVO;

@WebServlet("/GetComment")
public class GetComment extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestBookDAO guestbookDAO = new GuestBookDAO();
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String g_idx = request.getParameter("content");
		
		List<CommentsVO> list = guestbookDAO.getCommentList(g_idx);
		
		PrintWriter out = response.getWriter();
		StringBuilder result = new StringBuilder();
		result.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		result.append("<comments>");
		for (CommentsVO vo : list) {
			result.append("<comment>");
			result.append("<c_idx>" + vo.getC_idx() + "</c_idx>");
			result.append("<nickname>" + vo.getNickname() + "</nickname>");
			result.append("<regdate>" + vo.getRegdate() + "</regdate>");
			result.append("<content>" + vo.getContent() + "</content>");
			result.append("</comment>");
		}
		result.append("</comments>");
		
		out.print(result.toString());
	}
}
