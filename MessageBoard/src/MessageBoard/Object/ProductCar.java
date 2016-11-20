package MessageBoard.Object;

import java.util.ArrayList;

public class ProductCar {
	
	private ArrayList<Product> productList = new ArrayList<Product>();
	private Customer customer;
	
	public void addProduct(Product p){
		productList.add(p);
	}
	public void removeProduct(Product p){
		productList.remove(p);
	}
	
	public ArrayList<Product> getProductList(){
		return productList;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
}
