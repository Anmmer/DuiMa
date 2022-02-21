<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    function getQueryVariable(variable) {
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            if (pair[0] == variable) return pair[1];
        }
        return (false);
    }

    function checkAuthority(au) {
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for (var i = 0; i < authority.length; i++) {
            if (authority[i].fa_name == au) flag = true;
        }
        return flag;
    }

    var userId = getQueryVariable("userId");
    var userName = decodeURIComponent(getQueryVariable("userName"));

    // 变量
    var oldgpids = []      // 旧角色群组的id
    var newgpids = []      // 新角色群组的id
</script>
<div style="height: 95%;width:100%;background-color:white;">
    <div style="width:40%;height:100%;margin: 0 auto;">
        <div style="width:100%;height:5%;">
        </div>
        <button style="position: absolute;left: 20%;" onclick="returnLastPage()" class="btn btn-primary btn-sm">返回</button>
        <!--展示用户信息及其群组信息-->
        <p style="font-size:17px;font-weight: bolder">用户信息修改:</p>
        <div class="form-inline" style="width:100%;height:30%;float: left;">
            <br>
            <div class="form-group" style="width: 50%">
                <label for="userId" class="">工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</label>
                <input  style="width: 50%" class="form-control" id="userId" disabled placeholder="工号"><br><br>
                <label for="userName">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</label>
                <input style="width: 50%" class="form-control" id="userName" placeholder="姓名"><br><br>
                <label for="groupNames">添加角色：</label>
                <select class="form-control" style="width: 50%" id="groupNames" name="groupNames" size="1">
                </select>
                <button style="" class="btn btn-primary btn-sm" onclick="addGroup()">添加
                </button>
            </div>
            <%--            <span>所属群组角色名:</span><span id="groupName1" class="pStyle">userId</span></br></br>--%>
        </div>
        <div class="panel panel-default" style="width:56%;height:50%;overflow-y:hidden;">
            <div class="panel-heading">拥有功能权限如下:</div>
            <div id="newGroups" class="panel-body" style="height:100%;overflow-y:scroll;">
            </div>
        </div>
        <input type="button" value="提交修改" class="btn btn-primary btn-sm" style="margin-top: 0%" onclick="modify1()">
    </div>
