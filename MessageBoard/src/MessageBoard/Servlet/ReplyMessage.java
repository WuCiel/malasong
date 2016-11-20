package MessageBoard.Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MessageBoard.Dao.DbOperator;
import MessageBoard.Object.Message;

public class ReplyMessage extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DbOperator dbOperator;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		dbOperator = DbOperator.getDbOperator();
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Message msg = getMessage(request);
		boolean isReplySuccessful = dbOperator.addReplyMesage(msg);
		
		if(isReplySuccessful){
			out.print("<center>回复发布成功</center>");
		}else{
			out.print("<center>回复发布失败</center>");
		}
		response.setHeader("Refresh", "1;./MessageBoard");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
	
	private Message getMessage(HttpServletRequest request){
		
		Message msg = new Message();
		String content = request.getParameter("rcontent");
		String id = request.getParameter("id");
		String mowner = request.getParameter("mowner");
		msg.setContent(content);
		msg.setId(id);
		msg.setMowner(mowner);
		return msg;
		
	}

}
