package com.helloworld.controller.guest_book;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.dao.GuestBookDAO;
import com.helloworld.vo.MemberVO;

@WebServlet("/DeleteComment")
public class DeleteComment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestBookDAO guestbookDAO = new GuestBookDAO();
		response.setCharacterEncoding("UTF-8");
		
//삭제	MemberVO host = (MemberVO) session.getAttribute("host");
//삭제	MemberVO login = (MemberVO) session.getAttribute("login");
		String c_idx = request.getParameter("c_idx");
		
		guestbookDAO.deleteComment(c_idx);
//삭제	response.sendRedirect("getAll?host=" + host.getU_idx() + "&login=" + login.getU_idx());
/*추가  */response.sendRedirect("GetAllCommand"); // 파라미터 없이 서블릿 호출
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
