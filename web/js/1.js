$(document).ready(function(){
    var url="/currentuser.do";

    $.ajax({
        url:url
    }).done(function(msg){
        var obj=JSON.parse(msg);
        if(obj.status)
        {
            if ("student" == obj.type) {
                $("#username").html("欢迎， " + obj.name + "同学").attr("href", "/");
            }
            else if ("teacher" == obj.type) {
                $("#username").html("欢迎， " + obj.name + "老师").attr("href", "/teacher.jsp");
            }
            else if ("admin" == obj.type) {
                $("#username").html("欢迎， " + obj.name + "管理员").attr("href", "/admin.jsp");
            }
        }
        else
        {
            $("#username").html("请登录").attr("href","login.jsp");

        }
    })
});

function showError(msg)
{
    $("#alert-box").removeClass("hidden").html(msg);
}

function hideAlertBox()
{
    $("#alert-box").addClass("hidden");
}


$("#login-form").submit(function() {
    var url = "login.do"; // the script where you handle the form input.
    var data={
        account:$("#user:input").val(),
        pwd:$("#password:input").val(),
        remember:$("#remember-me").is(':checked')
    };
    console.log(JSON.stringify(data));
    $.ajax({
        type: "POST",
        url: url,
        data: data,
        timeout:500,
        statusCode: {
            500: function() {
                alert(" 500 data still loading");
                console.log('500 ');
            }
        },
        error:function(request,status,err)
        {
            if(status=="timeout")
            {
                showError("服务器无响应");
            }
            else
            {
                alert(request+status+err);
            }
        }
    }).done(function( msg ) {
        console.log(msg);
        var obj=JSON.parse(msg);
        if(obj.status)
        {
            window.location.href = "../redirect.jsp";
        }
        else
        {
            showError(obj.message);
        }
    });
    return false; // avoid to execute the actual submit of the form.
});

$("#change-password-form").submit(function() {
    var url = "changepassword.do"; // the script where you handle the form input.
    var data={
        old_password:$("#old-password:input").val(),
        new_password:$("#new-password:input").val(),
        confirm:$("#confirm:input").val()
    };

    $.ajax({
        type: "POST",
        url: url,
        data: data,
        timeout:500,
        statusCode: {
            500: function() {
                alert(" 500 data still loading");
                console.log('500 ');
            }
        },
        error:function(request,status,err)
        {
            if(status=="timeout")
            {
                showError("no response");
            }
            else
            {
                alert(request+status+err);
            }
        }
    }).done(function( msg ) {
        var obj=JSON.parse(msg);
        if(obj.status)
        {
            alert("New password is set.");
            window.location.href = "../redirect.jsp";
        }
        else
        {
            showError(obj.message);
        }
    });
    return false; // avoid to execute the actual submit of the form.
});


$("#ktbg-form").submit(function(){
   var url="ktbg.do";
   var data={
       name_en:$("#name-en").val(),
       name_cn:$("#name-cn").val(),
       type:$('input[name="ktbg-type"]:checked').val(),
       description:$("#description").val()
   };
   console.log(JSON.stringify(data));
   $.ajax({
       type:"POST",
       url:url,
       data:data
   }).done(function(msg){
        console.log(msg);
       var obj=JSON.parse(msg);
       if(!obj.status)
       {
           showError(obj.message);
       }
       else
       {
           alert("修改成功！");
       }
   });
   return false;
});
//
//$(function () {
//    $('#fileupload').fileupload({
//        dataType: 'json',
//        done: function (e, data) {
//            $.each(data.result.files, function (index, file) {
//                $('<p/>').text(file.name).appendTo(document.body);
//            });
//        }
//    });
//});

function logout()
{
    var url="/logout.do";
    $.ajax({
        url:url
    }).done(function(){
        window.location.href="/login.jsp";
    })
}

