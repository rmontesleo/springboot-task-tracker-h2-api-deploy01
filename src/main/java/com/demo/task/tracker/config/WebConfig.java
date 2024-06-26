package com.demo.task.tracker.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig {

	@Value("${allowOrigins}") private String allowOrigins;


    @Bean
	public WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings( @NonNull CorsRegistry registry) {				
				registry.addMapping("/**")
						.allowedOrigins( allowOrigins.split(",") )
						.allowedMethods( "GET", "POST", "PUT", "DELETE" );
			}
		};
	}
}
