<%@page import="com.helloworld.vo.MemberVO"%>
<%@page import="com.helloworld.dao.PhotoDAO"%>
<%@page import="com.helloworld.vo.PhotoVO"%>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.util.Enumeration" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberVO login = (MemberVO) session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%

	String path = "upload/image";
	String realPath = request.getServletContext().getRealPath(path);
	System.out.println("/image/write.jsp [realPath] - " + realPath);

	int maxSize= 5*1024*1024;	  															// 사진 사이즈 지정 (5MB)
	String encType = "utf-8";	
	/* String rFolder="C:\\MyStudy\\60_web\\99_HelloWorld\\WebContent\\upload";		   // 경로 저장 변수 */
	//String sFolder = ""; // 사진 저장 경로
	
	MultipartRequest mr = null;
	
	mr = new MultipartRequest(
	request,
	realPath,
	maxSize,
	encType,
	new DefaultFileRenamePolicy()
	);
	
	String p_idx = mr.getParameter("p_idx");
	String fileName = mr.getFilesystemName("fileName");
	String title = mr.getParameter("photoTitle");
	String content = mr.getParameter("photoContent");	
	String status = mr.getParameter("status");
	String oriFileName = mr.getOriginalFileName("fileName");
	String fileSysName = mr.getFilesystemName("fileName");
	
	System.out.println("p_idx : " + p_idx);
	System.out.println("oriFileName : " + oriFileName);
	System.out.println("content : " + content);
	if(content.length() == 0 ){
		System.out.println("content lenght 0 : " + content);
		content = " ";
	}
	System.out.println(fileName);
	System.out.println(title);
	PhotoVO pvo = new PhotoVO();
	
	System.out.println("PM_OK : " + p_idx);
	pvo.setP_idx(Integer.parseInt(p_idx));
	pvo.setTitle(mr.getParameter("photoTitle"));
	pvo.setContent(content);
	
	System.out.println("PM_OK : " + status);
	if("-1".equals(status)){
		PhotoDAO.upPhotoOrig(pvo);
	}else{
		if(fileSysName != null && oriFileName != null){
			pvo.setFilesysname(mr.getFilesystemName("fileName"));	
			pvo.setOrifilename(mr.getOriginalFileName("fileName"));
		}else {
			pvo.setFilesysname("");
			pvo.setOrifilename("");
		}
		PhotoDAO.upPhoto(pvo);
	}
	String paths = session.getServletContext().getRealPath("/");
	request.getRequestDispatcher("photo.jsp").forward(request, response);
%>
</body>
</html>