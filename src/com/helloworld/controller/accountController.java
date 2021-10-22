package com.helloworld.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.helloworld.dao.MemberDAO;
import com.helloworld.vo.MemberVO;

@WebServlet("/accountController")
public class accountController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int result = -1;
		String strResult = "";
		List<MemberVO> list = null;
		response.setContentType("text/html;charset=UTF-8");
		String id = request.getParameter("id");
		String category = request.getParameter("category");
		String type = request.getParameter("type");
		if ("validation".equals(type)) {
			if ("id".equals(category)) {
				result = MemberDAO.chkId(id);
			} else {
				result = MemberDAO.chkNickname(id);
			}
		} else if ("registry".equals(type)) {
			Map<String, String> map = new HashMap<>();

			Enumeration e = request.getParameterNames();
			while (e.hasMoreElements()) {
				String name = (String) e.nextElement();
				String[] values = request.getParameterValues(name);
				for (String value : values) {
					map.put(name, value);
				}
			}
			result = MemberDAO.insMember(map);
			
			if(result != 0) {
				response.sendRedirect("index.jsp?type=registry&result=1");
			}else {
				response.sendRedirect("index.jsp?type=registry&result=0");
			}
		} else if ("findId".equals(type)) {
			Map<String, String> map = new HashMap<>();

			Enumeration e = request.getParameterNames();
			while (e.hasMoreElements()) {
				String name = (String) e.nextElement();
				String[] values = request.getParameterValues(name);
				for (String value : values) {
					map.put(name, value);
				}
			}
			strResult = MemberDAO.findId(map);
			result = -2;
		} else if ("findPwd".equals(type)) {
			Map<String, String> map = new HashMap<>();

			Enumeration e = request.getParameterNames();
			while (e.hasMoreElements()) {
				String name = (String) e.nextElement();
				String[] values = request.getParameterValues(name);
				for (String value : values) {
					map.put(name, value);
				}
			}
			strResult = MemberDAO.findPwd(map);
			result = -2;
		} else if ("findPeople".equals(type)) {
			list = MemberDAO.findPeople(request.getParameter("nickname"));
			System.out.println(list);
			if(list.isEmpty() || list == null) {
				System.out.println("데이터가 없다~~");
				result = 0;
			} else {
				strResult = changeJson(list);
				result = -2;
			}
		} else if ("setPwd".equals(type)) {
			Map<String, String> map = new HashMap<>();
			map.put("u_id", request.getParameter("u_id"));
			String u_id = request.getParameter("u_id"); //임시용
			System.out.println(u_id);
			map.put("pwd", request.getParameter("pwd"));
			String pwd = request.getParameter("pwd"); //임시용
			System.out.println(pwd);
			result = MemberDAO.setPwd(map);
		} else if ("moveResetPwd".equals(type)) {
			System.out.println(id);
			request.setAttribute("id", request.getParameter("id"));
			request.getRequestDispatcher("resetPwd.jsp").forward(request, response);
		}
		PrintWriter out = response.getWriter();
		
		if (result == -2) {
			System.out.println(strResult);
			out.print(strResult);
		} else if (result == -3) {
			out.print(list);
		} else {
			out.print(result);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		doGet(req, resp);
	}
	
	//Json 형태로 변경하기
	private String changeJson(List<MemberVO> list) {
		StringBuilder result = new StringBuilder();
		result.append("{\"list\" : [");
		for (MemberVO vo : list) {
			result.append("{");
			result.append("\"u_idx\" : " + vo.getU_idx() + ",");
			result.append("\"u_id\" : \"" + vo.getU_id() + "\",");
			result.append("\"nickname\" : \"" + vo.getNickname() + "\",");
			result.append("\"name\" : \"" + vo.getName() + "\",");
			result.append("\"birth\" : \"" + vo.getBirth() + "\",");
			result.append("\"gender\" : \"" + vo.getGender() + "\"");
			result.append("},");
		}
		result.delete(result.length()-1, result.length());
		result.append("]}");
		
		return result.toString();
	}
}
