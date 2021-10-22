package com.helloworld.controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.dao.BoardDAO;
import com.helloworld.vo.BoardVO;
import com.helloworld.vo.MemberVO;

@WebServlet("/BoardInsertController")
public class BoardInsertController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//session객체에 저장되어 있는 MemberVO 객체 불러오기
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("login");
		
		//작성한 제목과 내용 가져오기
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		System.out.println("제목 : " + title);
		System.out.println("내용 : " + content);
		//데이터베이스에 insert할 BoardVO 객체 생성 후 값 저장
		BoardVO bvo = new BoardVO(); 
		bvo.setTitle(title);
		bvo.setContent(content);
		bvo.setU_idx(mvo.getU_idx());
		bvo.setNickname(mvo.getNickname());
		
		int result = BoardDAO.insert(bvo);
		if (result == 1) {
			System.out.println("저장 성공!");
		}else {
			System.out.println("저장 실패!");
		}
		
		request.getRequestDispatcher("BoardAllController?u_idx="+mvo.getU_idx()).forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		System.out.println(">> FrontControllerCommand doPost() 실행!!!");
		doGet(req, resp);
	}
	
}
