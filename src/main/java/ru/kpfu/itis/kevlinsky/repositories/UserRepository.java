package ru.kpfu.itis.kevlinsky.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.kevlinsky.models.Role;
import ru.kpfu.itis.kevlinsky.models.User;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findUserByEmail(String email);
    List<User> findAllByRole(Role role);
}
