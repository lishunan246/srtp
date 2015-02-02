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
    $.ajax({
        type: "POST",
        url: url,
        data: {
            account:$("#user:input").val(),
            pwd:$("#password:input").val()
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