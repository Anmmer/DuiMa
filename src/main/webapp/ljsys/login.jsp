<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<!-- 登陆界面 -->
<html>
<head>
    <meta charset="utf-8">
    <title>相城绿建堆码后台管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/ljsys/css/style.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/ljsys/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ljsys/dist/js/bootstrap.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/ljsys/dist/css/bootstrap.min.css" type="text/css"/>
</head>
<body class="BodyStyle" style="background-color: #1B65B9">
<div class="LoginStyle">
    <div style="width:100%;margin:0 auto;">
        <form name="login">
            <div class="header1" style="height: 60px;font-size: 24px;">
                系统登录
                <span style="margin-left: 10px;font-size: 16px;color: #606266;">SYSTEM LOGIN</span>
            </div>
            <div style="margin:0 auto;font-size:16px;font-family: 宋体;">
                <span class="ant-input-suffix_username">
                    <svg viewBox="64 64 896 896" focusable="false" data-icon="user" width="1em" height="1em"
                         fill="currentColor" aria-hidden="true" class=""><path
                            d="M858.5 763.6a374 374 0 00-80.6-119.5 375.63 375.63 0 00-119.5-80.6c-.4-.2-.8-.3-1.2-.5C719.5 518 760 444.7 760 362c0-137-111-248-248-248S264 225 264 362c0 82.7 40.5 156 102.8 201.1-.4.2-.8.3-1.2.5-44.8 18.9-85 46-119.5 80.6a375.63 375.63 0 00-80.6 119.5A371.7 371.7 0 00136 901.8a8 8 0 008 8.2h60c4.4 0 7.9-3.5 8-7.8 2-77.2 33-149.5 87.8-204.3 56.7-56.7 132-87.9 212.2-87.9s155.5 31.2 212.2 87.9C779 752.7 810 825 812 902.2c.1 4.4 3.6 7.8 8 7.8h60a8 8 0 008-8.2c-1-47.8-10.9-94.3-29.5-138.2zM512 534c-45.9 0-89.1-17.9-121.6-50.4S340 407.9 340 362c0-45.9 17.9-89.1 50.4-121.6S466.1 190 512 190s89.1 17.9 121.6 50.4S684 316.1 684 362c0 45.9-17.9 89.1-50.4 121.6S557.9 534 512 534z"></path></svg>
                </span>
                <input class="ant-input" placeholder="手机号" type="text" name="user_phone"><br/><br/>
                <span class="ant-input-suffix_password">
                    <svg viewBox="64 64 896 896" focusable="false" data-icon="lock" width="1em" height="1em"
                         fill="currentColor" aria-hidden="true" class=""><path
                            d="M832 464h-68V240c0-70.7-57.3-128-128-128H388c-70.7 0-128 57.3-128 128v224h-68c-17.7 0-32 14.3-32 32v384c0 17.7 14.3 32 32 32h640c17.7 0 32-14.3 32-32V496c0-17.7-14.3-32-32-32zM332 240c0-30.9 25.1-56 56-56h248c30.9 0 56 25.1 56 56v224H332V240zm460 600H232V536h560v304zM484 701v53c0 4.4 3.6 8 8 8h40c4.4 0 8-3.6 8-8v-53a48.01 48.01 0 10-56 0z"></path></svg>
                </span>
                <input class="ant-input" placeholder="密码" type="password" name="userPwd">
            </div>
            <div style="width:100%;height:40px;"></div>
            <div style="width:100%;height:55px;margin:0 auto;">
                <button type="button"
                        style="width:100%;height:32px;font-size:14px;color:#fff;border-radius: 4px;border:none;cursor: pointer;background-color: #1B65B9"
                        onclick="clickBtn()">登陆
                </button>
                <button type="button"
                        style="width: 30%; float:right;margin-top:5px;font-size: 12px; border:none;cursor: pointer; background-color: #fff; box-shadow: none;"
                        onclick=" $('#myModal').modal('show')">修改密码
                </button>
            </div>
        </form>
    </div>

