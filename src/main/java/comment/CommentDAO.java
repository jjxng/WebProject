package comment;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;

public class CommentDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public CommentDAO() {
		try
	    {
	        Class.forName("oracle.jdbc.OracleDriver");
	        String url = "jdbc:oracle:thin:@localhost:1521:xe";
	        String id = "musthave";
	        String pwd = "1234";
	        conn = DriverManager.getConnection(url, id, pwd);
	        System.out.println("DB 연결 성공(기본 생성자)");
		} catch (Exception e)
		    {
		        e.printStackTrace();
		    }
	}
	
   // 작성일자 메소드
   public Date getPostdate()
   {
      // 현재 시간선택
      String sql = "select sysdate from dual";
      try
      {
         PreparedStatement pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         if (rs.next())
         {
            return rs.getDate(1);
         }
      } catch (Exception e)
      {
         e.printStackTrace();
      }
      return null;   // 데이터베이스 오류
   }
	
    // 게시글 번호 부여 메소드
    public int getNext()
    {
	    // 현재 게시글들을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다.
	    String sql = "select commentID from comment1 order by commentID desc";
	    try
	    {
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        rs = pstmt.executeQuery();
	        if (rs.next())
	        {
	           return rs.getInt(1) + 1;
	        }
	        return 1;   // 첫 번째 게시글인 경우
	    } catch (Exception e)
	    {
           e.printStackTrace();
        }
	    return -1;   // 데이터베이스 오류
	}
	
	public int write(String commentContent, String id, int num) {
		String sql = "insert into comment1 values (?, ?, ?, ?, ?, ?)";
//		String sql = "insert into comment1(commentContent, commentID, id, available, postdate, num) "
//				+ "values (?, seq_comment1_num.nextval, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, commentContent);
			pstmt.setInt(2, getNext());
			pstmt.setString(3, id);
			pstmt.setInt(4, 1);
			pstmt.setDate(5, getPostdate());
			pstmt.setInt(6, num);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}

	public ArrayList<Comment> getList(int num){	// 특정한 리스트를 받아서 반환
		String sql = "select * from (select * from comment1 where num = ? and available = 1 order by commentID desc) where rownum <= 10";	// 마지막 게시물 반환, 삭제가 되지 않은 글만 가져온다.
		ArrayList<Comment> list = new ArrayList<Comment>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Comment comment = new Comment();
				comment.setCommentContent(rs.getString(1));
				comment.setCommentID(rs.getInt(2));
				comment.setId(rs.getString(3));
				comment.setAvailable(rs.getInt(4));
				comment.setPostdate(rs.getString(5));
				comment.setNum(rs.getInt(6));
				list.add(comment);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;	// 댓글 리스트 반환
	}
	
	public Comment getComment(int commentID) {	// 하나의 댓글 내용을 불러오는 함수
		String sql = "select * from comment1 where commentID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, commentID);
			rs=pstmt.executeQuery();	// select
			if(rs.next()) {	// 결과가 있다면
				Comment comment = new Comment();
				comment.setCommentContent(rs.getString(1));
				comment.setCommentID(rs.getInt(2));
				comment.setId(rs.getString(3));
				comment.setAvailable(rs.getInt(4));
				comment.setPostdate(rs.getString(5));
				comment.setNum(rs.getInt(6));				
				return comment;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int num, int commentID,String commentContent ) {
		String sql = "update comment1 set commentContent = ? where num = ? and commentID = ?";	// 특정한 아이디에 해당하는 제목과 내용을 바꿔준다. 
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, commentContent);	// 물음표의 순서
			pstmt.setInt(2, num);
			pstmt.setInt(3, commentID);
			return pstmt.executeUpdate();	// insert,delete,update			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
	
	public int delete(int commentID) {
		String sql = "update comment1 set available = 0 where commentID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, commentID);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
	
}
