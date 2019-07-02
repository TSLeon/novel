$(".link_show").hover(
    function () {
        $(this).find('a').show();//mouse in
},
    function () {
        $(this).find('a').hide();//mouse out
    });

$(document).ready(function () {
    /*$('div.jumbotron_self')*/
    jQuery('div.jumbotron_self').animate({backgroundColor: "#0f0f0f"}, 1000);
});