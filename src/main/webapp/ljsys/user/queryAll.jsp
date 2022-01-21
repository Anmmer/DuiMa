<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="javascript">
    var pageCur = 1;
    var pageAll = 1;
</script>
<div style="height: 100%;width:100%;background-color:white;overflow: hidden">
    <form name="query" class="form-inline" style="width:70%;height:10%;margin: 2% auto 0">
        <div class="form-group">
            <label>工号：</label><input type="text" name="userId"
                                     style="height:10%;" class="form-control">
        </div>
        <div class="form-group" style="margin-left:5%;">
            <label>姓名：</label><input type="text" name="userName"
                                     style="height:10%;" class="form-control">
        </div>
        <button type="button" class="btn btn-primary" style="height:50%;margin-left: 5%" onclick="updateTable(1)">
            模糊查询
        </button>
    </form>
    <div style="width:70%;height:90%;margin:0 auto;">
        <!--表格显示-->
        <%--            <!--结果显示提示：一共有多少记录，共几页-->--%>
        <%--            <p id="resultTip" style="margin-top: 0px;font-family: Simsun;font-size: 16px">请在上方输入框内输入相应信息并点击“模糊查询按钮”</p>--%>
        <%--            <form name="jumpPage" style="font-family: Simsun;font-size:16px;" onsubmit="return false;">--%>
        <%--                <span>输入页码进行跳转:</span><input type="text" name="page" class="FormInputStyle">--%>
        <%--                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage2()">跳转</button>--%>
        <%--            </form>--%>
        <div style="width:100%;height:5%;text-align: center"><h4 style="margin-top: 0px">用户信息</h4></div>
        <table class="table table-hover" style="height: 75%;font-size: 15px">
            <tr>
                <td style="width: 35%">工号</td>
                <td style="width: 35%">姓名</td>
                <td style="width: 30%;text-align: center">操作</td>
            </tr>
            <tbody id="tableText">
            </tbody>
        </table>
        <nav aria-label="Page navigation" style="margin-left:50%;width:80%;height:10%;">
            <ul class="pagination" style="margin-top: 0;width: 70%">
                <li><span id="total" style="width: 15%"></span></li>
                <li>
                    <a href="#" onclick="jumpToNewPage(2)" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li>
                    <a href="#" onclick="jumpToNewPage(3)" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                <li style="border: none"><span>跳转：</span></li>
                <li class="input-group">
                    <input type="text" class="form-control" style="width: 10%">
                </li>
                <li><a>go!</a></li>
            </ul>
        </nav>

        <%--        <div style="width:100%;height:10%;">--%>

        <%--            <div style="width:33%;float: left;">--%>
        <%--                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage(1)">第一页--%>
        <%--                </button>--%>
        <%--                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage(2)">前一页--%>
        <%--                </button>--%>
        <%--            </div>--%>
        <%--            <div style="width:33%;float: left;">--%>
        <%--                <p id="resultTip2" style="margin-top: 0px;font-family: Simsun;font-size: 16px;text-align: center;">--%>
        <%--                    1/1</p>--%>
        <%--            </div>--%>
        <%--            <div style="width:33%;float: left;">--%>
        <%--                <button type="button" style="font-family: Simsun;font-size:16px;float:right;"--%>
        <%--                        onclick="jumpToNewPage(4)">最后一页--%>
        <%--                </button>--%>
        <%--                <button type="button" style="font-family: Simsun;font-size:16px;float:right;"--%>
        <%--                        onclick="jumpToNewPage(3)">后一页--%>
        <%--                </button>--%>
        <%--            </div>--%>
        <%--        </div>--%>
        <%--        <form style="width: 100%;height: 10%" type="multipart/form-data">--%>
        <%--            <input type="file" id="file1">--%>
        <%--            <button type="button" value="提交" onclick="test()">提交</button>--%>
        <%--        </form>--%>
    </div>
</div>

