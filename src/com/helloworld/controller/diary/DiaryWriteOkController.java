package com.helloworld.controller.diary;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.dao.DiaryDAO;
import com.helloworld.vo.DiaryVO;
import com.helloworld.vo.MemberVO;

//다이어리 등록(작성) 컨트롤러
@WebServlet("/DiaryWriteOkController")
public class DiaryWriteOkController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		MemberVO host = (MemberVO) session.getAttribute("host");
		System.out.println("DiaryWriteOkController  - host : " + host);
		
		int cPage= Integer.parseInt(request.getParameter("cPage"));
		
		DiaryVO dvo = new DiaryVO(); //넘어온 정보 객체에 담기
		dvo.setTitle(request.getParameter("title"));
		dvo.setContent(request.getParameter("content"));
		dvo.setU_idx(host.getU_idx());
		dvo.setHit(0);
		
		int result = DiaryDAO.setDiary(dvo); 
		
		if (result == 1 ) {
			System.out.println("다이어리 등록 성공!!!!!!!");
		}
		String path = "DiaryListController?cPage=" + cPage;
		request.getRequestDispatcher(path).forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
