package MessageBoard.Object;

public class Message {
	
	private String id;
	private String mowner;
	private String content;
	private String mtime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMowner() {
		return mowner;
	}
	public void setMowner(String mowner) {
		this.mowner = mowner;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getMtime() {
		return mtime;
	}
	public void setMtime(String mtime) {
		this.mtime = mtime;
	}
	
}
