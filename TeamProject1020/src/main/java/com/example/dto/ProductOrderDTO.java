package com.example.dto;

import org.apache.ibatis.type.Alias;

//상세페이지에서 바로 주문시
//주문 상세 insert를 위한 DTO
//주문조회 상세보기 클릭시 상품 개별정보, 주문정보를 보여주기위한 DTO
@Alias("ProductOrderDTO")
public class ProductOrderDTO {
	
	private int order_no;
	private String product_code;
	private int odd_count;
	
	private int user_no;
	private String order_receiver;
	private String order_addr1;
	private String order_addr2;
	private int order_price;
	
	private String product_name;
	private String product_img;
	private String product_context;
	private int product_price;
	
	@Override
	public String toString() {
		return "ProductOrderDTO [order_no=" + order_no + ", product_code=" + product_code + ", odd_count=" + odd_count
				+ ", user_no=" + user_no + ", order_receiver=" + order_receiver + ", order_addr1=" + order_addr1
				+ ", order_addr2=" + order_addr2 + ", order_price=" + order_price + ", product_name=" + product_name
				+ ", product_img=" + product_img + ", product_context=" + product_context + ", product_price="
				+ product_price + "]";
	}
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public int getOdd_count() {
		return odd_count;
	}
	public void setOdd_count(int odd_count) {
		this.odd_count = odd_count;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getOrder_receiver() {
		return order_receiver;
	}
	public void setOrder_receiver(String order_receiver) {
		this.order_receiver = order_receiver;
	}
	public String getOrder_addr1() {
		return order_addr1;
	}
	public void setOrder_addr1(String order_addr1) {
		this.order_addr1 = order_addr1;
	}
	public String getOrder_addr2() {
		return order_addr2;
	}
	public void setOrder_addr2(String order_addr2) {
		this.order_addr2 = order_addr2;
	}
	public int getOrder_price() {
		return order_price;
	}
	public void setOrder_price(int order_price) {
		this.order_price = order_price;
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
	
}
