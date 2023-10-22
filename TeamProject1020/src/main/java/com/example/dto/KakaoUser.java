package com.example.dto;

public class KakaoUser{
	    Long id;
	    String email;
	    String nickname;
		
	    public KakaoUser() {
			super();
		}
		
	    //닉네임 제외하고 받을 수도 있게끔 설정함
	    public KakaoUser(Long id, String email) {
			super();
			this.id = id;
			this.email = email;
		}


		public KakaoUser(Long id, String email, String nickname) {
			super();
			this.id = id;
			this.email = email;
			this.nickname = nickname;
		}
		
		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getNickname() {
			return nickname;
		}

		public void setNickname(String nickname) {
			this.nickname = nickname;
		}

		@Override
		public String toString() {
			return "KakaoUser [id=" + id + ", email=" + email + ", nickname=" + nickname + "]";
		}
	    
		
	    
}
