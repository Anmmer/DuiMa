<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="width:40%;height:100%;background-color:white;margin: 0 auto;">
    <p style="padding-top: 6%;font-size:17px;font-weight: bolder">新增:</p>
    <br>
    <div class="form-horizontal" style="width:100%;height:28%;float: left;">
        <div class="form-group" style="height: 100%">
            <label for="name" style="width: 16%;text-align: left" class="col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:</label>
            <input style="width: 40%" class="form-control" id="name" placeholder="姓名"><br>
            <label for="user_phone" style="width: 16%;text-align: left" class="col-sm-2 control-label">手机号:</label>
            <input style="width: 40%" class="form-control" id="user_phone" placeholder="手机号"><br>
            <label for="groupName" style="width: 16%;text-align: left;padding-right: 0"
                   class="col-sm-2 control-label">添加角色:</label>
            <select class="form-control" style="width: 40%" id="groupName" name="groupName" size="1"
                    style="width:35%;">
            </select>
            <button style="margin-top: 5%;margin-left: 2%;" class="btn btn-primary btn-sm" onclick="addOne()">提交新增
            </button>
        </div>
    </div>
<%--    <div style="width:100%;height:3px;background-color: cornflowerblue;float:left;"></div>--%>
<%--    <div style="width:100%;height:10px;float: left;"></div>--%>
<%--    <div style="float: left;height:30%">--%>
<%--        <form name="batchAdd" enctype="multipart/form-data">--%>
<%--            <div class="form-horizontal" style="width:100%;height:28%;float: left;">--%>
<%--                <div style="width:100%;height:30px;float:left;"></div>--%>
<%--                <span style="margin-top: 6%;font-size:17px;font-weight: bolder">批量新增:</span>--%>
<%--                <div style="width:100%;height:30px;float:left;"></div>--%>
<%--                <div class="form-group" style="height: 100%">--%>
<%--                    <label for="file1" style="width: 28%;text-align: left;padding-right: 0"--%>
<%--                           class="col-sm-2 control-label">上传Excel:</label>--%>
<%--                    <input style="width: 60%" type="file" name="file1" id="file1"><br>--%>
<%--                    <button style="margin-top: 5%;margin-left: 2%;" class="btn btn-primary btn-sm" onclick="addBatch()">--%>
<%--                        批量新增--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </form>--%>
<%--    </div>--%>

<%--    <div style="float: left;width: 100%;"><span class="pStyle">信息面板:</span></div>--%>
<%--    <div id="errorInfo" style="width:100%;height:10%;overflow-y: auto;float:left;background-color: azure;"></div>--%>
<%--    <div class='pStyle' style="float:left;"><a href="./files/Template.xls" download="Template.xls">模板</a></div>--%>
</div>
<script type="text/javascript">
    function checkAuthority(au) {
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for (var i = 0; i < authority.length; i++) {
            if (authority[i].fa_name == au) flag = true;
        }
        return flag;
    }

    // 设置<select>标签
    var newgpids = []
    var groupNames = document.getElementById("groupName");
    let fieldNamestmp = {
        gp_id: "INT",
        gp_name: "STRING"
    };
    var fieldNamesStr = JSON.stringify(fieldNamestmp);
    var sqlStrtmp = "select gp_id,gp_name from gp where gp_status = 1;";
    let json = {
        sqlStr: sqlStrtmp,
        fieldNames: fieldNamesStr,
        pageCur: 1,
        pageMax: 100
    };
    $.ajax({
        url: "${pageContext.request.contextPath}/QuerySQL",
        type: 'post',
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: json,
        success: function (res) {
            var jsonobj = JSON.parse(res.data);
            for (var i = 0; i < jsonobj.length; i++) {
                groupNames.options.add(new Option(jsonobj[i].gp_name, jsonobj[i].gp_id));
            }
        },
        error: function (message) {
        }
    });


    function checkPhone(phone) {
        if (!(/^1[34578]\d{9}$/.test(phone))) {
            return false;
        }
        return true;
    }

    // 提交新增
    function addOne() {
        var userName = $("#name").val();
        let groupName = $("#groupName").val();
        let user_phone = $("#user_phone").val();
        if (userName === '' || userName === ' ') {
            alert('姓名不能为空');
            return
        }
        if (!checkPhone(user_phone)) {
            alert('手机号为空或不正确');
            return
        }
        newgpids.push(groupName);
        json = {
            id: sessionStorage.getItem("userId"),
            name: sessionStorage.getItem("userName"),
            userName: userName,
            user_phone: user_phone,
            groupIds: JSON.stringify(newgpids)
        }
        // 使用新增Servlet
        // 修改新增的后端
        $.ajax({
            url: "${pageContext.request.contextPath}/AddUser",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                if (res.result == "true") {
                    window.alert("用户新增成功!\n" + res.message)
                } else window.alert(res.message)
                location.reload()
            },
            error: function (message) {
                window.alert("新增失败!\n" + message['responseText'])
            }
        }).then(() => {
            newgpids = [];
        });
    }

    // 批量新增
    function addBatch() {
        var type = "file";
        var formData = new FormData();
        let file = $("#file1")[0].files[0];
        if (file == null) {
            alert('请上传Excel');
            return;
        }
        formData.append(type, file);
        // 使用批量新增的Servlet
        $.ajax({
            url: "${pageContext.request.contextPath}/UserBatchInsert",
            type: 'post',
            data: formData,
            processData: false,
            contentType: false,
            success: function (res) {
                // 将结果输出到table
                var jsonobj = JSON.parse(res)
                var info = ""
                for (var i = 0; i < jsonobj.length; i++) {
                    info += "<p class='pStyle'>" + jsonobj[i] + "</p>"
                }
                $("#errorInfo").html(info)
                window.alert("完成批量新增，具体信息见信息面板")
            },
            error: function (message) {
            }
        });
    }

    function addgp() {
        var gpid = $("#groupName :selected").val()
        var gpname = $("#groupName :selected").text()
        var flag = true
        for (var i = 0; i < newgpids.length; i++) {
            if (newgpids[i] == gpid) flag = false
        }
        if (flag) {
            var item = $("<div class='pStyle' id='gpname_" + gpid + "'><button onclick='removegp(" + gpid + ")'>删除</button>&nbsp&nbsp" + gpname + "</ br></div>")
            $("#addgp").append(item)
            newgpids.push(gpid)
        }
    }

    function removegp(gpid) {
        var item = $("#gpname_" + gpid)
        item.remove()
        // 在newgpids中删除
        var idx = 0;
        for (var i = 0; i < newgpids.length; i++) {
            if (newgpids[i] == gpid) idx = i;
        }
        newgpids.splice(i, 1)
    }
</script>
