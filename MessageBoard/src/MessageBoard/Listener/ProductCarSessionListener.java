package MessageBoard.Listener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import MessageBoard.Dao.DbDao;
import MessageBoard.Object.Customer;
import MessageBoard.Object.ProductCar;
/**
 * 监听session，但session销毁的时候，将购物车中内容插入到数据库中 
 * @author xuhua
 *
 */
public class ProductCarSessionListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent event) {

	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		
		HttpSession session = event.getSession();
		ProductCar productCar = (ProductCar)session.getAttribute("productCar");
		
			if(productCar!=null){
				String cname = (String)session.getAttribute("cname");
				Customer customer = new Customer();
				customer.setCid(cname);
				productCar.setCustomer(customer);
				
				DbDao db = DbDao.getDbOperator();
				boolean result = db.addToProductCar(productCar);
				System.out.println("result-->"+result);
		}else{
			System.out.println("is null");
		}
		
	}

}
