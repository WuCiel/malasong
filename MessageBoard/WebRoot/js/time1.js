var leftTime1 = "20:00";
    var t = "";
    function disTime1(){

          t = setTimeout("disTime1()",10);
        if(leftTime1 < "0:00"){
            return;
            // clearTimeout(t);
           }
        
        //当前时间
        var time = new Date().toLocaleString();
        // document.getElementById("nowTime").innerHTML = time;
        
        document.getElementById("leftTime1").innerHTML = leftTime1;
        
        var temp = leftTime1.split(":");
        if(temp[1] == '00'){
            temp[1] = '59';
            temp[0] = (parseInt(temp[0]) - 1) + "";
        }else{
            if(/^0[1-9]$/.test(temp[1])){
                temp[1] = temp[1].charAt(1);
            }
            temp[1] = parseInt(temp[1]) - 1;
            if(temp[1] < 10){
                temp[1] = "0" + temp[1];
            }else{
                temp[1] = temp[1] + "";    
            }
        }
        
        leftTime1 = temp.join(":");
    }
    
