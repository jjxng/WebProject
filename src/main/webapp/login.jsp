<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/custom.css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<title>BBS</title>
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
		<div class="row justyfy-content-center">
			<div class="col-xl-10 col-lg-12 col-md-9">
				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
							<div class="col-lg-6">
								<div class="p-5">
									<form method="post" action="loginAction.jsp">
										<div class="text-center">
											<h1 class="mb-4 text-gray-900 h4">Welcome!</h1>
										</div>
										<div class="form-group mt-3">
											<input 
											type="text" 
											class="form-control rounded-5" 
											placeholder="enter your id"
											name="id"
											maxlength="10"
											>
										</div>
		
										<div class="form-group mt-3">
											<input 
											type="password" 
											class="form-control rounded-5" 
											placeholder="enter your password"
											name="pass"
											maxlength="10"
											>
										</div>
										<input type="submit" class="btn btn-secondary form-control rounded-5" value="로그인"><br /><br />
										
									</form>
									
									<div class="text-center">
										<a class="small" href="join.jsp">
										회원가입하기
										</a>
									</div>
								</div>
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