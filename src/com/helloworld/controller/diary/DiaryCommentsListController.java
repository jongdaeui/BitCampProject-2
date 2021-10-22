package com.helloworld.controller.diary;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.helloworld.dao.DiaryDAO;
import com.helloworld.vo.CommentsVO;
import com.helloworld.vo.MemberVO;

@WebServlet("/DiaryCommentsListController")
public class DiaryCommentsListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		MemberVO login = (MemberVO) session.getAttribute("login");
		System.out.println("DiaryCommentsListController  - login : " + login);
		int d_idx = (Integer) session.getAttribute("d_idx");
		
		//데이터 가져오기
		List<CommentsVO> list =  DiaryDAO.getDiaryCommentList(d_idx);
		System.out.println("list : " + list);
		
		String result = makeJson(list);
		System.out.println("응답 JSON 문자열 : " + result);
		
		PrintWriter out = response.getWriter();
		out.print(result);		
	}

	private String makeJson(List<CommentsVO> list) {
		System.out.println("makeJson");
		//SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm ");//날짜형식 변환
		StringBuilder result = new StringBuilder();
		result.append("{ \"list\" : [");
		
		for (CommentsVO vo : list) {
			result.append("{");
			result.append("\"c_idx\" : " + vo.getC_idx() + ",");
			result.append("\"g_idx\" : " + vo.getG_idx() + ",");
			result.append("\"d_idx\" : " + vo.getD_idx() + ",");
			result.append("\"b_idx\" : " + vo.getB_idx() + ",");
			result.append("\"nickname\" : \"" + vo.getNickname() + "\",");
			result.append("\"regdate\" : \"" + vo.getRegdate() + "\",");			
			result.append("\"content\" : \"" + vo.getContent() + "\"");			
			result.append("},");
			
		}
		result.delete(result.length() - 1, result.length()); //마지막 ,제거하기		
		result.append("]}");
		System.out.println(result);
		return result.toString();	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
