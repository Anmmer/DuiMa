<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!--查询具体群组-->
<div style="height: 100%;width:100%;background-color:white;">
    <!--左栏-->
    <div style="height: 100%;width: 10%;float: left;"></div>
    <div style="height:100%; width:25%;float: left;">
        <div style="height: 30%;width:100%;float: left;">
            <div style="margin-top:10%;margin-bottom:5%;width: 100%;">
                <button onclick="returnLastPage()" class="btn btn-primary btn-sm">返回</button>
            </div>
            <div class="form-inline" style="width:100%;">
                <br>
                <div class="form-group">
                    <label for="groupId">角色编号：</label>
                    <input style="width: 60%" class="form-control" id="groupId" disabled placeholder="群组编号">
                </div>
                <br>
                <br>
                <div class="form-group">
                    <label for="groupName">角色名称：</label>
                    <input style="width: 60%" class="form-control" id="groupName" disabled placeholder="角色名称:">
                </div>
            </div>
        </div>
        <div class="panel panel-default" style="height: 60%;width: 80%;overflow-y:hidden;">
            <div class="panel-heading">所属于该群组的用户:</div>
            <div id="users" class="panel-body" style="height:100%;overflow-y:auto;">
            </div>
        </div>
    </div>
    <!--中栏-->
    <div style="height:100%; width:2px;background-color: cornflowerblue;float: left;"></div>
    <div style="height:100%; width:30%;float: left;">
        <div style="height:16%;width:70%;margin:  18% auto 5% auto;">
            <span style="font-size:17px;font-weight: bolder">网页权限管理:</span>
            <br>
            <br>
            <br>
            <br>
            <button type="button" class="btn btn-primary btn-sm"
                    onclick="addGroupFunction()">保存
            </button>
        </div>
        <div class="panel panel-default" style="height: 60%;width: 75%;overflow-y:hidden;margin: 0 auto;">
            <div class="panel-heading">该群组的功能权限:</div>
            <div id="functions" class="panel-body" style="height:100%;overflow-y:auto;">
            </div>
        </div>
    </div>
    <!--右栏-->
    <div style="height:100%; width:2px;background-color: cornflowerblue;float: left;"></div>
    <div style="height:100%;width: 30%;float: left;">
        <div style="height:16%;width:70%;margin:  18% auto 5% auto;">
            <span style="font-size:17px;font-weight: bolder">小程序权限管理:</span>
            <br>
            <br>
            <br>
            <br>
            <button type="button" style="" class="btn btn-primary btn-sm"
                    onclick="addGroupProcessContent()">保存
            </button>
        </div>
        <div class="panel panel-default" style="height: 60%;width: 70%;overflow-y:hidden;margin: 0 auto;">
            <div class="panel-heading">该群组的工序权限为:</div>
            <div id="processContents" class="panel-body" style="height:100%;overflow-y:auto;">
            </div>
        </div>
    </div>
</div>
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
                    $("#checkbox_" + jsonobj[i]['fa_id']).prop("checked", true);
                }
            },
            error: function (message) {
            }
        });
    }


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
                minAuthority = jsonobj
                for (var i = 0; i < jsonobj.length; i++) {
                    $("#pccheckbox_" + jsonobj[i]['pc_id']).prop("checked", true);
                }
            },
            error: function (message) {
            }
        });
    }

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
            $("#functions").empty();
            for (var i = 0; i < jsonobj.length - 1; i++) {
                var newitem = $("<div style='height:40px;'><input id='checkbox_" + jsonobj[i].fa_id + "' type='checkbox' data-id=" + jsonobj[i].fa_id + "><p style='width:85%;height:30px;float:left;'>" + jsonobj[i]['fa_name'] + "</p>" + "</br></div>")
                $("#functions").append(newitem);
            }
            var newitem = $("<div style='height:50px;'><input id='checkbox_" + jsonobj[i].fa_id + "' type='checkbox' data-id=" + jsonobj[jsonobj.length - 1].fa_id + "><p style='width:85%;height:30px;float:left;'>" + jsonobj[i]['fa_name'] + "</p>" + "</br></div>")
            $("#functions").append(newitem);
        },
        error: function (message) {
        }
    }).then(() =>
        getFunctions()
    );

    let minAuthority;
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
            $("#processContents").empty();
            for (var i = 0; i < jsonobj.length; i++) {
                var newitem = $("<div style='height: 40px'><input id='pccheckbox_" + jsonobj[i].pc_id + "' type='checkbox' data-id=" + jsonobj[i].pc_id + "><p style='width:85%;height:30px;float:left;'>" + jsonobj[i]['pc_name'] + "</p>" + "</br></div>")
                $("#processContents").append(newitem);
            }
        },
        error: function (message) {
        }
    }).then(() => getProcessContents());

    // 新增groupfunction
    function addGroupFunction() {
        let groupIds = [];
        $('#functions').find('input:checked').each(function () {
            groupIds.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组pids
        });
        if (groupIds.length === 0) {
            alert("请勾选！")
            return;
        }
        let authority = JSON.parse(sessionStorage.getItem("authority"));
        json = {
            groupIds: JSON.stringify(groupIds),
            groupId: groupId,
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
        let groupId = $("#groupId").val();
        let groupIds = []
        $('#processContents').find('input:checked').each(function () {
            groupIds.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组pids
        });
        if (groupIds.length === 0) {
            alert("请勾选！")
            return;
        }
        console.log(minAuthority.length)
        if (groupIds.length === minAuthority.length) {
            return;
        }
        json = {
            groupId: groupId,
            groupIds: JSON.stringify(groupIds),
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
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }
        var groupId = $("#groupId").val()
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
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }
        var groupId = $("#groupId").val()
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
