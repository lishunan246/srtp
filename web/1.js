function login_submit () {
    var user=$("#user:input").val();
    var password=$("#password:input").val();

    $.post("login",
        {
            "account": user,
            "pwd":password
        },
        function(data){
            var obj = JSON.parse(data);
            if (obj.status) {
                alert(obj.message);
                window.location.href = "index.jsp";
            }
            else {
                alert(obj.message);
            }
        }
    );
    return false;
}
