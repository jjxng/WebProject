<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name ="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
String id = null;
if(session.getAttribute("id") != null){
	id = (String)session.getAttribute("id");
}
User user=new UserDAO().getUser(id);

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
         <li class="nav-item"><a class="nav-link" href="bbs.jsp">게시판</a></li>
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
                  <li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
                  <li><a class="dropdown-item" href="userUpdate.jsp">회원정보수정</a></li>
               </ul>
            </li>
         </ul>
      <%} %>
      </div>
   </div>
</nav>
<%
	
%>

<div class="container">
	<div class="card o-hidden border-0 shadow-lg my-5">
		<div class="card-body p-0">
			<div class="row">
			<div class="col-lg-5 d-none d-lg-block bg-userUpdate-image"></div>
				<div class="col-lg-7">
					<div class="p-5">
						<div class="text-center">
							<h1 class="h4 text-gray-900 mb-4">
								회원정보 수정하기
							</h1>
							<form action="userUpdateAction.jsp" method="post">
							
<!-- 									<div class="input-group mt-4"> -->
<!-- 									<label class="input-group-text w15">아이디</label> -->
<!-- 									<input type="text" class="form-control rounded-5 w85" placeholder="아이디를 적어주세요." name="id" maxlength="10"> -->
<!-- 									</div> -->
							<div class = "form-group mt-4">
								<label class="input-group-text w15">아이디</label>
									<input type="text" class="form-control rounded-5 w85" value=<%=user.getId()%> name="id" maxlength="50" disabled>
							</div>
							<div class="form-group">
								<label class="input-group-text w15">비밀번호</label>
									<input type="password" class="form-control rounded-5 w85" value=<%=user.getPass()%> name="pass" maxlength="50">
							</div>
							<div class="form-group">
								<label class="input-group-text w15">이름</label>
									<input type="text" class="form-control rounded-5 w85" value=<%=user.getName()%> name="name" maxlength="50">
							</div>
							<input type="submit" class="btn btn-success form-control" value="수정하기"></form><br />
				           <form method="post" action="userDeleteAction.jsp">
				           <input type="submit" class="btn btn-danger pull-right" value="탈퇴하기">
				           </form>
							<br>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>