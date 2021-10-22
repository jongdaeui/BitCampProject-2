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

@WebServlet("/CommentBoardController")
public class CommentBoardController extends HttpServlet{
	//해당 게시글에 있는 모든 댓글들을 가져오는 컨트롤러
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//댓글 저장과 동시에 수정된 댓글 출력
		response.setContentType("text/html;charset=UTF-8");
		
		//db에서 해당 게시글의 댓글 리스트를 받아오기 위한 메서드 호출
		String b_idx = request.getParameter("b_idx");
		String nickname = request.getParameter("nickname");
		String content = request.getParameter("content");
		
		//받아온 값들을 가지고 해당 객체를 db에 저장, 모든 값들이 null이 아닐 때만 실행
		if (!b_idx.equals(null) && !nickname.equals(null) && !content.equals(null)) {
			CommentsDAO.boardInsert(b_idx, content, nickname);
		}
		
		//해당 게시글의 댓글을 가져오기 위한 메서드 호출
		List<CommentsVO> list = CommentsDAO.boardCommentsAll(b_idx);
		
		String result = makeJson(list);
		System.out.println("result : " + result);	
		//JSON 문자열 출력
		PrintWriter out = response.getWriter();
		out.print(result);
	}
	
	private String makeJson(List<CommentsVO> list) {
		/* {"list" : [ {}, {}, {}, .... , {} ] }
		{ "list" : [
			{
				"idx" : 1,
				"name" : "홍길동",
				"age" : 27,
				"addr" : "서울",
				"regdate" : "2021-10-07"
			}, {}, {}, ... , {}
		] }
		*/
		//JSON 형태 문자열로 바꾸기
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
