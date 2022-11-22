//package com.g12shop.security;
//
//import java.util.NoSuchElementException;
//
//import javax.sql.DataSource;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.http.HttpMethod;
//import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseBuilder;
//import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseType;
//import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
//import org.springframework.security.core.userdetails.User;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
//import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;
//import org.springframework.security.provisioning.JdbcUserDetailsManager;
//import org.springframework.security.provisioning.UserDetailsManager;
//import org.springframework.security.web.SecurityFilterChain;
//
//import com.g12shop.entity.Users;
//import com.g12shop.service.UsersService;
//
//@Configuration
//@EnableWebSecurity
//public class SecurityConfig {
//
//	@Autowired
//	private UsersService usersService;
//
//	@Bean
//    public DataSource dataSource() {
//        return new EmbeddedDatabaseBuilder()
//            .setType(EmbeddedDatabaseType.H2)
//            .addScript(JdbcDaoImpl.DEFAULT_USER_SCHEMA_DDL_LOCATION)
//            .build();
//    }
//	
//	@Bean
//    public UserDetailsManager users(DataSource dataSource) {
//        UserDetails user = User.withDefaultPasswordEncoder()
//            .username("user")
//            .password("password")
//            .roles("USER")
//            .build();
//        JdbcUserDetailsManager users = new JdbcUserDetailsManager(dataSource);
//        users.createUser(user);
//        return users;
//    }
//	
//	// Cung cấp nguồn dữ liệu đăng nhập
//	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//		auth.userDetailsService(username -> {
//			try {
//				Users user = usersService.findByUsername(username);
//				String password = user.getHashPassword();
//				String role = user.getRole().getName();
//				System.out.println(username + " " + password);
//				return User.withUsername(username).password("{noop}" + password).roles(role).build();
//			} catch (NoSuchElementException e) {
//				throw new UsernameNotFoundException(username + " not found!");
//			}
//		});
//	}
//
//	// Phân quyền sử dụng
//	@Bean
//    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
//		http.csrf().disable();
//		http.authorizeRequests()
//			.antMatchers("/cart/**").authenticated()
//			.antMatchers("/admin/**").hasAnyRole("admin")
//			.anyRequest().permitAll();
//		
//		http.formLogin()
//			.loginPage("/login")
//			.loginProcessingUrl("/login")
//			.defaultSuccessUrl("/security/login/success", false)
//			.failureUrl("/security/login/error")
//			.passwordParameter("hashPassword");
//	
//		http.rememberMe()
//			.tokenValiditySeconds(86400);
//		
//		http.exceptionHandling()
//			.accessDeniedPage("/security/unauthoried");
//		
//		http.logout(logout -> logout                                                
//	            .logoutUrl("/logout")                                            
//	            .logoutSuccessUrl("/index")
//	            .deleteCookies("JSESSIONID")
//	            .invalidateHttpSession(true));
//		return http.build();
//	}
//	
//	// Cho phép truy xuất REST API từ bên ngoài (domain khác)
//	@Bean
//    public WebSecurityCustomizer webSecurityCustomizer() {
//		return (web) -> web.ignoring().antMatchers(HttpMethod.OPTIONS, "/**");
//	}
//}
//
