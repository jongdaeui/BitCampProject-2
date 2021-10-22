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

//다이어리 수정 컨트롤러
@WebServlet("/DiaryModifyOkController")
public class DiaryModifyOkController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		MemberVO host = (MemberVO) session.getAttribute("host");
		int d_idx = (Integer) session.getAttribute("d_idx");
		
		DiaryVO vo = new DiaryVO(); //넘어온 파라미터 정보를 객체에 넣어주기
		vo.setTitle(request.getParameter("title"));
		vo.setContent(request.getParameter("content"));
		vo.setU_idx(host.getU_idx());
		vo.setHit(0);
		vo.setD_idx(d_idx);
		
		System.out.println("수정전 확인 vo : " + vo);
		
		//sql에 전달
		int result = DiaryDAO.modiDiary(vo);	
		System.out.println("result : " + result);
		
		if (result == 1 ) {
			System.out.println("다이어리 수정 성공~~~!!!!");
		}

		request.getRequestDispatcher("DiaryViewController").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
