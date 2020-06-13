package ru.kpfu.itis.kevlinsky;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import ru.kpfu.itis.kevlinsky.models.Hobby;
import ru.kpfu.itis.kevlinsky.repositories.HobbyRepository;

import java.util.List;

@SpringBootApplication
public class KevlinskyApplication {

    @Bean
    public PasswordEncoder encoder(){
        return new BCryptPasswordEncoder();
    }

    public static void main(String[] args) {
        SpringApplication.run(KevlinskyApplication.class, args);
    }
}
