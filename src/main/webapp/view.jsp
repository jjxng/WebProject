<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %><%--데이터베이스 접근 객체 가져오기 --%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title>view</title>
</head>
<body>
<%
// 현재 세션 상태 체크
String id = null;
if(session.getAttribute("id") != null) {
   id = (String)session.getAttribute("id");
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
Bbs bbs = new BbsDAO().getBbs(num);

int commentID = 0;
if(request.getParameter("commentID") != null)
	commentID = Integer.parseInt(request.getParameter("commentID"));
Comment comment = new CommentDAO().getComment(commentID);

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
      <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd"><br />
         <thead>
            <tr>
               <th colspan="3" style="background-color: #acd5b8; text-align: center;">게시판 글 보기</th>
            </tr>
         </thead>
         <tbody>
            <tr>
               <td style="width:20%; background-color: #d2e7d6;">글 제목</td>
               <td colspan="2"><%= bbs.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
            </tr>
			<tr>
				<td style="width:20%; background-color: #d2e7d6;">작성자</td>
				<td colspan="2"><%= bbs.getId() %></td>
			</tr>
            <tr>
               <td style="width:20%; background-color: #d2e7d6;">작성일자</td>
               <td colspan="2"><%= bbs.getPostdate().substring(0, 11) + bbs.getPostdate().substring(11, 13) + "시" + bbs.getPostdate().substring(14, 16) + "분" %></td>
            </tr>
            <tr>
               <td style="width:20%; background-color: #d2e7d6;">내용</td>
               <td colspan="2" style="min-height: 200px; text-align: left"><%= bbs.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
            </tr>

         </tbody>
      </table>
      <a href="bbs.jsp" class="btn btn-secondary">목록</a>
        <%
			if(id != null && id.equals(bbs.getId())){	// 해당 글이 본인이라면 수정과 삭제가 가능
		%>
         <a href="update.jsp?num=<%= num %>" class="btn btn-secondary">수정</a>
         <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?num=<%= num %>" class="btn btn-secondary">삭제</a>
      <%
         }
      %>
		<br><br>
			<div class="container">
				<div class="row">
					<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
						<tbody>
							<tr>
								<td align="left" bgcolor="skyblue">댓글</td>
							</tr>
							<tr>
								<%
									CommentDAO commentDAO = new CommentDAO();
									ArrayList<Comment> list = commentDAO.getList(num);
									for (int i = 0; i < list.size(); i++) {
								%>
								<div class="container">
				                  	<div class="row">
				                  	<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">                  	
				                  	<tbody>
				                  		<tr>
				                  			<td align="left"><%= list.get(i).getId() %></td>
				                  			
				                  			<td align="right"><%= list.get(i).getPostdate().substring(0,11)+list.get(i).getPostdate().substring(11,13)+"시"+list.get(i).getPostdate().substring(14,16)+"분" %></td>
				                  		</tr>
								<%
									System.out.println("getCommentContent: " + list.get(i).getCommentContent());
								%>
				                  		
				                  		<tr>
				                  			<td align="left"><%= list.get(i).getCommentContent() %></td>
				                  			<td align="right"><a href="commentUpdate.jsp?num=<%=num%>&commentID=<%=list.get(i).getCommentID()%>" class="btn btn-warning">수정</a>
				                  			<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="commentDeleteAction.jsp?num=<%=num%>&commentID=<%=list.get(i).getCommentID() %>" class="btn btn-danger">삭제</a></td>
				                  		</tr>
				                  	</tbody>
				                  	</table>
				                  	</div>
								</div>
								<%
									}
								%>
							</tr>
					</table>
				</div>
			</div>
<br>
			<div class="container">
				<div class="row">
					<form method="post" action="commentAction.jsp?num=<%= num %>">
						<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd">
							<tbody>
								<tr>
									<td align="left"><%= id %></td>
								</tr>
								<tr>
									<td><input type="text" class="form-control"
										placeholder="댓글 쓰기" name="commentContent" maxlength="300"></td>
								</tr>
							</tbody>
						</table>
						<input type="submit" class="btn btn-success pull-right"
							value="댓글 쓰기">
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="include/footer.jsp" %>
</body>
</html>