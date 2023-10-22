package com.example.dto;

public class delCVSDTO {
	
	private String address_name;
	private String phone;
	private String place_name;
	private String road_address_name;
	
	@Override
	public String toString() {
		return "delCVSDTO [address_name=" + address_name + ", phone=" + phone + ", place_name=" + place_name
				+ ", road_address_name=" + road_address_name + "]";
	}
	public String getAddress_name() {
		return address_name;
	}
	public void setAddress_name(String address_name) {
		this.address_name = address_name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public String getRoad_address_name() {
		return road_address_name;
	}
	public void setRoad_address_name(String road_address_name) {
		this.road_address_name = road_address_name;
	}
	
}
