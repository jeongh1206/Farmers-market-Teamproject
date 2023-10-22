package com.example.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.CartProductDTO;
import com.example.dto.OrderDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ProductOrderDTO;

@Repository
public class OrderDAO {
	@Autowired
	SqlSessionTemplate template;
	
	public List<CartProductDTO> orderConfirmByNum(ArrayList<String> cart_noList) {
		return template.selectList("OrderMapper.orderConfirmByNum",cart_noList);
	}

	public List<CartProductDTO> orderConfirmByCode(String product_code) {
		return template.selectList("OrderMapper.orderConfirmByCode", product_code);
	}

	public void orderAdd(OrderDTO dto) {
		template.insert("OrderMapper.orderAdd", dto);
		
	}

	public List<OrderDTO> orderList(int user_no) {
		return template.selectList("OrderMapper.orderList", user_no);
	}

	public void orderAdd_Detail(int order_no) {
		template.insert("OrderMapper.orderAdd_Detail", order_no);
		
	}

	public void orderAdd_Detail_nonCart(ProductOrderDTO productOrder) {
		template.insert("OrderMapper.orderAdd_Detail_nonCart", productOrder);
		
	}

	public List<ProductOrderDTO> orderView(OrderDTO order) {
		return template.selectList("OrderMapper.orderView", order);
	}

	public void orderDelete(int order_no) {
		 template.update("OrderMapper.orderDelete", order_no);
		
	}
	
	
}
