package com.helloworld.controller.diary;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.common.Paging;
import com.helloworld.dao.DiaryDAO;
import com.helloworld.vo.DiaryVO;
import com.helloworld.vo.MemberVO;

//다이어리 리스트 컨트롤러
@WebServlet("/DiaryListController")
public class DiaryListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		MemberVO host = (MemberVO) session.getAttribute("host");
		System.out.println("DiaryListController  - host : " + host);
		
		//페이징을 위한 객체 생성
		Paging p = new Paging();

		//1. 전체게시물 수량구하기
		p.setTotalRecord(DiaryDAO.getDiaryCount(host.getU_idx()));
		p.setTotalPage();
		System.out.println("> 전체 게시글 수 : " + p.getTotalRecord());	
		System.out.println("> 전체 페이지 수 : " + p.getTotalPage());
		
		//2. 현재페이지 구하기
		int cPage; 
		String cPage1 =  request.getParameter("cPage");
		if (cPage1 == null) {
			cPage = 0;
		} else {
			cPage =  Integer.parseInt(request.getParameter("cPage"));
			p.setNowPage(cPage);
		}
		System.out.println("> cPage : " + cPage);
		System.out.println("> paging nowPage : " +  p.getNowPage());
		
		//3. 현재페이지에 표시할 게시글 시작번호,끝번호 구하기
		if (p.getTotalRecord() < 10) {
			p.setNumPerPage(p.getTotalRecord());
		} else {
			p.setNumPerPage(10);
		}
		System.out.println("--->>p.getNumPerPage() : " + p.getNumPerPage());
		p.setEnd(p.getNowPage() * p.getNumPerPage()); //현재페이지 * 페이지당게시글 수
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1); //끝페이지 - 페이지당게시글 수
		 
		if (p.getEnd() <= 1) { //마지막 게시글번호가 총 게시글 수와 같게
			p.setEnd(p.getTotalRecord());
		}
		
		System.out.println(">>시작번호(begin) : " + p.getBegin()); //현재페이지번호 * 페이지당게시글 수
		System.out.println(">>끝번호(end) : " + p.getEnd());
		
		//(선택적) 3-1. 끝번호가 데이터 건수보다 많아지면 데이터 건수와 동일한 번호로 설정
		if (p.getEnd() > p.getTotalRecord()) {
			p.setEnd(p.getTotalRecord());
		}
		if (p.getEnd() == 0) p.setEnd(1);
		System.out.println(">>시작번호(begin) : " + p.getBegin()); //현재페이지번호 * 페이지당게시글 수
		System.out.println(">>끝번호(end) : " + p.getEnd());
		
		System.out.println(">>p.getPagePerBlock() : " + p.getPagePerBlock());
		
		//----------- 볼록 계산하기 ------------------
		//4. 볼록의 시작페이지,끝페이지 구하기
		//시작페이지 구하기
		int nowPage = p.getNowPage();
		int beginPage = (nowPage -1) / p.getPagePerBlock() * p.getPagePerBlock() + 1;
		p.setBeginPage(beginPage);
		p.setEndPage(p.getBeginPage() + p.getPagePerBlock() - 1);
		if (p.getTotalRecord() < 100) {
			p.setEndPage(p.getTotalPage());
		}
		
		//4-1 
		//4-1. 끝페이지(endPage)가 전체페이지 수(totalPage) 보다 크면
		// 끝페이지를 전체페이지 수로 변경 처리		
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
		} 
		
		System.out.println(">> beginPage : " + p.getBeginPage());
		System.out.println(">> endPage : " + p.getEndPage());	
		System.out.println("---mvo.getU_idx()--- : " + host.getU_idx());
		
		List<DiaryVO> list = DiaryDAO.getListDiary(p.getBegin(), p.getEnd(), host.getU_idx());
		System.out.println(">현재페이지 글목록(list) : " + list);
		
		request.setAttribute("list", list);
		request.setAttribute("pvo", p);
		request.setAttribute("cPage", cPage);
		
		String path = "diary.jsp";//다이어리목록 페이지로 이동
		request.getRequestDispatcher(path).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
