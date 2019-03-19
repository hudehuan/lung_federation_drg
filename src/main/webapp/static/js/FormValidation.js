		
		
		//必填项的函数
		function required(id){
			if($("#"+id).val()=="undefined" || $('#' + id).val()==""){

     				$('#' + id).validationEngine('showPrompt', '*此项必填', 'error', true);

					empty+=id+"0,";
				}
				else{
					empty+=id+"1,";
				}						
		}
		function required_radio(name){
			if($('input[type="radio"][name='+name+']').length!=0){
				if ($('input[type="radio"][name='+name+']:checked').length==0) {				
				var id=$("input:radio[name="+name+"]").attr("id");
				$("#" + id).validationEngine('showPrompt', '*此项必填', 'error', true);
					empty+=name+"0,";
				}else{
					empty+=name+"1,";
				}
			}
			else
			 empty+=name+"0,";
		}
 		 function  compare(sDate1, sDate2) {
                var aDate, oDate1, oDate2, iDays;
                aDate = sDate1.split("-");
                oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]);    //转换为12-18-2006格式  
                aDate = sDate2.split("-");
                oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]);
                iDays = (parseInt(oDate1 - oDate2) / 1000 / 60 / 60 / 24);    //把相差的毫秒数转换为天数  
                return iDays;
        }
  		
//		在入院和出院之间	
		function near(id,name){
			if($('#'+id).val()!="undefined"){
				if(
					(compare($("#"+id).val(),$("#cysj").val())>0)||(compare($("#"+id).val(),$("#rysj").val())<0)
				){
					$("#"+id).validationEngine('showPrompt', '*'+name+'应该在入院时间和出院院时间之间', 'error', true);
					empty+="0,";
				}
				else{
					empty+="1,";
				}
			}
		}
		//在num1 和num2之间
		function num_range(id,num1,num2,str){
			var value=$("#"+id).val();
			if((!value=="")&&((value<num1)||(value>num2))){
				$("#"+id).validationEngine('showPrompt', '*'+str+'应该在'+num1+'和'+num2+'之间', 'error', true);
				empty+="0,";
			}
				else{
					empty+="1,";
				}
			
		}
		function num_max(id,num1,str){
			var value=$("#"+id).val();
				if(value<num1){ //必须大于某个数
					$("#"+id).validationEngine('showPrompt', '*'+str+'应该大于等于'+num1, 'error', true);
					empty+="0,";
				}
		}
		function num_min(id,num1,str){
			var value=$("#"+id).val();
				if(value>num1){ //必须大于某个数
					$("#"+id).validationEngine('showPrompt', '*'+str+'应该小于等于'+num1, 'error', true);
					empty+="0,";
				}
		}
//		检验是否保留两位小数
		
		function keep_num(id,num){
			if(value==" "){return ;}
			var value=$("#"+id).val();
			if((value.indexOf(".")!=-1)&&(value.length-value.indexOf(".")>num+1)){
				$("#"+id).validationEngine('showPrompt', '*应保留'+num+'位小数', 'error', true);
			}
		}

		//修改控件的readonly状态
  		function set_readonly(id,isreadonly) {
            $("#"+id).attr("readonly",isreadonly)//将input元素设置为readonly
        }


        function set_show(id,isshow) {

            $("#divvcl_"+id).css('display',isshow);
            //$("#id").css('display','none'); //隐藏
            //$("#id").css('display', 'block'); //显示
        }


        function  regExp_check(id,regexp) {

            var value=$("#"+id).val();
            var re=new RegExp(regexp);
			if(re.test(value) == false){

                $("#" + id).validationEngine('showPrompt', '*此项格式错误', 'error', true);
                empty+="0,";
			}
			else{
                empty+="1,";
			}
        }