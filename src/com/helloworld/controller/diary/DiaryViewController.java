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

@WebServlet("/DiaryViewController")
public class DiaryViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		//페이지 이동 반복시 다이어리 인덱스(d_idx), 이동전 있던 페이지넘버(cPage) 파라미터 유무에 따른 처리
		int d_idx;
		String d_idx1 = request.getParameter("d_idx");
		if (d_idx1 == null) {
			d_idx = (Integer) session.getAttribute("d_idx");//파라미터 없을땐 세션에서
		} else {
			d_idx =  Integer.parseInt(request.getParameter("d_idx"));//파라미터 있을땐 파라미터로
		}		
		
		int cPage; 
		String cPage1 =  request.getParameter("cPage");
		if (cPage1 == null) {
			cPage = (Integer) session.getAttribute("cPage");//파라미터 없을땐 세션에서
		} else {
			cPage =  Integer.parseInt(request.getParameter("cPage"));//파라미터 있을땐 파라미터로
		}		
		session.setAttribute("d_idx", d_idx); //파라미터로 받는경우 세션에 저장
		session.setAttribute("cPage", cPage);
		
		System.out.println("DiaryViewController - d_idx확인-------> " + d_idx);
		DiaryVO dvo =  DiaryDAO.getOneDiary(d_idx);
		request.setAttribute("dvo", dvo);
		System.out.println("DiaryViewController - dvo : " + dvo);
		
		//다이어리 상세보기로 이동
		request.getRequestDispatcher("diary_view.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
