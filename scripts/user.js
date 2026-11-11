let registerForm = document.getElementById("register_form");
let loginForm = document.getElementById("login_form");

if(registerForm != null){
    registerForm.addEventListener("submit", registrationFormListener);
}
if (loginForm != null){
    loginForm.addEventListener("submit", loginFormListener); 
}


//document.getElementById("register_form_submit").onclick() = getUserRegistrationFromStuff();

function registrationFormListener(e){
    e.preventDefault();
    let fname = document.getElementById("fname").value;
    let lname = document.getElementById("lname").value;
    let username = document.getElementById("username").value;
    let pwd = document.getElementById("pwd").value;

    //let user =  new User(fname, lname, username, pwd);

    let user = {
        fname,
        lname,
        username,
        pwd,
    };

    console.log(user);

    return user;

}

function loginFormListener(e){
    e.preventDefault();

    let username = document.getElementById("username").value;
    let pwd = document.getElementById("pwd").value;

    //let userCreds = new UserCreds(username, pwd);

    let userCreds = {
        username,
        pwd,
    };
    console.log(userCreds);

    return userCreds;
}


function User(fname, lname, usernameOrEmail, password){
    this.fname = fname;
    this.lname = lname;
    this.usernameOrEmail = usernameOrEmail;
    this.password = password;
}

function UserCreds(username, pwd){
    this.username = username;
    this.pwd = pwd;
}


