package ru.kpfu.itis.kevlinsky.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HomePageUserDto {
    private String surname;
    private String name;
    private String patronymic;
    private long phone;
    private String sex;
}
