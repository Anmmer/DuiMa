<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="javascript">
    var pageCur = 1;
    var pageAll = 1;
</script>
<div style="height: 100%;width:100%;background-color:white;overflow: hidden">
    <form name="query" class="form-inline" style="width:70%;height:8%;margin: 2% auto 0">
        <div class="form-group">
            <label>工号：</label><input type="text" name="userId"
                                     style="height:10%;" class="form-control">
        </div>
        <div class="form-group" style="margin-left:5%;">
            <label>姓名：</label><input type="text" name="userName"
                                     style="height:10%;" class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="updateTable(1)">
            查 询
        </button>
    </form>
    <div style="width:70%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>用户信息</small></h3>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class="tdStyle_title active" style="width: 35%">工号</td>
                    <td class="tdStyle_title active" style="width: 35%">姓名</td>
                    <td class="tdStyle_title active" style="width: 30%;text-align: center">操作</td>
                </tr>
                <tbody id="tableText">
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" style="margin-left:50%;width:80%;height:10%;">
            <ul class="pagination" style="margin-top: 0;width: 70%">
                <li><span id="total" style="width: 22%"></span></li>
                <li>
                    <a href="#" onclick="jumpToNewPage(2)" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <li id="li_1"><a id="a_1" href="#">1</a></li>
                <li id="li_2"><a id="a_2" href="#">2</a></li>
                <li id="li_3"><a id="a_3" href="#">3</a></li>
                <li id="li_4"><a id="a_4" href="#">4</a></li>
                <li id="li_0"><a id="a_0" href="#">5</a></li>
                <li>
                    <a href="#" onclick="jumpToNewPage(3)" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                <li style="border: none"><span>跳转：</span></li>
                <li class="input-group">
                    <input type="text" id="jump_to" class="form-control" style="width: 10%">
                </li>
                <li><a href="#" onclick="jumpToNewPage2()">go!</a></li>
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
                $('#total').html(res.cnt + "条，共" + res.pageAll + "页");
                $('#li_1').addClass('active');
                // 重置查询为第一页
                pageCur = newpage;
                // 重置总页数
                pageAll = parseInt(res.pageAll);
                for (let i = 1; i < 6; i++) {
                    let k = i % 5;
                    if (i > pageAll) {
                        $('#a_' + k).text('.');
                    } else {
                        if (k === 0) {
                            $('#a_' + k).text(5);
                            $('#a_' + k).attr('onclick', 'jumpToNewPage1(5)');
                            continue;
                        } else {
                            $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + k + ')');
                        }
                    }
                }
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
                (jsonobj)
                for (var i = 0; i < jsonobj.length; i++) {
                    str += "<tr><td >" + jsonobj[i]['user_id'] +
                        "</td><td >" + jsonobj[i]['user_name'] +
                        "</td><td style='text-align: center'>";
                    // 查询
                    str += "<a href='userInfo.jsp?userId=" + jsonobj[i]['user_id'] + "&userName=" + jsonobj[i]['user_name'] + "'>详情</a>&nbsp";
                    str += "<a href='userModify.jsp?userId=" + jsonobj[i]['user_id'] + "&userName=" + jsonobj[i]['user_name'] + "'>修改</a>&nbsp";
                    str += "<a href='javascript:void(0);' onclick='deleteUser(" + jsonobj[i]['user_id'] + ")'>删除</a>";
                    str += "</td></tr>"
                }
                $("#tableText").html(str);
                if (newpageCode === 3) {
                    setFooter(3, res.pageAll, pageCur, newpage);
                }
                if (newpageCode === 2) {
                    setFooter(2, res.pageAll, pageCur, newpage);
                }
                // 重置查询为第一页
                pageCur = newpage;
                // 重置总页数
                pageAll = parseInt(res.pageAll);
            },
            error: function (message) {
                (json)
                (message)
            }
        });
    }

    function jumpToNewPage1(newPage) {
        if (newPage == pageCur) {
            return;
        }
        let fieldNamestmp = {
            user_id: "INT",
            user_name: "STRING"
        };
        var fieldNamesStr = JSON.stringify(fieldNamestmp);
        var userId = document.forms["query"]["userId"].value;
        var userName = document.forms["query"]["userName"].value;
        var sqlStrtmp = "select user_id,user_name from user where user_status = 1 and user_id like '%" + userId + "%' and user_name like '%" + userName + "%';";
        if (newPage <= 0 || newPage > pageAll || isNaN(newPage)) {
            window.alert("请输入一个在范围内的正确页码数字!")
            return
        }
        let json = {
            sqlStr: sqlStrtmp,
            fieldNames: fieldNamesStr,
            pageCur: newPage,
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
                $('#li_' + newPage % 5).addClass('active');
                $('#li_' + pageCur % 5).removeClass('active');
                pageCur = newPage;
            },
            error: function (message) {
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
        var newpageStr = $('#jump_to').val();
        var newpage = parseInt(newpageStr)
        if (newpage <= 0 || newpage > pageAll || isNaN(newpage)) {
            window.alert("请输入一个在范围内的正确页码数字!")
            return
        }
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
                jump2(newpage, res.pageAll);
                // 重置查询为第一页
                pageCur = newpage;
                // 重置总页数
                pageAll = parseInt(res.pageAll);
            },
            error: function (message) {
                (json)
                (message)
            }
        });
    }

    function jump2(newpage, pageAll) {
        if (newpage <= 5) {
            for (let i = 1; i < 6; i++) {
                let k = i % 5;
                if (i > pageAll) {
                    $('#a_' + k).text('.');
                } else {
                    if (k === 0) {
                        $('#a_' + k).text(5);
                    } else {
                        $('#a_' + k).text(k);
                        $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + k + ')');
                    }
                }
            }
            $('#li_' + pageCur % 5).removeClass('active');
            $('#li_' + newpage % 5).addClass('active');
        } else {
            let j = Math.floor(newpage / 5);
            let m = j * 5;
            for (let i = 1; i < 6; i++) {
                let k = i % 5;
                if (++m > pageAll) {
                    $('#a_' + k).text('.');
                } else {
                    $('#a_' + k).text(m);
                    $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + m + ')');
                }
            }
            $('#li_' + pageCur % 5).removeClass('active');
            $('#li_' + newpage % 5).addClass('active');
        }
    }

    function setFooter(newpageCode, pageAll, pageCur, newpage) {
        if (newpageCode === 3) {
            if (pageCur % 5 === 0) {
                let j = Math.floor(newpage / 5);
                let m = j * 5;
                for (let i = 1; i < 6; i++) {
                    let k = i % 5;
                    if (++m > pageAll) {
                        $('#a_' + k).text('.');
                    } else {
                        $('#a_' + k).text(m);
                        $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + m + ')');
                    }
                }

            }
            $('#li_' + newpage % 5).addClass('active');
            $('#li_' + pageCur % 5).removeClass('active');
        } else {
            if (pageCur % 5 === 1) {
                let j = Math.floor(newpage / 5);
                let m
                if (j < 0) {
                    m = 5;    //5*1
                } else {
                    m = j * 5;
                }
                for (let i = 5; i > 0; i--) {
                    let k = i % 5;
                    if (m > pageAll) {
                        $('#a_' + k).text('');
                        m--;
                    } else {
                        $('#a_' + k).text(m);
                        $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + m-- + ')');
                    }
                }
            }
            $('#li_' + newpage % 5).addClass('active');
            $('#li_' + pageCur % 5).removeClass('active');
        }
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
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
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
