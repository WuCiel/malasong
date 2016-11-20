package MessageBoard.Object;

/**
 * 产品信息类
 * @author xuhua
 *
 */
public class Product {
	
	private String pname;
	private String qoh;
	private String qoh_threshold;
	private String original_price;
	private String discnt_rate;
	private String sid;
	private String imgUrl;
	private String pid;
	private int count;
	private String deps;
	
	public Product() {

	}
	

	public String getDeps() {
		return deps;
	}

	public void setDeps(String deps) {
		this.deps = deps;
	}

	public int getCount() {
		return count;
	}


	public void setCount(int count) {
		this.count = count;
	}

	

	public Product(String pname, String qoh, String qoh_threshold,
			String original_price, String discnt_rate, String sid,
			String imgUrl, String pid, String deps) {
		super();
		this.pname = pname;
		this.qoh = qoh;
		this.qoh_threshold = qoh_threshold;
		this.original_price = original_price;
		this.discnt_rate = discnt_rate;
		this.sid = sid;
		this.imgUrl = imgUrl;
		this.pid = pid;
		this.deps = deps;
	}


	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getQoh() {
		return qoh;
	}
	public void setQoh(String qoh) {
		this.qoh = qoh;
	}
	public String getQoh_threshold() {
		return qoh_threshold;
	}
	public void setQoh_threshold(String qoh_threshold) {
		this.qoh_threshold = qoh_threshold;
	}
	public String getOriginal_price() {
		return original_price;
	}
	public void setOriginal_price(String original_price) {
		this.original_price = original_price;
	}
	public String getDiscnt_rate() {
		return discnt_rate;
	}
	public void setDiscnt_rate(String discnt_rate) {
		this.discnt_rate = discnt_rate;
	}
	public String getSid() {
		return sid;
	}
	
	
	public String getImgUrl() {
		return imgUrl;
	}


	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}


	public void setSid(String sid) {
		this.sid = sid;
	}
	
	

}
