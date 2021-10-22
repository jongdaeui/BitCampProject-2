	package com.helloworld.controller.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.dao.BoardDAO;
import com.helloworld.dao.CommentsDAO;
import com.helloworld.vo.BoardVO;
import com.helloworld.vo.CommentsVO;
import com.helloworld.vo.MemberVO;

@WebServlet("/BoardDetailController")
public class BoardDetailController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//게시글 상세보기를 위해 게시글 번호를 받아온다
		String b_idx = request.getParameter("b_idx");
		System.out.println("BoardDetail b_idx : " + b_idx);
		//게시글 주인이면 조회수를 늘리면 안되기 때문에 게시글 주인인지
		//확인하기 위해 login, host 객체를 생성
		HttpSession session = request.getSession();
		MemberVO lvo = (MemberVO)session.getAttribute("login");
		MemberVO hvo = (MemberVO)session.getAttribute("host");
		
		//로그인 안했을 때도 게시글을 보면 조회수가 증가한다
		if (lvo == null) {
			BoardDAO.hitPlus(b_idx);
		} else if (lvo != null) {
			if (lvo.getU_idx() != hvo.getU_idx()) {
				BoardDAO.hitPlus(b_idx);
			}
		}
				
		//해당 게시글의 객체를 받아오기 위한 메서드 호출
		BoardVO bvo = BoardDAO.detail(b_idx);
		request.setAttribute("bvo", bvo);
		
		//해당 게시글에 존재하는 댓글들을 저장하는 list생성
		List<CommentsVO> list = CommentsDAO.boardCommentsAll(b_idx);
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("board_detail.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		System.out.println(">> FrontControllerCommand doPost() 실행!!!");
		doGet(req, resp);
	}
	
}
