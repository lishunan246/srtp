function login_submit () {
    var user=$("#user:input").val();
    var password=$("#password:input").val();
    $.post("login",
        {
            "user": user,
            "password":password
        },
        function(data){
            alert(data);
        }
    );
}
