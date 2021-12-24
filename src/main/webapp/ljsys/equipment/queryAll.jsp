<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!--查询所有群组-->
<script type="javascript">
    var pageCur = 1;
    var pageAll = 1;
</script>
<div style="height: 95%;width:100%;background-color:white;">
    <div style="width:100%;height:10%;">
        <form name="query" style="font-family: Simsun;font-size:16px;">
            <div style="width:100%;height: 16px;float: left;"></div>
            <div style="width:70%;margin:0 auto;">
                <div style="width:40%;float: left;">
                    <span>设备编号:</span><input type="text" name="equipmentId" class="FormInputStyle">
                </div>
                <div style="width:40%;float: left;">
                    <span>设备名:</span><input type="text" name="equipmentName" class="FormInputStyle">
                </div>
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="updateTable(1)">模糊查询</button>
            </div>
        </form>
    </div>
    <div style="width:100%;height:90%;">
        <!--表格显示-->
        <div style="width:70%;height:80%;margin:0 auto;">
            <!--结果显示提示：一共有多少记录，共几页-->
            <p id="resultTip" style="margin-top: 0px;font-family: Simsun;font-size: 16px">请在上方输入框内输入相应信息并点击“模糊查询按钮”</p>
            <form name="jumpPage"  style="font-family: Simsun;font-size:16px;" onsubmit="return false;">
                <span>输入页码进行跳转:</span><input type="text" name="page" class="FormInputStyle">
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage2()">跳转</button>
            </form>
            <div style="width:100%;height:30px;"></div>
            <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                <tr>
                    <td class='tdStyle_title'>设备编号</td>
                    <td class='tdStyle_title'>设备名</td>
                    <td class='tdStyle_title'>二维码</td>
                </tr>
                <tbody id="tableText">
                </tbody>
            </table>
            <div style="width:100%;height:30px;"></div>
            <div style="width:33%;float: left;">
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage(1)">第一页</button>
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage(2)">前一页</button>
            </div>
            <div style="width:33%;float: left;">
                <p id="resultTip2" style="margin-top: 0px;font-family: Simsun;font-size: 16px;text-align: center;">1/1</p>
            </div>
            <div style="width:33%;float: left;">
                <button type="button" style="font-family: Simsun;font-size:16px;float:right;" onclick="jumpToNewPage(4)">最后一页</button>
                <button type="button" style="font-family: Simsun;font-size:16px;float:right;" onclick="jumpToNewPage(3)">后一页</button>
            </div>
        </div>
        <div style="width:70%;height:2px;background-color: black;margin: 0 auto;"></div>
        <div style="width:70%;height:16px;margin:0 auto;"></div>
        <div style="width:70%;height:17%;margin:0 auto;">
            <form name="newFactory" id="newEquipment">
                <span class="pStyle">新增设备名:</span><input type="text" name="newEquipmentName" id="newEquipmentName">
                <span class="pStyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <button type="button" style="font-size: 16px;font-family: Simsun;" onclick="addEquipment()">提交新增</button>
            </form>
        </div>
    </div>
    <!-- 查询所有群组 -->
    <script type="text/javascript">
        function updateTable(newpage) {
            let fieldNamestmp = {
                equipment_id:"INT",
                equipment_name:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var equipmentId = $("#equipmentId").text();
            var equipmentName = $("#equipmentName").text();
            var sqlStrtmp = "select equipment_id,equipment_name from equipment where equipment_status = 1 and equipment_id like '%"+equipmentId+"%' and equipment_name like '%"+equipmentName+"%';";
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames:fieldNamesStr,
                pageCur:newpage,
                pageMax:3
            };
            $.ajax({
                url:"http://localhost:8989/DuiMa_war_exploded/QuerySQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    // 将结果输出到table
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    for( var i = 0; i < jsonobj.length; i++) {
                        str +="<tr><td class='tdStyle_body'>" + jsonobj[i]['equipment_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['equipment_name'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "<img src='./pictures/QRCodes/equipment_" + jsonobj[i]['equipment_id']+".png' />"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    // 提示语
                    var tipStr = "共查询到"+res.cnt+"条记录,结果共有"+res.pageAll+"页!"
                    $("#resultTip").html(tipStr);
                    // 重置查询为第一页
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    var tipStr2 = pageCur+"/"+pageAll;
                    $("#resultTip2").html(tipStr2)
                },
                error:function(message){
                }
            });
        }
        updateTable(1);
        function jumpToNewPage(newpageCode) {
            let fieldNamestmp = {
                equipment_id:"INT",
                equipment_name:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var equipmentId = $("#equipmentId").text();
            var equipmentName = $("#equipmentName").text();
            var sqlStrtmp = "select equipment_id,equipment_name from equipment where equipment_status = 1 and equipment_id like '%"+equipmentId+"%' and equipment_name like '%"+equipmentName+"%';";
            var newpage = 1;
            if(newpageCode == 1) newpage = 1;
            if(newpageCode == 2){
                if(pageCur == 1) {
                    window.alert("已经在第一页!");
                    return
                }
                else{
                    newpage = pageCur-1;
                }
            }
            if(newpageCode == 3){
                if(pageCur == pageAll) {
                    window.alert("已经在最后一页!");
                    return
                }
                else{
                    newpage = pageCur+1;
                }
            }
            if(newpageCode == 4) newpage = pageAll;
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames:fieldNamesStr,
                pageCur:newpage,
                pageMax:15
            };
            $.ajax({
                url:"http://localhost:8989/DuiMa_war_exploded/QuerySQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    // 将结果输出到table
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    for( var i = 0; i < jsonobj.length; i++) {
                        str +="<tr><td class='tdStyle_body'>" + jsonobj[i]['equipment_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['equipment_name'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "详情"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    // 提示语
                    var tipStr = "共查询到"+res.cnt+"条记录,结果共有"+res.pageAll+"页!"
                    $("#resultTip").html(tipStr);
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    var tipStr2 = pageCur+"/"+pageAll;
                    $("#resultTip2").html(tipStr2)
                },
                error:function(message){
                }
            });
        }
        function jumpToNewPage2() {
            let fieldNamestmp = {
                equipment_id:"INT",
                equipment_name:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var equipmentId = $("#equipmentId").text();
            var equipmentName = $("#equipmentName").text();
            var sqlStrtmp = "select equipment_id,equipment_name from equipment where equipment_status = 1 and equipment_id like '%"+equipmentId+"%' and equipment_name like '%"+equipmentName+"%';";
            var newpageStr = document.forms["jumpPage"]["page"].value;
            var newpage = parseInt(newpageStr)
            if(newpage <= 0 || newpage > pageAll || isNaN(newpage)) {
                window.alert("请输入一个在范围内的正确页码数字!")
                return
            }
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames:fieldNamesStr,
                pageCur:newpage,
                pageMax:15
            };
            $.ajax({
                url:"http://localhost:8989/DuiMa_war_exploded/QuerySQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    // 将结果输出到table
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    for( var i = 0; i < jsonobj.length; i++) {
                        str +="<tr><td class='tdStyle_body'>" + jsonobj[i]['equipment_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['equipment_name'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "详情"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    // 提示语
                    var tipStr = "共查询到"+res.cnt+"条记录,结果共有"+res.pageAll+"页!"
                    $("#resultTip").html(tipStr);
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    var tipStr2 = pageCur+"/"+pageAll;
                    $("#resultTip2").html(tipStr2)
                },
                error:function(message){
                }
            });
        }
        function addEquipment(){
            var newEquipmentName = $("#newEquipmentName").val();
            var json = {
                equipmentName:newEquipmentName
            }
            $.ajax({
                url:"http://localhost:8989/DuiMa_war_exploded/AddEquipment",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    updateTable(1)
                },
                error:function(message){
                }
            });
        }
    </script>
</div>
