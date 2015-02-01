function login_submit (argument) {
    alert("logging in");
    $.post("login",
        {
            "user":"shi",
            "password":"123456"
        },
        function(data){
            alert(data);
        }
    );
}