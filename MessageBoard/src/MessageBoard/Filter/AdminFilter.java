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
/**
 * 非管理员过滤器
 * @author xuhua
 *
 */
public class AdminFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest request2 = (HttpServletRequest)request;
		HttpServletResponse response2 = (HttpServletResponse)response;
		request2.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		HttpSession session = request2.getSession();
		boolean isAdmin = (Boolean)session.getAttribute("isAdmin");
		if(!isAdmin){
			chain.doFilter(request2,response2);
			response2.setCharacterEncoding("utf-8");
		}else{
			response.getWriter().write("您不是管理员，不允许访问该页面");
		}
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
