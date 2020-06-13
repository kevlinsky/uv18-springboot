package ru.kpfu.itis.kevlinsky.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import ru.kpfu.itis.kevlinsky.services.MainService;

@Controller
public class MainController {
    @Autowired
    private MainService service;

    @GetMapping("/main")
    public String getMainPage(ModelMap map){
        map.put("title", "Главная");
        map.put("posts", service.getPosts());
        return "main";
    }

    @GetMapping("/")
    public String getRoot(){
        return "redirect:" + MvcUriComponentsBuilder.fromMappingName("MC#getMainPage").build();
    }
}
