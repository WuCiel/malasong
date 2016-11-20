package MessageBoard.Filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {

	FilterConfig config;
	@Override
	public void destroy() {
		config=null;
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest hreq = (HttpServletRequest)request;
		HttpServletResponse hrep = (HttpServletResponse)response;
		hreq.setCharacterEncoding("utf-8");
		hrep.setContentType("text/html;charset=utf-8");
		HttpSession session = hreq.getSession();
		String cname = (String)session.getAttribute("cname");
		String url =  hreq.getRequestURI();
		String path = hreq.getServletPath();
		System.out.println(path);
		if(url.endsWith(".js") || url.endsWith(".css") ||url.endsWith(".png") ||url.endsWith(".jpg")){
			
		}else if("/login.jsp".equals(path) || "/JudgeLogin".equals(path) ||"/JudgeRegister".equals(path) || "/regieter.html".equals(path)){
			
		}else if(path.startsWith("/admin")){
			if(session.getAttribute("isAdmin")==null){
				response.getWriter().write("您不是管理员，不允许访问该页面");
				hrep.setHeader("Refresh", "1;/MessageBoard/login.jsp");
				return ;
			}
			boolean isAdmin = (Boolean)session.getAttribute("isAdmin");
			
			if(isAdmin ){
				
			}else{
				response.getWriter().write("您不是管理员，不允许访问该页面");
				return ;
			}
			
		}else if(cname==null){
			response.getWriter().print("您没有登录，请先登录<br>");
			hrep.setHeader("Refresh", "1;/MessageBoard/login.jsp");
			return;
		}
		if(hrep!=null && hreq!=null){
			chain.doFilter(hreq, hrep);
			hrep.setCharacterEncoding("utf-8");
		}
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		this.config=config;
	}

}
