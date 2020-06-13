package ru.kpfu.itis.kevlinsky.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import ru.kpfu.itis.kevlinsky.dto.SignUpDto;
import ru.kpfu.itis.kevlinsky.services.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
public class UserController {
    @Autowired
    private UserService service;

    @GetMapping("/signIn")
    public String getSignIn(Authentication authentication, ModelMap map){
        if (authentication == null) {
            map.put("title", "Вход");
            return "signIn";
        } else {
            return "redirect:" + MvcUriComponentsBuilder.fromMappingName("PC#getProfile").build();
        }
    }

    @GetMapping("/signUp")
    public String getSignUp(Authentication authentication, ModelMap map){
        if (authentication == null){
            map.put("title", "Регистрация");
            map.put("user", new SignUpDto());
            return "signUp";
        } else {
            return "redirect:" + MvcUriComponentsBuilder.fromMappingName("PC#getProfile").build();
        }
    }

    @PostMapping("/signUp")
    public String postSignUp(
            @Valid @ModelAttribute("user") SignUpDto signUpDto,
            BindingResult result,
            ModelMap map,
            HttpServletRequest request
    ){
        if(result.hasErrors()){
            map.put("title", "Регистрация");
            return "signUp";
        } else if (!signUpDto.getPassword().equals(signUpDto.getPasswordRepeat())){
            map.put("passwordError", "Пароли не совпадают");
            map.put("title", "Регистрация");
            return "signUp";
        } else if (service.findByEmail(signUpDto.getEmail()) != null) {
            map.put("userFoundError", "Пользователь с такой почтой уже зарегистрирован");
            map.put("title", "Регистрация");
            return "signUp";
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("fromRegistration", signUpDto.getEmail());
            service.save(signUpDto);
            return "redirect:" + MvcUriComponentsBuilder.fromMappingName("HC#getHobbies").build();
        }
    }
}
