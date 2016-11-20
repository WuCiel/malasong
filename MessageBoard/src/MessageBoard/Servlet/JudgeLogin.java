package MessageBoard.Servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.jms.Session;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import MessageBoard.Dao.DbDao;
import MessageBoard.Object.Customer;

public class JudgeLogin extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DbDao db=null ;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		db = DbDao.getDbOperator();
		Customer cus = getCustomer(request);
		boolean isCheck = db.judgeCustomer(cus);
		if(isCheck){
			String isAutoLogin = request.getParameter("auto");
			if("on".equals(isAutoLogin)){
				setCookie(cus, response);
			}
			setSession(cus,request);
			boolean isAdmin = db.isAdmin(cus);
			if(!isAdmin){
				response.getWriter().print("<center>正在跳转shop....<br/></center>");
				response.setHeader("Refresh", "1;/MessageBoard/GetProductList");
			}else{
				
				response.getWriter().print("<center>欢迎您，管理员 "+cus.getCname()+"....<br/></center>");
				response.setHeader("Refresh", "1;/MessageBoard/admin/");
			}
		}else{
			response.getWriter().print("账号或者密码错误，请重新登录<br>");
			response.setHeader("Refresh", "1;/MessageBoard/login.jsp");
		}
	}
	
	//设置session
	private void setSession(Customer cus,HttpServletRequest request){
		HttpSession session = request.getSession();
		session.setAttribute("cname",cus.getCid());
		//session.setAttribute("productCar", db.getProductCar(cus.getCid()));
	}
	
	//设置cookie
	private void setCookie(Customer cus,HttpServletResponse response){
		Cookie cname;
		try {
			cname = new Cookie("name",URLEncoder.encode(cus.getCname(), "UTF-8"));
			Cookie cpwd = new Cookie("pwd",cus.getCpwd());
			cname.setMaxAge(99999999);
			cpwd.setMaxAge(99999999);
			response.addCookie(cname);
			response.addCookie(cpwd);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	// 获取用户
	private Customer getCustomer(HttpServletRequest request){
		
		String cname = request.getParameter("cname");
		String cpwd = request.getParameter("cpwd");
		Customer customer = new Customer();
		
		System.out.println("customer-->"+cname+" "+cpwd);
		customer.setCid(cname);
		customer.setCpwd(cpwd);
		return customer;
	}

}
