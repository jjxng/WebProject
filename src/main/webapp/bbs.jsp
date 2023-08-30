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
<title>bbs</title>
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
int pageNumber = 1;
if(request.getParameter("pageNumber") != null) {
   pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
<div class="bg-gradient-primary">
	<%
		BbsDAO bbs = new BbsDAO();
	%>
<div class="container">
   <div class="row justyfy-content-center">
      <div class="col-md-12">
         <h1 class="mt-3 mb-3">글 목록</h1>
        	 <form method="post" name="search" action="searchbbs.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="title">제목</option>
								<option value="id">작성자(아이디)</option>
								<option value="content">내용</option>
						</select></td>
						<td><input type="text" class="form-control"
							placeholder="검색어 입력" name="searchText" maxlength="100"></td>
						<td><button type="submit" class="btn btn-success">검색</button></td>
					</tr>
				</table>
			</form>
            <table class="table table-striped">
               <thead>
                  <tr>
                     <th style="background-color: #acd5b8; text-align: center;">번호</th>
                     <th style="background-color: #acd5b8; text-align: center;">제목</th>
                     <th style="background-color: #acd5b8; text-align: center;">작성자(아이디)</th>
                     <th style="background-color: #acd5b8; text-align: center;">작성일</th>
                  </tr>
               </thead>
               <tbody>
                  <%
                     BbsDAO bbsDAO =  new BbsDAO();
                     ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                     for(int i = 0; i < list.size(); i++) {
                   %> 
                  <tr>
                     <td style="background-color: #d2e7d6; text-align: center;"><%= list.get(i).getNum() %></td>
                     <td style="background-color: #d2e7d6; text-align: center;"><a href="view.jsp?num=<%= list.get(i).getNum() %>"><%= list.get(i).getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
                     <td style="background-color: #d2e7d6; text-align: center;"><%= list.get(i).getId() %></td>
                     <td style="background-color: #d2e7d6; text-align: center;"><%= list.get(i).getPostdate().substring(0, 11) + list.get(i).getPostdate().substring(11, 13) + "시" + list.get(i).getPostdate().substring(14, 16) + "분" %></td>
                  </tr>
                  <%
                      }
                   %> 
               </tbody>
            </table>
            <%
                if(pageNumber != 1) {
             %> 
               <a href="bbs.jsp?pageNumber=<%= pageNumber - 1 %>" class="btn btn-secondary btn-arraw-left">이전</a>
            <%
                } if(bbsDAO.nextPage(pageNumber + 1)) {
             %> 
               <a href="bbs.jsp?pageNumber=<%= pageNumber + 1 %>" class="btn btn-secondary btn-arraw-left">다음</a>
            <% 
                }
            %> 
            
            <div class="d-flex justify-content-end mt-5 mb-5">
               <a href="write.jsp" class="btn btn-secondary pull-right">글쓰기</a>
            </div>
      </div>
   </div>
</div>
</div>
<%@ include file="include/footer.jsp" %>
</body>
</html>