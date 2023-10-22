package com.example.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dao.ProductDAO;
import com.example.dto.CartDTO;
import com.example.dto.PageDTO;
import com.example.dto.ProductDTO;

@Service
public class ProductService {
	
	@Autowired
	ProductDAO dao;
	
	@Autowired
	SqlSessionTemplate session;
	
	public List<HashMap<String, Object>> getProductList(@RequestParam HashMap<Object, Object> filter) {
		// 필터값 다오로 넘겨준다.
		System.out.println("여기 서비스 "+filter);
		List<HashMap<String, Object>> list = dao.getProductList(filter);
//		List<Object> list = new ArrayList<Object>();
//		String pData = (String)filter.get("filter");
//		list = session.selectList("productList", pData);
		return list;
	}
	
	public List<ProductDTO> keywordSearch(String keyword) {
		
		return dao.keywordSearch(keyword);
	}
	
	public ProductDTO goodsRetrieve(String product_code) {
		ProductDTO dto= dao.goodsRetrieve(product_code);
		return dto;
	}
	
	public void cartAdd(CartDTO cart) {
		dao.cartAdd(cart);	
	}

	public PageDTO selectPage(int curPage, String searchWord) {
		
		return dao.selectPage(curPage, searchWord);
	}

	public List<ProductDTO> goodsList(String category_code) {
		return dao.goodsList(category_code);
	}
	
	public ProductDTO productDetails(String product_code) {
		ProductDTO dto=dao.productDetails(product_code);
		return dto;
	}
}
