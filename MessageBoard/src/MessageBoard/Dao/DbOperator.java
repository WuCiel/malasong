package MessageBoard.Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.swing.undo.StateEdit;

import MessageBoard.Object.Message;
import MessageBoard.Object.User;

public class DbOperator {
	private static String dbdriver = "";
	private static String dbuser = "";
	private static String dbpwd = "";
	private static String dbhost = "";
	private static String dbencodeMethod = "useUnicode=true&characterEncoding=utf-8";
	private static String dburl = "";
	
	private static DbOperator dbOperator=null;
	private Connection conn;
	
	//初始化参数
	public static void setDbParameter(String dbDriver,String dbHost,String dbUser,String dbPwd){
		dbdriver = dbDriver;
		dbhost = dbHost;
		dbuser = dbUser;
		dbpwd = dbPwd;
		dburl = "JDBC:mysql://"+dbhost+"/"+dbuser+"?"+dbencodeMethod;
	}
	//初始化对象
	private DbOperator() {
		 try {
			Class.forName(dbdriver);
			conn = DriverManager.getConnection(dburl,dbuser,dbpwd);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	//获取对象
	public static DbOperator getDbOperator(){
		if(dbOperator==null)
			dbOperator = new DbOperator();
		return dbOperator;
	}
	
	//添加新用户
	public boolean addUser(User user){
		
		String sql = "INSERT INTO use_info(uname,pwd,registerDate,lastLoginDate,lastLoginIp,realName,email) "
				+ "values(?,MD5('"+user.getUname()+user.getPwd()+"'),now(),now(),?,?,?)";
		
		PreparedStatement st;
		int count = 0;
		try {
			st = conn.prepareStatement(sql);
			st.setString(1, user.getUname());
			st.setString(2,user.getLastLoginIp());
			st.setString(3,user.getRealName());
			st.setString(4,user.getEmail());
			count = st.executeUpdate();
			st.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(count==1){
			return true;
		}else{
			return false;
		}
	}
	
	//更新用户最后登录的信息
	private void updateLastLoginInfo(User user){
		String sql = "update use_info set lastLoginDate = now() ,lastLoginIp = '"+
					user.getLastLoginIp()+"' where uname = '"+user.getUname()+"'";
		Statement state=null;
		try {
			state = conn.createStatement();
			state.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(state!=null)
					state.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	//判断用户是否存在
	public boolean isExitUser(String usename){
		
		String sql = "SELECT uname from use_info WHERE uname='"+usename+"'";
		Statement state;
		try {
			state = conn.createStatement();
			ResultSet result = state.executeQuery(sql);
			if(!result.next()) return false;
			else return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 添加回复的信息
	
	public boolean addReplyMesage(Message msg){
		
		String sql = "select max(rid) from replymessage where mid="+msg.getId();
		String maxSize="";
		ResultSet result;
		try {
			PreparedStatement state =conn.prepareStatement(sql);
			result = state.executeQuery(sql);
			if(result.next()){
				maxSize = result.getString("max(rid)");
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		 
		if(maxSize==null) maxSize="0";
		int tolNum = Integer.parseInt(maxSize)+1;
		 sql = "Insert into replymessage(id,rid,rtime,mid,mowner,rcontent) values(0,?,now(),?,?,?)";
		PreparedStatement st;
		try {
			st = conn.prepareStatement(sql);
			st.setString(1, tolNum+"");
			st.setString(2,msg.getId());
			st.setString(3, msg.getMowner());
			st.setString(4,msg.getContent());
			int count = st.executeUpdate();
			if(count==1) return true;
			else return false;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
		
	}
	
	//添加发布的留言信息
	public boolean addMsg(Message msg){
		String sql = "INSERT INTO message(id,content,mtime,mowner) values(?,?,now(),?)";
		try {
			PreparedStatement  st = conn.prepareStatement(sql);
			st.setInt(1, 0);
			st.setString(2, msg.getContent());
			st.setString(3, msg.getMowner());
			int result = st.executeUpdate();
			
			if(result==1) return true;
			else return false;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
	
	// 获取回复信息
	public ArrayList<Message> getReplyMsg(String id){
		String sql = "SELECT rid,mowner,rtime,rcontent FROM replymessage where mid = '" +id+"' order by rid";
		Statement state;
		ArrayList<Message> msgList = new ArrayList<Message>();
		try {
	   		state=conn.prepareStatement(sql);
			ResultSet rs = state.executeQuery(sql);
			
			while(rs.next()){
	   			
				String mowner =rs.getString("mowner"); 
				String rid =rs.getString("rid"); 
				String rtime = rs.getString("rtime");
				String rcontent = getFiltString(rs.getString("rcontent"));
	   			
	   			Message msg = new Message();
	   			msg.setContent(rcontent);
	   			msg.setId(rid);
	   			msg.setMowner(mowner);
	   			msg.setMtime(rtime);
	   			
	   			msgList.add(msg);	
			}
			
	   	} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return msgList;
	}
	//获得信息的总数
	public int getMessageNum(){
		
		int maxSize=1;
		String sql = "select count(*) from message";
    	PreparedStatement state;
		try {
			state = conn.prepareStatement(sql);
			ResultSet result  = state.executeQuery(sql);
			
			if(result.next()){
				maxSize=result.getInt("count(*)");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return maxSize;
	}
	
	//处理用户信息
	private String getFiltString(String content){
		if(content!=null)
		return content.replaceAll("<", "&lt")
						.replaceAll(">", "&gt")
						.replace("\n", "<br/>");
		return "";
	}
	
	public ArrayList<Message> getMessage(int pageNum,int pageSize){
		String  sql = "SELECT id,mowner,mtime,content FROM message order by id desc limit "+
			 		(pageNum-1)*pageSize+","+pageSize;
		
		Statement state;
		ArrayList<Message> msgList = new ArrayList<Message>();
		try {
			state = conn.prepareStatement(sql);
			ResultSet result = state.executeQuery(sql);
			
			while(result.next()){
	   			
	   			String id = result.getString("id");
	   			String mtime = result.getString("mtime");
	   			String content = getFiltString(result.getString("content"));
	   			String mowner = result.getString("mowner");
	   			
	   			Message msg = new Message();
	   			msg.setContent(content);
	   			msg.setId(id);
	   			msg.setMowner(mowner);
	   			msg.setMtime(mtime);
	   			
	   			msgList.add(msg);	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return msgList;
		
	}
	
	//检查用户名和密码是否正确
 	public boolean checkUser(User user){
 		
 		Statement state=null;
		try {
			state = conn.createStatement();
			String sql = "select uname from use_info where uname='"+user.getUname()+"' and pwd=MD5( '"+user.getUname()+user.getPwd()+"') pwd";
			ResultSet result = state.executeQuery(sql);
			if(result.next()){
				updateLastLoginInfo(user);
				return true;
			}else{
				return false;
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(state!=null)
					state.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
 		
 		return true;
 	}
 	
 	public ArrayList<User> getUse(){
 		String sql = "select * from use_info";
 		ArrayList<User> useList = new ArrayList<User>();
 		try {
			Statement state = conn.createStatement();
			ResultSet result = state.executeQuery(sql);
			while(result.next()){
				
				User use = new User();
				String uname = result.getString("uname");
				use.setUname(uname);
				useList.add(use);
			}
			
 		} catch (SQLException e) {
			e.printStackTrace();
		}
 		return useList;
 	}

 	public boolean checkUser(String name,String pwd){
 		Statement state;
 		String sql = "select pwd from use_info where uname='"+name+"'";
		try {
			state = conn.prepareStatement(sql);
			ResultSet result  = state.executeQuery(sql);
			
			if(result.next()) return true;
			else return false;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
 		
 		return true;
 	}
}
