package com.helloworld.controller.guest_book;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.dao.GuestBookDAO;
import com.helloworld.vo.GuestBookVO;
import com.helloworld.vo.MemberVO;

@WebServlet("/InsertContent")
public class InsertContent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestBookDAO guestbookDAO = new GuestBookDAO();
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
//삭제	MemberVO host = (MemberVO) session.getAttribute("host"); 
//삭제	MemberVO login = (MemberVO) session.getAttribute("login"); 
		
/*추가*/	String u_idx = request.getParameter("u_idx");
/*추가*/	String nickname = request.getParameter("nickname");
/*추가*/	String content = request.getParameter("content");
		System.out.println("InsertContent : " + "u_idx : " + u_idx + ", nickname : " + nickname + ", content : " + content);
		
		Map<String, String> map = new HashMap<String, String>();
/*수정*/	map.put("u_idx", u_idx); // value 파라미터 변경
/*수정*/	map.put("content", content); // value 파라미터 변경
/*수정*/	map.put("nickname", nickname); // value 파라미터 변경
		
		guestbookDAO.insertContent(map);
//삭제	response.sendRedirect("getAll?host=" + host.getU_idx() + "&login=" + login.getU_idx());
/*추가*/	response.sendRedirect("GetAllCommand"); // 파라미터 없이 서블릿 호출
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
