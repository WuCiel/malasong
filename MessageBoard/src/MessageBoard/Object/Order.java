package MessageBoard.Object;
/**
 * 订单信息
 * @author xuhua
 *
 */
public class Order {
	
	private ProductCar productCar;
	private float price;
	
	
	public ProductCar getProductCar() {
		return productCar;
	}
	public void setProductCar(ProductCar productCar) {
		this.productCar = productCar;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	
}
