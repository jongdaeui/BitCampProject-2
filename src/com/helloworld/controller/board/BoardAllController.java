package com.helloworld.controller.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.common.BoardPaging;
import com.helloworld.dao.BoardDAO;
import com.helloworld.dao.MemberDAO;
import com.helloworld.vo.BoardVO;
import com.helloworld.vo.MemberVO;

@WebServlet("/BoardAllController")
public class BoardAllController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		MemberVO hvo = (MemberVO)session.getAttribute("host");
		BoardPaging p = new BoardPaging();
		
		p.setTotalRecord(BoardDAO.getTotalCount(hvo.getU_idx()));
		p.setTotalPage();
		/*
		 * System.out.println("> 전체 게시글 수 : " + p.getTotalRecord());
		 * System.out.println("> 전체 페이지 수 : " + p.getTotalPage());
		 */
		
		//2. 현재 페이지 구하기
		String cPage = request.getParameter("cPage");
		if (cPage != null) {
			p.setNowPage(Integer.parseInt(cPage));
		}
		/*
		 * System.out.println("> cPage : " + cPage);
		 * System.out.println("> paging nowPage : " + p.getNowPage());
		 */
		
		//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
		p.setEnd(p.getNowPage() * p.getNumPerPage());  //현재 페이지 번호 * 페이지 당 개시글 수
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
		/*
		 * System.out.println(">> 시작번호(begin) : " + p.getBegin());
		 * System.out.println(">> 끝번호(end) : " + p.getEnd());
		 */
		
		//(선택적) 3-1. 끝 번호가 데이터 건수보다 많아지면 데이터 건수와 동일한 번호로 설정
//		if (p.getEnd() > p.getTotalRecord()) {
//			p.setEnd(p.getTotalRecord());
//		}
		
		//----- 블록(block) 계산하기 -----
		//4. 블록의 시작페이지, 끝페이지 구하기(현재 페이지 번호 사용)
		// 시작페이지 구하기
		int nowPage = p.getNowPage();
		int beginPage = (nowPage - 1) / p.getPagePerBlock() * p.getPagePerBlock() + 1;
		p.setBeginPage(beginPage);
		p.setEndPage(p.getBeginPage() + p.getPagePerBlock() - 1);
		
		//4-1 endPage가 전체페이지 수(totalPage) 보다 크면
		//끝 페이지 수를 전체페이지 수로 변경
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
		}
		/*
		 * System.out.println(">> beginPage : " + p.getBeginPage());
		 * System.out.println(">> endPage : " + p.getEndPage());
		 */
		
		//현재페이지 기준으로 DB데이터 가져오기
		List<BoardVO> list = BoardDAO.getList(p.getBegin(), p.getEnd(), hvo.getU_idx());
		System.out.println("> 현재페이지 글 목록(list) : " + list);
		
		//list를 request객체로 넘기기
		request.setAttribute("list", list);
		request.setAttribute("pvo", p);
		request.getRequestDispatcher("board.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		doGet(req, resp);
	}
	
}
