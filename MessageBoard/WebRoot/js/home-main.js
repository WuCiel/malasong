/**
 * Created by Fruit Basket on 2016/3/26.
 */
window.onload = function(){//ҳ�������ɺ�ִ�к���
    readmore();
    getTop();
    scrolltotop();
    var gundong=document.getElementById('gundong');//��ȡ��ǩ������
    var list = document.getElementById('list');
    var buttons = document.getElementById('buttons').getElementsByTagName('span');//��ȡһ��spanԪ��
    var lbut = document.getElementById('lbut');
    var rbut = document.getElementById('rbut');
    var index = 0;//��¼Բ�㰴ť�������
    var i,n;
    var isrunning = false;//���ã���ҳ�����ڻ���ʱ���ٵ����ť����Ч�ģ�ִ����һ�λ���֮��ֵ��Ϊtrue����ʱ�ſ����ٰ���ť��
    var selfmove;//�趨�Զ�������
    function showbutton(index){
        for(i=0;i<buttons.length;i++){
            if(buttons[i].className == 'on'){
                buttons[i].className = '';//�������㰴ť����Ϊû������
            }
        }
        buttons[index].className='on';//�ѵ���ĵ�״��ť����Ϊon�ڵ�������ʽ
    }

    function point(move){
        isrunning = true;
        var newleft = parseInt(list.style.left)+move;//�ƶ����list�����۵���ͼƬλ��
        var time = 500;//�޶�λ����ʱ��
        var interval = 10;//λ��ʱ����
        var speed = move/(time/interval);//ÿ�ε�λ����
        function go(){
            if((speed < 0 && parseInt(list.style.left) > newleft)||(speed > 0 && parseInt(list.style.left) < newleft)){
                list.style.left = parseInt(list.style.left) + speed + 'px';
                setTimeout(go,interval);
            }//speed<0�������ƣ������ƶ������ƶ����λ��û�ﵽ�����ƶ���ɺ��λ�ã���ô�����ƶ���ͬ��speed>0,�����ƣ��ƶ���λ��û�дﵽ���۵��ƶ����ʱ��λ�ã��ͼ����ƶ���
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
    lbut.onclick = function(){//����󻬰�ť
        if(isrunning==false){//�������ִ��һ�λ�������ִ����һ�λ���������ִ�С�
            index -=1;
            if(index==-1){//����������һ�Ż���ǰ������ת�������ſ�ʼ
                index=2;
            }
            showbutton(index);//�㰴ť��������
            point(1200);//��������
        }
    }
    rbut.onclick = function(){//����һ�����ť
        if(isrunning==false){
            index +=1;
            if(index==3){//�����������»���������ת����һ�ſ�ʼ
                index=0;
            }
            showbutton(index);
            point(-1200);
        }
    }
    for(n=0;n<buttons.length;n++){
        buttons[n].onclick = function(){
            if(isrunning==false){//ͬ��������ִ��һ�ι��������ε������Ч������ִ�б��ι���
                var myindex = parseInt(this.getAttribute('index'));//�����ȡ��mydexֵҪ��buttons�����ʾ�ڼ�����ť��index��һ��
                //alert(index+"&"+myindex);
                var move = -1200*(myindex-1-index);//����֮ǰ��Բ��͵����Բ���������������һ����Ҫ�ƶ�������ֵ
                point(move);
                showbutton(myindex-1);
                index=myindex-1;//Ȼ��ǰԲ�����Ż��ɵ����Բ�����
            }
        }
    }
    function play(){
        selfmove = setInterval(rbut.onclick,4000);//ÿ��4�����һ��rub.onclick������ע�⣬�����setInterval���������޴��ظ�ִ�У���setTimeoutִ��һ�ξ�ʧЧ��֮ǰ�Ĺ���֮������һֱִ�У�����Ϊ��setTimeout���õĺ�����go�����������������ְ���setTimeout������
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


/*���ƹ̶�λ��div��ʱ��ʾ�����￪ʼ*/
function getTop() {
    var mytop = $(document).scrollTop();
    if (mytop > 200) {
        $("#scroll-top-div").css("display","block");//�趨��ʱ��ʾ��תҳ�����϶˼�ͷ
        $("#scroll-bottom-div").css("display","block");//�趨��ʱ��ʾ��תҳ�����¶˼�ͷ
        $("#top-container").css("display","block");//�趨��ʱ��ʾ���϶˰�ť��
    }
    else {
        $("#scroll-top-div").css('display', 'none');
        $("#scroll-bottom-div").css('display', 'none');
        $("#top-container").css("display","none");
    }
    setTimeout(getTop);//�ݹ�ִ��getTop��������
}/*���ƹ̶�λ��div��ʱ��ʾ����*/

function scrolltotop(){//�����ť�ص���ҳ�����Լ��ײ�
    $("#scroll-top-div").click(function(){
        $('body,html').animate({scrollTop:0},400);
        return false;
    });
    $("#scroll-bottom-div").click(function(){
        $('body,html').animate({scrollTop:1400},400);
        return false;
    });
};

function readmore(){//�����������ֽ��ܵİ�ť����ʾ�����������
    var $firstPara = $('#p-hide');//�Եڰ˸�p��ǩ���ֽ�������
    $firstPara.hide();
    $('.more').click(function(){
        if($firstPara.is(':hidden')){
            $firstPara.fadeIn('slow');
            $('.more').text('read less');
        }else{
            $firstPara.fadeOut('slow');
            $('.more').text('read more');
        }
        return false;   //����a��ǩ�е�href����Ч��
    });
}