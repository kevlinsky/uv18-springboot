package ru.kpfu.itis.kevlinsky.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.kevlinsky.models.Hobby;

@Repository
public interface HobbyRepository extends JpaRepository<Hobby, Integer> {
    Hobby findByFontTitle(String fontTitle);
    Hobby findByTitle(String title);
}
