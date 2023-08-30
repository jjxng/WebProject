<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="id"/>
<jsp:setProperty name="user" property="pass"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<title>loginAction</title>
</head>
<body>
<%
// 현재 세션 상태 체크
String id = null;
if(session.getAttribute("id") != null) {
	id = (String)session.getAttribute("id");
}
// 이미 로그인 했으면 다시 로그인할 수 없게 한다.
if(id != null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 로그인이 되어 있습니다.')");
	script.println("location.href='main.jsp'");
	script.println("</script>");	
}

UserDAO userDAO = new UserDAO();
int result = userDAO.login(user.getId(), user.getPass());
if(result == 1){
	// 로그인에 성공하면 세션 부여
	session.setAttribute("id", user.getId());
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인 성공')");
	script.println("location.href='main.jsp'");
	script.println("</script>");
} else if (result == 0) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('비밀번호가 틀립니다.')");
	script.println("history.back()");
	script.println("</script>");
} else if (result == -1) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('존재하지 않는 아이디 입니다.')");
	script.println("history.back()");
	script.println("</script>");
} else if (result == -2) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('데이터베이스 오류입니다.')");
	script.println("history.back()");
	script.println("</script>");
}
%>
</body>
</html>