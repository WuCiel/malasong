package MessageBoard.Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import MessageBoard.Dao.DbDao;
import MessageBoard.Object.Customer;
import MessageBoard.Object.ProductCar;

public class logout extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		Cookie[] cookies = request.getCookies();
    	if(cookies!=null){
			response.setContentType("text/html");
	    	for(Cookie c:cookies){
				if("cname".equals(c.getName()) || "cpwd".equals(c.getName())){
					Cookie cc = new Cookie(c.getName(),null);
					cc.setMaxAge(0);
					cc.setPath("/");
					response.addCookie(cc);
				}
	    	}
		}
	    else out.print("没有 cookies");
    	HttpSession session = request.getSession();
    	if(session!=null){
    		ProductCar productCar = (ProductCar)session.getAttribute("productCar");
    		
    			if(productCar!=null){
    				String cname = (String)session.getAttribute("cname");
    				Customer customer = new Customer();
    				customer.setCid(cname);
    				//productCar.setCustomer(customer);
    				
    				//DbDao db = DbDao.getDbOperator();
    				//boolean result = db.addToProductCar(productCar);
    			}
    			session.removeAttribute("cname");
    	}
    	out.print("成功退出成功");
    	response.setHeader("Refresh", "1;/MessageBoard/GetProductList");
    	
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
