package com.example.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.dto.CartDTO;
import com.example.dto.PageDTO;
import com.example.dto.ProductDTO;
import com.example.dto.UserDTO;
import com.example.service.ProductService;

@Controller
public class ProductController {
	@Autowired
	ProductService service;
	
//	@RequestMapping("/cartAdd")
//	public String cartAdd(CartDTO cart, HttpSession session) {
//		System.out.println("cartAdd 함수 실행됨");
//		UserDTO mDTO= (UserDTO)session.getAttribute("login");
//		cart.setUser_no(mDTO.getUser_no());
//		session.setAttribute("mesg", cart.getProduct_code());
//		System.out.println(cart);
//		service.cartAdd(cart);
//		return "redirect:/goodsRetrieve?product_code="+cart.getProduct_code();
//	}
	
	@RequestMapping("/keywordSearch")
	public @ResponseBody String keywordSearch(@RequestParam String keyword) {
		if(keyword==null||keyword.equals("")) return null;		
		keyword=keyword.toUpperCase();
		List<ProductDTO> keywordList=service.keywordSearch(keyword);
		//검색 목록 4개씩 보여주기
		if(keywordList.size()>6) {
			keywordList=keywordList.subList(0, 6);
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("keyword", keywordList);
		String jsonInfo=jsonObject.toString();
		return jsonInfo;
			
	}
	//상품 검색 페이지
	
	@RequestMapping("/searchGoods")
	public ModelAndView searchGoods(@RequestParam String searchWord,HttpServletRequest request,
			@RequestParam(value = "curPage", required = false, defaultValue = "1") int curPage){
		String viewName=(String)request.getAttribute("viewName");
		PageDTO pDTO = service.selectPage(curPage,searchWord);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("searchWord", searchWord);
		mav.addObject("goodsList", pDTO.getList());
		mav.addObject("pDTO", pDTO);
		return mav;		
	}
	
//	@RequestMapping("/goodsRetrieve")//goodsRetrieve.jsp  //view에 대한 지정이 없음 url= 뷰파일.jsp
//	@ModelAttribute("goodsRetrieve") //key값  goodsRetrieve= dto
//	public ProductDTO goodsRetrieve(@RequestParam("product_code") String product_code) {//상품자세히 보기
//		ProductDTO dto= service.goodsRetrieve(product_code);
//		return dto;
//	}
	
//	@RequestMapping("/goodsList")
//	public ModelAndView goodsList(@RequestParam(value = "category_code", required=false) String category_code) {//상품목록보기
//		if(category_code== null) {
//			category_code="001";
//		}
//		List<ProductDTO> list= service.goodsList(category_code);
//		ModelAndView mav= new ModelAndView();
//		mav.addObject("goodsList", list);
//		//request.setAttribute("goodsList", list)와 동일
//		mav.setViewName("goodsList"); //goodsList.jsp
//		return mav;	
//	}
	
	@RequestMapping("/productDetails")
	public String productDetails(String product_code,HttpSession session, Model m){
		ProductDTO dto=service.productDetails(product_code);
		m.addAttribute("product",dto);
		addGoodsInQuick(product_code,dto,session);
		return "goodsRetrieve";
	}
	//빠른 메뉴(퀵메뉴)
	private void addGoodsInQuick(String product_code,ProductDTO product,HttpSession session){
		boolean already_existed=false;
		List<ProductDTO> quickGoodsList; //최근 본 상품 저장 ArrayList
		quickGoodsList=(ArrayList<ProductDTO>)session.getAttribute("quickGoodsList");
		
		if(quickGoodsList!=null){
			if(quickGoodsList.size() < 4){ //미리본 상품 리스트에 상품개수가 세개 이하인 경우
				for(int i=0; i<quickGoodsList.size();i++){
					ProductDTO productBean=(ProductDTO)quickGoodsList.get(i);
					if(product_code.equals(productBean.getProduct_code())){
						already_existed=true;
						break;
					}
				}
				if(already_existed==false){
					quickGoodsList.add(product);
				}
			}
			
		}else{
			quickGoodsList =new ArrayList<ProductDTO>();
			quickGoodsList.add(product);
			
		}
		session.setAttribute("quickGoodsList",quickGoodsList);
		session.setAttribute("quickGoodsListNum", quickGoodsList.size());
	}
	 
}
