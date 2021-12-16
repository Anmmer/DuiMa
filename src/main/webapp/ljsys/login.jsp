<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<!-- 登陆界面 -->
<html class="BodyStyle">
    <head>
        <meta charset="utf-8">
        <title>相城绿建堆码后台管理系统</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/ljsys/css/style.css" type="text/css">
        <script type="text/javascript" src="${pageContext.request.contextPath}/ljsys/js/jquery-3.3.1.min.js"></script>
    </head>
    <script type="text/javascript">
        function clickBtn(){
            let json = {
                userId: document.forms["login"]["userId"].value,
                userPwd: document.forms["login"]["userPwd"].value
            };
            $.ajax({
                url:"http://localhost:8989/DuiMa_war_exploded/LoginCheck",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success: function(res){
                    console.log(res);
                    if(res.ret == "true") {
                        sessionStorage.setItem("userId",json.userId);
                        sessionStorage.setItem("userName",res.userName);
                        // 获取权限
                        $.ajax({
                            url:"http://localhost:8989/DuiMa_war_exploded/GetAuthority",
                            type:'post',
                            dataType:'json',
                            contentType:'application/x-www-form-urlencoded;charset=utf-8',
                            data:{
                                userId:json.userId
                            },
                            success:function(res){
                                var functionList = JSON.parse(res.function);
                                console.log(functionList)
                                sessionStorage.setItem("authority",JSON.stringify(functionList))
                                location.href = "index.jsp"
                            },
                            error:function(message){
                                console.log(message)
                            }
                        })

                    }
                },
                error:function(message){
                    console.log(json)
                    console.log(message)
                }
            });
        }
    </script>
    <script type="text/javascript">
        sessionStorage.clear()
    </script>
    <body class="BodyStyle" style="background-color: rgb(50,64,87);">
        <div style="width:100%;height:20%"></div>
        <div style="width:100%;height:10%">
            <p class="TitleStyle">相城绿建堆码后台管理系统</p>
        </div>
        <div class="LoginStyle">
            <div style="width:100%;height: 50px;"></div>
            <div style="width:400px;margin:0 auto;">
                <form name="login">
                    <div style="margin:0 auto;font-size:30px;font-family: 宋体;">
                        账号:<input type="text" name="userId" style="width:300px;height:30px;margin:0 0;"><br/><br/>
                        密码:<input type="password" name="userPwd" style="width:300px;height:30px;margin:0 0;">
                    </div>
                    <div style="width:100%;height:50px;"></div>
                    <div style="width:210px;height:55px;margin:0 auto;">
                        <button type="button" style="width:200px;height:50px;font-size:30px;font-family: 宋体;" onclick="clickBtn()">登陆</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
