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
    if (mytop > 50) {
        $("#scroll-top-div").css("display","block");//�趨��ʱ��ʾ��תҳ�����϶˼�ͷ
        $("#scroll-buttom-div").css("display","block");//�趨��ʱ��ʾ��תҳ�����¶˼�ͷ
        $("#div-top-container").css("display","block");//�趨������ʾ���϶˰�ť��
    }
    else {
        $("#scroll-top-div").css('display', 'none');
        $("#scroll-buttom-div").css('display', 'none');
        $("#div-top-container").css("display","none");
    }
    setTimeout(getTop);//�ݹ�ִ��getTop��������
}/*���ƹ̶�λ��div��ʱ��ʾ����*/
function scrolltotop(){//�����ť�ص���ҳ�����Լ��ײ�
    $("#scroll-top-div").click(function(){
        $('body,html').animate({scrollTop:0},300);
        return false;
    });
    $("#scroll-buttom-div").click(function(){
        $('body,html').animate({scrollTop:1040},300);
        return false;
    });
};
/*�ж��������ݸ�ʽ�Ƿ���ȷ*/
function text_is_right() {
    if(loginForm.name0.value==""||loginForm.tel0.value==""||loginForm.email0.value==""||loginForm.subject0.value==""||loginForm.message0.value==""){
        alert("����δ������");
        return;
    }
    if (loginForm.subject0.value!="Wireless & RFID"&&loginForm.subject0.value!="Mobile Computing"&&loginForm.subject0.value!="Wireless Sensor Network") {
        alert("��Ŀѡ����ȷ��");/*����ֻ�趨��������Ŀ*/
        return;
    }
    loginForm.submit();
}