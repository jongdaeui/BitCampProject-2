package com.helloworld.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.dao.MemberDAO;
import com.helloworld.vo.MemberVO;

@WebServlet("/HostController")
public class HostController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nickname = request.getParameter("nickname");
		MemberVO mvo = MemberDAO.selectByNickname(nickname);
		HttpSession session = request.getSession();
		session.setAttribute("host", mvo);
		
		request.getRequestDispatcher("home.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
