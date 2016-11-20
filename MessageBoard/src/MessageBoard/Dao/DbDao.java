package MessageBoard.Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import MessageBoard.Object.Customer;
import MessageBoard.Object.Order;
import MessageBoard.Object.Product;
import MessageBoard.Object.ProductCar;
public class DbDao {
	
	private static String dbdriver = "";
	private static String dbuser = "";
	private static String dbpwd = "";
	private static String dbhost = "";
	private static String dbencodeMethod = "useUnicode=true&characterEncoding=utf-8";
	private static String dburl = "";
	private static String db="";
	
	private static DbDao dbDao=null;
	private Connection conn=null;
	
	//初始化参数
	public static void setDbParameter(String dbDriver,String dbT,String dbHost,String dbUser,String dbPwd){
		dbdriver = dbDriver;
		dbhost = dbHost;
		db = dbT;
		dbuser = dbUser;
		dbpwd = dbPwd;
		dburl = "JDBC:mysql://"+dbhost+":3306/"+db+"?"+dbencodeMethod;
		
		System.out.println("setting dbParam");
	}
	
	//获取对象
	public static DbDao getDbOperator(){
		if(dbDao==null)
			dbDao = new DbDao();
		return dbDao;
	}
	
	//构造器
	private DbDao() {
		 try {
			Class.forName(dbdriver);
			conn = DriverManager.getConnection(dburl,dbuser,dbpwd);
			if(conn==null){
				System.out.println("is null");
			}else{
				System.out.println("ok");
			}
		} catch (ClassNotFoundException e) {
			System.out.println("wrong");
		} catch (SQLException e) {
			System.out.println("wrong12");
		}
	}
	
