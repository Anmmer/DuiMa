<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!--查询具体群组-->
<div style="height: 100%;width:100%;background-color:white;">
    <!--左栏-->
    <div style="height: 100%;width: 10%;float: left;"></div>
    <div style="height:100%; width:25%;float: left;">
        <div style="height: 30%;width:100%;float: left;">
            <div style="height:70px;width: 100%;float:left;">
                <div style="height:30%;width:100%;float:left;"></div>
                <button onclick="returnLastPage()" class="btn btn-primary">返回</button>
            </div>
            <div class="form-horizontal" style="width:100%;height:30%;float: left;">
                </br>
                <div class="form-group" style="height: 100%">
                    <label for="groupId" style="width: 21%;text-align: left"
                           class="col-sm-2 control-label">角色编号:</label>
                    <input style="width: 40%" class="form-control" id="groupId" disabled placeholder="群组编号"><br>
                    <label for="groupName" style="width: 21%;text-align: left"
                           class="col-sm-2 control-label">角色名称:</label>
                    <input style="width: 40%" class="form-control" id="groupName" disabled placeholder="角色名称:"><br>
                </div>
            </div>
            <%--            <span class="pStyle" style="width:30%;height:30px;line-height:30px;float:left;font-weight: bolder;">群组编号:</span>--%>
            <%--            <span class="pStyle" style="width:70%;height:30px;line-height: 30px;float: left;" name="groupId" id="groupId">Id</span>--%>
            <%--            <div style="height:30px;width: 100%;float:left;"></div>--%>
            <%--            <span class="pStyle" style="width:30%;height:30px;line-height:30px;float: left;font-weight: bolder;">群组名:</span>--%>
            <%--            <span class="pStyle" style="width:70%;height:30px;line-height: 30px;float: left;" name="groupName" id="groupName">Name</span>--%>
        </div>
        <div class="panel panel-default" style="height: 60%;width: 80%;float: left;overflow-y:hidden;">
            <div class="panel-heading">所属于该群组的用户:</div>
            <div id="users" class="panel-body" style="height:100%;overflow-y:auto;">
            </div>
        </div>
        <%--        <span class="pStyle" style="width: 100%;float: left;font-weight: bolder;">所属于该群组的用户:</span>--%>
        <%--        <div style="width:80%;height:80%;overflow-y:auto;" name="users" id="users">--%>
        <%--            <span class="pStyle" style="color: blueviolet;">⚪&nbsp;</span><span class="pStyle">用户1</span><br/>--%>
        <%--        </div>--%>
    </div>
    <!--中栏-->
    <div style="height:100%; width:2px;background-color: cornflowerblue;float: left;"></div>
    <div style="height:100%; width:30%;float: left;">
        <div style="height:16%;width:70%;margin:  18% auto 5% auto;">
            <span style="font-size:17px;font-weight: bolder">新增功能权限:</span>
            <form class="form-horizontal" style="width:100%;height:30%;" name="addFunction">
                <br>
                <br>
                <div class="form-group" style="height: 100%">
                    <label for="chooseFunction" style="width: 25%;text-align: left"
                           class="col-sm-2 control-label">角色编号:</label>
                    <select style="width: 45%" class="form-control" id="chooseFunction"
                            name="chooseFunction"></select><br>
                    <button type="button" style="position: absolute;left: 56%;top: 17%" class="btn btn-primary"
                            onclick="addGroupFunction()">新增
                    </button>
                </div>
            </form>
        </div>
        <div class="panel panel-default" style="height: 60%;width: 70%;overflow-y:hidden;margin: 0 auto;">
            <div class="panel-heading">该群组的功能权限为:</div>
            <div id="functions" class="panel-body" style="height:100%;overflow-y:auto;">
            </div>
        </div>
        <%--        <span class="pStyle" style="font-weight: bolder;width: 90%;">该群组的功能权限为:</span>--%>
        <%--        <div style="height:350px;width:85%;float:left;overflow-y: auto;" id="functions" name="functions">--%>
        <%--            <span class="pStyle" style="color:red;">√&nbsp;</span><span--%>
        <%--                class="pStyle">功能权限1&nbsp;&nbsp;&nbsp;&nbsp;</span><span class="pStyle">-</span><br/>--%>
        <%--        </div>--%>
    </div>
    <!--右栏-->
    <div style="height:100%; width:2px;background-color: cornflowerblue;float: left;"></div>
    <div style="height:100%;width: 30%;float: left;">
        <div style="height:16%;width:70%;margin:  18% auto 5% auto;">
            <span style="font-size:17px;font-weight: bolder">新增工序权限:</span>
            <form class="form-horizontal" style="width:100%;height:30%;" name="addFunction">
                <br>
                <br>
                <div class="form-group" style="height: 100%">
                    <label for="chooseProcessContent" style="width: 25%;text-align: left"
                           class="col-sm-2 control-label">工序权限:</label>
                    <select style="width: 45%" class="form-control" id="chooseProcessContent"
                            name="chooseFunction"></select><br>
                    <button type="button" style="position: absolute;left: 86%;top: 17%" class="btn btn-primary"
                            onclick="addGroupProcessContent()">新增
                    </button>
                </div>
            </form>
        </div>
        <div class="panel panel-default" style="height: 60%;width: 70%;overflow-y:hidden;margin: 0 auto;">
            <div class="panel-heading">该群组的工序权限为:</div>
            <div id="processContents" class="panel-body" style="height:100%;overflow-y:auto;">
            </div>
        </div>
        <%--        <div style="height:100%;width:10%;float: left;"></div>--%>
        <%--        <div style="height:70px;width:90%;float:left;"></div>--%>
        <%--        <span class="pStyle" style="font-weight: bolder;width: 90%;">该群组的工序权限为:</span>--%>
        <%--        <div style="height:350px;width:85%;float:left;overflow-y: auto;" id="processContents" name="processContents">--%>
        <%--            <span class="pStyle" style="color:red;">√&nbsp;</span><span--%>
        <%--                class="pStyle">工序权限1&nbsp;&nbsp;&nbsp;&nbsp;</span><span class="pStyle">-</span><br/>--%>
        <%--        </div>--%>
        <%--        <div style="height:50px;width:90%;float:left;"></div>--%>
        <%--        <div style="height:180px;width:90%;float:left;">--%>
        <%--            <form name="addProcessContent">--%>
        <%--                <span class="pStyle">新增工序权限:</span>--%>
        <%--                <select id="chooseProcessContent" name="chooseProcessContent" size="5"--%>
        <%--                        style="width:200px;font-size:16px;font-family:Simsun;"></select>--%>
        <%--                <div style="width:100%;height:30px;"></div>--%>
        <%--                <button type="button" style="font-size: 16px;font-family: Simsun;" onclick="addGroupProcessContent()">--%>
        <%--                    提交新增--%>
        <%--                </button>--%>
        <%--            </form>--%>
        <%--        </div>--%>
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

    if (!checkAuthority("查看角色群组详情")) {
        window.alert("您无查看角色群组详情的权限")
        location.href = "index.jsp"
    }

    function getQueryVariable(variable) {
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            if (pair[0] == variable) return pair[1];
        }
        return (false);
    }

    var groupId = getQueryVariable("groupId")
    var groupName = decodeURIComponent(getQueryVariable("groupName"))
    // 群组界面数据
    $("#groupId").val(groupId)
    $("#groupName").val(groupName)
    // 用户信息数据获取
    let fieldNamestmp = {
        user_id: "INT",
        user_name: "STRING"
    };
    var fieldNamesStr = JSON.stringify(fieldNamestmp);
    var sqlStrtmp = "select user.user_id,user_name from user,user_gp where user.user_id=user_gp.user_id and gp_id = " + groupId + ";";
    let json = {
        sqlStr: sqlStrtmp,
        fieldNames: fieldNamesStr,
        pageCur: 1,
        pageMax: 10000
    };
    $.ajax({
        url: "${pageContext.request.contextPath}/QuerySQL",
        type: 'post',
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: json,
        success: function (res) {
            var jsonobj = JSON.parse(res.data)
            var strtmp = ""
            for (var i = 0; i < jsonobj.length; i++) {
                strtmp += "<span class='pStyle' style='color: blueviolet;'>⚪&nbsp;</span><span class='pStyle'>" + jsonobj[i]['user_name'] + "</span><br />";
            }
            $("#users").html(strtmp)
        },
        error: function (message) {
        }
    });

    // 功能权限数据获取
    function getFunctions() {
        fieldNamestmp = {
            fa_id: "INT",
            fa_name: "STRING"
        }
        fieldNamesStr = JSON.stringify(fieldNamestmp);
        var sqlStrtmp = "select function_authority.fa_id,fa_name from function_authority,gp_function_authority where function_authority.fa_id = gp_function_authority.fa_id and gp_id=" + groupId + ";";
        json = {
            sqlStr: sqlStrtmp,
            fieldNames: fieldNamesStr,
            pageCur: 1,
            pageMax: 1000
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                var jsonobj = JSON.parse(res.data)
                for (var i = 0; i < jsonobj.length; i++) {
                    var newitem = $("<div></p><p style='width:80%;height:30px;float:left;'>" + jsonobj[i]['fa_name'] + "</p>" + "<button style='width:15%;height:30px;float:left;' class='btn btn-primary btn-sm' onclick='deleteGroupFunction(" + jsonobj[i]['fa_id'] + ")'>删除</button></br></div>")
                    $("#functions").append(newitem);
                }
            },
            error: function (message) {
            }
        });
    }

    getFunctions();

    function getProcessContents() {
        fieldNamestmp = {
            pc_id: "INT",
            pc_name: "STRING"
        }
        fieldNamesStr = JSON.stringify(fieldNamestmp);
        var sqlStrtmp = "select process_content.pc_id,pc_name from process_content,gp_process_content where process_content.pc_id = gp_process_content.pc_id and gp_id=" + groupId + ";";
        json = {
            sqlStr: sqlStrtmp,
            fieldNames: fieldNamesStr,
            pageCur: 1,
            pageMax: 1000
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                var jsonobj = JSON.parse(res.data)
                for (var i = 0; i < jsonobj.length; i++) {
                    var newitem = $("<div></p><p style='width:80%;height:30px;float:left;'>" + jsonobj[i]['pc_name'] + "</p>" + "<button style='width:15%;height:30px;float:left;' class='btn btn-primary btn-sm' onclick='deleteGroupFunction(" + jsonobj[i]['pc_id'] + ")'>删除</button></br></div>")
                    $("#processContents").append(newitem);
                }
            },
            error: function (message) {
            }
        });
    }

    getProcessContents();
    // 新增权限获取数据
    fieldNamestmp = {
        fa_id: "INT",
        fa_name: "STRING"
    }
    fieldNamesStr = JSON.stringify(fieldNamestmp);
    var sqlStrtmp = "select fa_id,fa_name from function_authority;";
    json = {
        sqlStr: sqlStrtmp,
        fieldNames: fieldNamesStr,
        pageCur: 1,
        pageMax: 1000
    }
    $.ajax({
        url: "${pageContext.request.contextPath}/QuerySQL",
        type: 'post',
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: json,
        success: function (res) {
            var jsonobj = JSON.parse(res.data)
            var str = ""
            var functionLists = document.getElementById("chooseFunction")
            functionLists.length = 0
            for (var i = 0; i < jsonobj.length; i++) {
                functionLists.options.add(new Option(jsonobj[i].fa_name, jsonobj[i].fa_id))
            }
        },
        error: function (message) {
        }
    });
    // 新增工序权限获取数据
    fieldNamestmp = {
        pc_id: "INT",
        pc_name: "STRING"
    }
    fieldNamesStr = JSON.stringify(fieldNamestmp);
    var sqlStrtmp = "select pc_id,pc_name from process_content;";
    json = {
        sqlStr: sqlStrtmp,
        fieldNames: fieldNamesStr,
        pageCur: 1,
        pageMax: 1000
    }
    $.ajax({
        url: "${pageContext.request.contextPath}/QuerySQL",
        type: 'post',
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: json,
        success: function (res) {
            var jsonobj = JSON.parse(res.data)
            var str = ""
            var functionLists = document.getElementById("chooseProcessContent")
            functionLists.length = 0
            for (var i = 0; i < jsonobj.length; i++) {
                functionLists.options.add(new Option(jsonobj[i].pc_name, jsonobj[i].pc_id))
            }
        },
        error: function (message) {
        }
    });

    // 新增groupfunction
    function addGroupFunction() {
        if (!checkAuthority("修改角色群组")) {
            window.alert("您无修改角色群组的权限")
            return
        }
        var groupId = $("#groupId").text();
        var faId = $("#chooseFunction").val();
        json = {
            groupId: groupId,
            faId: faId,
            id: sessionStorage.getItem("userId"),
            name: sessionStorage.getItem("userName")
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/AddGroupFunction",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                window.alert(res.message)
                // 刷新功能权限
                getFunctions();
            },
            error: function (message) {
            }
        });
    }

    // 新增工序
    function addGroupProcessContent() {
        if (!checkAuthority("修改角色群组")) {
            window.alert("您无修改角色群组的权限")
            return
        }
        var groupId = $("#groupId").text();
        var pcId = $("#chooseProcessContent").val();
        json = {
            groupId: groupId,
            pcId: pcId,
            id: sessionStorage.getItem("userId"),
            name: sessionStorage.getItem("userName")
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/AddGroupProcessContent",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                window.alert(res.message)
                // 刷新功能权限
                getProcessContents();
            },
            error: function (message) {
            }
        });
    }

    // 删除groupfunction
    function deleteGroupFunction(id) {
        if (!checkAuthority("修改角色群组")) {
            window.alert("您无修改角色群组的权限")
            return
        }
        var groupId = $("#groupId").text()
        var sqlStr = "delete from gp_function_authority where gp_id=" + groupId + " and fa_id=" + id + ";";
        var json = {
            sqlStr: sqlStr,
            id: sessionStorage.getItem("userId"),
            name: sessionStorage.getItem("userName"),
            message: "移除了编号为" + groupId + "的群组的功能权限(编号为" + id + ")"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/ExecuteSQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                getFunctions()
            },
            error: function (message) {
            }
        });
    }

    // 删除工序权限
    function deleteGroupProcessContent(id) {
        if (!checkAuthority("修改角色群组")) {
            window.alert("您无修改角色群组的权限")
            return
        }
        var groupId = $("#groupId").text()
        var sqlStr = "delete from gp_process_content where gp_id=" + groupId + " and pc_id=" + id + ";";
        var json = {
            sqlStr: sqlStr,
            id: sessionStorage.getItem("userId"),
            name: sessionStorage.getItem("userName"),
            message: "移除了群组(编号为" + groupId + ")的权限(编号为" + id + ")"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/ExecuteSQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                getProcessContents()
            },
            error: function (message) {
            }
        });
    }

    function returnLastPage() {
        window.history.go(-1);
    }
</script>
