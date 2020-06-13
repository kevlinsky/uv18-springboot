<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<#import "/spring.ftl" as spring/>
<!--Navbar -->
<nav class="mb-1 navbar navbar-expand-lg navbar-dark bg-primary secondary-color lighten-1">
    <a class="navbar-brand" href="<@spring.url "/main"/>"><img src="<@spring.url "/img/logo.png"/>" class="rounded-circle z-depth-0" alt="navbar image" style="height: 35px"></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbar">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item nav-pills">
                <a class="nav-link" href="#">О нас</a>
            </li>
            <li class="nav-item nav-pills">
                <a class="nav-link" href="#">Мероприятия</a>
            </li>
            <li class="nav-item nav-pills">
                <a class="nav-link" href="#">Фото</a>
            </li>
            <li class="nav-item nav-pills">
                <a class="nav-link" href="#">Студсовет</a>
            </li>
            <li class="nav-item nav-pills">
                <a class="nav-link" href="#">Контакты</a>
            </li>
        </ul>
        <ul class="navbar-nav ml-auto nav-flex-icons">
            <li class="nav-item nav-pills avatar dropdown">
                <a class="nav-link" id="navbarDropdownMenuLink-55" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">
                    <@security.authorize access="isAuthenticated()">
                        <img src="https://mdbootstrap.com/img/Photos/Avatars/avatar-2.jpg" class="rounded-circle z-depth-0" alt="avatar image" style="height: 35px">
                    </@security.authorize>
                    <@security.authorize access="!isAuthenticated()">
                        <img src="<@spring.url "/img/anon.png"/>" class="rounded-circle z-depth-0" alt="anon image" style="height: 35px">
                    </@security.authorize>
                </a>
                <div class="dropdown-menu dropdown-menu-lg-right dropdown-secondary"
                     aria-labelledby="navbarDropdownMenuLink-55">
                    <@security.authorize access="isAuthenticated()">
                        <a class="dropdown-item" href="<@spring.url "/profile"/>">Мой профиль</a>
                        <a class="dropdown-item" href="<@spring.url "/logout"/>">Выйти</a>
                    </@security.authorize>
                    <@security.authorize access="!isAuthenticated()">
                        <a class="dropdown-item" href="<@spring.url "/signIn"/>">Войти</a>
                        <a class="dropdown-item" href="<@spring.url "/signUp"/>">Зарегистрироваться</a>
                    </@security.authorize>
                </div>
            </li>
        </ul>
    </div>
</nav>
<!--Navbar -->