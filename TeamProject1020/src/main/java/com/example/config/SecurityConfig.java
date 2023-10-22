package com.example.config;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;

@Configuration
@EnableWebSecurity
public class SecurityConfig { 
	
	@Bean
	public AccessDeniedHandler accessDeniedHandler() {
	    CustomAccessDeniedHandler accessDeniedHandler = new CustomAccessDeniedHandler();
	    accessDeniedHandler.setErrorPage("/denied");
	    return accessDeniedHandler;
	}
	
	/* 로그인 실패 핸들러 의존성 주입 */
	@Autowired
	private AuthenticationFailureHandler customFailureHandler;
	  
	  protected void configure(HttpSecurity http) throws Exception {
	        http.csrf().disable();
	   }
	  
	  @Bean
	    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		  http  .csrf().disable()
                .authorizeRequests()
                    //여기에 로그인 없이 접근 가능하게할 주소를 쓴다.
                	.antMatchers("/","/main","/productList","/loginUI","/logout","/login123","/childEmail_verification","/mailConfirm","/addBuyerUI","/addBuyer","/main","/resources/**","/resources/css/**","/resources/js/**","/resources/images/**","/resources/img/**","/resources/mapper/**").permitAll()
                	.antMatchers("/cart", "/cartAdd", "/cartUpdate","/cartDel","/cartAllDel","/cartCheckDel",
                    		"/order","/map","/orderDone","/orderList","/orderConfirm","/orderView","/orderDelete","/delCVS",
                    		"/myPage","/logout","/logoutDone").access("hasRole('USER') or hasRole('ADMIN')")
                    .and()
                    .formLogin(login -> login
                    .loginPage("/login/UI")
                    //실제 로그인이 처리되는 위치. 
                    .loginProcessingUrl("/login")
                    .usernameParameter("user_id")
                    .passwordParameter("user_pw")                    
                    .defaultSuccessUrl("/main",true)
                    .failureHandler(customFailureHandler)/* 로그인 실패 핸들러 */
                    .permitAll()
                    .and())
                    .exceptionHandling()
                    .accessDeniedHandler(accessDeniedHandler())
                    .and()
                    .logout()
                    .logoutSuccessHandler((request, response, authentication) -> {
                        response.sendRedirect("/app/main");
                    });
		  
	        return http.build();
    }
	  
	    
		public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
				throws IOException, ServletException {
			
			chain.doFilter(request, response);
	    }
		
		@Bean public HttpFirewall defaultHttpFirewall() {
	        
			return new DefaultHttpFirewall();
	    }
}

