package com.example.SHRMS.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final CustomUserDetailsService userDetailsService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .userDetailsService(userDetailsService)
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/css/**", "/js/**", "/images/**", "/uploads/**", "/webjars/**").permitAll()
                .requestMatchers("/login", "/login-process", "/login-error").permitAll()

                // Admin only
                .requestMatchers("/employees/add", "/employees/edit/**", "/employees/delete/**").hasRole("ADMIN")
                .requestMatchers("/holidays/add", "/holidays/delete/**").hasAnyRole("ADMIN", "HR")
                .requestMatchers("/payroll/generate").hasAnyRole("ADMIN", "HR")
                .requestMatchers("/performance/add").hasAnyRole("ADMIN", "HR", "MANAGER")

                // Manager + above
                .requestMatchers("/tasks/assign").hasAnyRole("ADMIN", "HR", "MANAGER")
                .requestMatchers("/leaves/manage").hasAnyRole("ADMIN", "HR", "MANAGER")

                // All authenticated users
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login-process")
                .usernameParameter("email")
                .passwordParameter("password")
                .defaultSuccessUrl("/dashboard", true)
                .failureUrl("/login?error=true")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                .logoutSuccessUrl("/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
            )
            .sessionManagement(session -> session
                .invalidSessionUrl("/login?session=expired")
                .maximumSessions(1)
                .expiredUrl("/login?session=expired")
            )
            .csrf(csrf -> csrf.disable()); // disable for JSP form simplicity

        return http.build();
    }
}
