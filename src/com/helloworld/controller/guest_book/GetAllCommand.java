package com.helloworld.controller.guest_book;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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

@WebServlet("/GetAllCommand")
public class GetAllCommand extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestBookDAO guestbookDAO = new GuestBookDAO();
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();

//삭제	String u_idx = request.getParameter("u_idx");
		
/*추가 */	MemberVO vo = (MemberVO)session.getAttribute("host"); // home에서 저장된 host 세션을 이용해서 vo객체 생성후 필요한 데이터를 꺼내어 사용
/*추가 */	String u_idx = Integer.toString(vo.getU_idx());
		String currentPage = request.getParameter("currentPage");
		String maxContent = request.getParameter("maxContent");

		if (currentPage == null) { currentPage = "1"; }
		if (maxContent == null) { maxContent = "5"; }
		String startContent = Integer.toString((Integer.parseInt(maxContent) * Integer.parseInt(currentPage)) - (Integer.parseInt(maxContent)  - 1));
		String lastContent = Integer.toString((Integer.parseInt(maxContent) * Integer.parseInt(currentPage)));
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("u_idx", u_idx);
		map.put("startContent", startContent);
		map.put("lastContent", lastContent);
		
		List<GuestBookVO> list = guestbookDAO.getGuestBook(map);
		request.setAttribute("list", list);
		request.setAttribute("maxContent", maxContent);
		request.setAttribute("currentPage", currentPage);
		
		request.getRequestDispatcher("guest_book.jsp").forward(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
