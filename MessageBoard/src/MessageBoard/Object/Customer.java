package MessageBoard.Object;

/**
 * 顾客类
 * @author xuhua
 *
 */
public class Customer {
	
	private String cid;
	private String cname;
	private String city;
	private String cpwd;
	
	
	public Customer() {	}

	public Customer(String cid, String cname, String city, String cpwd) {
		super();
		this.cid = cid;
		this.cname = cname;
		this.city = city;
		this.cpwd = cpwd;
	}


	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCpwd() {
		return cpwd;
	}
	public void setCpwd(String cpwd) {
		this.cpwd = cpwd;
	}
	
	

}
