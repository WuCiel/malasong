/**
 * Created by Fruit Basket on 2016/3/26.
 */
window.onload = function(){//页面加载完成后执行函数
    readmore();
    getTop();
    scrolltotop();
    var gundong=document.getElementById('gundong');//获取标签的内容
    var list = document.getElementById('list');
    var buttons = document.getElementById('buttons').getElementsByTagName('span');//获取一组span元素
    var lbut = document.getElementById('lbut');
    var rbut = document.getElementById('rbut');
    var index = 0;//记录圆点按钮数组序号
    var i,n;
    var isrunning = false;//作用：当页面正在滑动时，再点击按钮是无效的，执行完一次滑动之后，值变为true，这时才可以再按按钮。
    var selfmove;//设定自动滚动用
    function showbutton(index){
        for(i=0;i<buttons.length;i++){
            if(buttons[i].className == 'on'){
                buttons[i].className = '';//把其他点按钮设置为没有属性
            }
        }
        buttons[index].className='on';//把点击的点状按钮设置为on内的属性样式
    }

    function point(move){
        isrunning = true;
        var newleft = parseInt(list.style.left)+move;//移动后的list的理论的新图片位置
        var time = 500;//限定位移总时间
        var interval = 10;//位移时间间隔
        var speed = move/(time/interval);//每次的位移量
        function go(){
            if((speed < 0 && parseInt(list.style.left) > newleft)||(speed > 0 && parseInt(list.style.left) < newleft)){
                list.style.left = parseInt(list.style.left) + speed + 'px';
                setTimeout(go,interval);
            }//speed<0即向右移，并且移动距离移动后的位置没达到理论移动完成后的位置，那么继续移动。同理，speed>0,向左移，移动后位置没有达到理论的移动完成时的位置，就继续移动。
            else{
                isrunning = false;
                list.style.left=newleft+'px';
                if(newleft>-1200){
                    list.style.left = -3600+'px';
                }
                if(newleft<-3600){
                    list.style.left= -1200+'px';
                }
            }
        }
        go();
    }
    lbut.onclick = function(){//点击左滑按钮
        if(isrunning==false){//如果正在执行一次滑动，则不执行这一次滑动，否则执行。
            index -=1;
            if(index==-1){//若滚动到第一张还向前滚，就转到第四张开始
                index=2;
            }
            showbutton(index);//点按钮操作函数
            point(1200);//滚动函数
        }
    }
    rbut.onclick = function(){//点击右滑动按钮
        if(isrunning==false){
            index +=1;
            if(index==3){//若滚到第五章还向后滚，就转到第一张开始
                index=0;
            }
            showbutton(index);
            point(-1200);
        }
    }
    for(n=0;n<buttons.length;n++){
        buttons[n].onclick = function(){
            if(isrunning==false){//同理，若正在执行一次滚动，本次点击则无效，否则执行本次滚动
                var myindex = parseInt(this.getAttribute('index'));//这里获取的mydex值要比buttons数组表示第几个按钮的index大一。
                //alert(index+"&"+myindex);
                var move = -1200*(myindex-1-index);//根据之前的圆点和点击的圆点序号相减，计算出一共需要移动的像素值
                point(move);
                showbutton(myindex-1);
                index=myindex-1;//然后当前圆点的序号换成点击的圆点序号
            }
        }
    }
    function play(){
        selfmove = setInterval(rbut.onclick,4000);//每隔4秒调用一次rub.onclick函数。注意，这里的setInterval函数是无限次重复执行，而setTimeout执行一次就失效，之前的滚动之所以能一直执行，是因为，setTimeout调用的函数是go（）函数，函数中又包含setTimeout函数。
    }
    function stop(){
        clearInterval(selfmove);
    }
    gundong.onmouseover = stop;
    gundong.onmouseout = play;
}
$(document).ready(function(){
    $("#div1 li").mousemove(function(){
        $(this).find('ul').slideDown('1000');
    });
    $("#div1 li").mouseleave(function(){
        $(this).find('ul').slideUp('1000');
    });
});


/*控制固定位置div何时显示从这里开始*/
function getTop() {
    var mytop = $(document).scrollTop();
    if (mytop > 200) {
        $("#scroll-top-div").css("display","block");//设定何时显示跳转页面最上端剪头
        $("#scroll-bottom-div").css("display","block");//设定何时显示跳转页面最下端剪头
        $("#top-container").css("display","block");//设定何时显示最上端按钮栏
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
        $('body,html').animate({scrollTop:0},400);
        return false;
    });
    $("#scroll-bottom-div").click(function(){
        $('body,html').animate({scrollTop:1400},400);
        return false;
    });
};

function readmore(){//点击最后面文字介绍的按钮，显示更多段落文字
    var $firstPara = $('#p-hide');//对第八个p标签文字进行隐藏
    $firstPara.hide();
    $('.more').click(function(){
        if($firstPara.is(':hidden')){
            $firstPara.fadeIn('slow');
            $('.more').text('read less');
        }else{
            $firstPara.fadeOut('slow');
            $('.more').text('read more');
        }
        return false;   //屏蔽a标签中的href链接效果
    });
}