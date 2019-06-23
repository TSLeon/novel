$(".link_show").hover(
    function () {
        $(this).find('a').show();//mouse in
},
    function () {
        $(this).find('a').hide();//mouse out
    });

$(document).ready(function () {
    $('div.jumbotron_self').fadeIn(1000);
});
$('.img-self').hover(
    function () {
        $(this).css("box-shadow","darkgrey 5px 5px 10px 5px");
    },
    function () {
        $(this).css("box-shadow","darkgrey 2px 2px 5px 2px");
    }
);