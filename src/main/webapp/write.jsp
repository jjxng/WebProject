<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
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
      <%
      // 로그인 하지 않았을 때 보이는 화면
      if(id == null) {
      %>
         <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown">
               <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">접속하기</a>
               <ul class="dropdown-menu">
                  <li><a class="dropdown-item active" href="login.jsp">로그인</a></li>
                  <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
               </ul>
            </li>
         </ul>
      <!-- 로그인이 되어 있는 상태에서 보여주는 화면 -->
      <%} else {%>
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
      <%} %>
      </div>
   </div>
</nav>
<div class="container">
   <div class="row">
   <div class="col-md-12">
      <form name="form" method="post" action="writeAction.jsp">
         <table class="table table-striped">
         <br />
            <thead>
               <tr>
                  <th colspan="2" style="background-color: #acd5b8; text-align: center;">게시판 글쓰기 양식</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <td style="background-color: #d2e7d6;">
                  <input type="text" class="form-control" placeholder=" 글 제목" name="title" maxlength="200"></td>
               </tr>
               <tr>
                  <td style="background-color: #d2e7d6;">
                  <textarea class="form-control" placeholder=" 글 내용" name="content" maxlength="2048" rows="15" style="height: 350px"></textarea></td>
               </tr>
            </tbody>
         </table>
         <div class="d-flex justify-content-end mt-5 mb-5">
            <input type="submit" class="btn btn-secondary pull-right" value="글쓰기">
         </div>
      </form>
   </div>
   </div>
</div>
<%@ include file="include/footer.jsp" %>
</body>
</html>