package com.example.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.CartDTO;
import com.example.dto.PageDTO;
import com.example.dto.ProductDTO;

@Repository
public class ProductDAO {
	@Autowired
	SqlSessionTemplate template;
	
	public List<HashMap<String, Object>> getProductList(HashMap<Object, Object> filter) {
		// 필터값 매퍼로 넘겨준다.
		System.out.println("여기 다오 "+filter);
		String pData = (String)filter.get("filter");
		List<HashMap<String, Object>> list = template.selectList("productList", pData);
		return list;
	}
	
	public List<ProductDTO> keywordSearch(String keyword) {
		return template.selectList("ProductMapper.selectKeywordSearch", keyword);
	}

	public ProductDTO goodsRetrieve(String product_code) {
		ProductDTO dto= template.selectOne("ProductMapper.goodsRetrieve", product_code);
		return dto;
	}
	public void cartAdd(CartDTO cart) {
		template.insert("CartMapper.cartAdd", cart);		
	}

	public PageDTO selectPage(int curPage, String searchWord) {
		PageDTO pDTO = new PageDTO();
		int perPage = pDTO.getPerPage();
		int offset = (curPage - 1) * perPage;
		
		List<ProductDTO> list =  template.selectList("ProductMapper.selectAll",searchWord, new RowBounds(offset, perPage));
		
		pDTO.setCurPage(curPage);
		pDTO.setList(list);
		pDTO.setTotalCount(template.selectOne("ProductMapper.totalCount",searchWord));
		
		return pDTO;
	}

	public List<ProductDTO> goodsList(String category_code) {
		List<ProductDTO> list= template.selectList("ProductMapper.goodsList", category_code);
		return list;
	}
	public ProductDTO productDetails(String product_code) {
		ProductDTO dto=template.selectOne("ProductMapper.productDetails",product_code);
		return dto;
	}
	
}
