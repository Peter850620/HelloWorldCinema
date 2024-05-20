package com;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.service","templates","com.controller","com.util","com.dao"})
public class HelloWorldCinemaApplication {

	public static void main(String[] args) {
		SpringApplication.run(HelloWorldCinemaApplication.class, args);
	}

}
