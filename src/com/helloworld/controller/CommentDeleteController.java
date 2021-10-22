package com.helloworld.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.helloworld.dao.CommentsDAO;
import com.helloworld.vo.CommentsVO;

@WebServlet("/CommentDeleteController")
public class CommentDeleteController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//댓글 삭제와 동시에 ajax로 댓글을 출력
		System.out.println("CommentDeleteController 실행");
		response.setContentType("text/html;charset=UTF-8");
		
		String c_idx = request.getParameter("c_idx");
		String b_idx = request.getParameter("b_idx");
		//System.out.println("c_idx : " + c_idx);
		System.out.println("c_idx : " + c_idx);
		System.out.println("b_idx : " + b_idx);
		
		CommentsDAO.boardCommentDelete(c_idx);
		
		List<CommentsVO> list = CommentsDAO.boardCommentsAll(b_idx);
		
		String result = makeJson(list);
		System.out.println("result : " + result);	
		//JSON 문자열 출력
		PrintWriter out = response.getWriter();
		out.print(result);
		
	}
	
	private String makeJson(List<CommentsVO> list) {
		System.out.println("makeJson 실행~");
		StringBuilder result = new StringBuilder();
		result.append("{ \"list\" : [");	
		
		for (CommentsVO vo : list) {
			result.append("{");
			result.append("\"nickname\" : \"" + vo.getNickname() + "\",");
			result.append("\"content\" : \"" + vo.getContent() + "\",");
			result.append("\"regdate\" : \"" + vo.getRegdate() + "\",");
			result.append("\"c_idx\" : " + vo.getC_idx());
			result.append("},");
		}
		result.delete(result.length() - 1, result.length());
		result.append("]}");
		
		return result.toString();
	}
}
