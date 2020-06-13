<#include "parts/header.ftlh">
<#include "parts/navigation.ftlh">
<!-- UI - X Starts -->
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-4"></div>
        <div class="ui-x col-lg-4">
            <form method="post" action="">
                <!-- Main Heading -->
                <p class="h4">Чем бы ты хотел заниматься?</p>
                <!-- Item -->
                <#list hobbies as hobby>
                    <a href="#" class="ui-item clearfix">
                        <!-- Icon -->
                        <i class="fas ${hobby.fontTitle}"><input type="text" value="${hobby.fontTitle}" hidden></i>
                        <!-- Details -->
                        <span class="ui-details">
                            <!-- Heading -->
                            <span>${hobby.title}</span>
                            <!-- Paragraph -->
                            <strong>${hobby.description}</strong>
                        </span>
                    </a>
                </#list>
                <a id="hobby-link-collapse" href="#hobby-collapse" data-toggle="collapse" class="ui-item clearfix" aria-expanded="false" style="padding-bottom: 0">
                    <i class="fa fa-user"><input type="text" value="fa-user" hidden></i>
                    <span class="ui-details">
                        <span>Другое</span>
                    </span>
                </a>
                <div class="row">
                    <div class="col-2"></div>
                    <div class="collapse col-10" id="hobby-collapse" style="padding-left: 0">
                        <label for="hobbyTitleInput" style="font-weight: 500; font-size: 15px">Название хобби</label>
                        <input type="text" class="form-control form-control-sm" id="hobbyTitleInput" name="hobbyTitleInput"
                               placeholder="Название" minlength="1">
                        <label for="hobbyDescriptionInput" style="font-weight: 500; font-size: 15px">Описание хобби</label>
                        <input type="text" class="form-control form-control-sm" id="hobbyDescriptionInput" name="hobbyDescriptionInput"
                               placeholder="Описание" minlength="1">
                    </div>
                </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" hidden>
                <button id="hobbySubmit" class="btn btn-primary my-4 btn-block" type="submit">Подтвердить</button>
            </form>
        </div>
        <div class="col-lg-4"></div>
    </div>
</div>
<!-- UI - X Ends -->
<#include "parts/footer.ftlh">
