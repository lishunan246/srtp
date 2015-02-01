function login_submit (argument) {
    $.get("login",
        {
            "user":"shi",
            "password":"123456"
        },
        function(data){
            alert(data);
        }
    );
}