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
        var obj=JSON.parse(msg);
        if(obj.status)
        {
            window.location.href="../index.jsp";
        }
        else
        {
            showError(obj.message);
        }
    });
    return false; // avoid to execute the actual submit of the form.
});

$("#ktbg-form").submit(function(){
   var url="";
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

   });
   return false;
});

$(function () {
    $('#fileupload').fileupload({
        dataType: 'json',
        done: function (e, data) {
            $.each(data.result.files, function (index, file) {
                $('<p/>').text(file.name).appendTo(document.body);
            });
        }
    });
});
