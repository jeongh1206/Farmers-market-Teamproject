package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.CartProductDTO;
import com.example.dto.UserDTO;
import com.example.service.CartService;

@Controller
public class CartController {

	@Autowired
	CartService service;

	// 카트에 담음 o
	@RequestMapping("/cartAdd")
	public String cartAdd(CartProductDTO dto, HttpSession session,HashMap<String, Object> map) {
		System.out.println(dto);
		System.out.println(map);
//		1. 상품코드, 유저번호, 수량
		String PRODUCT_CODE=dto.getProduct_code(); // 상품코드 받기
		UserDTO Udto = (UserDTO) session.getAttribute("login");
		int user_no = Udto.getUser_no(); //유저번호 받기
		int cart_amount = dto.getCart_count(); // 상품 수량 받기
		//System.out.println("상품코드, 유저번호, 상품수량 >>>> "+PRODUCT_CODE+user_no+cart_amount);
		dto.setUser_no(user_no);
		//System.out.println(user_no);
		List<CartProductDTO> list = service.cartList(user_no);
		session.setAttribute("cartList", list);
		//System.out.println(dto);
		int CART_COUNT=0;
		
		if (list.size()==0) {
			int n = service.cartAdd(dto);
			session.setAttribute("addNum", n);
		} else {//장바구니 리스트 있을 때
			boolean flag=true;
			for (CartProductDTO cdto : list) { // 같은 상품 수량증가
				if (PRODUCT_CODE.equals(cdto.getProduct_code())) {
					CART_COUNT = dto.getCart_count() + cdto.getCart_count();
					flag=false;
				}
			}
			if(flag) { //참이면=상품 코드가 다르면
				int n = service.cartAdd(dto);
				session.setAttribute("addNum", n);
			}else {
				//System.out.println("초ㅣ종수량"+"CART_COUNT");
				map.put("PRODUCT_CODE", PRODUCT_CODE);
				map.put("CART_COUNT", CART_COUNT);
				//System.out.println(map);
				int n = service.amountUpdate(map);
				session.setAttribute("addNum", n);
			}
		}
		return "redirect:/productDetails?product_code=" + dto.getProduct_code();
	}
	//리스트
	@RequestMapping("/cart")
	public String cartList(HttpSession session) {
		UserDTO dto = (UserDTO) session.getAttribute("login");
		if (dto != null) {
			int user_no = dto.getUser_no();
			List<CartProductDTO> list = service.cartList(user_no);
			session.setAttribute("cartList", list);
		}
		return "cart";
	}
	
	@RequestMapping("/cartUpdate")
	public @ResponseBody String update(String CART_NO, int CART_COUNT,HashMap<String, Object> map) {
		//System.out.println(CART_NO);
		//System.out.println(CART_COUNT);
		map.put("CART_NO",CART_NO);
		map.put("CART_COUNT",CART_COUNT);
		int n=service.cartUpdate(map);
		//System.out.println(n);
		return "cart";
	}
	//선택 삭제
	@RequestMapping("/cartDel")
	public String cartDel(String delnum) {
		int n=service.delete(delnum);
		//System.out.println(n);
		return "redirect:cart";
	}
	//전체 삭제
	@RequestMapping("/cartAllDel")
	public String cartAllDel(@RequestParam("selectCheck") ArrayList<String> list) {
		int n=service.allDelete(list);
		System.out.println(n);
		return "redirect:cart";
	}
	//개별 삭제
	@RequestMapping("/cartCheckDel")
	public String cartCheckDel(@RequestParam("cartCheckNum") ArrayList<Integer> cartCheckNum) {
		int n=service.cartCheckDel(cartCheckNum);
		System.out.println(n);
		return "redirect:cart";
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping("/getCartList") 
	public @ResponseBody List<HashMap<String, Object>> getCartList(HttpSession session, @RequestParam HashMap<Object, Object> param){
		System.out.println("여기다"+param);
		List<HashMap<String, Object>>getCartList = new ArrayList<>();
		UserDTO Udto = (UserDTO) session.getAttribute("login");
		param.put("user_no", Udto.getUser_no());
		getCartList = service.getCartList(param);
		
		return getCartList;
	}

}
