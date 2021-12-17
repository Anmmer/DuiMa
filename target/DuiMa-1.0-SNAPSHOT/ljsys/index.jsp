<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="BodyStyle">
    <head>
        <meta charset="utf-8">
        <title>相城绿建堆码后台管理系统</title>
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
    </head>
    <body class="BodyStyle">
        <!-- 左边的菜单栏 -->
        <%@ include file="menu.jsp" %>
        <!-- 右边-->
        <div style="height:100%;width:85%;background-color: white;float:left;">
            <!-- 顶部消息 -->
            <div style="height: 5%;width:100%;background-color: rgb(239,242,247);">
                <p id="userInfo" style="margin: 0 0;float: right;font-family: 宋体;font-size:20px;line-height: 40px;">TEXT</p>
            </div>
            <!-- 内容窗口 -->
            <div style="height: 95%;width:100%;background-color:white;">
                <div style="height:100%;width:80%;margin: auto;">
                    <div style="height: 32%;width:100%;float:left;">
                        <p class="pStyle" style="font-weight: bolder;">密码修改(可以由数字，字母，下划线组成，长度在6到20位):</p>
                        <p class="pStyle">新密码:</p><input id="newpwd" class="pStyle" type="password">
                        <p class="pStyle">请再输入一遍:</p><input id="checkpwd" class="pStyle" type="password"></br></br>
                        <button onclick="updatePwd()">确定修改</button></br>
                    </div>
                    <div style="height:10px;width:100%;float:left;background-color: white;"></div>
                    <div style="height:2px;width:100%;float:left;background-color: black;"></div>
                    <div style="height:10px;width:100%;float:left;background-color: white;"></div>
                    <div style="height: 15%;width: 100%;float:left;">
                        <!--日志下载-->
                        <p class="pStyle" style="font-weight: bolder;">下载日志</p>
                        <input type="date" id="logdate" onchange="logdatechange()">
                        <a id="downloadurl" href="" download="" style="display: none;" onclick="downloadlog()">下载</a>
                        <!--<button id="downloadlog" style="display: none;" onclick="downloadlog()">下载</button>-->
                    </div>
                    <div style="height:2px;width:100%;float:left;background-color: black;"></div>
                    <div style="height:10px;width:100%;float:left;background-color: white;"></div>
                    <div style="height: 40%;width: 100%;float:left;">
                        <!--项目字段维护-->
                        <!--左边显示和删除-->
                        <div style="height:100%;width:45%;float:left;">
                            <span class="pStyle" style="font-weight: bolder;">项目字段:</span>
                            <div id="projectitems" style="overflow-y: auto;width:97%;height:95%;">
                                <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                                    <tr>
                                        <td class='tdStyle'>项目字段名</td>
                                        <td class='tdStyle'>项目字段值</td>
                                        <td class='tdStyle'>操作</td>
                                    </tr>
                                    <tbody id="tableText">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div style="height:100%;width:9%;float:left;background-color: white;"></div>
                        <!--右边添加-->
                        <div style="height:100%;width:45%;float:left;">
                            <p class='pStyle'>新增字段名:</p><input id="newvalue">
                            <p class='pStyle'>新增字段值:</p><input id="newkey">
                            <button onclick="addItem()">提交</button>
                        </div>
                    </div>
                </div>
            <!--密码修改-->
            <!--日志下载-->
            <!--项目字段维护-->
            </div>
        </div>
        <script type="text/javascript">
            downloadurl=""
            if(sessionStorage.getItem("userName")==null){
                location.href = "login.jsp"
                window.alert("您未登陆，请先登陆！")
            }
            else{
                var userInfo = document.getElementById("userInfo");
                userInfo.innerHTML = sessionStorage.getItem("userName").toString()+",您好,欢迎使用相城绿建堆码后台管理系统!<a href='login.jsp'>点击登出</a>";
                if(!checkAuthority("网页登陆")){
                    window.alert("您无网页端登陆权限!")
                    location.href = "login.jsp"
                }
            }
            updateProjectItem()
            function checkAuthority(au){
                var authority = JSON.parse(sessionStorage.getItem("authority"))
                flag = false;
                for(var i = 0; i < authority.length; i++){
                    if(authority[i].fa_name == au) flag = true;
                }
                return flag;
            }
            // 验证密码，6-20个由字母，数字，下划线组成
            function isValid(str) { return /^\w{6,20}$/.test(str); }
            // 验证中文字段名
            function checkValue(str) { return /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/.test(str)}
            // 验证英文
            function checkKey(str) { return /[_a-zA-Z0-9]+$/.test(str)}
            function updatePwd(){
                var newpwd = $("#newpwd").val()
                var checkpwd = $("#checkpwd").val()
                if(newpwd == checkpwd){
                    console.log(newpwd)
                    var str = "update user set user_pwd='"+newpwd+"' where user_id="+sessionStorage.getItem("userId")+";";
                    console.log(str)
                    if(isValid(newpwd)){
                        $.ajax({
                            url:"http://localhost:8989/DuiMa_war_exploded/ExecuteSQL",
                            type:'post',
                            dataType:'json',
                            contentType:'application/x-www-form-urlencoded;charset=utf-8',
                            data:{
                                sqlStr:str,
                                id:sessionStorage.getItem("userId"),
                                name:sessionStorage.getItem("userName"),
                                message:"修改了自身密码"
                            },
                            success:function(res){
                                console.log(res)
                                window.alert("密码修改成功")
                                $("#newpwd").val("")
                                $("#checkpwd").val("")
                            }
                        })
                    }
                    else{
                        window.alert("您的密码不符合规则，新密码需要由6到20个字母，数字和下划线组成!")
                    }
                }
                else{
                    window.alert("两次密码不一致!")
                }
            }
            // 日志input onchange
            function logdatechange(){
                var logdate = $("#logdate").val()
                console.log(logdate)
                // 查询是否存在该日志，不存在将该downloadurl设置为空字符串
                // 若存在则设定downloadurl并清空display，显示下载按钮
                $.ajax({
                    url:"http://localhost:8989/DuiMa_war_exploded/IsExist",
                    type:'post',
                    dataType:'json',
                    contentType:'application/x-www-form-urlencoded;charset=utf-8',
                    data:{
                        filename:logdate+".txt"
                    },
                    success:function(res){
                        console.log(res)
                        if(res){
                            downloadurl = "./logs/"+logdate+".txt"
                            document.getElementById("downloadurl").style.display = ""
                            document.getElementById("downloadurl").href = downloadurl
                            document.getElementById("downloadurl").download = logdate+".txt"
                        }
                        else{
                            document.getElementById("downloadurl").style.display = "none"
                            window.alert("您选择的日期无日志!")
                        }
                    },
                    error:function(message){
                        console.log(message)
                    }
                })
            }
            function downloadlog(){
                //window.location.href = downloadurl
                //window.open(downloadurl)
                // 清空url，清空日期
                downloadurl = ""
                $("#logdate").val("")
                document.getElementById("downloadurl").style.display = "none"
                //document.getElementById("downloadlog").style.display = "none"
            }
            // 展示最新系统字段
            function updateProjectItem(){
                var fieldNamestmp = {
                    pi_id : "INT",
                    pi_key : "STRING",
                    pi_value : "STRING"
                }
                $.ajax({
                    url:"http://localhost:8989/DuiMa_war_exploded/QuerySQL",
                    type:'post',
                    dataType:'json',
                    contentType:'application/x-www-form-urlencoded;charset=utf-8',
                    data:{
                        sqlStr:"select pi_id,pi_key,pi_value from project_item;",
                        fieldNames:JSON.stringify(fieldNamestmp),
                        pageCur:1,
                        pageMax:1000
                    },
                    success:function(res){
                        console.log(res)
                        var jsonobj = JSON.parse(res.data)
                        console.log(jsonobj)
                        var str = ""
                        for(var i = 0; i < jsonobj.length; i++){
                            str += "<tr><td class='tdStyle'>"+jsonobj[i]['pi_value'] +
                                "</td><td class='tdStyle'>" + jsonobj[i]['pi_key'] +
                                "</td><td class='tdStyle'>"
                            str += "<a href='javascript:void(0);' onclick='deleteItem("+jsonobj[i]['pi_id']+")'>删除</a>";
                            str += "</td></tr>"
                        }
                        $("#tableText").html(str);
                    }
                })
            }
            function deleteItem(id){
                $.ajax({
                    url:"http://localhost:8989/DuiMa_war_exploded/ExecuteSQL",
                    type:'post',
                    dataType:'json',
                    contentType:'application/x-www-form-urlencoded;charset=utf-8',
                    data:{
                        sqlStr:"delete from project_item where pi_id="+id+";",
                        id:sessionStorage.getItem("userId"),
                        name:sessionStorage.getItem("userName"),
                        message:"删除了项目字段(其编号为"+id+")"
                    },
                    success:function(res){
                        console.log(res)
                        window.alert("删除成功!")
                        updateProjectItem()
                    },
                    error:function(message){
                        console.log(message)
                        window.alert("删除失败!请联系系统管理员或查看本机网络状态")
                    }
                })
            }
            // 新增字段
            function addItem(){
                var newkey = $("#newkey").val()
                var newvalue = $("#newvalue").val()
                if(!checkKey(newkey)){
                    window.alert("新增的字段值不和法，可以由英文,下划线,数字组成！")
                    return
                }
                if(!checkValue(newvalue)){
                    window.alert("新增的字段名不合法，可以由中文，英文，下划线，数字组成!")
                    return
                }
                console.log(newkey)
                console.log(newvalue)
                console.log(sessionStorage.getItem("userId"))
                console.log(sessionStorage.getItem("userName"))
                $.ajax({
                    url:"http://localhost:8989/DuiMa_war_exploded/AddProjectItem",
                    type:'post',
                    dataType:'json',
                    contentType:'application/x-www-form-urlencoded;charset=utf-8',
                    data:{
                        id:sessionStorage.getItem("userId"),
                        name:sessionStorage.getItem("userName"),
                        pikey:newkey,
                        pivalue:newvalue
                    },
                    success:function(res){
                        console.log(res)
                        window.alert(res.message)
                        updateProjectItem()
                    },
                    error:function(message){
                        console.log(message)
                        window.alert("新增失败!")
                    }
                })
            }
        </script>
    </body>
</html>
