package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.chating.Room;

@Controller
public class ChatController {
	
	List<Room> roomList = new ArrayList<Room>();
	static int roomNumber = 0;
	
//	1:1채팅 
	@RequestMapping("/chat")
	public ModelAndView chat() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chat");
		return mv;
	}
	
	/**
	 * 방 페이지
	 * @return
	 */
	@RequestMapping("/room")
	public ModelAndView room() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("room");
		return mv;
	}
	
	/**
	 * 방 생성하기
	 * @param params
	 * @return
	 */
	@RequestMapping("/createRoom") 
	public @ResponseBody List<Room> createRoom(@RequestParam HashMap<Object, Object> roomdata){
//		1. room.jsp 에서 "roomName":"입력한 방제목" 으로 데이터 받아온다.
//		2. 받아온 데이터로 방생성 및 방번호 부여( 시퀀스 처럼 자동 증가 시키겠음 )
		String roomName = (String) roomdata.get("roomName");
		if(roomName != null && !roomName.trim().equals("")) { // 방 이름이 있는지 유효성 검사
			Room room = new Room();
			room.setRoomNumber(++roomNumber); // 초기값 0이니까 ++해서 방번호 부여
			System.out.println("roomNumber : "+roomNumber); 
			room.setRoomName(roomName); // set으로 방이름 설정
			roomList.add(room); // 방리스트에 추가
		} 
		return roomList;
	}
	
	/**
	 * 방 정보가져오기
	 * @param params
	 * @return
	 */
	@RequestMapping("/getRoom")
	public @ResponseBody List<Room> getRoom(@RequestParam HashMap<Object, Object> params){
		return roomList;
	}
	
	/**
	 * 채팅방
	 * @return
	 */
	@RequestMapping("/moveChating")
	public ModelAndView chating(@RequestParam HashMap<Object, Object> roomdata) {
		ModelAndView mv = new ModelAndView();
		int roomNumber = Integer.parseInt((String) roomdata.get("roomNumber"));
		
		List<Room> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
		if(new_list != null && new_list.size() > 0) {
			mv.addObject("roomName", roomdata.get("roomName"));
			mv.addObject("roomNumber", roomdata.get("roomNumber"));
			mv.setViewName("chat");
		}else {
			mv.setViewName("room");
		}
		return mv;
	}
	
}


