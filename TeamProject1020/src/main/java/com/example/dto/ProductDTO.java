package com.example.dto;

import org.apache.ibatis.type.Alias;

//@Alias("ProductDTO")
@Alias("Product")
public class ProductDTO {
	   String product_code;
	   String product_name;
	   String product_img;
	   String product_context;
	   int product_price;
	   int product_stock;
	   String category_code;
	   String product_company;
	   int product_delip;
	   String product_status;
	   
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
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
		return "ProductDTO [product_code=" + product_code + ", product_name=" + product_name + ", product_context="
				+ product_context + ", product_price=" + product_price + ", getProduct_code()=" + getProduct_code()
				+ ", getProduct_name()=" + getProduct_name() + ", getProduct_img()=" + getProduct_img()
				+ ", getProduct_context()=" + getProduct_context() + ", getProduct_price()=" + getProduct_price()
				+ ", getProduct_stock()=" + getProduct_stock() + ", getCategory_code()=" + getCategory_code()
				+ ", getProduct_company()=" + getProduct_company() + ", getProduct_delip()=" + getProduct_delip()
				+ ", getProduct_status()=" + getProduct_status() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString() + "]";
	}
	   
	   
}