<!-- 查询所有用户 -->
<script type="text/javascript">
    function updateTable(newpage) {
        let fieldNamestmp = {
            user_id: "INT",
            user_name: "STRING"
        };
        var fieldNamesStr = JSON.stringify(fieldNamestmp);
        var userId = document.forms["query"]["userId"].value;
        var userName = document.forms["query"]["userName"].value;
        var sqlStrtmp = "select user_id,user_name from user where user_status = 1 and user_id like '%" + userId + "%' and user_name like '%" + userName + "%';";
        let json = {
            sqlStr: sqlStrtmp,
            fieldNames: fieldNamesStr,
            pageCur: newpage,
            pageMax: 10
        };
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                // 将结果输出到table
                var str = "";
                var jsonobj = JSON.parse(res.data);
                for (var i = 0; i < jsonobj.length; i++) {
                    str += "<tr><td>" + jsonobj[i]['user_id'] +
                        "</td><td>" + jsonobj[i]['user_name'] +
                        "</td><td style='text-align: center'>";
                    // 查询
                    str += "<a href='userInfo.jsp?userId=" + jsonobj[i]['user_id'] + "&userName=" + jsonobj[i]['user_name'] + "'>详情</a>&nbsp";
                    str += "<a href='userModify.jsp?userId=" + jsonobj[i]['user_id'] + "&userName=" + jsonobj[i]['user_name'] + "'>修改</a>&nbsp";
                    str += "<a href='javascript:void(0);' onclick='deleteUser(" + jsonobj[i]['user_id'] + ")'>删除</a>";
                    str += "</td></tr>"
                }
                $("#tableText").html(str);
                // 提示语
                var tipStr = "共查询到" + res.cnt + "条记录,结果共有" + res.pageAll + "页!"
                $('#total').html('共' + res.pageAll + "页");
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
            user_id: "INT",
            user_name: "STRING"
        };
        var fieldNamesStr = JSON.stringify(fieldNamestmp);
        var userId = document.forms["query"]["userId"].value;
        var userName = document.forms["query"]["userName"].value;
        var sqlStrtmp = "select user_id,user_name from user where user_status = 1 and user_id like '%" + userId + "%' and user_name like '%" + userName + "%';";
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
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                // 将结果输出到table
                var str = "";
                var jsonobj = JSON.parse(res.data);
                (jsonobj)
                for (var i = 0; i < jsonobj.length; i++) {
                    str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['user_id'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['user_name'] +
                        "</td><td class='tdStyle_body'>";
                    // 查询
                    str += "<a href='userInfo.jsp?userId=" + jsonobj[i]['user_id'] + "&userName=" + jsonobj[i]['user_name'] + "'>详情</a>&nbsp";
                    str += "<a href='userModify.jsp?userId=" + jsonobj[i]['user_id'] + "&userName=" + jsonobj[i]['user_name'] + "'>修改</a>&nbsp";
                    str += "<a href='javascript:void(0);' onclick='deleteUser(" + jsonobj[i]['user_id'] + ")'>删除</a>";
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
            user_id: "INT",
            user_name: "STRING"
        };
        var fieldNamesStr = JSON.stringify(fieldNamestmp);
        var userId = document.forms["query"]["userId"].value;
        var userName = document.forms["query"]["userName"].value;
        var sqlStrtmp = "select user_id,user_name from user where user_status = 1 and user_id like '%" + userId + "%' and user_name like '%" + userName + "%';";
        var newpageStr = document.forms["jumpPage"]["page"].value;
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
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                // 将结果输出到table
                var str = "";
                var jsonobj = JSON.parse(res.data);
                (jsonobj)
                for (var i = 0; i < jsonobj.length; i++) {
                    str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['user_id'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['user_name'] +
                        "</td><td class='tdStyle_body'>";
                    // 查询
                    str += "<a href='userInfo.jsp?userId=" + jsonobj[i]['user_id'] + "&userName=" + jsonobj[i]['user_name'] + "'>详情</a>&nbsp";
                    str += "<a href='userModify.jsp?userId=" + jsonobj[i]['user_id'] + "&userName=" + jsonobj[i]['user_name'] + "'>修改</a>&nbsp";
                    str += "<a href='javascript:void(0);' onclick='deleteUser(" + jsonobj[i]['user_id'] + ")'>删除</a>";
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

    function test() {
        var type = "file";
        var formData = new FormData();
        formData.append(type, $("#file1")[0].files[0]);
        $.ajax({
            url: "${pageContext.request.contextPath}/UserBatchInsert",
            type: 'post',
            data: formData,
            processData: false,
            contentType: false,
            success: function (res) {
                // 将结果输出到table
                (res)
            },
            error: function (message) {
                (message)
            }
        });
    }

    function deleteUser(userid) {
        if (!checkAuthority("删除用户")) {
            window.alert("您无删除用户的权限!")
            return
        }
        var sqlStr = "update user set user_status = 0 where user_id =" + userid + ";";
        $.ajax({
            url: "${pageContext.request.contextPath}/ExecuteSQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                sqlStr: sqlStr,
                id: sessionStorage.getItem("userId"),
                name: sessionStorage.getItem("userName"),
                message: "删除了用户(编号为" + userid + ")"
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

    function checkAuthority(au) {
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for (var i = 0; i < authority.length; i++) {
            if (authority[i].fa_name == au) flag = true;
        }
        return flag;
    }
</script>
