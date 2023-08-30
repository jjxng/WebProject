<%@page import="org.apache.jasper.tagplugins.jstl.core.If"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title>main</title>
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
			<li class="nav-item"><a class="nav-link active" href="main.jsp">메인</a></li>
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
<div class="container-fluid p-0">
	<div id="demo" class="carousel slide" data-bs-ride="carousel">
	
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active">
			</button>
			<button type="button" data-bs-target="#demo" data-bs-slide-to="1">
			</button>
			<button type="button" data-bs-target="#demo" data-bs-slide-to="2">
			</button>
		</div>	
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="img/slide/1.jpg" alt="" class="d-block mw-100">
			</div>
			<div class="carousel-item active">
				<img src="img/slide/2.jpg" alt="" class="d-block mw-100">
			</div>
			<div class="carousel-item active">
				<img src="img/slide/3.jpg" alt="" class="d-block mw-100">
			</div>
		</div>
		
		<button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
			<span class="carousel-control-prev-icon"></span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
			<span class="carousel-control-next-icon"></span>
		</button>
	</div>
</div>
<%@ include file="include/footer.jsp" %>
</body>
</html>