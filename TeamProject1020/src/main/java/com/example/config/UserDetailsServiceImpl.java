package com.example.config;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.dao.UserDAO;
import com.example.dto.UserDTO;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserDAO userRepository;

    @Autowired
    private HttpServletRequest request;
    
//    @Autowired
//   private PasswordEncoder passwordEncoder;
    
    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    public UserDetails loadUserByUsername(String user_id) throws UsernameNotFoundException {
        UserDTO user = userRepository.selectBuyerByid(user_id);
        HttpSession session = request.getSession();

        if (user == null) {
            throw new UsernameNotFoundException("User not found: " + user_id);
        }

        if (session.getAttribute("login") == null) {

            String user_pw = request.getParameter("user_pw");
            String storedHashedPassword = user.getUser_pw();

            if (passwordEncoder().matches(user_pw, storedHashedPassword)) {
                session.setAttribute("login", user);
            } else {
                session.setAttribute("warning", "아이디/비밀번호 확인해주세요");
            }
        }

        return toUserDetails(user);
    }

    private UserDetails toUserDetails(UserDTO user) {
        return User.builder()
                .username(user.getUser_id())
                .password(user.getUser_pw())
                .authorities(new SimpleGrantedAuthority(user.getroles()))
                .build();
    }
}
