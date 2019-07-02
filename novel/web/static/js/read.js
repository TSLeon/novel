if($('#first_chapter').length > 0){
    $('#read-container').show();
}
if($('#pre_chapter').attr('href') == 'javascript:;'){
    $('#pre_chapter').css("color","darkgrey");
}
if($('#next_chapter').attr('href') == 'javascript:;'){
    $('#next_chapter').css("color","darkgrey");
}