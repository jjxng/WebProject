<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link rel="stylesheet" href="css/custom.css">
<title>join</title>
</head>
<body class="bg-gradient-primary">
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
			<ul class="navbar-nav mr-auto">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">접속하기</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item active" href="login.jsp">로그인</a></li>
						<li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</nav>
<div class="container">
	<div class="card o-hidden border-0 shadow-lg my-5">
		<div class="card-body p-0">
			<div class="row">
			<div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
				<div class="col-lg-7">
					<div class="p-5">
						<div class="text-center">
							<h1 class="h4 text-gray-900 mb-4">
								회원가입하기
							</h1>
							<form action="joinAction.jsp" method="post">
							
								<div class="input-group mt-4">
									<label class="input-group-text w15">아이디</label>
									<input type="text" class="form-control rounded-5 w85" placeholder="아이디를 적어주세요." name="id" maxlength="50">
								</div>
								
								<div class="input-group mt-4">
									<label class="input-group-text w15">비밀번호</label>
									<input type="password" class="form-control rounded-5 w85" placeholder="비밀번호를 적어주세요." name="pass" maxlength="50">
								</div>
								
								<div class="input-group mt-4">
									<label class="input-group-text w15">이름</label>
									<input type="text" class="form-control rounded-5 w85" placeholder="이름을 적어주세요." name="name" maxlength="50">
								</div>
								<div class="input-group mt-4">
									<input type="submit" class="form-control rounded-5 btn btn-secondary" value="회원가입">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="include/footer.jsp" %>
</body>
</html>