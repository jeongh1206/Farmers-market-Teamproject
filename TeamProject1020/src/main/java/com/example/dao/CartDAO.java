package com.example.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.dto.CartProductDTO;

@Repository
public class CartDAO {
	
	@Autowired
	SqlSessionTemplate session;

	public List<CartProductDTO> cartList(int user_no) {
		List<CartProductDTO> list = session.selectList("cartList",user_no);
		return list;
	}

	public int cartAdd(CartProductDTO dto) {
		int n = session.insert("cartAdd",dto);
		return n;
	}

	public int amountUpdate(HashMap<String, Object> map) {
		int n = session.update("amountUpdate",map);
		return n;
	}

	public int cartUpdate(HashMap<String, Object> map) {
		int n = session.update("cartUpdate",map);
		return n;
	}

	public int delete(String delnum) {
		int n = session.update("delete",delnum);
		return n;
	}

	public int allDelete(ArrayList<String> list) {
		int n = session.delete("allDelete",list);
		return n;
	}

	public int cartCheckDel(ArrayList<Integer> list) {
		int n = session.delete("cartCheckDel",list);
		return n;
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public List<HashMap<String, Object>> getCartList(HashMap<Object, Object> param) {
		System.out.println("여기 다오 "+param);
		List<HashMap<String, Object>> list = session.selectList("getCartList", param);
		return list;
	}
	
}
