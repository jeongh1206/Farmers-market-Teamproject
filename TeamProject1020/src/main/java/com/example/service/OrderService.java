package com.example.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.OrderDAO;
import com.example.dto.CartProductDTO;
import com.example.dto.OrderDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ProductOrderDTO;

@Service
public class OrderService {
	@Autowired
	OrderDAO dao; 

	public List<CartProductDTO> orderConfirmByNum(ArrayList<String> cart_noList) {
		// TODO Auto-generated method stub
		return dao.orderConfirmByNum(cart_noList);
	}

	public List<CartProductDTO> orderConfirmByCode(String product_code) {
		// TODO Auto-generated method stub
		return dao.orderConfirmByCode(product_code);
	}

	public void orderAdd(OrderDTO dto) {
		// TODO Auto-generated method stub
		dao.orderAdd(dto);
		
	}

	public List<OrderDTO> orderList(int user_no) {
		return dao.orderList(user_no);
	}

	public void orderAdd_Detail(int order_no) {
		dao.orderAdd_Detail(order_no);
		
	}

	public void orderAdd_Detail_nonCart(ProductOrderDTO productOrder) {
		dao.orderAdd_Detail_nonCart(productOrder);
		
	}

	public List<ProductOrderDTO> orderView(OrderDTO order) {
		return dao.orderView(order);
	}

	public void orderDelete(int order_no) {
		dao.orderDelete(order_no);
		
	}
}
