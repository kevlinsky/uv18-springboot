package ru.kpfu.itis.kevlinsky.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import ru.kpfu.itis.kevlinsky.dto.SignUpDto;
import ru.kpfu.itis.kevlinsky.models.Hobby;
import ru.kpfu.itis.kevlinsky.models.Role;
import ru.kpfu.itis.kevlinsky.models.State;
import ru.kpfu.itis.kevlinsky.models.User;
import ru.kpfu.itis.kevlinsky.repositories.HobbyRepository;
import ru.kpfu.itis.kevlinsky.repositories.UserRepository;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private HobbyRepository hobbyRepository;

    @Autowired
    private PasswordEncoder encoder;

    public void save(SignUpDto signUpDto){
        userRepository.save(User.builder().email(signUpDto.getEmail())
                .password(encoder.encode(signUpDto.getPassword()))
                .name(signUpDto.getName())
                .surname(signUpDto.getSurname())
                .patronymic(signUpDto.getPatronymic())
                .phone(signUpDto.getPhone())
                .sex(signUpDto.isSex())
                .role(Role.USER)
                .state(State.CONFIRMED)
                .build()
        );
    }

    public User findByEmail(String email){
        Optional<User> userOptional = userRepository.findUserByEmail(email);
        return userOptional.orElse(null);
    }

    public void resolveProfileAction(HttpServletRequest request, HttpServletResponse response, User user, ModelMap map) {
        Cookie[] cookies = request.getCookies();
        Cookie emailCookie = new Cookie("email", "selected");
        Cookie passwordCookie = new Cookie("password", "selected");
        Cookie roleCookie = new Cookie("role", "selected");
        Cookie hobbyCookie = new Cookie("hobby", "selected");
        emailCookie.setMaxAge(0);
        passwordCookie.setMaxAge(0);
        roleCookie.setMaxAge(0);
        hobbyCookie.setMaxAge(0);
        for (Cookie cookie : cookies) {
            switch (cookie.getName()) {
                case "email":
                    String newEmail = request.getParameter("email");
                    if (newEmail.equals("")) {
                        response.addCookie(emailCookie);
                        map.put("linkId", "list-settings-list");
                        map.put("emailNullError", "Пожалуйста, введите e-mail");
                    } else if (!checkEmail(newEmail)){
                        response.addCookie(emailCookie);
                        map.put("linkId", "list-settings-list");
                        map.put("emailError", "Некорректный e-mail");
                    } else {
                        user.setEmail(newEmail);
                        userRepository.save(user);
                        response.addCookie(emailCookie);
                        map.put("linkId", "list-settings-list");
                        map.put("emailChangeSuccess", "E-mail успешно изменён");
                    }
                    break;
                case "password":
                    String newPassword = request.getParameter("password");
                    String newPasswordConfirm = request.getParameter("password_confirm");
                    if (!newPassword.equals("") && !newPasswordConfirm.equals("")) {
                        if (newPassword.equals(newPasswordConfirm)) {
                            user.setPassword(encoder.encode(newPassword));
                            userRepository.save(user);
                            response.addCookie(passwordCookie);
                            map.put("linkId", "list-settings-list");
                            map.put("passwordChangeSuccess", "Пароль успешно изменён");
                        } else {
                            response.addCookie(passwordCookie);
                            map.put("linkId", "list-settings-list");
                            map.put("passwordError", "Пароли не совпадают");
                        }
                    } else {
                        response.addCookie(passwordCookie);
                        map.put("linkId", "list-settings-list");
                        map.put("passwordNullError", "Пожалуйста, заполните все поля");
                        if (!newPassword.equals("")) {
                            map.put("userPassword", newPassword);
                        }
                        if (!newPasswordConfirm.equals("")) {
                            map.put("userPasswordConfirm", newPasswordConfirm);
                        }
                    }
                    break;
                case "role":
                    String email = request.getParameter("emailForRole");
                    String role = request.getParameter("role");
                    if (email.equals("")) {
                        response.addCookie(roleCookie);
                        map.put("linkId", "list-dashboard-list");
                        map.put("emailForRoleNullError", "Пожалуйста, введите e-mail пользователя");
                    } else if (role.equals("")){
                        response.addCookie(roleCookie);
                        request.setAttribute("linkId", "list-dashboard-list");
                        request.setAttribute("selectError", "Пожалуйста, выберете роль");
                    } else if (!userRepository.findUserByEmail(email).isPresent()){
                        response.addCookie(roleCookie);
                        map.put("linkId", "list-dashboard-list");
                        map.put("emailForRoleNullError", "Пользователь не найден");
                    } else if (user.getEmail().equals(email)){
                        response.addCookie(roleCookie);
                        map.put("linkId", "list-dashboard-list");
                        map.put("ownEmailError", "Нельзя изменить роль самому себе");
                    } else if (checkSuperUserEmail(email)) {
                        response.addCookie(roleCookie);
                        map.put("linkId", "list-dashboard-list");
                        map.put("superUserEmailError", "Нельзя изменить роль администратору");
                    } else {
                        if (role.equals("admin")){
                            user.setRole(Role.ADMIN);
                        } else if (role.equals("user")){
                            user.setRole(Role.USER);
                        }
                        userRepository.save(user);
                        response.addCookie(roleCookie);
                        map.put("linkId", "list-dashboard-list");
                        map.put("setRoleSuccess", "Роль успешно изменена");
                    }
                    break;
                case "hobby":
                    String hobby = request.getParameter("hobbySelect");
                    if (!hobby.equals("empty")) {
                        Hobby selectedHobby = hobbyRepository.findByTitle(hobby);
                        user.getHobbyList().add(selectedHobby);
                        userRepository.save(user);
                        response.addCookie(hobbyCookie);
                        map.put("linkId", "list-hobbies-list");
                        map.put("addHobbySuccess", "Хобби успешно добавлено");
                    } else {
                        response.addCookie(hobbyCookie);
                        map.put("linkId", "list-hobbies-list");
                        map.put("emptyHobbyError", "Пожалуйста, выберите хобби");
                    }
                    break;
            }
        }
    }

    private boolean checkSuperUserEmail(String email) {
        List<User> users = userRepository.findAllByRole(Role.ADMIN);
        if (users.isEmpty()){
            return false;
        } else {
            boolean superUser = false;
            for(User user: users){
                if (user.getEmail().equals(email)) {
                    superUser = true;
                    break;
                }
            }
            return superUser;
        }
    }

    private boolean checkEmail(String email) {
        Pattern pattern = Pattern.compile("(\\w+\\.*)*@(\\w+\\.)*\\w{2,4}");
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }
}
