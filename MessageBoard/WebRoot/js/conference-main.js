/**
 * Created by Fruit Basket on 2016/3/26.
 */
window.onload = function(){//ҳ�������ɺ�ִ�к���
    getTop();
    scrolltotop();
}
/*���ƹ̶�λ��div��ʱ��ʾ�����￪ʼ*/
function getTop() {
    var mytop = $(document).scrollTop();
    if (mytop > 200) {
        $("#scroll-top-div").css("display","block");//�趨��ʱ��ʾ��תҳ�����϶˼�ͷ
        $("#scroll-bottom-div").css("display","block");//�趨��ʱ��ʾ��תҳ�����¶˼�ͷ
        $("#top-container").css("display","block");//�趨������ʾ���϶˰�ť��
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
        $('body,html').animate({scrollTop:0},300);
        return false;
    });
    $("#scroll-bottom-div").click(function(){
        $('body,html').animate({scrollTop:1200},300);
        return false;
    });
};