package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("CartDTO")
public class CartDTO {
	
	private int cart_no;
	private int user_no;
	private String product_code;
	private int cart_count;
	
	public CartDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CartDTO(int cart_no, int user_no, String product_code, int cart_count) {
		super();
		this.cart_no = cart_no;
		this.user_no = user_no;
		this.product_code = product_code;
		this.cart_count = cart_count;
	}

	public int getCart_no() {
		return cart_no;
	}

	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int i) {
		this.user_no = i;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public int getCart_count() {
		return cart_count;
	}

	public void setCart_count(int cart_count) {
		this.cart_count = cart_count;
	}

	@Override
	public String toString() {
		return "CartDTO [cart_no=" + cart_no + ", user_no=" + user_no + ", product_code=" + product_code
				+ ", cart_count=" + cart_count + "]";
	}
	
	
	
	

}
