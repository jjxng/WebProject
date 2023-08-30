<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
	String id = null;
	if(session.getAttribute("id") != null){
		id = (String)session.getAttribute("id");
	}
	if(id == null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	int num = 0;
	if(request.getParameter("num")!=null)
		num = Integer.parseInt(request.getParameter("num"));
	
	int commentID = 0;
	if(request.getParameter("commentID") != null)
		commentID = Integer.parseInt(request.getParameter("commentID"));
	
	if(commentID == 0){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}
	
	Comment comment = new CommentDAO().getComment(commentID);
	if(!id.equals(comment.getId())){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	} else{
			CommentDAO commentDAO=new CommentDAO();	// 하나의 인스턴스
			int result = commentDAO.delete(commentID);
			if(result == -1){	// 데이터 베이스 오류가 날 때
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('댓글 삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("location.href=document.referrer;");
				script.println("</script>");
			}
	}
%>
</body>
</html>