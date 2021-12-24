<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!--查询所有群组-->
<script type="text/javascript">
    var pageCur = 1;
    var pageAll = 1;

    function checkAuthority(au) {
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for (var i = 0; i < authority.length; i++) {
            if (authority[i].fa_name == au) flag = true;
        }
        return flag;
    }
</script>
<div style="height: 95%;width:100%;background-color:white;">
    <div style="width:100%;height:10%;">
        <form name="query" style="font-family: Simsun;font-size:16px;">
            <div style="width:100%;height: 16px;float: left;"></div>
            <div style="width:70%;margin:0 auto;">
                <div style="width:40%;float: left;">
                    <span>群组编号:</span><input type="text" name="gpId" class="FormInputStyle">
                </div>
                <div style="width:40%;float: left;">
                    <span>群组角色名:</span><input type="text" name="gpName" class="FormInputStyle">
                </div>
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="updateTable(1)">模糊查询</button>
            </div>
        </form>
    </div>
    <div style="width:100%;height:90%;">
        <!--表格显示-->
        <div style="width:70%;height:80%;margin:0 auto;">
            <!--结果显示提示：一共有多少记录，共几页-->
            <p id="resultTip" style="margin-top: 0px;font-family: Simsun;font-size: 16px">请在上方输入框内输入相应信息并点击“模糊查询按钮”</p>
            <label for="page" class="pStyle">输入页码进行跳转:</label><input type="text" id="page" class="FormInputStyle">
            <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage2()">跳转</button>
            <label for="newGroupName" class="pStyle" style="margin-left: 5%">新增群组名:</label>
            <input type="text" id="newGroupName" name="newGroupName" style="font-size: 16px;font-family: Simsum;">
            <button type="button" style="font-size: 16px;font-family: Simsun;margin-left: 4%" onclick="addGroup()">提交新增</button>
            <div style="width:100%;height:10px;"></div>
            <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                <tr>
                    <td class='tdStyle_title'>群组编号</td>
                    <td class='tdStyle_title'>群组角色名</td>
                    <td class='tdStyle_title'>操作</td>
                </tr>
                <tbody id="tableText">
                </tbody>
            </table>
            <div style="width:100%;height:30px;"></div>
            <div style="width:33%;float: left;">
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage(1)">第一页
                </button>
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage(2)">前一页
                </button>
            </div>
            <div style="width:33%;float: left;">
                <p id="resultTip2" style="margin-top: 0px;font-family: Simsun;font-size: 16px;text-align: center;">
                    1/1</p>
            </div>
            <div style="width:33%;float: left;">
                <button type="button" style="font-family: Simsun;font-size:16px;float:right;"
                        onclick="jumpToNewPage(4)">最后一页
                </button>
                <button type="button" style="font-family: Simsun;font-size:16px;float:right;"
                        onclick="jumpToNewPage(3)">后一页
                </button>
            </div>
        </div>
    </div>
    <!-- 查询所有群组 -->
    <script type="text/javascript">
        function updateTable(newpage) {
            let fieldNamestmp = {
                gp_id: "INT",
                gp_name: "STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var gpId = document.forms["query"]["gpId"].value;
            var gpName = document.forms["query"]["gpName"].value;
            var sqlStrtmp = "select gp_id,gp_name from gp where gp_status = 1 and gp_id like '%" + gpId + "%' and gp_name like '%" + gpName + "%';";
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames: fieldNamesStr,
                pageCur: newpage,
                pageMax: 15
            };
            $.ajax({
                url: "http://localhost:8989/DuiMa_war_exploded/QuerySQL",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: json,
                success: function (res) {
                    // 将结果输出到table
                    (json)
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    (jsonobj)
                    for (var i = 0; i < jsonobj.length; i++) {
                        str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['gp_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['gp_name'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "<a href='groupInfo.jsp?groupId=" + jsonobj[i]['gp_id'] + "&groupName=" + encodeURIComponent(jsonobj[i]['gp_name']) + "'>详情</a>"
                        str += "&nbsp &nbsp<a href='javascript:void(0);' onclick='deleteGroup(" + jsonobj[i]['gp_id'] + ")'>删除</a>"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    // 提示语
                    var tipStr = "共查询到" + res.cnt + "条记录,结果共有" + res.pageAll + "页!"
                    $("#resultTip").html(tipStr);
                    // 重置查询为第一页
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    var tipStr2 = pageCur + "/" + pageAll;
                    $("#resultTip2").html(tipStr2)
                },
                error: function (message) {
                    (json)
                    (message)
                }
            });
        }

        updateTable(1);

        function jumpToNewPage(newpageCode) {
            let fieldNamestmp = {
                gp_id: "INT",
                gp_name: "STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var gpId = document.forms["query"]["gpId"].value;
            var gpName = document.forms["query"]["gpName"].value;
            var sqlStrtmp = "select gp_id,gp_name from gp where gp_status = 1 and gp_id like '%" + gpId + "%' and gp_name like '%" + gpName + "%';";
            var newpage = 1;
            if (newpageCode == 1) newpage = 1;
            if (newpageCode == 2) {
                if (pageCur == 1) {
                    window.alert("已经在第一页!");
                    return
                } else {
                    newpage = pageCur - 1;
                }
            }
            if (newpageCode == 3) {
                if (pageCur == pageAll) {
                    window.alert("已经在最后一页!");
                    return
                } else {
                    newpage = pageCur + 1;
                }
            }
            if (newpageCode == 4) newpage = pageAll;
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames: fieldNamesStr,
                pageCur: newpage,
                pageMax: 15
            };
            $.ajax({
                url: "http://localhost:8989/DuiMa_war_exploded/QuerySQL",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: json,
                success: function (res) {
                    // 将结果输出到table
                    (json)
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    (jsonobj)
                    for (var i = 0; i < jsonobj.length; i++) {
                        str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['gp_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['gp_name'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "<a href='groupInfo.jsp?groupId=" + jsonobj[i]['gp_id'] + "&groupName=" + encodeURIComponent(jsonobj[i]['gp_name']) + "'>详情</a>"
                        str += "&nbsp &nbsp<a href='javascript:void(0);' onclick='deleteGroup(" + jsonobj[i]['gp_id'] + ")'>删除</a>"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    // 提示语
                    var tipStr = "共查询到" + res.cnt + "条记录,结果共有" + res.pageAll + "页!"
                    $("#resultTip").html(tipStr);
                    // 重置查询为第一页
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    var tipStr2 = pageCur + "/" + pageAll;
                    $("#resultTip2").html(tipStr2)
                },
                error: function (message) {
                    (json)
                    (message)
                }
            });
        }

        function jumpToNewPage2() {
            let fieldNamestmp = {
                gp_id: "INT",
                gp_name: "STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var gpId = document.forms["query"]["gpId"].value;
            var gpName = document.forms["query"]["gpName"].value;
            var sqlStrtmp = "select gp_id,gp_name from gp where gp_status = 1 and gp_id like '%" + gpId + "%' and gp_name like '%" + gpName + "%';";
            var newpageStr = $('#page').val();
            var newpage = parseInt(newpageStr)
            (newpage)
            if (newpage <= 0 || newpage > pageAll || isNaN(newpage)) {
                window.alert("请输入一个在范围内的正确页码数字!")
                return
            }
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames: fieldNamesStr,
                pageCur: newpage,
                pageMax: 15
            };
            $.ajax({
                url: "http://localhost:8989/DuiMa_war_exploded/QuerySQL",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: json,
                success: function (res) {
                    // 将结果输出到table
                    (json)
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    (jsonobj)
                    for (var i = 0; i < jsonobj.length; i++) {
                        str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['gp_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['gp_name'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "<a href='groupInfo.jsp?groupId=" + jsonobj[i]['gp_id'] + "&groupName=" + encodeURIComponent(jsonobj[i]['gp_name']) + "'>详情</a>"
                        str += "&nbsp &nbsp<a href='javascript:void(0);' onclick='deleteGroup(" + jsonobj[i]['gp_id'] + ")'>删除</a>"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    // 提示语
                    var tipStr = "共查询到" + res.cnt + "条记录,结果共有" + res.pageAll + "页!"
                    $("#resultTip").html(tipStr);
                    // 重置查询为第一页
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    var tipStr2 = pageCur + "/" + pageAll;
                    $("#resultTip2").html(tipStr2)
                },
                error: function (message) {
                    (json)
                    (message)
                }
            });
        }

        function addGroup() {
            if (!checkAuthority("新增角色群组")) {
                window.alert("您无新增角色群组的权限!")
                return;
            }
            var newGroupName = $("#newGroupName").val()
            (newGroupName)
            var json = {
                groupName: newGroupName,
                id: sessionStorage.getItem("userId"),
                name: sessionStorage.getItem("userName")
            }
            $.ajax({
                url: "http://localhost:8989/DuiMa_war_exploded/AddGroup",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: json,
                success: function (res) {
                    (res)
                    updateTable(1);
                    window.alert(res.message)
                },
                error: function (message) {
                    (message)
                }
            });
        }

        function deleteGroup(gpid) {
            if (!checkAuthority("删除角色群组")) {
                window.alert("您无删除角色群组的权限!")
                return;
            }
            var sqlStr = "update gp set gp_status = 0 where gp_id = " + gpid + ";";
            $.ajax({
                url: "http://localhost:8989/DuiMa_war_exploded/ExecuteSQL",
                type: 'post',
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded;charset=utf-8',
                data: {
                    sqlStr: sqlStr,
                    id: sessionStorage.getItem("userId"),
                    name: sessionStorage.getItem("userName"),
                    message: "删除了角色群组(编号为" + gpid + ")"
                },
                success: function (res) {
                    (res)
                    updateTable(pageCur)
                },
                error: function (message) {
                    (message)
                }
            });
        }
    </script>
</div>