</div>
<script type="text/javascript">
    let fieldNamestmp = {
        gp_id: "INT",
        gp_name: "STRING"
    }
    var fieldNamesStr = JSON.stringify(fieldNamestmp);
    var sqlStrtmp = "select gp.gp_id,gp_name from gp,user_gp where gp.gp_id = user_gp.gp_id and user_id=" + userId + ";";
    let json = {
        sqlStr: sqlStrtmp,
        fieldNames: fieldNamesStr,
        pageCur: 1,
        pageMax: 100
    };
    <%--$.ajax({--%>
    <%--    url: "${pageContext.request.contextPath}/QuerySQL",--%>
    <%--    type: 'post',--%>
    <%--    dataType: 'json',--%>
    <%--    contentType: 'application/x-www-form-urlencoded;charset=utf-8',--%>
    <%--    data: json,--%>
    <%--    success: function (res) {--%>
    <%--        (res)--%>
    <%--        var jsonobj = JSON.parse(res.data);--%>
    <%--        (jsonobj)--%>
    <%--        var gpids = jsonobj[0]['gp_id']--%>
    <%--        var gpnames = jsonobj[0]['gp_name']--%>
    <%--        var strtmp = "";--%>
    <%--        $("#function").html(strtmp);--%>
    <%--        $("#groupId1").text(gpids);--%>
    <%--        $("#groupName1").text(gpnames);--%>
    <%--    },--%>
    <%--    error: function (message) {--%>
    <%--        (json)--%>
    <%--        (message)--%>
    <%--    }--%>
    <%--});--%>
    $("#userId").val(userId);
    $("#userName").val(userName);
    // 设置SELECT组件
    var groupNames = document.getElementById("groupNames");
    fieldNamestmp = {
        gp_id: "INT",
        gp_name: "STRING"
    };
    fieldNamesStr = JSON.stringify(fieldNamestmp);
    sqlStrtmp = "select gp_id,gp_name from gp where gp_status = 1;";
    json = {
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
            (jsonobj)
            for (var i = 0; i < jsonobj.length; i++) {
                groupNames.options.add(new Option(jsonobj[i].gp_name, jsonobj[i]['gp_id']));
            }
        },
        error: function (message) {
            (message)
        }
    });
    // 获取已有分组
    filedNamestmp = {
        gp_id: "INT",
        gp_name: "STRING"
    };
    fieldNamesStr = JSON.stringify(fieldNamestmp)
    sqlStrtmp = "select gp.gp_id, gp.gp_name from gp,user_gp where user_gp.gp_id = gp.gp_id and user_id = " + userId + ";";
    $.ajax({
        url: "${pageContext.request.contextPath}/QuerySQL",
        type: 'post',
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: {
            sqlStr: sqlStrtmp,
            fieldNames: fieldNamesStr,
            pageCur: 1,
            pageMax: 100
        },
        success: function (res) {
            var jsonobj = JSON.parse(res.data);
            // 循环放入div中并放入两个数组中
            var groupdiv = $("#newGroups")
            for (var i = 0; i < jsonobj.length; i++) {
                oldgpids.push(jsonobj[i]['gp_id'])
                newgpids.push(jsonobj[i]['gp_id'])
                var newitem = $("<div id='gpname_" + jsonobj[i]['gp_id'] + "'>" + "<p class='pStyle' style='width:80%;height:30px;float:left;'>" + jsonobj[i]['gp_name'] + "</p>" + "<button style='width:15%;height:30px;float:left;' class='btn btn-primary  btn-xs' onclick='removeGroup(" + jsonobj[i]['gp_id'] + ")'>删除</button></br></div>")
                groupdiv.append(newitem)
            }
        },
        error: function (message) {
            (message)
        }
    });

    function modify1() {
        var newName = $("#userName").val();
        var groupId = $("#groupNames").val();
        var sqlStr = ""
        if (newName != "") {
            sqlStr = "update user set user_name='" + newName + "' where user_id=" + userId + ";";
            json = {
                sqlStr: sqlStr,
                id: sessionStorage.getItem("userId"),
                name: sessionStorage.getItem("userName"),
                message: "修改了用户'" + userName + "'的姓名，新姓名为'" + newName + "'"
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/ExecuteSQL",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: json,
                success: function (res) {
                    (res)
                },
                error: function (message) {
                    (message)
                }
            });
        }
        // 循环添加分组，比对oldgpids和newgpids，删除应该删除的，新增要新增的
        // 先增后删
        for (var i = 0; i < newgpids.length; i++) {
            var flag = true
            for (var j = 0; j < oldgpids.length; j++) {
                if (newgpids[i] == oldgpids[j]) flag = false
            }
            if (flag) {
                // 需要新增
                $.ajax({
                    url: "${pageContext.request.contextPath}/AddUserGp",
                    type: 'post',
                    dataType: 'json',
                    data: {
                        userId: userId,
                        groupId: newgpids[i],
                        id: sessionStorage.getItem("userId"),
                        name: sessionStorage.getItem("userName")
                    },
                    success: function (res) {
                        (res)
                    },
                    error: function (message) {
                        (message)
                    }
                })
                var start = (new Date()).getTime();
                while ((new Date()).getTime() - start < 500) {
                    continue;
                }
            }
        }
        // 需要删除
        for (var i = 0; i < oldgpids.length; i++) {
            var flag = true
            for (var j = 0; j < newgpids.length; j++) {
                if (newgpids[j] == oldgpids[i]) flag = false
            }
            if (flag) {
                // 需要删除
                $.ajax({
                    url: "${pageContext.request.contextPath}/ExecuteSQL",
                    type: 'post',
                    dataType: 'json',
                    contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                    data: {
                        sqlStr: "delete from user_gp where user_id=" + userId + " and gp_id =" + oldgpids[i] + ";",
                        id: sessionStorage.getItem("userId"),
                        name: sessionStorage.getItem("userName"),
                        message: "从群组(编号为" + oldgpids[i] + ")中移除了用户(工号为" + userId + ");"
                    },
                    success: function (res) {
                        (res)
                    },
                    error: function (message) {
                        (message)
                    }
                });
            }
        }
        // update
        //location.reload();
        var start = (new Date()).getTime();
        while ((new Date()).getTime() - start < 1000) {
            continue;
        }
        window.alert("修改完毕");
        location.reload();
    }

    function removeGroup(gpid) {
        // 找到在newgpids中的下标
        var idx = 0;
        for (var i = 0; i < newgpids.length; i++) {
            if (newgpids[i] == gpid) {
                idx = i
            }
        }
        // 在newgpids中删除
        newgpids.splice(idx, 1)
        $("#gpname_" + gpid).remove()
    }

    function addGroup() {
        // 新增select中被选中的值
        var id = $("#groupNames :selected").val()
        var name = $("#groupNames :selected").text()
        var flag = false
        for (var i = 0; i < newgpids.length; i++) {
            if (newgpids[i] == id) flag = true;
        }
        if (!flag) {
            var groupdiv = $("#newGroups")
            var newitem = $("<div id='gpname_" + id + "'>" + "<p class='pStyle' style='width:80%;height:30px;float:left;'>" + name + "</p>" + "<button style='width:15%;height:30px;float:left;' class='btn btn-primary  btn-xs' onclick='removeGroup(" + id + ")'>删除</button></br></div>")
            groupdiv.append(newitem)
            newgpids.push(id)
        }
    }

    function returnLastPage() {
        window.history.go(-1);
    }

</script>
