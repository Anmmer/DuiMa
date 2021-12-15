<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="javascript">
    var pageCur = 1;
    var pageAll = 1;
</script>
<div style="height: 95%;width:100%;background-color:white;">
    <div style="width:100%;height:10%;">
        <form name="query" style="font-family: Simsun;font-size:20px;">
            <div style="width:100%;height: 20px;float: left;"></div>
            <div style="width:70%;margin:0 auto;">
                <div style="width:40%;float: left;">
                    <span>工号:</span><input type="text" name="userId" class="FormInputStyle">
                </div>
                <div style="width:40%;float: left;">
                    <span>姓名:</span><input type="text" name="userName" class="FormInputStyle">
                </div>
                <button type="button" style="font-family: Simsun;font-size:20px;" onclick="updateTable(1)">模糊查询</button>
            </div>
        </form>
    </div>
    <div style="width:100%;height:90%;">
        <!--表格显示-->
        <div style="width:70%;height:90%;margin:0 auto;">
            <!--结果显示提示：一共有多少记录，共几页-->
            <p id="resultTip" style="margin-top: 0px;font-family: Simsun;font-size: 20px">请在上方输入框内输入相应信息并点击“模糊查询按钮”</p>
            <form name="jumpPage"  style="font-family: Simsun;font-size:20px;" onsubmit="return false;">
                <span>输入页码进行跳转:</span><input type="text" name="page" class="FormInputStyle">
                <button type="button" style="font-family: Simsun;font-size:20px;" onclick="jumpToNewPage2()">跳转</button>
            </form>
            <div style="width:100%;height:30px;"></div>
            <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                <tr>
                    <td class='tdStyle'>工号</td>
                    <td class='tdStyle'>姓名</td>
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
    </div>
    <form enctype="multipart/form-data">
        上传文件:<input type="file" name="file1" id="file1"><br/>
        <input type="button" value="提交" onclick="test()">
    </form>
    <!-- 查询所有用户 -->
    <script type="text/javascript">
        function updateTable(newpage) {
            let fieldNamestmp = {
                user_id:"INT",
                user_name:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var userId = document.forms["query"]["userId"].value;
            var userName = document.forms["query"]["userName"].value;
            var sqlStrtmp = "select user_id,user_name from user where user_status = 1 and user_id like '%"+userId+"%' and user_name like '%"+userName+"%';";
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames:fieldNamesStr,
                pageCur:newpage,
                pageMax:15
            };
            $.ajax({
                url:"http://8.142.26.93:8989/DuiMa_war_exploded/QuerySQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    // 将结果输出到table
                    var str = "";
                    console.log(res)
                    var jsonobj = JSON.parse(res.data);
                    console.log(jsonobj)
                    for( var i = 0; i < jsonobj.length; i++) {
                        str +="<tr><td class='tdStyle'>" + jsonobj[i]['user_id'] + 
                            "</td><td class='tdStyle'>" + jsonobj[i]['user_name'] + 
                            "</td><td class='tdStyle'>";
                        // 查询
                        str +="<a href='userInfo.jsp?userId="+jsonobj[i]['user_id']+"&userName="+jsonobj[i]['user_name']+"'>详情</a>&nbsp";
                        str +="<a href='userModify.jsp?userId="+jsonobj[i]['user_id']+"&userName="+jsonobj[i]['user_name']+"'>修改</a>&nbsp";
                        str +="<a href='javascript:void(0);' onclick='deleteUser("+jsonobj[i]['user_id']+")'>删除</a>";
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
                user_id:"INT",
                user_name:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var userId = document.forms["query"]["userId"].value;
            var userName = document.forms["query"]["userName"].value;
            var sqlStrtmp = "select user_id,user_name from user where user_status = 1 and user_id like '%"+userId+"%' and user_name like '%"+userName+"%';";
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
                url:"http://8.142.26.93:8989/DuiMa_war_exploded/QuerySQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    // 将结果输出到table
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    console.log(jsonobj)
                    for( var i = 0; i < jsonobj.length; i++) {
                        str +="<tr><td class='tdStyle'>" + jsonobj[i]['user_id'] + 
                            "</td><td class='tdStyle'>" + jsonobj[i]['user_name'] + 
                            "</td><td class='tdStyle'>";
                        // 查询
                        str +="<a href='userInfo.jsp?userId="+jsonobj[i]['user_id']+"&userName="+jsonobj[i]['user_name']+"'>详情</a>&nbsp";
                        str +="<a href='userModify.jsp?userId="+jsonobj[i]['user_id']+"&userName="+jsonobj[i]['user_name']+"'>修改</a>&nbsp";
                        str +="<a href='javascript:void(0);' onclick='deleteUser("+jsonobj[i]['user_id']+")'>删除</a>";
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
                user_id:"INT",
                user_name:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var userId = document.forms["query"]["userId"].value;
            var userName = document.forms["query"]["userName"].value;
            var sqlStrtmp = "select user_id,user_name from user where user_status = 1 and user_id like '%"+userId+"%' and user_name like '%"+userName+"%';";
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
                url:"http://8.142.26.93:8989/DuiMa_war_exploded/QuerySQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    // 将结果输出到table
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    console.log(jsonobj)
                    for( var i = 0; i < jsonobj.length; i++) {
                        str +="<tr><td class='tdStyle'>" + jsonobj[i]['user_id'] + 
                            "</td><td class='tdStyle'>" + jsonobj[i]['user_name'] + 
                            "</td><td class='tdStyle'>";
                        // 查询
                        str +="<a href='userInfo.jsp?userId="+jsonobj[i]['user_id']+"&userName="+jsonobj[i]['user_name']+"'>详情</a>&nbsp";
                        str +="<a href='userModify.jsp?userId="+jsonobj[i]['user_id']+"&userName="+jsonobj[i]['user_name']+"'>修改</a>&nbsp";
                        str +="<a href='javascript:void(0);' onclick='deleteUser("+jsonobj[i]['user_id']+")'>删除</a>";
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
        function test() {
            var type = "file";
            var formData = new FormData();
            formData.append(type,$("#file1")[0].files[0]);
            $.ajax({
                url:"http://8.142.26.93:8989/DuiMa_war_exploded/UserBatchInsert",
                type:'post',
                data:formData,
                processData:false,
                contentType:false,
                success:function(res){
                    // 将结果输出到table
                    console.log(res)
                },
                error:function(message){
                    console.log(message)
                }
            });
        }
        function deleteUser(userid) {
            if(!checkAuthority("删除用户")){
                window.alert("您无删除用户的权限!")
                return
            }
            var sqlStr = "update user set user_status = 0 where user_id ="+userid+";";
            $.ajax({
            url:"http://8.142.26.93:8989/DuiMa_war_exploded/ExecuteSQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:{
                    sqlStr:sqlStr,
                    id:sessionStorage.getItem("userId"),
                    name:sessionStorage.getItem("userName"),
                    message:"删除了用户(编号为"+userid+")"
                },
                success:function(res){
                    console.log(res)
                    updateTable(pageCur)
                },
                error:function(message){
                    console.log(message)
                }
            });
        }
        function checkAuthority(au){
            var authority = JSON.parse(sessionStorage.getItem("authority"))
            flag = false;
            for(var i = 0; i < authority.length; i++){
                if(authority[i].fa_name == au) flag = true;
            }
            return flag;
        }
    </script>
</div>