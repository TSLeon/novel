$(document).ready(function () {
   $('#register-label').click(function () {
       if($('#check-self').is(':checked')) {
           $('#register').removeAttr("disabled");
       }
       else {
           $('#register').attr("disabled","disabled");
       }
   });
});

function check_info() {
    var User;
    var Password;
    var ComfirmPasswrod;
    var Email;
    var tempU;
    var tempP;
    var tempC;
    var tempE;
    var reg = /\s/;
    User = document.getElementById("InputUser").value;
    Email = document.getElementById("InputEmail").value;
    Password = document.getElementById("InputPassword").value;
    ComfirmPasswrod = document.getElementById("ComfirmPassword").value;

    tempU = User.replace(/(^\s*)|(\s*$)/g, '');
    tempE = Email.replace(/(^\s*)|(\s*$)/g, '');
    tempP = Password.replace(/(^\s*)|(\s*$)/g, '');
    tempC = ComfirmPasswrod.replace(/(^\s*)|(\s*$)/g, '');
    if(tempU == '' || tempU == undefined || tempU == null || User == null || reg.test(User)){
        $('#user-danger').show();
        return false;
    }else{
        $('#user-danger').hide();
    }
    if(tempE == '' || tempE == undefined || tempE ==null || Email == null || reg.test(Email)){
        $('#email-danger').show();
        return false;
    }else{
        $('#email-danger').hide();
    }
    if(tempP == '' || tempP == undefined || tempP == null || Password == null || reg.test(Password)){
        $('#pswd-danger').show();
        return false;
    }else{
        $('#pswd-danger').hide();
    }
    if(tempC == '' || tempC == undefined || tempC == null || ComfirmPasswrod == null || reg.test(ComfirmPasswrod)){
        $('#com-danger').show();
        return false;
    }else{
        $('#com-danger').hide();
    }
    if(Password != ComfirmPasswrod){
        $('#com-danger').show();
        return false;
    }else{
        $('#com-danger').hide();
    }
/*
    if(User == null || reg.test(User) || User == undefined){
    }else if(Email == null || reg.test(Email)){
        alert("email");
    }else if(Password == null || reg.test(Password)){
        alert("Pass");
    }else if(ComfirmPasswrod == null || reg.test(ComfirmPasswrod)){
        alert("COmm");
    }else if(Password != ComfirmPasswrod){
        alert("not equal");
    }*/
}
/*$('#myModal').modal("show");*/
if($('#rg_false').length > 0){
    $('#myModal').modal("show");
}
