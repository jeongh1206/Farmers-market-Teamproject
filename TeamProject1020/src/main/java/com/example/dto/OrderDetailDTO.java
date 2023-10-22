package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("OrderDetailDTO")
public class OrderDetailDTO {
	
	private int odd_no;
	private int order_no;
	private String product_code;
	private int odd_count;
	
	
	@Override
	public String toString() {
		return "OrderDetailDTO [odd_no=" + odd_no + ", order_no=" + order_no + ", product_code=" + product_code
				+ ", odd_count=" + odd_count + "]";
	}
	public int getOdd_no() {
		return odd_no;
	}
	public void setOdd_no(int odd_no) {
		this.odd_no = odd_no;
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
	

}
