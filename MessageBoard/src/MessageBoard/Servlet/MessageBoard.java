package MessageBoard.Servlet;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MessageBoard.Dao.DbDao;
import MessageBoard.Dao.DbOperator;
import MessageBoard.Object.Message;

public class MessageBoard extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private DbOperator dbOperator;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dbOperator = DbOperator.getDbOperator();
		
		String name="",pwd="";
		response.setContentType("text/html");
		request.setCharacterEncoding("utf-8");
		getCookie(request,name,pwd);
		boolean isCookieCorrect = dbOperator.checkUser(name,pwd);
		
		if(!isCookieCorrect){
			name = (String)request.getSession().getAttribute("name");			
		}
		
		int pageSize = 5;
		
		int pageId = getPageId(request,pageSize);
		
		ArrayList<Message> msgList = dbOperator.getMessage(pageId, pageSize);
		HashMap<String ,ArrayList<Message>> replyMsg = getReplyMessage(msgList);
		
		request.setAttribute("pageId", pageId);
		
		getServletContext().setAttribute("msgList", msgList);
		getServletContext().setAttribute("replyMsg",replyMsg);
		
		getServletContext().getRequestDispatcher("/jsp/MessageBoardView.jsp").forward(request, response);

	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
	
	//获取当期页面的id
	private int getPageId(HttpServletRequest request,int pageSize){
		
		int messageNum = dbOperator.getMessageNum();
		int tolPageNum = messageNum/pageSize + (messageNum%pageSize==0?0:1);

		String currentPage = request.getParameter("page");
    	if(currentPage==null){
    		currentPage="1";
    	}
    	int pageId = Integer.parseInt(currentPage);
    	if(pageId<=0) pageId=1;
    	if(pageId>tolPageNum) pageId=tolPageNum;
    	
    	return pageId;
	}

	//获取回复的留言信息
	public HashMap<String ,ArrayList<Message>> getReplyMessage(ArrayList<Message> msgList){
		HashMap<String ,ArrayList<Message>> replyMsg = new HashMap<String,ArrayList<Message>>();
		
		if(msgList!=null)
			for(Message m:msgList){
				if(m!=null){
					ArrayList<Message> reply = dbOperator.getReplyMsg(m.getId());
					replyMsg.put(m.getId(), reply);
				}
			}
		return replyMsg;
	}
	
	@Override
	public void init() throws ServletException {
		super.init();
		String dbDriver = getServletContext().getInitParameter("dbDriver");
		String dbHost = getServletContext().getInitParameter("dbHost");
		String dbUser = getServletContext().getInitParameter("dbUser");
		String dbPwd = getServletContext().getInitParameter("dbPwd");
		String dbT = getServletContext().getInitParameter("dbT");
		
		System.out.println(dbDriver+" "+dbHost+"  "+dbUser+" "+dbPwd+"  "+dbT);
		
		//DbOperator.setDbParameter(dbDriver, dbHost, dbUser, dbPwd);
		DbDao.setDbParameter(dbDriver, dbT, dbHost, dbUser, dbPwd);
	}
	
	//获取cookies值
	private void getCookie(HttpServletRequest request,String name,String pwd){
    	Cookie[] cookies = request.getCookies();
		if(cookies!=null){
			for(Cookie c:cookies){
				if("name".equals(c.getName())){
				try{
					name = URLDecoder.decode(c.getValue(), "UTF-8"); 
					}catch(Exception e){}
				}
				if("pwd".equals(c.getName()))
					pwd= c.getValue();
			}
		}
	}

}
