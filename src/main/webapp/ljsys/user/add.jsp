<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div style="height: 95%;width:100%;background-color:white;">
    <div style="width:40%;height:100%;margin: 0 auto;">
        <div style="width:100%;height: 16px;float: left;"></div>
        <span style="font-size: 16px;font-family: Simsun;font-weight: bolder;">新增:</span>
        <div style="width:100%;height:30px;float:left"></div>
        <div name="add" style="width: 100%">
            <label class="pStyle" for="name" style="margin-right: 10%">姓名:</label>
            <input type="text" name="name" id="name" style="width:55%;" class="FormInputStyle">
            <div style="width:100%;height:30px;"></div>
            <label class="pStyle" for="groupName" style="margin-right: 4%">角色群组:</label>
            <select id="groupName" name="groupName" size="1"
                    style="width:55%;font-size:16px;font-family:Simsun;height: 24.4px">
            </select><br>
            <%--            <button style="float:left" onclick="addgp()">新增</button>--%>
            <%--            <div style="width:100%;height:30px;float:left;" class="pStyle">群组:</div>--%>
            <button style="font-size:16px;font-family:Simsun;margin-top: 30px;" onclick="addOne()">提交新增
            </button>
        </div>
        <div style="width:100%;height:30px;float:left"></div>
        <div style="width:100%;height:3px;background-color: cornflowerblue;float:left;"></div>
        <div style="width:100%;height:10px;float: left;"></div>
        <div style="float: left;">
            <form name="batchAdd" enctype="multipart/form-data">
                <div style="width:100%;height:30px;float:left;"></div>
                <span style="font-size: 16px;font-family: Simsun;font-weight: bolder;float: left;">批量新增:</span>
                <div style="width:100%;height:30px;float:left;"></div>
                <!--批量新增-->
                <span class="pStyle"
                      style="width:30%;height:30px;float:left;line-height:30px;font-size: 16px;font-family:Simsun;">请选择文件:</span>
                <input type="file" name="file1" id="file1"
                       style="width:65%;height:40px;float:left;font-size:16px;font-family: Simsun;"><br/>
                <div style="width:100%;height:30px;float:left;"></div>
                <input type="button" value="批量新增" style="float:left;font-size: 16px;font-family: Simsun;"
                       onclick="addBatch()">
            </form>
        </div>

        <div style="float: left;width: 100%;"><span class="pStyle">信息面板:</span></div>
        <div id="errorInfo" style="width:100%;height:100px;overflow-y: auto;float:left;background-color: azure;"></div>
        <div class='pStyle' style="float:left;"><a href="./files/Template.xls" download="Template.xls">模板</a></div>
    </div>
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

    if (!checkAuthority("新增用户")) {
        window.alert("您无新增用户的权限!")
        location.href = "index.jsp"
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
        url: "http://localhost:8989/DuiMa_war_exploded/QuerySQL",
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

    // 提交新增
    function addOne() {
        if (!checkAuthority("新增用户")) {
            window.alert("您无新增用户的权限!")
            return
        }
        var userName = $("#name").val();
        json = {
            id: sessionStorage.getItem("userId"),
            name: sessionStorage.getItem("userName"),
            userName: userName,
            groupIds: JSON.stringify(newgpids)
        }
        // 使用新增Servlet
        // 修改新增的后端
        $.ajax({
            url: "http://localhost:8989/DuiMa_war_exploded/AddUser",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                if (res.result == "true") window.alert("用户新增成功!\n" + res.message)
                else window.alert(res.message)
                location.reload()
            },
            error: function (message) {
                window.alert("新增失败!\n" + message['responseText'])
            }
        });
    }

    // 批量新增
    function addBatch() {
        if (!checkAuthority("新增用户")) {
            window.alert("您无新增用户的权限!")
            return
        }
        var type = "file";
        var formData = new FormData();
        formData.append(type, $("#file1")[0].files[0]);
        // 使用批量新增的Servlet
        $.ajax({
            url: "http://localhost:8989/DuiMa_war_exploded/UserBatchInsert",
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
