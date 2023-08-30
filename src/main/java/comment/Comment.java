package comment;

public class Comment {
	private String commentContent;
	private int commentID;
	private String id;
	private int available;
	private int num;
	private String postdate;
	
	public String getCommentContent()
	{
		return commentContent;
	}
	public void setCommentContent(String commentContent)
	{
		this.commentContent = commentContent;
	}
	public int getCommentID()
	{
		return commentID;
	}
	public void setCommentID(int commentID)
	{
		this.commentID = commentID;
	}
	public String getId()
	{
		return id;
	}
	public void setId(String id)
	{
		this.id = id;
	}
	public int getAvailable()
	{
		return available;
	}
	public void setAvailable(int available)
	{
		this.available = available;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getPostdate()
	{
		return postdate;
	}
	public void setPostdate(String postdate)
	{
		this.postdate = postdate;
	}
}

