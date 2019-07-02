if($('#flag_false').length > 0){
    $('#myModal').modal('show');
    $('#login-error').show();
}

function check() {
    var user;
    var pswd;
    var tempU;
    var tempP;
    var reg = /\s/;

    user = document.getElementById('InputUser').value;
    pswd = document.getElementById('InputPassword').value;

    tempU = user.replace(/(^\s*)|(\s*$)/g, '');
    tempP = pswd.replace(/(^\s*)|(\s*$)/g, '');

    if(tempU == '' || tempU == undefined || tempU == null || reg.test(user)){
        $('#myModal').modal('show');
        $('#user-info').show();
        $('#login-error').hide();
        return false;
    }else{
        $('#user-info').hide();
        $('#login-error').hide();
    }
    if(tempP =='' || tempP == undefined || tempP == null || reg.test(tempP)){
        $('#myModal').modal('show');
        $('#pswd-info').show();
        return false;
    }else{
        $('#pswd-info').hide();
    }
}