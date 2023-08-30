<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty property="id" name="user"/>
<jsp:setProperty property="pass" name="user"/>
<jsp:setProperty property="name" name="user"/>
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
// 이미 로그인을 했으면 회원가입을 할 수 없게 한다.
if(id != null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 로그인 되어 있습니다.')");
	script.println("location.href='main.jsp'");
	script.println("</script>");	
}

// db테이블 누락 확인
if(user.getId() == null || user.getPass() == null || user.getName() == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('입력이 안 된 사항이 있습니다.')");
	script.println("history.back()");
	script.println("</script>");
} else {
	UserDAO userDAO = new UserDAO();
	int result = userDAO.join(user);
	if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디 입니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		session.setAttribute("id", user.getId());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원가입 성공.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
}
	
%>
</body>
</html>