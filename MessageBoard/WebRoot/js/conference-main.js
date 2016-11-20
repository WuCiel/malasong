/**
 * Created by Fruit Basket on 2016/3/26.
 */
window.onload = function(){//页面加载完成后执行函数
    getTop();
    scrolltotop();
}
/*控制固定位置div何时显示从这里开始*/
function getTop() {
    var mytop = $(document).scrollTop();
    if (mytop > 200) {
        $("#scroll-top-div").css("display","block");//设定何时显示跳转页面最上端剪头
        $("#scroll-bottom-div").css("display","block");//设定何时显示跳转页面最下端剪头
        $("#top-container").css("display","block");//设定合适显示最上端按钮栏
    }
    else {
        $("#scroll-top-div").css('display', 'none');
        $("#scroll-bottom-div").css('display', 'none');
        $("#top-container").css("display","none");
    }
    setTimeout(getTop);//递归执行getTop（）函数
}/*控制固定位置div何时显示结束*/

function scrolltotop(){//点击按钮回到网页顶部以及底部
    $("#scroll-top-div").click(function(){
        $('body,html').animate({scrollTop:0},300);
        return false;
    });
    $("#scroll-bottom-div").click(function(){
        $('body,html').animate({scrollTop:1200},300);
        return false;
    });
};