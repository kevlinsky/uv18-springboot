<#include "parts/header.ftlh">
<#include "parts/navigation.ftlh">
<!-- Default form login -->
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <form class="text-center p-5" action="" method="post">
                <p class="h4 mb-4">Вход в профиль</p>
                <!-- Email -->
                <input type="text" name="email" id="defaultLoginFormEmail" class="form-control mb-4" placeholder="E-mail" required>
                <!-- Password -->
                <input type="password" name="password" id="defaultLoginFormPassword" class="form-control mb-4" placeholder="Пароль" required>
                <div class="d-flex justify-content-around">
                    <div>
                        <!-- Remember me -->
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" name="rememberMe" id="defaultLoginFormRemember">
                            <label class="custom-control-label" for="defaultLoginFormRemember">Запомнить меня</label>
                        </div>
                    </div>
                </div>
                <#if userError??>
                    <div class="alert alert-danger" style="margin-top: 10px">
                        ${userError}
                    </div>
                </#if>
                <!-- Csrf -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" hidden>
                <!-- Sign in button -->
                <button class="btn btn-block my-4 btn-primary" type="submit">Войти</button>
                <!-- Register -->
                <p>Ещё не с нами?
                    <a href="<@spring.url "/signUp"/>">Зарегистрироваться</a>
                </p>
            </form>
        </div>
        <div class="col-lg-4"></div>
    </div>
</div>
<!-- Default form login -->
<#include "parts/footer.ftlh">