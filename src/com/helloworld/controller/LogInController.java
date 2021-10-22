package com.helloworld.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.dao.MemberDAO;
import com.helloworld.vo.MemberVO;

public class LogInController implements Command {

	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		MemberVO mvo = null;
		System.out.println("id, pw : " + id + ", " + pw);
		int result = MemberDAO.getIdPw(id, pw);
		
		System.out.println("getIdPw result:" + result);
	    if (result == 1) { 
			mvo = MemberDAO.selectOne(id); 
	    } 
	    else if (result == 0) {
			System.out.println("로그인 실패"); return "failLogIn.jsp"; 
	    }
		
	    System.out.println("LogInController mvo : " + mvo);
	    
		// session에 logIn객체 올리기
		HttpSession session = request.getSession();
		session.setAttribute("login", mvo);
		//session.setAttribute("host", mvo);
		return "open.jsp";
	}

}
