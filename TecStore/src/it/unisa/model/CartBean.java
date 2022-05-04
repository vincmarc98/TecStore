package it.unisa.model;

import java.util.ArrayList;
import java.util.List;

public class CartBean {

	private List<MerceBean> products;
	
	public CartBean(){
		products = new ArrayList<MerceBean>();
	}
	
	public void addMerceBean(MerceBean product) {
		products.add(product);
	}
	
	public void deleteMerceBean(MerceBean product) {
		for(MerceBean prod : products) {
			if(prod.getCodiceMerce()==(product.getCodiceMerce())) {
				products.remove(prod);
				break;
			}
		}
 	}
	

	public List<MerceBean> getCart() {
		return products;
	}
	
}
