<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- 打印管理界面2，无法打印翻转的图片，先获取数据（检测是否打印过，并给出提示），再用数据生成打印界面 -->
<!-- 打印操作台-->
<div style="width:100%;height:15%;float:left">
    <!--空白-->
    <div style="width:100%;height:20px;float:left;"></div>
    <!--获取数据，上传数据的按钮等-->
    <div style="width:80%;height:120px;margin:auto">
        <div style="width:50%;height:100%;float:left">
            <button style="float:left">获取接口打印数据</button>
            <div style="width:20px;height:20px;float:left"></div>
            <form name="getPrintInfo" enctype="multipart/form-data" style="float:left;">
                <span class="pStyle" style="float:left;">选择文件:</span>
                <input type="file" id="file1" style="float:left;">
                <div style="width:20px;height:20px;float:left;"></div>
                <input type="button" value="上传" onclick="getPrintDataByExcel()">
            </form>
            <div style="width:100%;height:10px;float:left;"></div>
            <span class="pStyle" style="float:left">选择一个样式:</span>
            <select id="qrcodestyles" style="float:left" onchange="getStyle()"></select>
            <button style="float:left" onclick="printLabels()">打印</button>
            <div style="width:100%;height: 5px;float:left;"></div>
            <span class="pStyle" style="float:left">上传文件重置打印次数:</span>
            <form name="resetprint" enctype="multipart/form-data" style="float:left">
                <input type="file" id="file2" style="float:left">
                <input type="button" value="上传" onclick="resetPrint()">
            </form>     
        </div>
        <div id="messages" style="width:50%;height:100%;float:left;background-color: azure;overflow-y: auto;">
        </div>
    </div>
</div>
<!--打印主界面-->
<div style="width:100%;height:70%;;margin:auto;float: left;">
    <div id="printArea" style="width:80%;height:100%;margin: auto;background-color: azure;overflow-y: auto;"></div>

</div>
<div style="width:80%;margin:auto">
    <div class='pStyle' style="float:left;"><a href="./files/QRCodeDataTemplate.xls" download="QRCodeDataTemplate.xls">EXCEL导入模板</a>&nbsp;&nbsp;</div>
    <div class='pStyle' style="float:left;"><a href="./files/ResetPrintTemplate.xls" download="ResetPrintTemplate.xls">重置打印次数模板</a></div>
</div>

