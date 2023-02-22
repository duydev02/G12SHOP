package com.g12shop.security;

import com.g12shop.config.EncoderConfig;
import com.g12shop.entity.Users;
import com.g12shop.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.NoSuchElementException;

@SuppressWarnings("deprecation")
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UsersService usersService;

    // Cung cấp nguồn dữ liệu đăng nhập
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(username -> {
            try {
                Users user = usersService.findByUsername(username);
                String password = user.getHashPassword();
                String role = user.getRole().getName();
                return User.withUsername(username).password(password).roles(role).build();
            } catch (NoSuchElementException e) {
                throw new UsernameNotFoundException(username + " not found!");
            }
        });
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable().cors().disable();

        http.authorizeRequests()
                .antMatchers("/cart/**").authenticated()
                .antMatchers("/admin/**").hasAnyRole("admin")
                .anyRequest().permitAll();

        http.formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .defaultSuccessUrl("/security/login/success", true)
                .failureUrl("/security/login/error")
                .passwordParameter("hashPassword");

        http.rememberMe()
                .rememberMeParameter("remember-me")
                .tokenValiditySeconds(86400);

        http.logout()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/index")
                .deleteCookies("JSESSIONID")
                .invalidateHttpSession(true);
    }

    // Phân quyền sử dụng
//    @Bean
//    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
//        http.csrf().disable();
//        http.authorizeRequests()
//                .antMatchers("/cart/**").authenticated()
//                .antMatchers("/admin/**").hasAnyRole("admin")
//                .anyRequest().permitAll();
//
//        http.formLogin()
//                .loginPage("/login")
//                .loginProcessingUrl("/login")
//                .defaultSuccessUrl("/security/login/success", false)
//                .failureUrl("/security/login/error")
//                .passwordParameter("hashPassword");
//
//        http.rememberMe()
//                .rememberMeParameter("remember-me")
//                .tokenValiditySeconds(86400);
//
//        http.exceptionHandling()
//                .accessDeniedPage("/security/unauthoried");
//
//        http.logout(logout -> logout
//                .logoutUrl("/logout")
//                .logoutSuccessUrl("/index")
//                .deleteCookies("JSESSIONID")
//                .invalidateHttpSession(true));
//        return http.build();
//    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        super.configure(web);
    }
}

