package com.example.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig2 implements WebMvcConfigurer {
   @Override
   public void addResourceHandlers(ResourceHandlerRegistry registry) {
      registry.addResourceHandler("/upload2/**")
//      .addResourceLocations("C:/farmers/upload2/");
      //file://가 외부 경로 파일 불러오는 코드
      // /upload2/** 쓰면 알아서 주소로 바꿔준다.
      
      .addResourceLocations("file:///C:/farmers/upload2/");

   }
}