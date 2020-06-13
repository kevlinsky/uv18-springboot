<#import "/spring.ftl" as spring/>
<!-- jQuery -->
<script type="text/javascript" src="<@spring.url "/js/jquery.min.js"/>"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="<@spring.url "/js/popper.min.js"/>"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="<@spring.url "/js/bootstrap.min.js"/>"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="<@spring.url "/js/mdb.min.js"/>"></script>
<!--My own scripts-->
<script type="text/javascript" src="<@spring.url "/js/script.js"/>"></script>
<script>
    $(document).ready(function(){
        $(".ui-x a.ui-item").click(function(e){
            e.preventDefault();
            if ($(this).id !== "hobby-link-collapse") {
                if (!($(this).hasClass("active"))) {
                    $(this).addClass("active");
                    $(this).children("i").addClass("bg-primary");
                    document.cookie = $(this).children("i").children("input").val() + "=selected; max-age=31536000‬";
                } else {
                    $(this).removeClass("active");
                    $(this).children("i").removeClass("bg-primary");
                    document.cookie = $(this).children("i").children("input").val() + "=selected; max-age=0‬";
                }
            } else {
                if (!($(this).hasClass("active"))) {
                    $(this).addClass("active");
                    $(this).children("i").addClass("bg-primary");
                    $("#hobbySubmit").attr("disabled", true);
                } else {
                    $(this).removeClass("active");
                    $(this).children("i").removeClass("bg-primary");
                    $("#hobbySubmit").removeAttr("disabled");
                }
            }
        });
        $("#hobby-link-collapse").click(function () {
            if ($(this).hasClass("active")) {
                $("#hobbySubmit").attr("disabled", true);
            } else {
                $("#hobbySubmit").removeAttr("disabled");
            }
        });
        $("#hobbyTitleInput").keyup(function () {
            if ($(this).val().length < 1) {
                $("#hobbySubmit").attr("disabled", true);
            } else {
                $("#hobbySubmit").removeAttr("disabled");
            }
        });
        $("li.list-group-item button.badge").click(function () {
            $.ajax({
                type: "POST",
                url: "/delete",
                headers: {"X-CSRF-TOKEN": ${_csrf.token}},
                data: "title=" + $(this).parent("li").children("span").text(),
                dataType: "text",
                success:function(url) {
                    window.location.href = url;
                },
                error: function(url) {
                    window.location.href = url;
                }
            })
        })
    });
</script>
<!-- Footer -->
<footer class="page-footer font-small bg-primary fixed-bottom">

    <!-- Copyright -->
    <div class="footer-copyright text-center py-3">© 2019 Copyright:
        <a href="https://vk.com/kelinskiy" target="_blank"> Елин Артём</a>
    </div>
    <!-- Copyright -->

</footer>
<!-- Footer -->
</body>
</html>