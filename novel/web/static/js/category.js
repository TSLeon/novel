$(function () {
    $('.type-list>ul>li>a').click(function () {
        if($(this).hasClass('type-list-click')){

        }else{
            $(this).addClass("type-list-click");
        }
        $(this).parent().siblings('li').find('a').removeClass('type-list-click');
    });
});

$('.type-list>ul>li>a').hover(
    function () {
        $(this).css({"color":"#ff3955"});
    },
    function () {
        $(this).css({"color":"#0f0f0f"})
    });