</div>
<!-- Modal -->
<div class="modal fade" id="myModal" style="position: absolute; top:18%;left:10%;" tabindex="-1" role="dialog"
     data-backdrop="false"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width:70%">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="title">修改密码</h4>
            </div>
            <div class="modal-body">
                <div class="form-horizontal">
                    <div class="form-group" style="margin-top: 5%;">
                        <label for="user_phone" style="width: 28%;padding-right: 0"
                               class="col-sm-2 control-label">手&nbsp;机&nbsp;号：</label>
                        <input type="text" class="form-control" style="width:50%;" id="user_phone"><br>
                        <label for="old_password" style="width: 28%;padding-right: 0"
                               class="col-sm-2 control-label">旧&nbsp;密&nbsp;码：</label>
                        <input type="password" class="form-control" style="width:50%;" id="old_password"><br>
                        <label for="password" style="width: 28%;padding-right: 0"
                               class="col-sm-2 control-label">新&nbsp;密&nbsp;码：</label>
                        <input type="password" class="form-control" style="width:50%;" id="password"><br>
                        <label for="password" style="width: 28%;padding-right: 0"
                               class="col-sm-2 control-label">确认密码：</label>
                        <input type="password" class="form-control" style="width:50%;" id="en_password">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                <button type="button" onclick="save()" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<div style="width: 100%;position: fixed;bottom: 10%;text-align: center;">
    <span style="width: 576px;height: 13px;font-size: 14px;font-weight: normal;font-stretch: normal;line-height: 90px;letter-spacing: 0px; color: #ffffff;">相城绿建堆码后台管理系统</span>
</div>
</body>
<script>
    sessionStorage.clear()

    function clickBtn() {
        let json = {
            user_phone: document.forms["login"]["user_phone"].value,
            userPwd: document.forms["login"]["userPwd"].value
        };
        $.ajax({
            url: "${pageContext.request.contextPath}/LoginCheck",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                if (res.flag) {
                    sessionStorage.setItem("userId", res.userId);
                    sessionStorage.setItem("userName", res.userName);
                    // 获取权限
                    $.ajax({
                        url: "${pageContext.request.contextPath}/GetAuthority",
                        type: 'post',
                        dataType: 'json',
                        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                        data: {
                            userId: res.userId
                        },
                        success: function (res) {
                            var functionList = JSON.parse(res.function);
                            sessionStorage.setItem("authority", JSON.stringify(functionList))
                            location.href = "${pageContext.request.contextPath}/ljsys/ljsys.html"
                        },
                        error: function (message) {
                        }
                    })

                } else {
                    alert(res.message)
                }
            },
            error: function (message) {
                alert(message)
            }
        });
    }

    $('#myModal').on('hidden.bs.modal', function (e) {
        reset()
    })

    function save() {
        let user_phone = $('#user_phone').val().replace(/(^\s*)|(\s*$)/g, "");
        let old_password = $('#old_password').val()
        let password = $('#password').val()
        let en_password = $('#en_password').val()
        if (user_phone === '') {
            alert('手机号不能为空')
            return
        }
        if (old_password === password) {
            alert('新密码不能与旧密码相同')
            return;
        }
        if (password !== en_password) {
            alert('确认密码与新密码不同')
            return;
        }
        let data = {
            user_phone: user_phone,
            password: password
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/UpdatePassword",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: data,
            success: function (res) {
                if (res.flag) {
                    alert(res.message)
                    $('#myModal').modal('hide')
                } else {
                    alert(res.message)
                }
            }
        })

    }

    function open() {
        $('#myModal').modal('show')
    }

    //重置弹窗
    function reset() {
        $('#user_phone').val('');
        $('#old_password').val('');
        $('#password').val('');
        $('#en_password').val('');
    }
</script>
</html>
