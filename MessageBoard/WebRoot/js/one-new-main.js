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
    if (mytop > 50) {
        $("#scroll-top-div").css("display","block");//设定何时显示跳转页面最上端剪头
        $("#scroll-buttom-div").css("display","block");//设定何时显示跳转页面最下端剪头
        $("#div-top-container").css("display","block");//设定合适显示最上端按钮栏
    }
    else {
        $("#scroll-top-div").css('display', 'none');
        $("#scroll-buttom-div").css('display', 'none');
        $("#div-top-container").css("display","none");
    }
    setTimeout(getTop);//递归执行getTop（）函数
}/*控制固定位置div何时显示结束*/
function scrolltotop(){//点击按钮回到网页顶部以及底部
    $("#scroll-top-div").click(function(){
        $('body,html').animate({scrollTop:0},300);
        return false;
    });
    $("#scroll-buttom-div").click(function(){
        $('body,html').animate({scrollTop:1040},300);
        return false;
    });
};
/*判断输入内容格式是否正确*/
function text_is_right() {
    if(loginForm.name0.value==""||loginForm.tel0.value==""||loginForm.email0.value==""||loginForm.subject0.value==""||loginForm.message0.value==""){
        alert("存在未输入的项！");
        return;
    }
    if (loginForm.subject0.value!="Wireless & RFID"&&loginForm.subject0.value!="Mobile Computing"&&loginForm.subject0.value!="Wireless Sensor Network") {
        alert("科目选择不正确！");/*由于只设定这三个科目*/
        return;
    }
    loginForm.submit();
}