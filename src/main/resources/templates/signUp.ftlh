<#include "parts/header.ftlh">
<#include "parts/navigation.ftlh">
<#import "/spring.ftl" as spring>
<!-- Default form register -->
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <form class="text-center p-5" method="post" action="">

                <div class="container-fluid">
                    <div class="row mb-4">
                        <div class="col-lg-12"><p class="h4">Регистрация</p></div>
                    </div>

                    <!-- User Found Error -->
                    <#if userFoundError??>
                        <div class="row mb-1">
                            <div class="col-lg-12">
                                <div class="alert alert-danger">
                                    ${userFoundError}
                                </div>
                            </div>
                        </div>
                    </#if>

                    <div class="row mb-4">
                        <div class="col-lg-6">
                            <!-- Last name -->
                            <@spring.bind "user.surname"/>
                            <@spring.formInput "user.surname" "id=\"defaultRegisterFormFirstName\" name=\"surname\" class=\"form-control\"
                                   placeholder=\"Фамилия\"" "text"/>
                        </div>
                        <div class="col-lg-6">
                            <!-- First name -->
                            <@spring.bind "user.name"/>
                            <@spring.formInput "user.name" "id=\"defaultRegisterFormLastName\" name=\"name\" class=\"form-control\"
                                   placeholder=\"Имя\"" "text"/>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <div class="alert alert-danger">
                                <@spring.showErrors "<br>"/>
                            </div>
                        </div>
                    </div>

                    <!-- Patronymic -->
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <@spring.bind "user.patronymic"/>
                            <@spring.formInput "user.patronymic" "name=\"patronymic\" id=\"defaultRegisterFormPatronymic\"
                                                          class=\"form-control\"
                                                          placeholder=\"Отчество\"" "text"/>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <div class="alert alert-danger">
                                <@spring.showErrors "<br>"/>
                            </div>
                        </div>
                    </div>

                    <!-- E-mail -->
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <@spring.bind "user.email"/>
                            <@spring.formInput "user.email" "name=\"email\" id=\"defaultRegisterFormEmail\"
                                                      class=\"form-control\"
                                                      placeholder=\"E-mail\"" "text"/>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <div class="alert alert-danger">
                                <@spring.showErrors "<br>"/>
                            </div>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <@spring.bind "user.password"/>
                            <@spring.formPasswordInput "user.password" "name=\"password\" id=\"defaultRegisterFormPassword\"
                                                      class=\"form-control\"
                                                      placeholder=\"Пароль\"
                                                      aria-describedby=\"defaultRegisterFormPasswordHelpBlock\" minlength=\"6\""/>
                            <small id="defaultRegisterFormPasswordHelpBlock" class="form-text text-muted">
                                Пароль должен содержать минимум 6 символов
                            </small>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <div class="alert alert-danger">
                                <@spring.showErrors "<br>"/>
                            </div>
                        </div>
                    </div>

                    <!-- Password Confirm -->
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <@spring.bind "user.passwordRepeat"/>
                            <@spring.formPasswordInput "user.passwordRepeat" "name=\"password_confirm\"
                                                      id=\"defaultRegisterFormPasswordConfirm\"
                                                      placeholder=\"Пароль ещё раз\" class=\"form-control\" minlength=\"6\""/>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <div class="alert alert-danger">
                                <@spring.showErrors "<br>"/>
                            </div>
                        </div>
                    </div>

                    <!-- Password Error-->
                    <#if passwordError??>
                        <div class="row mb-4">
                            <div class="col-lg-12">
                                <div class="alert alert-danger">
                                    ${passwordError}
                                </div>
                            </div>
                        </div>
                    </#if>

                    <!-- Phone number -->
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">+7</div>
                                </div>
                                <@spring.bind "user.phone"/>
                                <@spring.formInput "user.phone" "name=\"phone\" id=\"defaultRegisterPhonePassword\" class=\"form-control\"
                                       placeholder=\"Номер телефона\" minlength=\"10\"
                                        maxlength=\"10\"" "text"/>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <div class="alert alert-danger">
                                <@spring.showErrors "<br>"/>
                            </div>
                        </div>
                    </div>

                    <!-- Sex -->
                    <div class="row">
                        <div class="col-lg-2"></div>
                        <div class="col-lg-4">
                            <div class="custom-control custom-radio">
                                <@spring.bind "user.sex"/>
                                <@spring.formInput "user.sex" "id=\"customRadio1\" name=\"sex\" class=\"custom-control-input\"
                                       value=\"true\" aria-describedby=\"defaultRegisterFormSexHelpBlock\"" "radio"/>
                                <label class="custom-control-label" for="customRadio1">Мужской</label>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="custom-control custom-radio">
                                <@spring.formInput "user.sex" "id=\"customRadio2\" name=\"sex\" class=\"custom-control-input\"
                                       value=\"false\" aria-describedby=\"defaultRegisterFormSexHelpBlock\"" "radio"/>
                                <label class="custom-control-label" for="customRadio2">Женский</label>
                            </div>
                        </div>
                        <div class="col-lg-2"></div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <small id="defaultRegisterFormSexHelpBlock" class="form-text text-muted">
                                Выберите свой пол
                            </small>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <div class="alert alert-danger">
                                <@spring.showErrors "<br>"/>
                            </div>
                        </div>
                    </div>

                    <!-- Personal Data Processing -->
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <div class="custom-control custom-checkbox">
                                <@spring.bind "user.accept"/>
                                <@spring.formCheckbox "user.accept" "class=\"custom-control-input\" id=\"defaultRegisterFormTerms\" required"/>
                                <label class="custom-control-label" for="defaultRegisterFormTerms">Согласен с <a href="#">правилами</a> сайта</label>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-lg-12">
                            <div class="alert alert-danger">
                                <@spring.showErrors "<br>"/>
                            </div>
                        </div>
                    </div>

                    <!-- Csrf -->
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" hidden>

                    <!-- Sign up button -->
                    <button class="btn btn-primary my-4 btn-block" type="submit">Зарегистрироваться</button>
                </div>
            </form>
        </div>
        <div class="col-lg-4"></div>
    </div>
</div>
<!-- Default form register -->
<#include "parts/footer.ftlh">
