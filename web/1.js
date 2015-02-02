$("#login-form").submit(function() {

        var url = "login.do"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: {
                account:$("#user:input").val(),
                pwd:$("#password:input").val()
            }// serializes the form's elements.
        }).done(function( msg ) {
            var obj=JSON.parse(msg);
            if(obj.status)
            {
                window.location.href="index.jsp";
            }
            else
            {
               alert(obj.message);
            }
        });

        return false; // avoid to execute the actual submit of the form.
    });
