function login_submit () {
    var user=$("#user:input").val();
    var password=$("#password:input").val();
    $.post("login",
        {
            "account": user,
            "pwd":password
        },
        function(data){
            alert(data);
        }
    );
}
