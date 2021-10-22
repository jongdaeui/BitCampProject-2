package com.helloworld.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.helloworld.dao.MemberDAO;
import com.helloworld.vo.MemberVO;


@WebServlet("/InformationController")
public class InformationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		int u_idx = Integer.parseInt(request.getParameter("u_idx"));
		System.out.println("컨트롤러에서 받은 u_idx: "+u_idx);
		
		//DB데이터 가져오기
		MemberVO mvo = MemberDAO.getInfo(u_idx);
		
		System.out.println("DB에서 받은프로필: "+mvo);
		
		//json형태로 변형 
		String result = makeJson(mvo);
		System.out.println("jason으로 변형:" +result);
		
		//데이터 출력
		PrintWriter out = response.getWriter();
		out.print(result);
	}
		private String makeJson(MemberVO mvo) {
			StringBuilder result= new StringBuilder();
			result.append("{\"list\" : [");
			result.append("{");
			result.append("\"nickname\" : \"" +mvo.getNickname()+"\",");
			result.append("\"birth\" : \"" +mvo.getBirth()+"\",");
			result.append("\"gender\" : \""+mvo.getGender()+"\",");
			result.append("\"email\" : \""+mvo.getEmail()+"\",");
			result.append("\"phone\" : \""+mvo.getPhone()+"\"");
			result.append("}");
			result.append("]}");
			return result.toString();
		}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
