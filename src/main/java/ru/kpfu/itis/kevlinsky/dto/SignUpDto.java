package ru.kpfu.itis.kevlinsky.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.kpfu.itis.kevlinsky.models.Role;
import ru.kpfu.itis.kevlinsky.models.User;

import javax.validation.constraints.AssertTrue;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SignUpDto {
    @Size(min = 6, message = "Length of the email must be greater than 6")
    @Pattern(regexp = "(\\w+\\.*)*@(\\w+\\.)*\\w{2,4}", message = "Incorrect email")
    @NotNull
    private String email;

    @Size(min = 6, message = "Length of the password must be greater than 6")
    @NotNull
    private String password;

    @Size(min = 6, message = "Length of the password repeat must be greater than 6")
    @NotNull
    private String passwordRepeat;

    @Size(min = 2, message = "Length of the name must be grater than 2")
    @NotNull
    private String name;

    @Size(min = 2, message = "Length of the surname must be grater than 2")
    @NotNull
    private String surname;

    @Size(min = 2, message = "Length of the patronymic must be grater than 2")
    @NotNull
    private String patronymic;

    @NotNull
    private long phone;

    @NotNull
    private boolean sex;

    @NotNull
    @AssertTrue
    private boolean accept;
}
