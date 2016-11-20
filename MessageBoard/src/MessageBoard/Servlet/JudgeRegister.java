package MessageBoard.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MessageBoard.Dao.DbDao;
import MessageBoard.Object.Customer;

public class JudgeRegister extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DbDao db=null ;
	
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		db=DbDao.getDbOperator();
		String cid = request.getParameter("cid");

		boolean isExitUser =  db.isExitUser(cid);
		if(!isExitUser){
			Customer cus = getCus(request,cid);
			boolean isSuccessfulAddUser = db.addCustomer(cus);
			
			if(isSuccessfulAddUser){
				response.getWriter().print("<center>注册成功,正在跳转至登录页面.....</center><br/>");
				response.setHeader("Refresh","1;/MessageBoard/logjin.jsp" );
			}
		}else{
			response.getWriter().print("昵称已被使用，请换其他的昵称<br>");
			response.setHeader("Refresh", "1;/MessageBoard/regieter.html");
		}
				
	}
	
	private Customer getCus(HttpServletRequest request,String cid){
		
    	String cpwd = request.getParameter("cpwd");
		String cname = request.getParameter("cname");
		String city  = request.getParameter("city");
		
		Customer cus = new Customer(cid, cname, city, cpwd);
		
		return cus;
	}

}
