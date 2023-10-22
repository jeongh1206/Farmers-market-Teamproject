package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("CartProductDTO")
public class CartProductDTO {
	
	private int cart_no;
	private int user_no;
	private String product_code;
	private int cart_count;
	private String product_name;
	private String product_img;
	private String product_context;
	private int product_price;
	private int product_stock;
	private String category_code;
	private String product_company;
	private int product_delip;
	private String product_status;
	
	public CartProductDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CartProductDTO(int cart_no, int user_no, String product_code, int cart_count, String product_name,
			String product_img, String product_context, int product_price, int product_stock, String category_code,
			String product_company, int product_delip, String product_status) {
		super();
		this.cart_no = cart_no;
		this.user_no = user_no;
		this.product_code = product_code;
		this.cart_count = cart_count;
		this.product_name = product_name;
		this.product_img = product_img;
		this.product_context = product_context;
		this.product_price = product_price;
		this.product_stock = product_stock;
		this.category_code = category_code;
		this.product_company = product_company;
		this.product_delip = product_delip;
		this.product_status = product_status;
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

	public void setUser_no(int user_no) {
		this.user_no = user_no;
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

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getProduct_img() {
		return product_img;
	}

	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}

	public String getProduct_context() {
		return product_context;
	}

	public void setProduct_context(String product_context) {
		this.product_context = product_context;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public int getProduct_stock() {
		return product_stock;
	}

	public void setProduct_stock(int product_stock) {
		this.product_stock = product_stock;
	}

	public String getCategory_code() {
		return category_code;
	}

	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}

	public String getProduct_company() {
		return product_company;
	}

	public void setProduct_company(String product_company) {
		this.product_company = product_company;
	}

	public int getProduct_delip() {
		return product_delip;
	}

	public void setProduct_delip(int product_delip) {
		this.product_delip = product_delip;
	}

	public String getProduct_status() {
		return product_status;
	}

	public void setProduct_status(String product_status) {
		this.product_status = product_status;
	}

	@Override
	public String toString() {
		return "CartProductDTO [cart_no=" + cart_no + ", user_no=" + user_no + ", product_code=" + product_code
				+ ", cart_count=" + cart_count + ", product_name=" + product_name + ", product_img=" + product_img
				+ ", product_context=" + product_context + ", product_price=" + product_price + ", product_stock="
				+ product_stock + ", category_code=" + category_code + ", product_company=" + product_company
				+ ", product_delip=" + product_delip + ", product_status=" + product_status + "]";
	}
}