	//判断用户是否存在
	public boolean isExitUser(String usename){
		
		String sql = "SELECT cname from customers WHERE cname='"+usename+"'";
		PreparedStatement state=null;
		try {
			state = conn.prepareStatement(sql);
			ResultSet result = state.executeQuery(sql);
			if(!result.next()) return false;
			else return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(state!=null && !state.isClosed()){
					try {
						state.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}
	
	public boolean isAdmin(Customer c){
		String sql = "select isManager is from Customers where cid = ?";
		PreparedStatement state=null;
		try {
			state = conn.prepareStatement(sql);
			int isManage = 0;
			ResultSet resultSet = state.executeQuery();
			if(resultSet.next()){
				isManage = resultSet.getInt("is");
			}
			if(isManage==1) return true;
			else return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
		
	}
	
	//删除产品
	public boolean delectProduct(Product product){
		String sql = "delect from products where pid=?";
		PreparedStatement state=null;
		try {
			state=conn.prepareStatement(sql);
			state.setString(1, product.getPid());

			int result = state.executeUpdate();
			if(result ==1) return true;
			else return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				if(state!=null && !state.isClosed()){
					try {
						state.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}
	
	//更新产品信息
	public boolean updateProduct(Product product){
		
		String sql = "Update products set pname=?,qoh=?,qoh_threshold=?,original_price=?,discnt_rate=? where pid=?";
		PreparedStatement state=null;
		try {
			state=conn.prepareStatement(sql);
			state.setString(1, product.getPname());
			state.setString(2,product.getQoh());
			state.setString(3,product.getQoh_threshold());
			state.setString(4, product.getOriginal_price());
			state.setString(5, product.getDiscnt_rate());
			state.setString(6, product.getPid());
			
			int result = state.executeUpdate();
			if(result==1) return true;
			else return false;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(state!=null && !state.isClosed()){
					try {
						state.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return false;
	}
	
	//添加产品
	public boolean addProduct(Product product){

		String sql = "Insert into products(pid,pname,qoh,qoh_threshold,original_price,discnt_rate,sid,imgUrl) values(0,?,?,?,?,?,?,?)";
		PreparedStatement state =null;
		try {
			state=conn.prepareStatement(sql);
			state.setString(1, product.getPname());
			state.setString(2,product.getQoh());
			state.setString(3,product.getQoh_threshold());
			state.setString(4, product.getOriginal_price());
			state.setString(5, product.getDiscnt_rate());
			state.setString(6, product.getImgUrl());
			int result = state.executeUpdate();
			if(result==1) return true;
			else return false;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(state!=null && !state.isClosed()){
					try {
						state.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}
	
	private String getMd5(String cname,String cpwd){
		String sql = "Select MD5('"+cname+cpwd+"') pwd";
		Statement state=null;
		String pwd="";
		try {
			state = conn.createStatement();
			ResultSet result = state.executeQuery(sql);
			if(result.next()){
				pwd = result.getString("pwd");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pwd;
	}
	//添加新用户
	public boolean addCustomer(Customer c){
		
		String pwd = getMd5(c.getCid(), c.getCpwd());
		String sql = "Insert into customers(cid,cpwd,cname,city,visits_made,last_visit_time) values(?,?,?,?,1,now())";
		PreparedStatement state =null;
		try {
			state=conn.prepareStatement(sql);
			state.setString(1, c.getCid());
			state.setString(2,pwd);
			state.setString(3, c.getCname());
			state.setString(4, c.getCity());
			int result = state.executeUpdate();
			if(result==1){
				return true;
			}else return false;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(state!=null && !state.isClosed()){
					try {
						state.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;		
	}
	//检查账号密码是否正确
	public boolean judgeCustomer(Customer c){
		String pwd = getMd5(c.getCid(), c.getCpwd());
		System.out.println(c.getCid()+"  "+c.getCpwd());
		String sql = "select cid,cpwd from customers where cid=? and cpwd= ?";
		PreparedStatement state =null;
		try {
			state=conn.prepareStatement(sql);
			state.setString(1, c.getCid());
			state.setString(2,pwd);
			ResultSet result = state.executeQuery();
			if(result.next()) return true;
			else return false;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(state!=null && !state.isClosed()){
					try {
						state.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	

	//获取所有产品列表
	public ArrayList<Product> getProduct(){
		ArrayList<Product> productList = new ArrayList<Product>();
		String  sql = "SELECT * FROM products ";
		PreparedStatement state=null;
		try {
			 state= conn.prepareStatement(sql);
			ResultSet result = state.executeQuery();
			while(result.next()){
				String pid = result.getString("pid");
				String pname = result.getString("pname");
				String qoh = result.getString("qoh");
				String qoh_threshold = result.getString("qoh_threshold");
				String original_price = result.getString("original_price");
				String discnt_rate = result.getString("discnt_rate");
				String sid = result.getString("sid");
				String imgUrl = result.getString("imgUrl");
				String deps = result.getString("deps");
				//int count = result.getInt("count");
				Product product  = new Product(pname, qoh, qoh_threshold, original_price, discnt_rate, sid, imgUrl, pid, deps);
				productList.add(product);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(state!=null && !state.isClosed()){
					try {
						state.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return productList;
	}
	
	//根据pageNum以及pageSize来获取产品列表
	public ArrayList<Product> getProduct(int pageNum,int pageSize){
		ArrayList<Product> productList = new ArrayList<Product>();
		String  sql = "SELECT * FROM products limit "+
				 		(pageNum-1)*pageSize+","+pageSize;
		PreparedStatement state=null;
		try {
			 state= conn.prepareStatement(sql);
			ResultSet result = state.executeQuery();
			while(result.next()){
				String pid = result.getString("pid");
				String pname = result.getString("pname");
				String qoh = result.getString("qoh");
				String qoh_threshold = result.getString("qoh_threshold");
				String original_price = result.getString("original_price");
				String discnt_rate = result.getString("discnt_rate");
				String sid = result.getString("sid");
				String imgUrl = result.getString("imgUrl");
				String deps = result.getString("deps");
				//int count = result.getInt("count");
				Product product  = new Product(pname, qoh, qoh_threshold, original_price, discnt_rate, sid, imgUrl, pid, deps);
				productList.add(product);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(state!=null && !state.isClosed()){
					try {
						state.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return productList;
	}
	
	//获取产品种类数量
	public int getProductNum(){
		String sql = "Select count(*) from products";
		int pageNum =0;
		PreparedStatement state =null;
		try {
			state=conn.prepareStatement(sql);
			ResultSet result = state.executeQuery();
			if(result.next()){
				pageNum = Integer.parseInt(result.getString("count(*)"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(state!=null && !state.isClosed()){
					try {
						state.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return pageNum;
	}
	
	//插入订单
	@SuppressWarnings("resource")
	public boolean addOrder(Order order){
		
		String sql = "Insert into myorder(cid,price) values(?,?)";
		PreparedStatement state=null;
		String oid = "";
		ProductCar productCar = order.getProductCar();
		ArrayList<Product> productList = productCar.getProductList();
		Customer cus = productCar.getCustomer();
		String cid = cus.getCid();
		
		try {
			state=conn.prepareStatement(sql);
			state.setString(1, cid);
			state.setFloat(2, (float) order.getPrice());
			state.executeUpdate();
			sql = "SELECT LAST_INSERT_ID() oid";
			state=conn.prepareStatement(sql);
			ResultSet result = state.executeQuery();
			if(result.next()){
				oid = result.getString("oid");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(state!=null && !state.isClosed()){
					try {
						state.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
				}
		}
		int cnt=0;
		if(productList!=null){
			for(Product p:productList){
				try {
					sql = "Insert into orderItem(oid,pid,ccount)values(?,?,?)";
					state=conn.prepareStatement(sql);
					state.setString(1, oid);
					state.setString(2,p.getPid());
					state.setInt(3, p.getCount());
					cnt+=state.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
				}finally{
					try {
						if(state!=null && !state.isClosed()){
							try {
								state.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
						}
					} catch (SQLException e) {
						e.printStackTrace();
						}
					}
			}
		}
		if(cnt==productList.size()){
			return true;
		}else{
			return false;
		}
	}
	
	//获取购物车中的物品
	public ProductCar getProductCar(String cid){
		
		String sql = "Select * from buyCar where cid=?";
		PreparedStatement state=null;
		ProductCar productCar = new ProductCar();
		try {
			state=conn.prepareStatement(sql);
			state.setString(1, cid);
			ResultSet result = state.executeQuery();
			while(result.next()){
				
				Product p = new Product();
				String pid = result.getString("pid");
				int count = result.getInt("pcount");
				p.setCount(count);
				p.setPid(pid);		
				productCar.addProduct(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return productCar;
	}
	
	//将购物车的内容添加到数据库
	public boolean addToProductCar(ProductCar productCar){
		
		ArrayList<Product> productList = productCar.getProductList();
		Customer cus = productCar.getCustomer();
		String cid = cus.getCid();
		PreparedStatement state=null;
		int cnt=0;
		for(Product p:productList){
			String sql = "Insert into buyCar(cid,pid,pcount) values(?,?,?)";
			try {
				state = conn.prepareStatement(sql);
				state.setString(1, cid);
				state.setString(2,p.getPid());
				state.setInt(3, p.getCount());
				cnt+=state.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
			try {
				if(state!=null && !state.isClosed()){
					try {
						state.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
				}
			}
		}
		if(cnt==productList.size()){
			return true;
		}else{
			return false;
		}
	}
}
