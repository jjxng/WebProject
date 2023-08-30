<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<jsp:setProperty name="bbs" property="title"/>
<jsp:setProperty name="bbs" property="content"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// 현재 세션 상태 체크
String id = null;
if(session.getAttribute("id") != null) {
	id = (String)session.getAttribute("id");
}

String str_title = request.getParameter("title");
System.out.println("===title==:"+str_title);

if(id == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 하세요.')");
	script.println("location.href='login.jsp'");
	script.println("</script>");	
} else {
	if(bbs.getTitle() == null || bbs.getContent() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.write(bbs.getTitle(), id, bbs.getContent());
		if(result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시글 작성 완료')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
	}
}
%>
</body>
</html>