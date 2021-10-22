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
import com.helloworld.vo.CommentsVO;
import com.helloworld.vo.MemberVO;

@WebServlet("/InsertReply")
public class InsertReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestBookDAO guestbookDAO = new GuestBookDAO();
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
// 삭제	MemberVO host = (MemberVO) session.getAttribute("host");
		MemberVO login = (MemberVO) session.getAttribute("login"); // 필요해서 session 사용 유지
/*수정 */	String g_dix = request.getParameter("g_idx"); // 타입 int > String으로 변경
		String content = request.getParameter("content");
	
/*추가*/	Map<String, String> map = new HashMap<String, String>();
/*추가*/	map.put("g_idx", g_dix);
/*추가*/	map.put("nickname", login.getNickname());
/*추가*/	map.put("content", content);

		guestbookDAO.insertComment(map);
		
// 삭제	response.sendRedirect("getAll?host=" + host.getU_idx() + "&login=" + login.getU_idx());
/*추가  */response.sendRedirect("GetAllCommand"); // 파라미터 없이 서블릿 호출
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
