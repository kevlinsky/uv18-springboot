<#include "parts/header.ftlh">
<#include "parts/navigation.ftlh">
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-3"></div>
        <div class="col-lg-6">
            <div class="row">
                <div class="col-4">
                    <div class="list-group" id="list-tab" role="tablist">
                        <a class="list-group-item list-group-item-action <#if !linkId??>active</#if>" id="list-personal-data-list"
                        data-toggle="list" href="#list-personal-data" role="tab" aria-controls="personal data">Персональные
                        данные</a>
                        <a class="list-group-item list-group-item-action haha" id="list-hobbies-list" data-toggle="list"
                           href="#list-hobbies" role="tab" aria-controls="hobbies">Интересы</a>
                        <a class="list-group-item list-group-item-action" id="list-settings-list" data-toggle="list"
                           href="#list-settings" role="tab" aria-controls="settings">Настройки</a>
                        <#if user.role == 'admin'>
                            <a class="list-group-item list-group-item-action" id="list-dashboard-list" data-toggle="list"
                               href="#list-dashboard" role="tab" aria-controls="dashboard">Панель управления</a>
                        </#if>
                    </div>
                </div>
                <div class="col-8">
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="list-personal-data" role="tabpanel" aria-labelledby="list-personal-data-list">
                            <ul class="list-group-flush">
                                <li class="list-group-item"><span style="font-weight: 400; color: #212529;">Фамилия: </span>${user.surname}</li>
                                <li class="list-group-item"><span style="font-weight: 400; color: #212529;">Имя: </span>${user.name}</li>
                                <li class="list-group-item"><span style="font-weight: 400; color: #212529;">Отчество: </span>${user.patronymic}</li>
                                <li class="list-group-item"><span style="font-weight: 400; color: #212529;">Пол: </span>${user.sex?string('Мужской', 'Женский')}</li>
                                <li class="list-group-item"><span style="font-weight: 400; color: #212529;">Телефон: </span>+7${user.phone}</li>
                            </ul>
                        </div>
                        <div class="tab-pane fade" id="list-hobbies" role="tabpanel" aria-labelledby="list-hobbies-list">
                            <ul class="list-group-flush">
                                <#list hobbies as hobby>
                                    <!--Изменить id span'a-->
                                    <li class="list-group-item"><span style="font-weight: 400; color: #212529;">${hobby.title}: </span>${hobby.description}<br><button class="badge badge-primary">Удалить</button></li>
                                </#list>
                                <li class="list-group-item">
                                    <a id="hobby-link-collapse" href="#hobby-collapse" data-toggle="collapse" class="ui-item clearfix" aria-expanded="false" style="padding-bottom: 0">
                                        <span style="font-weight: 400; color: #212529;">Добавить хобби</span>
                                        <#if emptyHobbyError??>
                                            <div class="form-group">
                                                <div class="alert alert-danger">
                                                    ${emptyHobbyError}
                                                </div>
                                            </div>
                                        </#if>
                                        <#if addHobbySuccess??>
                                            <div class="form-group">
                                                <div class="alert alert-success">
                                                    ${addHobbySuccess}
                                                </div>
                                            </div>
                                        </#if>
                                    </a>
                                    <div class="collapse" id="hobby-collapse">
                                        <form action="" method="post">
                                            <div class="form-group">
                                                <select class="form-control" name="hobbySelect">
                                                    <option value="empty">-Выберите хобби-</option>
                                                    <#list allHobbies as hobby>
                                                        <option value="${hobby.title}">${hobby.title}</option>
                                                    </#list>
                                                </select>
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" hidden>
                                                <button type="submit" id="hobby-button" class="btn btn-primary">Добавить</button>
                                            </div>
                                        </form>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-pane fade" id="list-settings" role="tabpanel" aria-labelledby="list-settings-list">
                            <form action="" method="post">
                                <div class="form-group">
                                    <label for="exampleInputEmail1" style="font-weight: 400; color: #212529;">Сменить e-mail адрес</label>
                                    <input type="text" name="email" class="form-control" id="exampleInputEmail1" placeholder="Введите e-mail">
                                </div>
                                <#if emailError??>
                                    <div class="form-group">
                                        <div class="alert alert-danger">
                                            ${emailError}
                                        </div>
                                    </div>
                                </#if>
                                <#if emailNullError??>
                                    <div class="form-group">
                                        <div class="alert alert-danger">
                                            ${emailNullError}
                                        </div>
                                    </div>
                                </#if>
                                <#if emailChangeSuccess??>
                                    <div class="form-group">
                                        <div class="alert alert-success">
                                            ${emailChangeSuccess}
                                        </div>
                                    </div>
                                </#if>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" hidden>
                                <button type="submit" id="email-button" class="btn btn-primary">Подтвердить</button>
                            </form>
                            <hr>
                            <form action="" method="post">
                                <div class="form-group">
                                    <label for="exampleInputPassword" style="font-weight: 400; color: #212529;">Сменить пароль</label>
                                    <input type="password" name="password" class="form-control" id="exampleInputPassword" aria-describedby="passwordHelp" placeholder="Введите пароль" minlength="6"
                                    <#if userPassword??>
                                        value="${userPassword}"
                                    </#if>
                                    >
                                    <small id="passwordHelp" class="form-text text-muted">Пароль должен содержать минимум 6 символов</small>
                                </div>
                                <div class="form-group">
                                    <input type="password" name="password_confirm" class="form-control" id="exampleInputPasswordConfirm" placeholder="Подтвердите пароль" minlength="6"
                                    <#if userPasswordConfirm??>
                                        value="${userPasswordConfirm}"
                                    </#if>
                                    >
                                </div>
                                <#if passwordError??>
                                    <div class="form-group">
                                        <div class="alert alert-danger">
                                            ${passwordError}
                                        </div>
                                    </div>
                                </#if>
                                <#if passwordNullError??>
                                    <div class="form-group">
                                        <div class="alert alert-danger">
                                            ${passwordNullError}
                                        </div>
                                    </div>
                                </#if>
                                <#if passwordChangeSuccess??>
                                    <div class="form-group">
                                        <div class="alert alert-success">
                                            ${passwordChangeSuccess}
                                        </div>
                                    </div>
                                </#if>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" hidden>
                                <button type="submit" id="password-button" class="btn btn-primary">Подтвердить</button>
                            </form>
                        </div>
                        <#if user.role == 'admin'>
                            <div class="tab-pane fade" id="list-dashboard" role="tabpanel" aria-labelledby="list-dashboard-list">
                                <ul class="list-group-flush">
                                    <form action="" method="post">
                                        <div class="form-group">
                                            <label for="emailForRole" style="font-weight: 400; color: #212529;">Изменить роль</label>
                                            <input type="email" name="emailForRole" class="form-control mb-4" id="emailForRole" placeholder="Введите e-mail пользователя">
                                            <select class="form-control" name="role">
                                                <option value="empty">-Выберите роль-</option>
                                                <option value="admin">Администратор</option>
                                                <option value="user">Пользователь</option>
                                            </select>
                                        </div>
                                        <#if emailForRoleError??>
                                            <div class="form-group">
                                                <div class="alert alert-danger">
                                                    ${emailForRoleError}
                                                </div>
                                            </div>
                                        </#if>
                                        <#if emailForRoleNullError??>
                                            <div class="form-group">
                                                <div class="alert alert-danger">
                                                    ${emailForRoleNullError}
                                                </div>
                                            </div>
                                        </#if>
                                        <#if selectError??>
                                            <div class="form-group">
                                                <div class="alert alert-danger">
                                                    ${selectError}
                                                </div>
                                            </div>
                                        </#if>
                                        <#if ownEmailError??>
                                            <div class="form-group">
                                                <div class="alert alert-danger">
                                                    ${ownEmailError}
                                                </div>
                                            </div>
                                        </#if>
                                        <#if superUserEmailError??>
                                            <div class="form-group">
                                                <div class="alert alert-danger">
                                                    ${superUserEmailError}
                                                </div>
                                            </div>
                                        </#if>
                                        <#if setRoleSuccess??>
                                            <div class="form-group">
                                                <div class="alert alert-success">
                                                    ${setRoleSuccess}
                                                </div>
                                            </div>
                                        </#if>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" hidden>
                                        <button type="submit" id="role-button" class="btn btn-primary">Подтвердить</button>
                                    </form>
                                </ul>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3"></div>
    </div>
</div>
<script>
    window.onload = function () {
        let email_button = document.getElementById("email-button");
        let password_button = document.getElementById("password-button");
        let role_button = document.getElementById("role-button");
        let hobby_button = document.getElementById("hobby-button");
        email_button.onclick = function () {
            document.cookie = "email=selected; max-age=31536000‬";
        };
        password_button.onclick = function () {
            document.cookie = "password=selected; max-age=31536000‬";
        };
        role_button.onclick = function () {
            document.cookie = "role=selected; max-age=31536000‬";
        };
        hobby_button.onclick = function () {
            document.cookie = "hobby=selected; max-age=31536000‬;"
        };
        <#if linkid??>
            let link = document.getElementById("${linkId}");
            link.click();
        </#if>
    }
</script>
<#include "parts/footer.ftlh">
