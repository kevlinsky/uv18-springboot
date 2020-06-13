package ru.kpfu.itis.kevlinsky.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import ru.kpfu.itis.kevlinsky.models.Hobby;
import ru.kpfu.itis.kevlinsky.models.User;
import ru.kpfu.itis.kevlinsky.security.UserDetailsImpl;
import ru.kpfu.itis.kevlinsky.services.HobbyService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class HobbyController {
    @Autowired
    private HobbyService service;

    @GetMapping("/hobbies")
    public String getHobbies(ModelMap map, HttpServletRequest request){
        HttpSession session = request.getSession();
        if (session.getAttribute("fromRegistration") != null){
            map.put("title", "Хобби");
            map.put("hobbies", service.findAll());
            return "hobby";
        } else {
            return "redirect:" + MvcUriComponentsBuilder.fromMappingName("PC#getProfile").build();
        }
    }

    @PostMapping("/hobbies")
    public String postHobbies(HttpServletRequest request, HttpServletResponse response){
        service.addHobbies(request, response, (String) request.getSession().getAttribute("fromRegistration"));
        request.getSession().removeAttribute("fromRegistration");
        return "redirect:" + MvcUriComponentsBuilder.fromMappingName("UC#getSignIn").build();
    }

    @PostMapping("/delete")
    public void deleteHobbies(Authentication authentication, ModelMap map, @RequestParam("title") String titleParam){
        User user = ((UserDetailsImpl) authentication.getPrincipal()).getUser();
        String title = titleParam.replace(": ", "");
        service.deleteHobby(user, title);
        map.put("linkId", "list-hobbies-list");
        map.put("url", "/profile");
    }
}
