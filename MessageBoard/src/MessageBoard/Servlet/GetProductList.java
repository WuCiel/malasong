package MessageBoard.Servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MessageBoard.Dao.DbDao;
import MessageBoard.Object.Product;
/**
 * 获取产品信息列表
 * @author xuhua
 *
 */
public class GetProductList extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DbDao db=null;
	private int pageSize=6;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		db=DbDao.getDbOperator();
		int pageNum=0;
		String page = request.getParameter("pageInfo");
		if(page==null){
			pageNum=1;
		}else{
			pageNum= Integer.parseInt(page);
		}
		
		int maxNum = db.getProductNum();
		
		if(pageNum>maxNum){
			pageNum=maxNum;
		}
		
		ArrayList<Product> productList = db.getProduct(pageNum, pageSize);
		request.setAttribute("productList", productList);
	
		getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
	}

}
