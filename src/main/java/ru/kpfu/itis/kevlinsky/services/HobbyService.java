package ru.kpfu.itis.kevlinsky.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.kevlinsky.models.Hobby;
import ru.kpfu.itis.kevlinsky.models.User;
import ru.kpfu.itis.kevlinsky.repositories.HobbyRepository;
import ru.kpfu.itis.kevlinsky.repositories.UserRepository;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Service
public class HobbyService {
    @Autowired
    private HobbyRepository hobbyRepository;

    @Autowired
    private UserRepository userRepository;

    public List<Hobby> findAll(){
        return hobbyRepository.findAll();
    }

    public void addHobbies(HttpServletRequest request, HttpServletResponse response, String email) {
        Cookie[] cookies = request.getCookies();
        List<Hobby> hobbies = new ArrayList<>();
        for (Cookie cookie : cookies) {
            switch (cookie.getName()) {
                case "fas fa-running":
                    hobbies.add(hobbyRepository.findByFontTitle(cookie.getName()));
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                    break;
                case "fas fa-theater-masks":
                    hobbies.add(hobbyRepository.findByFontTitle(cookie.getName()));
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                    break;
                case "fas fa-shield-alt":
                    hobbies.add(hobbyRepository.findByFontTitle(cookie.getName()));
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                    break;
                case "fa fa-user":
                    String title = request.getParameter("hobbyTitleInput");
                    String description = request.getParameter("hobbyDescriptionInput");
                    Hobby hobby = Hobby.builder().title(title).description(description).fontTitle("fa fa-user").build();
                    hobbyRepository.save(hobby);
                    hobbies.add(hobby);
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                    break;
            }
        }
        User user = userRepository.findUserByEmail(email).orElse(null);
        user.setHobbyList(hobbies);
        userRepository.save(user);
    }

    public void deleteHobby(User user, String title) {
        Hobby hobby = hobbyRepository.findByTitle(title);
        hobby.getUsers().remove(user);
        hobbyRepository.save(hobby);
    }

    public List<Hobby> getNotUsedHobbies(List<Hobby> usersHobbies) {
        List<Hobby> hobbies = hobbyRepository.findAll();
        for(Hobby hobby: hobbies){
            for(Hobby usersHobby: usersHobbies){
                if (hobby.equals(usersHobby)){
                    hobbies.remove(hobby);
                }
            }
        }
        return hobbies;
    }
}
