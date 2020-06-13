package ru.kpfu.itis.kevlinsky.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import ru.kpfu.itis.kevlinsky.models.User;
import ru.kpfu.itis.kevlinsky.security.UserDetailsImpl;
import ru.kpfu.itis.kevlinsky.services.HobbyService;
import ru.kpfu.itis.kevlinsky.services.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class ProfileController {
    @Autowired
    private HobbyService hobbyService;

    @Autowired
    private UserService userService;

    @GetMapping("/profile")
    public String getProfile(Authentication authentication, ModelMap map){
        User user = ((UserDetailsImpl) authentication.getPrincipal()).getUser();
        map.put("user", user);
        map.put("title", "Мой профиль");
        map.put("hobbies", user.getHobbyList());
        map.put("allHobbies", hobbyService.getNotUsedHobbies(user.getHobbyList()));
        return "profile";
    }

    @PostMapping("/profile")
    public String postProfile(HttpServletRequest request, HttpServletResponse response, Authentication authentication, ModelMap map){
        User user = ((UserDetailsImpl) authentication.getPrincipal()).getUser();
        userService.resolveProfileAction(request, response, user, map);
        map.put("user", user);
        map.put("title", "Мой профиль");
        map.put("hobbies", user.getHobbyList());
        map.put("allHobbies", hobbyService.getNotUsedHobbies(user.getHobbyList()));
        return "profile";
    }
}
