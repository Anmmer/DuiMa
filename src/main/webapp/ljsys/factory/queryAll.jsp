<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!--查询所有群组-->
<script type="text/javascript">
    var pageCur = 1;
    var pageAll = 1;
    function checkAuthority(au){
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for(var i = 0; i < authority.length; i++){
            if(authority[i].fa_name == au) flag = true;
        }
        return flag;
    }
</script>
<div style="height: 95%;width:100%;background-color:white;">
    <div style="width:100%;height:10%;">
        <form name="query" style="font-family: Simsun;font-size:20px;">
            <div style="width:100%;height: 20px;float: left;"></div>
            <div style="width:70%;margin:0 auto;">
                <div style="width:40%;float: left;">
                    <span>仓库组织编号:</span><input type="text" name="factoryId" class="FormInputStyle">
                </div>
                <div style="width:40%;float: left;">
                    <span>仓库组织名:</span><input type="text" name="factoryName" class="FormInputStyle">
                </div>
                <button type="button" style="font-family: Simsun;font-size:20px;" onclick="updateTable(1)">模糊查询</button>
            </div>
        </form>
    </div>
    <div style="width:100%;height:90%;">
        <!--表格显示-->
        <div style="width:70%;height:80%;margin:0 auto;">
            <!--结果显示提示：一共有多少记录，共几页-->
            <p id="resultTip" style="margin-top: 0px;font-family: Simsun;font-size: 20px">请在上方输入框内输入相应信息并点击“模糊查询按钮”</p>
            <form name="jumpPage"  style="font-family: Simsun;font-size:20px;" onsubmit="return false;">
                <span>输入页码进行跳转:</span><input type="text" name="page" class="FormInputStyle">
                <button type="button" style="font-family: Simsun;font-size:20px;" onclick="jumpToNewPage2()">跳转</button>
            </form>
            <div style="width:100%;height:30px;"></div>
            <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                <tr>
                    <td class='tdStyle'>仓库组织编号</td>
                    <td class='tdStyle'>仓库组织名</td>
                    <td class='tdStyle'>仓库组织地址</td>
                    <td class='tdStyle'>操作</td>
                </tr>
                <tbody id="tableText">
                </tbody>
            </table>
            <div style="width:100%;height:30px;"></div>
            <div style="width:33%;float: left;">
                <button type="button" style="font-family: Simsun;font-size:20px;" onclick="jumpToNewPage(1)">第一页</button>
                <button type="button" style="font-family: Simsun;font-size:20px;" onclick="jumpToNewPage(2)">前一页</button>
            </div>
            <div style="width:33%;float: left;">
                <p id="resultTip2" style="margin-top: 0px;font-family: Simsun;font-size: 20px;text-align: center;">1/1</p>
            </div>
            <div style="width:33%;float: left;">
                <button type="button" style="font-family: Simsun;font-size:20px;float:right;" onclick="jumpToNewPage(4)">最后一页</button>
                <button type="button" style="font-family: Simsun;font-size:20px;float:right;" onclick="jumpToNewPage(3)">后一页</button>
            </div>
        </div>
        <div style="width:70%;height:2px;background-color: black;margin: 0 auto;"></div>
        <div style="width:70%;height:20px;margin:0 auto;"></div>
        <div style="width:70%;height:17%;margin:0 auto;">
            <form name="newFactory" id="newFactory">
                <span class="pStyle">新增仓库组织名:</span><input type="text" name="newFactoryName" id="newFactoryName">
                <span class="pStyle">新增仓库组织地址:</span><input type="text" name="newFactoryAddress" id="newFactoryAddress">
                <span class="pStyle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <button type="button" style="font-size: 20px;font-family: Simsun;" onclick="addFactory()">提交新增</button>
            </form>
        </div>
    </div>
    <!-- 查询所有群组 -->
    <script type="text/javascript">
        function updateTable(newpage) {
            let fieldNamestmp = {
                factory_id:"INT",
                factory_name:"STRING",
                factory_address:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var factoryId = document.forms["query"]["factoryId"].value;
            var factoryName = document.forms["query"]["factoryName"].value;
            var sqlStrtmp = "select factory_id,factory_name,factory_address from factory where factory_status = 1 and factory_id like '%"+factoryId+"%' and factory_name like '%"+factoryName+"%';";
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
                    console.log(json)
                    console.log(res)
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    console.log(jsonobj)
                    for( var i = 0; i < jsonobj.length; i++) {
                        str +="<tr><td class='tdStyle'>" + jsonobj[i]['factory_id'] +
                            "</td><td class='tdStyle'>" + jsonobj[i]['factory_name'] +
                            "</td><td class='tdStyle'>" + jsonobj[i]['factory_address'] +
                            "</td><td class='tdStyle'>";
                        // 查询

                        str += "<a href='warehouseQueryAll.jsp?factoryId="+jsonobj[i]['factory_id']+"&factoryName="+jsonobj[i]['factory_name']+"'>详情</a>&nbsp"
                        str += "<a href='javascript:void(0);' onclick='removeFactory("+jsonobj[i]['factory_id']+")'>删除</a>"
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
                    console.log(json)
                    console.log(message)
                }
            });
        }
        updateTable(1);
        function jumpToNewPage(newpageCode) {
            let fieldNamestmp = {
                gp_id:"INT",
                gp_name:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var factoryId = document.forms["query"]["factoryId"].value;
            var factoryName = document.forms["query"]["factoryName"].value;
            var sqlStrtmp = "select factory_id,factory_name,factory_address from factory where facotry_status = 1 and factory_id like '%"+factoryId+"%' and factory_name like '%"+factoryName+"%';";
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
                    console.log(json)
                    console.log(res)
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    console.log(jsonobj)
                    for( var i = 0; i < jsonobj.length; i++) {
                        str +="<tr><td class='tdStyle'>" + jsonobj[i]['factory_id'] +
                            "</td><td class='tdStyle'>" + jsonobj[i]['factory_name'] +
                            "</td><td class='tdStyle'>" + jsonobj[i]['factory_address'] +
                            "</td><td class='tdStyle'>";
                        // 查询
                        str += "<a href='warehouseQueryAll.jsp?factoryId="+jsonobj[i]['factory_id']+"&factoryName="+jsonobj[i]['factory_name']+"'>详情</a>&nbsp"
                        str += "<a href='javascript:void(0);' onclick='removeFactory("+jsonobj[i]['factory_id']+")'>删除</a>"
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
                    console.log(json)
                    console.log(message)
                }
            });
        }
        function jumpToNewPage2() {
            let fieldNamestmp = {
                gp_id:"INT",
                gp_name:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var factoryId = document.forms["query"]["factoryId"].value;
            var factoryName = document.forms["query"]["factoryName"].value;
            var sqlStrtmp = "select factory_id,factory_name,factory_address from factory where facotry_status = 1 and factory_id like '%"+factoryId+"%' and factory_name like '%"+factoryName+"%';";
            var newpageStr = document.forms["jumpPage"]["page"].value;
            var newpage = parseInt(newpageStr)
            console.log(newpage)
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
                    console.log(json)
                    console.log(res)
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    console.log(jsonobj)
                    for( var i = 0; i < jsonobj.length; i++) {
                        str +="<tr><td class='tdStyle'>" + jsonobj[i]['factory_id'] +
                            "</td><td class='tdStyle'>" + jsonobj[i]['factory_name'] +
                            "</td><td class='tdStyle'>" + jsonobj[i]['factory_address'] +
                            "</td><td class='tdStyle'>";
                        // 查询
                        str += "<a href='warehouseQueryAll.jsp?factoryId="+jsonobj[i]['factory_id']+"&factoryName="+jsonobj[i]['factory_name']+"'>详情</a>&nbsp"
                        str += "<a href='javascript:void(0);' onclick='removeFactory("+jsonobj[i]['factory_id']+")'>删除</a>"
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
                    console.log(json)
                    console.log(message)
                }
            });
        }
        function addFactory(){
            if(!checkAuthority("新增仓库组织")){
                window.alert("您无新增仓库组织的权限")
                return;
            }
            var factoryName = $("#newFactoryName").val();
            var factoryAddress = $("#newFactoryAddress").val();
            console.log(factoryName)
            console.log(factoryAddress)
            var json = {
                factoryName : factoryName,
                factoryAddress : factoryAddress,
                id : sessionStorage.getItem("userId"),
                name : sessionStorage.getItem("userName")
            }
            $.ajax({
                url:"http://localhost:8989/DuiMa_war_exploded/AddFactory",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    console.log(res)
                    updateTable(pageCur);
                    window.alert(res.message);
                },
                error:function(message){
                    console.log(message)
                }
            });
        }
        function removeFactory(factoryid){
            if(!checkAuthority("删除仓库组织")){
                window.alert("您无删除仓库组织的权限")
                return;
            }
            console.log("delete"+factoryid)
            // 库房清零后方可删除
            // 查询该工厂是否有库房
            var fieldNames = {
                warehouse_id : "INT"
            }
            $.ajax({
                url:"http://localhost:8989/DuiMa_war_exploded/QuerySQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:{
                    sqlStr:"select warehouse_id from warehouse where factory_id = "+factoryid+";",
                    fieldNames:JSON.stringify(fieldNames),
                    pageCur:1,
                    pageMax:100
                },
                success:function(res){
                    if(res.cnt == 0){
                        // 可以删除工厂
                        $.ajax({
                            url:"http://localhost:8989/DuiMa_war_exploded/ExecuteSQL",
                            type:'post',
                            dataType:'json',
                            contentType:'application/x-www-form-urlencoded;charset=utf-8',
                            data:{
                                sqlStr:"update factory set factory_status = 0 where factory_id ="+factoryid+";",
                                id:sessionStorage.getItem("userId"),
                                name:sessionStorage.getItem("userName"),
                                message:"删除了库存组织(其编号为"+factoryid+")"
                            },
                            success:function(res){
                                console.log(res)
                                window.alert("删除成功!")
                                updateTable(pageCur)
                            },
                            error:function(message){
                                console.log(message)
                                window.alert("删除失败!")
                            }
                        });
                    }
                    else{
                        window.alert("未成功!请删除该仓库组织下所有仓库!");
                    }
                },
                error:function(message){
                    console.log(message)
                    window.alert("删除失败!请查看您的网络状态或联系运维人员!")
                }
            })

        }
    </script>
</div>