<script type="text/javascript">
    // 公共变量
    function checkAuthority(au){
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for(var i = 0; i < authority.length; i++){
            if(authority[i].fa_name == au) flag = true;
        }
        return flag;
    }
    if(!checkAuthority("打印二维码标签")){
        window.alert("您无打印二维码标签的权限")
        window.history.go(-1)
    }
    var dataReady = false           // 数据是否准备完毕
    var styleReady = false          // 样式是否选择完毕
    var fieldmap = {}              // 字段映射
    var pdata = []                   // 数据
    //dataReady = true
    //checkdata()
    var qrstyle = {}                // 二维码样式
    getStyleList()
    getFieldMap()

    //printData()
    // 函数
    // 获取所有样式并放入select
    function getStyleList(){
        var fieldNames = {
            qrcode_id:"INT",
            qrcode_name:"STRING"
        }
        $.ajax({
            url:"http://8.142.26.93:8989/DuiMa_war_exploded/QuerySQL",
            type:'post',
            dataType:'json',
            contentType:'application/x-www-form-urlencoded;charset=utf-8',
            data:{
                sqlStr: "select qrcode_id, qrcode_name from qrcode where qrcode_status=1;",
                fieldNames:JSON.stringify(fieldNames),
                pageCur:1,
                pageMax:1000
            },
            success:function(res){
                var jsonobj = JSON.parse(res.data);
                var qrcodestyles = document.getElementById("qrcodestyles")
                for(var i = 0; i < jsonobj.length; i++){
                    qrcodestyles.options.add(new Option(jsonobj[i].qrcode_name,jsonobj[i].qrcode_id))
                }
                // 测试
                //getStyle()
            },
            error:function(message){
                console.log(message)
            }
        })
    }
    // 获取样式
    function getStyle(){
        // 把样式设定为目前选中的样式
        var qrcodeid = $("#qrcodestyles :selected").val()
        console.log(qrcodeid)
        var fieldNames = {
            qrcode_content:"STRING"
        }
        $.ajax({
            url:"http://8.142.26.93:8989/DuiMa_war_exploded/QuerySQL",
            type:'post',
            dataType:'json',
            contentType:'application/x-www-form-urlencoded;charset=utf-8',
            data:{
                sqlStr: "select qrcode_content from qrcode where qrcode_id="+qrcodeid+";",
                fieldNames:JSON.stringify(fieldNames),
                pageCur:1,
                pageMax:1000
            },
            success:function(res){
                var datatmp = JSON.parse(res.data)[0]
                qrstyle = JSON.parse(datatmp.qrcode_content)
                console.log(qrstyle)
		styleReady = true
                printData()
            },
            error:function(message){
                console.log(message)
            }
        })

    }

    // 在打印区域生成内容
    // 每个子div都需要style="page-break-after:always;"
    function printData(){
        if(!styleReady){
            window.alert("加载中，请过几秒再尝试一次!")
            return
        }
        if(!dataReady){
            window.alert("未加载数据，请从接口获取数据或者上传excel!")
            return
        }
        var startStr = "<!--startprint-->"
        var endStr = "<!--endprint-->"
        // 获取样式中的长宽
        var xsize = qrstyle.xsize
        var ysize = qrstyle.ysize
        var startitem = $(startStr)
        $("#printArea").empty()
        $("#printArea").append(startitem)
        console.log("data length:"+window.pdata.length)
        for(var i = 0; i < window.pdata.length; i++){
            console.log("loop "+i)
            // 已判断是否都已获取
            // 先填充内容，后设置位置
            var item = "<div style='page-break-after:always;position:relative;width:"+xsize+"px;height:"+ysize+"px;'>"
            // start
            // 放置二维码,后续需要往里面填充内容
            var xsituation = qrstyle.qRCode['xsituation']
            var ysituation = qrstyle.qRCode['ysituation']
            item += "<div id='qrcode_"+i+"' style='position: absolute;width:150px;height:150px;left:"+xsituation+"px;top:"+ysituation+"px;'></div>"
            // 放置其他各项
            for(var j = 0; j < qrstyle.items.length; j++){
                var node = qrstyle.items[j]
                var nodevalue = node.content;
                xsituation = node.xsituation
                ysituation = node.ysituation
                console.log(window.pdata[i])
                var nodestr = fieldmap[nodevalue] + ":" + window.pdata[i][nodevalue]
                item += "<span class='pStyle' style='position: absolute;left:"+xsituation+"px;top:"+ysituation+"px;'>" + nodestr + "</span>"
            }
            // end
            item += "</div>"
            var newItem = $(item)
            $("#printArea").append(newItem)
            // 设置二维码内容
            var qrcodeContent = ""
            console.log(qrstyle)
            console.log(qrstyle.qRCode.qRCodeContent)
            var tmp = qrstyle.qRCode.qRCodeContent
            for(var j = 0; j < tmp.length; j++){
                qrcodeContent += fieldmap[tmp[j]] + ":" + window.pdata[i][tmp[j]] + "\n"
            }
            getQRCode(i,qrcodeContent)
        }
        var enditem = $(endStr)
        $("#printArea").append(enditem)
    }

    function getQRCode(idx,str){
        new QRCode(document.getElementById("qrcode_"+idx),{
            text:str,
            width:150,
            height:150,
            colorDark:"#000000",
            colorLight:"#ffffff",
            correctLevel : QRCode.CorrectLevel.H
        })
    }
    // 打印标签
    function printLabels(){
        var bdhtml = window.document.body.innerHTML;
        var sprnstr = "<!--startprint-->";
        var eprnstr = "<!--endprint-->";
        var prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr)+17);
        prnhtml = prnhtml.substring(0,prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML=prnhtml;
        window.print();
        window.document.body.innerHTML=bdhtml;
    }

    // 获取字段映射
    function getFieldMap(){
        var fieldNames = {
            pi_key : "STRING",
            pi_value : "STRING"
        }
        $.ajax({
            url:"http://8.142.26.93:8989/DuiMa_war_exploded/QuerySQL",
            type:'post',
            dataType:'json',
            contentType:'application/x-www-form-urlencoded;charset=utf-8',
            data:{
                sqlStr: "select pi_key,pi_value from project_item;",
                fieldNames:JSON.stringify(fieldNames),
                pageCur:1,
                pageMax:1000
            },
            success:function(res){
                var jsonobj = JSON.parse(res.data)
                fieldmap = {}
                for(var i = 0; i < jsonobj.length; i++){
                    fieldmap[jsonobj[i].pi_key] = jsonobj[i].pi_value
                }
                console.log(fieldmap)
            }
        })
    }
    function getPrintDataByExcel(){
        var type="file";
        var formData = new FormData();
        formData.append(type,$("#file1")[0].files[0]);
        $.ajax({
            url:"http://8.142.26.93:8989/DuiMa_war_exploded/GetPrintDataByExcel",
            type:'post',
            data:formData,
            processData:false,
            contentType:false,
            success:function(res){
                console.log(res)
                console.log(JSON.parse(res))
                var jsonobj = JSON.parse(res)
	        console.log(jsonobj.data)
	        console.log(jsonobj.info)
	        window.pdata = []
	    console.log(jsonobj.data.length)

	    for(var i = 0; i < jsonobj.data.length; i++){
	        console.log(jsonobj.data[i]);
	        window.pdata.push(jsonobj.data[i]);
	    }
                console.log(window.pdata)
                // 完成后自动触发生成标签
                checkdata()
            },
            error:function(message){
                console.log(message)
            }
        })
    }
    function resetPrint(){
        if(!checkAuthority("重置打印次数")){
            window.alert("您无重置打印次数的权限")
            return
        }
        var type="file";
        var formData = new FormData();
        formData.append(type,$("#file2")[0].files[0]);
        $.ajax({
            url:"http://8.142.26.93:8989/DuiMa_war_exploded/ResetPrint",
            type:'post',
            data:formData,
            processData:false,
            contentType:false,
            success:function(res){
                console.log(res)
                $("#messages").html(res)
            },
            error:function(message){
                console.log(message)
            }
        })
    }
    function checkdata(){
        var productids = []
	console.log(window.pdata.length)

        for(var i = 0; i < window.pdata.length; i++){
            productids.push(window.pdata[i].productId)
        }
	console.log(productids)
	console.log(window.pdata.length)
        $.ajax({
            url:"http://8.142.26.93:8989/DuiMa_war_exploded/PrintProduct",
            type:'post',
            dataType:'json',
            contentType:'application/x-www-form-urlencoded;charset=utf-8',
            data:{
                id:sessionStorage.getItem("userId"),
                name:sessionStorage.getItem("userName"),
                productIds:JSON.stringify(productids)
            },
            success:function(res){
                console.log(res)
                $("#messages").html(res.message)
                var jsonobj = JSON.parse(res.data)
                console.log(jsonobj)
                // 原来的data中去除已打印部分
                var deleteidxs = []     // 需要删除的下标
                for(var i = 0; i < window.pdata.length; i++){
                    var flag = true
                    for(var j =0 ; j < jsonobj.length; j++){
                        if(window.pdata[i].productId ==jsonobj[j]) flag = false;
                    }
                    if(flag) deleteidxs.push(i)
                }
                for(var i = deleteidxs.length-1; i >= 0; i--){
                    window.pdata.splice(deleteidxs[i],1)
                }
	    	dataReady = true
	        console.log(pdata)
                getStyle()
            },
            error:function(message){
                console.log(message)
            }
        })
    }
</script>
