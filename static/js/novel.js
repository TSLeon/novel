$('#remark_control').click(function () {
    $('#remark').show();
    $('#category').hide();
    $('#remark_control').css({"border-bottom":"2px solid #ff3955"});
    $('#remark_control>a').css({"color":"#ff3955"});
    $('#category_control').css({"border-bottom":"0"});
    $('#category_control>a').css({"color":"#000000"});
});
$('#category_control').click(function () {
    $('#remark').hide();
    $('#category').show();
    $('#remark_control').css({"border-bottom":"0"});
    $('#remark_control>a').css({"color":"#000000"});
    $('#category_control').css({"border-bottom":"2px solid #ff3955"});
    $('#category_control>a').css({"color":"#ff3955"});
});
/*
$('#remark_control').hover(function () {
    $('#remark_control>a').css({"color":"#ff3955"});
})
$('#category_control').hover(function () {
    $('#category_control>a').css({"color":"#ff3955"});
})
*/