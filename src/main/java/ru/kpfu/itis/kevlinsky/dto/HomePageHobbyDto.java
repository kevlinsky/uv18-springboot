package ru.kpfu.itis.kevlinsky.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HomePageHobbyDto {
    private String title;
    private String description;
}
