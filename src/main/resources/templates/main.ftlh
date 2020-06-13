<#include "parts/header.ftlh">
<#include "parts/navigation.ftlh">
<div class="col-lg-4"></div>
<div class="col-lg-4">
    <#list posts as post>
        <div class="row">
            <div class="col-lg-12">
                <p>${post.text}</p>
                <#list post.photos as photo>
                    <p><img src="${photo}"></p>
                </#list>
            </div>
        </div>
    </#list>
</div>
<div class="col-lg-4"></div>
<#include "parts/footer.ftlh">