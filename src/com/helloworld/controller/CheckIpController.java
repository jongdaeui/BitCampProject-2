package com.helloworld.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.helloworld.dao.BoardDAO;
import com.helloworld.dao.DiaryDAO;
import com.helloworld.dao.PhotoDAO;
import com.helloworld.dao.TodayDAO;
import com.helloworld.vo.BoardVO;
import com.helloworld.vo.DiaryVO;
import com.helloworld.vo.PhotoVO;

//당일날짜와 주인idx가 같은 ip가 방문한 ip와 같은지 비교(중복확인)
@WebServlet("/CheckIpController")
public class CheckIpController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String ip = req.getParameter("ip");
		String u_idx = req.getParameter("u_idx");
		//임시로 idx 값 설정
		
		System.out.println("checkIpController ip:"+ip+",u_idx:"+u_idx);
		
		Map<String,String> map = new HashMap<>();		
		
		map.put("ip", ip);
		map.put("u_idx", u_idx);
		
		//당일에 해당홈페이지에 접속한 ip인지 확인 있다면 1, 없다면 0리턴
		int result = TodayDAO.chIp(map);
		
		System.out.println("TodayDAO.chIp값 :"+result);
		
		int setIp = 0;
		if(result==0) {
			//ip없다면 DB에 추가 
			setIp = TodayDAO.setIp(map);
			System.out.println("TodayDAO.setIp값 :"+setIp);
		}
		//today값 불러오기 
			int today = TodayDAO.today(u_idx);
			System.out.println("today값 :"+today);
			
		//total값 불러오기 
			int total = TodayDAO.total(u_idx);
			System.out.println("total값 :"+total);
		
		//최근 작성한 다이어리 하나 불러오기
		DiaryVO dvo = DiaryDAO.newDiary(u_idx);
		//최근 작성한 게시글 하나 불러오기
		BoardVO bvo = BoardDAO.newBoard(u_idx);
		//최근 작성한 사진첩 하나 불러오기
		PhotoVO pvo = PhotoDAO.newPhoto(u_idx);
		
		req.setAttribute("pvo", pvo);
		req.setAttribute("bvo", bvo);
		req.setAttribute("dvo", dvo);
		req.setAttribute("existIp",setIp);
		req.setAttribute("today",today);
		req.setAttribute("total",total);
		req.getRequestDispatcher("home.jsp").forward(req, resp);
	
}
}
