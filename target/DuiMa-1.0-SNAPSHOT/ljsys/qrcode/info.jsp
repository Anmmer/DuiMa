<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    // 获取二维码编号
    function getQueryVariable(variable){
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for(var i=0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            if(pair[0] == variable) return pair[1];
        }
        return(false);
    }
    function checkAuthority(au){
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for(var i = 0; i < authority.length; i++){
            if(authority[i].fa_name == au) flag = true;
        }
        return flag;
    }
    if(!checkAuthority("查看二维码样式")){
        window.alert("您无查看二维码样式的权限")
        window.history.go(-1)
    }
    var qrcodeId = getQueryVariable("qrcodeId");
    var qrcodeName = decodeURIComponent(getQueryVariable("qrcodeName"))
</script>
<!--版面样式-->
<div style="height: 95%;width:100%;background-color:white;">
    <!--控制台-->
    <div style="height:100%;width:49%;float: left;">
        <div style="height:30px;width:100%;float:left;"></div>
        <!--信息展示-->
        <div style="height:80px;width:100%;float:left;">
            <span class="pStyle">二维码样式编号:</span><span class="pStyle" id="qrcodeId"></span><br />
            <span class="pStyle">二维码样式名:</span><span class="pStyle" id="qrcodeName"></span>
        </div>
        <!--控制台-->
        <div style="height:100px;width:100%;float:left;">
            <span class="pStyle">画布横宽:</span><input type="text" id="xsize"><br/>
            <span class="pStyle">画布纵长:</span><input type="text" id="ysize"><br/><br/>
            <button type="button" onclick="submitQRcode()">提交修改</button><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <button type="button" onclick="deleteStyle()">删除该样式</button><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <button type="button" onclick="newItem()">新增一项</button>
            <select id="itemNames">
            </select>
        </div>
        <!--列表台-->
        <div style="height:600px;width: 100%;float:left;overflow-y: auto;" id="ItemList">
            <div style="height:100px;width:100%;float:left">
                <select id="valuesFrom" size="4" style="width:100px;">
                </select>
                <button type="button" onclick="addContent()">添加</button>
                <select id="valuesTo" size="4" style="width:100px;">
                </select>
                <button type="button">删除</button>
            </div>
        </div>
    </div>
    <div style="height:100%;width:2px;background-color:black;float:left;"></div>
    <div style="height:100%;width:50%;background-color: rgb(224, 221, 221);float: left;">
        <div id="draw" style="height:600px;width:400px;background-color: white;position:relative;"></div>
    </div>
