package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("OrderDTO")
public class OrderDTO {
	private int order_no;
	private String order_date;
	//편의점배송인 경우 post 값 N
	private String order_post="N";
	private String order_addr1;
	private String order_addr2;
	private String order_receiver;
	private String order_phone;
	private int user_no;
	private String user_name;
	private String order_sta;
	private String order_paysta;
	private int order_disprice;
	private int order_price;
	private String order_name;
	private String order_paymethod;
	private String product_name;
	private int cart_count;
	
	public OrderDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "OrderDTO [order_no=" + order_no + ", order_date=" + order_date + ", order_post=" + order_post
				+ ", order_addr1=" + order_addr1 + ", order_addr2=" + order_addr2 + ", order_receiver=" + order_receiver
				+ ", order_phone=" + order_phone + ", user_no=" + user_no + ", user_name=" + user_name + ", order_sta="
				+ order_sta + ", order_paysta=" + order_paysta + ", order_disprice=" + order_disprice + ", order_price="
				+ order_price + ", order_name=" + order_name + ", oder_paymethod=" + order_paymethod + ", product_name="
				+ product_name + ", cart_count=" + cart_count + "]";
	}

	public int getOrder_no() {
		return order_no;
	}

	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}

	public String getOrder_date() {
		return order_date;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}

	public String getOrder_post() {
		return order_post;
	}

	public void setOrder_post(String order_post) {
		this.order_post = order_post;
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

	public String getOrder_receiver() {
		return order_receiver;
	}

	public void setOrder_receiver(String order_receiver) {
		this.order_receiver = order_receiver;
	}

	public String getOrder_phone() {
		return order_phone;
	}

	public void setOrder_phone(String order_phone) {
		this.order_phone = order_phone;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getOrder_sta() {
		return order_sta;
	}

	public void setOrder_sta(String order_sta) {
		this.order_sta = order_sta;
	}

	public String getOrder_paysta() {
		return order_paysta;
	}

	public void setOrder_paysta(String order_paysta) {
		this.order_paysta = order_paysta;
	}

	public int getOrder_disprice() {
		return order_disprice;
	}

	public void setOrder_disprice(int order_disprice) {
		this.order_disprice = order_disprice;
	}

	public int getOrder_price() {
		return order_price;
	}

	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}

	public String getOrder_name() {
		return order_name;
	}

	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getCart_count() {
		return cart_count;
	}

	public void setCart_count(int cart_count) {
		this.cart_count = cart_count;
	}

	public String getOrder_paymethod() {
		return order_paymethod;
	}

	public void setOrder_paymethod(String order_paymethod) {
		this.order_paymethod = order_paymethod;
	}

}
