package MessageBoard.Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MessageBoard.Dao.DbDao;
import MessageBoard.Object.Order;
import MessageBoard.Object.ProductCar;

/**
 * 添加订单
 * @author xuhua
 *
 */
public class Purchase extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DbDao db;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ProductCar productCar = (ProductCar)request.getAttribute("boughtProduct");
		float price = (Float) request.getAttribute("price");
		Order order = new Order();
		order.setProductCar(productCar);
		order.setPrice(price);
		db = DbDao.getDbOperator();
		boolean isAddOrder = db.addOrder(order);
		if(isAddOrder){
			System.out.println("successful");
		}else{
			System.out.println("add fail");
		}
	}
}
