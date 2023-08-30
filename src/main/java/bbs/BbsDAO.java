package bbs;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO
{
   private Connection conn;
   public PreparedStatement pstmt;
   private ResultSet rs;   
   
   public BbsDAO()
   {
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
        String sql = "select num from board1 order by num desc";
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
   
   // 글쓰기 메소드
   public int write(String title, String id, String content)
   {
       // id로 name를 가져욘다
//       String sql = "select name, email from user1 where id = ?";
//       String name  = "";
//       String email = "";
//       try
//       {
//           PreparedStatement pstmt = conn.prepareStatement(sql);
//           pstmt.setString(1, id);
//           rs = pstmt.executeQuery();
//           if (rs.next())
//           {
//              name  =  rs.getString(1);
//              email =  rs.getString(2);
//          }
//       } catch (Exception e)
//       {
//          e.printStackTrace();
//       }

	   
       	String sql = "insert into board1(num, title, id, postdate, content, available) "
            + "values (seq_board1_num.nextval, ?, ?, ?, ?, ?)";
      try
      {
         PreparedStatement pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, title);
         pstmt.setString(2, id);
         pstmt.setDate(3, getPostdate());
         pstmt.setString(4, content);
         pstmt.setInt(5, 1);   // 글의 유효번호 추후 delete가 아닌 유효성 상실로 삭제 사용
         return pstmt.executeUpdate();
      } catch (Exception e)
      {
         e.printStackTrace();
      }
      return -1;   // 데이터베이스 오류
   }

   
   // 게시글 리스트 메서드
   public ArrayList<Bbs> getList(int pageNumber)
   {
      String sql = "select * from (select * from board1 where num < ? and available = 1 order by num desc) where rownum <= 10";
      ArrayList<Bbs> list = new ArrayList<Bbs>();
         try
         {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
            while (rs.next())
            {
               Bbs bbs = new Bbs();
               bbs.setNum(rs.getInt(1));
               bbs.setTitle(rs.getString(2));
               bbs.setId(rs.getString(3));
               bbs.setPostdate(rs.getString(4));
               bbs.setContent(rs.getString(5));
               bbs.setAvailable(rs.getInt(6));
               list.add(bbs);
            }
         } catch (Exception e)
         {
            e.printStackTrace();
         }
         return list;   // 데이터베이스 오류
   }
	public int getCount() {
		String sql = "select count(*) from board1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
   
   public boolean nextPage(int pageNumber)
   {
      String sql = "select * from board1 where num < ? and available = 1";
        try
        {
           PreparedStatement pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
           rs = pstmt.executeQuery();
           while (rs.next())
           {
             return true;
           }
        } catch (Exception e)
        {
           e.printStackTrace();
        }
        return false;   // 데이터베이스 오류
   }
   
   public Bbs getBbs(int num)
   {
      String sql = "select * from board1 where num = ?";
         try
         {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);  
            rs = pstmt.executeQuery();
            while (rs.next())
            {
              Bbs bbs = new Bbs();
              bbs.setNum(rs.getInt(1));
              bbs.setTitle(rs.getString(2));
              bbs.setId(rs.getString(3));
              bbs.setPostdate(rs.getString(4));
              bbs.setContent(rs.getString(5));
              bbs.setAvailable(rs.getInt(6));
              return bbs;
            }
         } catch (Exception e)
         {
            e.printStackTrace();
         }
         return null;   // 데이터베이스 오류
   }
   
    public int update(int num, String title, String content)
	{
		String sql = "update board1 set title = ?, content =? where num =?";
		    try
		    {
		        PreparedStatement pstmt = conn.prepareStatement(sql);
		        pstmt.setString(1, title);
		        pstmt.setString(2, content);
		        pstmt.setInt(3, num); 
		        return pstmt.executeUpdate();
		    } catch (Exception e)
		    {
		        e.printStackTrace();
		    }
		    return -1;   // 데이터베이스 오류
	}
    
    public int delete(int num)
	{
    	String sql = "update board1 set available = 0 where num =?";
	    try
	    {
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, num); 
	        return pstmt.executeUpdate();
	    } catch (Exception e)
	    {
	        e.printStackTrace();
	    }
	    return -1;   // 데이터베이스 오류
	}
    
    public ArrayList<Bbs> getSearch(String searchField, String searchText){	// 특정한 리스트를 받아서 반환
	      ArrayList<Bbs> list = new ArrayList<Bbs>();
	      String sql ="select * from board1 where "+searchField.trim();
	      try {
	            if(searchText != null && !searchText.equals("") ){
	            	sql +=" like '%"+searchText.trim()+"%' and rownum <= 10 order by num desc";
	            }
	            PreparedStatement pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();	//  select
	        while(rs.next()) {
	            Bbs bbs = new Bbs();
	            bbs.setNum(rs.getInt(1));
                bbs.setTitle(rs.getString(2));
                bbs.setId(rs.getString(3));
                bbs.setPostdate(rs.getString(4));
                bbs.setContent(rs.getString(5));
                bbs.setAvailable(rs.getInt(6));
	            list.add(bbs);	// list에 해당 인스턴스를 담는다.
	         }         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
	      return list;	// 게시글 리스트 반환
	   }
}