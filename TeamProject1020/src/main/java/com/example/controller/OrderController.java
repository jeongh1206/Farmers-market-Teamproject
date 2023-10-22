package com.example.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.CartProductDTO;
import com.example.dto.OrderDTO;
import com.example.dto.OrderDetailDTO;
import com.example.dto.ProductDTO;
import com.example.dto.ProductOrderDTO;
import com.example.dto.UserDTO;
import com.example.service.CartService;
import com.example.service.OrderService;
import com.example.service.ProductService;
import com.example.service.UserService;

@Controller
public class OrderController {
	@Autowired
	OrderService service;
	@Autowired
	UserService uService;
	@Autowired
	CartService cService;
	
	@PostMapping("/order")
	public String order(
			@RequestParam(value = "cart_noList", required = false) ArrayList<String> cart_noList ,
			CartProductDTO cartProduct,	HttpSession session ,Model m) {
		UserDTO userDTO=(UserDTO)session.getAttribute("login");
		int user_no=userDTO.getUser_no();
		userDTO=uService.myPage(user_no);
		List<CartProductDTO> cart=null;
		//장바구니에서 주문한경우
		if(cart_noList!=null) {
			cart=service.orderConfirmByNum(cart_noList);
			m.addAttribute("cDTO", cart);
		}
		//제품 상세페이지에서 바로 주문한경우
		else {
			cart=service.orderConfirmByCode(cartProduct.getProduct_code());
			cart.get(0).setCart_count(cartProduct.getCart_count());
		}
		m.addAttribute("cDTO", cart);
		m.addAttribute("mDTO", userDTO);
		return "orderConfirm";
	}
	@GetMapping("/order")
	public String getOrder() {
		return "main";
	}
	
	@GetMapping("/check")
	public String check() {
		return "checkout";
	}
	@GetMapping("/map")
	public String kakaoMap() {
		return "kakaoMap";
	}
	
	@RequestMapping("/orderDone")
	public String orderDone(@RequestParam(value = "cart_noList") ArrayList<Integer> cart_noList,
			ProductOrderDTO productOrder, OrderDTO order, HttpSession session, Model m) {
		
		UserDTO userDTO=(UserDTO)session.getAttribute("login");
		int user_no=userDTO.getUser_no();
		int cart_no = cart_noList.get(0);
		order.setUser_no(user_no);
		//selectKey를 통해 insert와 동시에 oder_no를 order에 담음
		service.orderAdd(order);
		int order_no=order.getOrder_no();
		productOrder.setOrder_no(order_no);		
		//주문상세 insert
		//장바구니를 거쳐 주문한 경우
		if(cart_no!=0) {
			service.orderAdd_Detail(order_no);
			
		//상세페이지에서 바로 주문한 경우
		}else {
			service.orderAdd_Detail_nonCart(productOrder);
		}
		
		//결제 완료된 상품 장바구니 목록에서 삭제
		cService.cartCheckDel(cart_noList);
		
		//결제완료 페이지에서 주문번호 보여주기
		m.addAttribute("order_no", order_no);		
		return "orderDone";
	}
	
	//회원 번호 기준 주문 목록
	@RequestMapping("/orderList")
	public String orderList(HttpSession session, Model m) {
		UserDTO userDTO=(UserDTO)session.getAttribute("login");
		int user_no=userDTO.getUser_no();
		List<OrderDTO> orderList =service.orderList(user_no);
		m.addAttribute("orderList", orderList);
		return "orderList";
	}
	//주문 상세
	@RequestMapping("/orderView")
	public String orderView(@RequestParam("n") int order_no ,HttpSession session, Model m) {
		UserDTO userDTO=(UserDTO)session.getAttribute("login");
		int user_no=userDTO.getUser_no();
		OrderDTO order = new OrderDTO();
		order.setUser_no(user_no);
		order.setOrder_no(order_no);
		
		List<ProductOrderDTO> orderView = service.orderView(order);
		//System.out.println(orderView.get(0).getOrder_no());
		m.addAttribute("orderView", orderView);
		return "orderView";
	}
	//주문 삭제
	//주문테이블 삭제여부 컬럼 변경
	@RequestMapping("/orderDelete")
	public String orderDelete(@RequestParam("order_no") int order_no) {

		service.orderDelete(order_no);
		
		return "redirect:orderList";
	}
}
