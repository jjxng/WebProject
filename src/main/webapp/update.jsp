<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title>write</title>
<style type="text/css">
   a, a:hover {
      color: #003030;
      text-decoration: none;
   }
</style>
</head>
<body>
<%
String id = null;
if(session.getAttribute("id") != null) {
   id = (String)session.getAttribute("id");
}
if (id == null) {
	   PrintWriter script = response.getWriter();
	   script.println("<script>");
	   script.println("alert('로그인을 하세요.')");
	   script.println("location.href='login.jsp'");
	   script.println("</script>");	
}
int num = 0;
if (request.getParameter("num") != null) {
   num = Integer.parseInt(request.getParameter("num"));
}
if (num == 0) {
   PrintWriter script = response.getWriter();
   script.println("<script>");
   script.println("alert('유효하지 않은 글입니다.')");
   script.println("location.href='bbs.jsp'");
   script.println("</script>");
}
// 작성자 확인
Bbs bbs = new BbsDAO().getBbs(num);
if (!id.equals(bbs.getId())) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('권한이 없습니다.')");
    script.println("location.href='bbs.jsp'");
    script.println("</script>");
}
%>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
   <div class="container-fluid">
      <div class="navbar-header">
         <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
            <span class="navbar-toggler-icon"></span>
         </button>
         <a class="navbar-brand active" href="main.jsp">JJXXNZ</a>
      </div>
   <div class="collapse navbar-collapse" id="#collapsibleNavbar">
      <ul class="nav navbar-nav me-auto">
         <li class="nav-item"><a class="nav-link" href="main.jsp">메인</a></li>
         <li class="nav-item"><a class="nav-link active" href="bbs.jsp">게시판</a></li>
         <li class="nav-item"><a class="nav-link" href="kakaoMap.jsp">오시는길</a></li>
      </ul>
         <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown">
               <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">회원관리</a>
               <ul class="dropdown-menu">
                  <li>
                     <a class="dropdown-item" href="userUpdate.jsp">회원정보수정</a>                  
                     <a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
                  </li>
               </ul>
            </li>
         </ul>
      </div>
   </div>
</nav>
<div class="container">
   <div class="row">
   <div class="col-md-12">
      <form method="post" action="updateAction.jsp?num=<%= num %>"><%-- 업데이트 요청 페이지 --%>
         <table class="table table-striped">
         <br />
            <thead>
               <tr>
                  <th colspan="2" style="background-color: #acd5b8; text-align: center;">게시판 글 수정 양식</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <td style="background-color: #d2e7d6;">
                  <input type="text" class="form-control" placeholder=" 글 제목" name="title" maxlength="200" value="<%= bbs.getTitle() %>"></td>
               </tr>
               <tr>
                  <td style="background-color: #d2e7d6;">
                  <textarea class="form-control" placeholder=" 글 내용" name="content" maxlength="2048" rows="15" style="height: 350px;"><%= bbs.getContent() %></textarea></td>
               </tr>
            </tbody>
         </table>
         <div class="d-flex justify-content-end mt-5 mb-5">
            <input type="submit" class="btn btn-secondary pull-right" value="글 수정">
         </div>
      </form>
   </div>
   </div>
</div>
<%@ include file="include/footer.jsp" %>
</body>
</html>