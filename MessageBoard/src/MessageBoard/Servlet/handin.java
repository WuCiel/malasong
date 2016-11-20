package MessageBoard.Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MessageBoard.Dao.DbOperator;
import MessageBoard.Object.Message;

public class handin extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DbOperator dbOperator;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		dbOperator = DbOperator.getDbOperator();
		
  		request.setCharacterEncoding("utf-8");
  		String useName = (String)request.getSession().getAttribute("name");
  		
		if(useName!=null){

			Message msg = getMessage(request);
			boolean addSuccessful = dbOperator.addMsg(msg);
			
			if(addSuccessful){
				out.print("<center>留言发布成功</center>");
			}else{
				out.print("<center>留言发布失败</center>");
			}
			
			response.setHeader("Refresh", "1;./MessageBoard");
		}else{
			out.print("您没有登录，请登录后回复留言");
			response.setHeader("Refresh", "1;./MessageBoard");
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
	
	private Message getMessage(HttpServletRequest request){
		
		String  text = request.getParameter("text");
  		String mowner=(String)request.getSession().getAttribute("name");
  		Message msg  = new Message();
  		msg.setContent(text);
  		msg.setMowner(mowner);
  		return msg;
	}
}
