package com.g12shop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = { SecurityAutoConfiguration.class })
public class G12ShopApplication {

	public static void main(String[] args) {
		SpringApplication.run(G12ShopApplication.class, args);
	}

}
