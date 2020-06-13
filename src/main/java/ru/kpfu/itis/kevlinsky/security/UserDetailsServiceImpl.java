package ru.kpfu.itis.kevlinsky.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.kevlinsky.models.User;
import ru.kpfu.itis.kevlinsky.repositories.UserRepository;

import java.util.Optional;

@Service(value = "customUserDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    private UserRepository repository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<User> userOptional = repository.findUserByEmail(email);
        if (userOptional.isPresent()){
            User user = userOptional.get();
            return new UserDetailsImpl(user);
        } else {
            throw new UsernameNotFoundException("User not found");
        }
    }
}