</div>
<button type="button" onclick="printLabel()">打印</button>
<script type="text/javascript">
    var Aflag = false
    var fields = {
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
            fieldNames:JSON.stringify(fields),
            pageCur:1,
            pageMax:1000
        },
        success:function(res){
            var jsonobj = JSON.parse(res.data)
            for(var i = 0; i < jsonobj.length; i++){
                var select1 = $("#valuesFrom")
                var select2 = $("#itemNames")
                var item1 = $("<option value='"+jsonobj[i]['pi_key']+"'>"+jsonobj[i]['pi_value']+"</option>")
                var item2 = $("<option value='"+jsonobj[i]['pi_key']+"'>"+jsonobj[i]['pi_value']+"</option>")
                select1.append(item1)
                select2.append(item2)
            }
            startpage()
        },
        error:function(message){
            console.log(message)
        }
    })
    // 两个Select增加Option
    var itemlist = []                   // 放置编号
    var itemValues = []                 // 放置值
    $("#qrcodeId").text(qrcodeId)
    $("#qrcodeName").text(qrcodeName)
    $("#xsize").val("400")
    $("#ysize").val("600")
    // 新增设置宽高
    $("#xsize").bind("blur",function(event){
        var elem = event.target
        var newXsize = $("#xsize").val()
        document.getElementById("draw").style.width = newXsize + "px"
    })
    $("#ysize").bind("blur",function(event){
        var elem = event.target
        var newYsize = $("#ysize").val()
        document.getElementById("draw").style.height = newYsize + "px"
    })
    var cnt = 0;
    var oldxposition = 0;
    var oldyposition = 0;
    // 新增一项,写入其中文属性值以及其绑定的属性值
    function newItem(){
        // 获取新插入值的name和 value
        var itemValue = $("#itemNames option:checked").text()
        var itemName = $("#itemNames option:checked").val()
        // 在ItemList中新增一项
        var divstr = $("<div style='width:100%;height:80px;float:left;' id='item"+cnt+"'><div>");
        $("#ItemList").append(divstr)
        // 新增item中的元素
        var contentspan = $("<span class='pStyle'></span>").text("设计项名称:")
        var content = $("<span class='pStyle' id='content"+cnt+"'></span>").text(itemValue)
        var xspan = $("<span class='pStyle'></span>").text("X坐标:")
        var xvalue = $("<input type='text' id='xvalue"+cnt+"'>")
        xvalue.bind("blur",function(event){
            // 修改内容则修改draw
            // 获取编号
            var elem = event.target
            var id = elem.id.substring(6,elem.id.length)
            var drawelem = document.getElementById("draw"+id)
            console.log($("#"+elem.id).val())
            drawelem.style.left = $("#"+elem.id).val()+"px"
        })
        var yspan = $("<span class='pStyle'></span>").text("Y坐标:")
        var yvalue = $("<input type='text' id='yvalue"+cnt+"'>")
        yvalue.bind("blur",function(event){
            var elem = event.target
            var id = elem.id.substring(6,elem.id.length)
            var drawelem = document.getElementById("draw"+id)
            drawelem.style.top = $("#"+elem.id).val()+"px"
        })
        var itemButton = $("<button type='button' id='button"+cnt+"'>删除该项</button>")
        // 删除事件
        itemButton.bind("click",function(event){
            var targetid = event.target.id
            var id = targetid.substring(6,targetid.length)
            // 查找元素
            var idx = -1;
            for(var i = 0; i < itemlist.length; i++){
                if(itemlist[i] == id) {
                    idx = i;
                    break;
                }
            }
            if(idx != -1){
                itemlist.splice(idx,1)
                itemValues.splice(idx,1)
            }
            console.log(itemlist)
            // 删除元素
            var fa = document.getElementById("ItemList")
            var child = document.getElementById("item"+id)
            fa.removeChild(child)
            fa = document.getElementById("draw")
            child = document.getElementById("draw"+id)
            fa.removeChild(child)
            
        })
        $("#item"+cnt).append(contentspan,content,xspan,xvalue,yspan,yvalue,itemButton)
        // 画布上新增
        var drawItem = $("<span class='pStyle' style='position: absolute;' draggable='true' id='draw"+cnt+"'></span>").text(itemValue+":"+"TEST");
        $("#draw").append(drawItem);
        var drawElem = document.getElementById("draw"+cnt)
        drawElem.style.left = "0px"
        drawElem.style.top = "0px"
        // 添加事件
        $("#draw"+cnt).bind("dragstart",function(event){
            oldxposition = event.pageX
            oldyposition = event.pageY
            var targetid = event.target.id
            console.log("drag " + targetid + " start !")
            console.log("X:"+oldxposition)
            console.log("Y:"+oldyposition)
        })
        $("#draw"+cnt).bind("dragend",function(event){
            console.log("====================")
            var Xoffset = event.pageX-oldxposition
            var Yoffset = event.pageY-oldyposition
            var elem = event.target
            var xbd = elem.style.left
            var ybd = elem.style.top
            var xtmp = parseInt(xbd.substring(0,xbd.length-2))
            var ytmp = parseInt(ybd.substring(0,ybd.length-2))
            xtmp = xtmp + Xoffset
            ytmp = ytmp + Yoffset
            elem.style.top = ytmp+"px"
            elem.style.left = xtmp + "px"
            // 设置控制组内的
            var itemId = elem.id.substring(4,elem.id.length)
            // 设置输入框
            $("#xvalue"+itemId).val(xtmp)
            $("#yvalue"+itemId).val(ytmp)
        })
        // 将编号写入itemlist中
        itemlist.push(cnt+"")
        itemValues.push(itemName)
        cnt = cnt + 1;
    }
    function addQRcode(){
        // 新增QRCode的图片
        // 获取新插入值的name和 value
        // 在ItemList中新增一项
        var divstr = $("<div style='width:100%;height:80px;float:left;' id='item"+cnt+"'><div>");
        $("#ItemList").append(divstr)
        // 新增item中的元素
        var xspan = $("<span class='pStyle'></span>").text("X坐标:")
        var xvalue = $("<input type='text' id='xvalue"+cnt+"'>")
        xvalue.bind("blur",function(event){
            // 修改内容则修改draw
            // 获取编号
            var elem = event.target
            var id = elem.id.substring(6,elem.id.length)
            var drawelem = document.getElementById("draw"+id)
            console.log($("#"+elem.id).val())
            drawelem.style.left = $("#"+elem.id).val()+"px"
        })
        var yspan = $("<span class='pStyle'></span>").text("Y坐标:")
        var yvalue = $("<input type='text' id='yvalue"+cnt+"'>")
        yvalue.bind("blur",function(event){
            var elem = event.target
            var id = elem.id.substring(6,elem.id.length)
            var drawelem = document.getElementById("draw"+id)
            drawelem.style.top = $("#"+elem.id).val()+"px"
        })
        $("#item"+cnt).append(xspan,xvalue,yspan,yvalue)
        // 画布上新增
        var drawItem = $("<img src='./pictures/qrcode.png' style='position: absolute;'  draggable='true' id='draw"+cnt+"' />");
        $("#draw").append(drawItem);
        var drawElem = document.getElementById("draw"+cnt)
        drawElem.style.left = "0px"
        drawElem.style.top = "0px"
        // 添加事件
        $("#draw"+cnt).bind("dragstart",function(event){
            oldxposition = event.pageX
            oldyposition = event.pageY
            var targetid = event.target.id
            console.log("drag " + targetid + " start !")
            console.log("X:"+oldxposition)
            console.log("Y:"+oldyposition)
        })
        $("#draw"+cnt).bind("dragend",function(event){
            console.log("====================")
            var Xoffset = event.pageX-oldxposition
            var Yoffset = event.pageY-oldyposition
            var elem = event.target
            var xbd = elem.style.left
            var ybd = elem.style.top
            var xtmp = parseInt(xbd.substring(0,xbd.length-2))
            var ytmp = parseInt(ybd.substring(0,ybd.length-2))
            xtmp = xtmp + Xoffset
            ytmp = ytmp + Yoffset
            elem.style.top = ytmp+"px"
            elem.style.left = xtmp + "px"
            // 设置控制组内的
            var itemId = elem.id.substring(4,elem.id.length)
            // 设置输入框
            $("#xvalue"+itemId).val(xtmp)
            $("#yvalue"+itemId).val(ytmp)
        })
        // 将编号写入itemlist中
        itemlist.push(cnt+"")
        itemValues.push("qrcode")
        cnt = cnt + 1;
    }
    // 面板设置ajax读取,如果qrcode_content有数据则根据数据来，否则直接增加二维码
    console.log(qrcodeId)
    function startpage(){
        $.ajax({
            url:"http://8.142.26.93:8989/DuiMa_war_exploded/GetQRCode",
            type:'post',
            dataType:'json',
            contentType:'application/x-www-form-urlencoded;charset=utf-8',
            data:{
                qrcodeId:qrcodeId
            },
            success:function(res){
                console.log(res)
                if(res==null) addQRcode();
                else{
                    // res即最终的qrcodestyle
                    // 构建图画
                    // 设置画布
                    var draw = document.getElementById("draw")
                    draw.style.height = res.ysize + "px"
                    draw.style.width = res.xsize + "px"
                    $("#xsize").val(res.xsize)
                    $("#ysize").val(res.ysize)
                    // 设置二维码
                    addQRcode();
                    // 设置二维码位置
                    var drawtmp = document.getElementById("draw0")
                    drawtmp.style.left = res.qRCode.xsituation + "px"
                    drawtmp.style.top = res.qRCode.ysituation + "px"
                    // 设置二维码内容
                    for(var i = 0; i < res.qRCode.qRCodeContent.length; i++) {
                        var valuestmp = document.getElementById("valuesFrom")
                        var valueslen = valuestmp.length
                        for(var j = 0; j < valueslen; j++){
                            if(valuestmp.options[j].value == res.qRCode.qRCodeContent[i]){
                                // 值相等
                                var newOption = $("<option></option>").attr("value",valuestmp.options[j].value)
                                newOption.text(valuestmp.options[j].text)
                                $("#valuesTo").append(newOption)
                            }
                        }
                    }
                    // 设置控制面板二维码数值
                    $("#xvalue0").val(res.qRCode.xsituation)
                    $("#yvalue0").val(res.qRCode.ysituation)
                    // 设置子项
                    for(var i = 0; i < res.items.length; i++){
                        var valuestmp = document.getElementById("itemNames")
                        var valueslen = valuestmp.length
                        for(var j = 0; j < valueslen; j++) {
                            console.log("v:"+valuestmp.options[j].value)
                            console.log("c:"+res.items[i].content)
                            if(valuestmp.options[j].value == res.items[i].content) {
                                valuestmp.options[j].selected = true
                                newItem()
                                // 设置新项的位置
                                var cnttmp = cnt - 1
                                console.log(cnttmp)
                                var drawtmp = document.getElementById("draw"+cnttmp)
                                drawtmp.style.left = res.items[i].xsituation + "px"
                                drawtmp.style.top = res.items[i].ysituation + "px"
                                $("#xvalue"+cnttmp).val(res.items[i].xsituation)
                                $("#yvalue"+cnttmp).val(res.items[i].ysituation)
                            }
                        }
                    }
                }
            }
        })        
    }

    function submitQRcode(){
        if(!checkAuthority("修改二维码样式")){
            window.alert("您无修改二维码样式的权限!")
            return;
        }
        // 点击提交的事件
        console.log(itemlist)
        var qrcodestyle = {}
        qrcodestyle['xsize']=$("#xsize").val()
        qrcodestyle['ysize']=$("#ysize").val()
        var qRCode = {}
        var contentlist = 
        qRCode['qRCodeContent'] = []
        var len = document.getElementById("valuesTo").length
        for(var i = 0; i < len; i++){
            qRCode['qRCodeContent'].push(document.getElementById("valuesTo").options[i].value)
            console.log(document.getElementById("valuesTo").options[i].value)
        }
        qRCode['xsituation'] = $("#xvalue0").val()
        qRCode['ysituation'] = $("#yvalue0").val()  
        qrcodestyle['qRCode'] = qRCode
        // 设置items
        var items = []
        for(var i = 1; i < itemlist.length; i++) {  // 从1开始
            var item = {}
            var idxtmp = parseInt(itemlist[i])
            item['content'] = itemValues[i]
            item['xsituation'] = $("#xvalue"+idxtmp).val()
            item['ysituation'] = $("#yvalue"+idxtmp).val()
            items.push(item)
            console.log(itemValues[i])
        }
        qrcodestyle['items'] = items;
        console.log(len)
        console.log(qrcodestyle)
        var qrcodestylestr = JSON.stringify(qrcodestyle)
        $.ajax({
            url:"http://8.142.26.93:8989/DuiMa_war_exploded/SetQRCode",
            type:'post',
            dataType:'json',
            contentType:'application/x-www-form-urlencoded;charset=utf-8',
            data:{
                qrcodeId: qrcodeId,
                qrcodestyle:qrcodestylestr
            },
            success:function(res){
                console.log(res)
            }
        })

    }
    function addContent(){
        // 添加内容
        var selectedValue = $("#valuesFrom").val();
        var selectedContent = $("#valuesFrom option:selected").text();
        console.log(selectedValue)
        console.log(selectedContent)
        var newOption = $("<option></option>").attr("value",selectedValue)
        newOption.text(selectedContent)
        $("#valuesTo").append(newOption);
    }
    function printLabel(){
        data1 = {
            qrcodeId:1,
            list:[
                {
                    productId : "product1",
                    projectName : "扬子津改造项目",
                    produceTime : "2021-05-30 12:28:38",
                    storey : "1楼",
                    title : "相城绿建"

                },
                {
                    productId : "product2",
                    projectName : "扬子津改造项目",
                    produceTime : "2021-05-30 13:21:12",
                    storey : "2楼",
                    title : "相城绿建"
                }
            ],
            mymap:{
                productId : "构件号",
                projectName : "项目名",
                produceTime : "生产时间",
                storey : "楼层号",
                title : "公司名"
            },
            turnover:0,
            userid:1,
            taskname:"test"
        }
        $.ajax({
            url:"http://8.142.26.93:8989/DuiMa_war_exploded/PrintLabel",
            type:'post',
            dataType:'json',
            contentType:'application/x-www-form-urlencoded;charset=utf-8',
            data:{
                data:JSON.stringify(data1)
            },
            success:function(res){
                console.log(res)
            },
            error:function(message){
                console.log(message)
            }
        })
    }
    function deleteStyle(){
        if(!checkAuthority("删除二维码样式")){
            window.alert("您无删除二维码样式的权限!")
            return;
        }
        $.ajax({
            url:"http://8.142.26.93:8989/DuiMa_war_exploded/ExecuteSQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:{
                    sqlStr:"update qrcode set qrcode_status = 0 where qrcode_id = "+qrcodeId+";",
                    id:sessionStorage.getItem("userId"),
                    name:sessionStorage.getItem("userName"),
                    message:"删除了二维码样式'"+qrcodeName+"'(编号为"+qrcodeId+")"
                },
                success:function(res){
                    console.log(res)
                    window.alert("删除成功!")
                    location.href = "qrcodeQueryAll.jsp"
                },
                error:function(message){
                    console.log(message)
                }
        });
    }
</script>