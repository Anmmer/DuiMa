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
<div style="height: 100%;width:100%;background-color:white;margin:0 auto;">
    <div style="width:100%;">
        <form name="query" class="form-inline" style="width:70%;height:8%;margin: 2% auto 0">
            <div class="form-group">
                <label>群组编号：</label><input type="text" name="gpId"
                                           style="height:10%;" class="form-control">
            </div>
            <div class="form-group" style="margin-left:5%;">
                <label>群组角色名：</label><input type="text" name="gpName"
                                            style="height:10%;" class="form-control">
            </div>
            <button type="button" class="btn btn-primary" style="height:60%;margin-left: 5%" onclick="updateTable(1)">
                模糊查询
            </button>
        </form>
        <%--        <form name="query" style="font-family: Simsun;font-size:16px;">--%>
        <%--            <div style="width:100%;height: 16px;float: left;"></div>--%>
        <%--            <div style="width:70%;margin:0 auto;">--%>
        <%--                <div style="width:40%;float: left;">--%>
        <%--                    <span>群组编号:</span><input type="text" name="gpId" class="FormInputStyle">--%>
        <%--                </div>--%>
        <%--                <div style="width:40%;float: left;">--%>
        <%--                    <span>群组角色名:</span><input type="text" name="gpName" class="FormInputStyle">--%>
        <%--                </div>--%>
        <%--                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="updateTable(1)">模糊查询</button>--%>
        <%--            </div>--%>
        <%--        </form>--%>
    </div>
    <div style="width:70%;height:80%;margin:0 auto;">
        <!--表格显示-->
        <%--        <label for="page" class="pStyle">输入页码进行跳转:</label><input type="text" id="page" class="FormInputStyle">--%>
        <%--        <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage2()">跳转</button>--%>
        <%--        <label for="newGroupName" class="pStyle" style="margin-left: 5%">新增群组名:</label>--%>
        <%--        <input type="text" id="newGroupName" name="newGroupName" style="font-size: 16px;font-family: Simsum;">--%>
        <%--        <button type="button" style="font-size: 16px;font-family: Simsun;margin-left: 4%" onclick="addGroup()">提交新增--%>
        <%--        </button>--%>
        <div class="page-header" style="margin-top: 3%;margin-bottom: 1%;width: 100%">
            <h3 style="margin-bottom: 0;margin-top: 0;margin-right:0;width: 50% "><small>角色信息</small></h3>
            <button type="button" style="position: absolute;right: 15%;top:11%" class="btn btn-primary"
                    data-toggle="modal"
                    data-target="#myModal">
                添加角色
            </button>
        </div>
        <!-- Button trigger modal -->
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class="active" style="width: 35%">群组编号</td>
                    <td class="active" style="width: 35%">群组角色名</td>
                    <td class="active" style="width: 30%;">操作</td>
                </tr>
                <tbody id="tableText">
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" style="margin-left:50%;width:80%;height:10%;">
            <ul class="pagination" style="margin-top: 0;width: 70%">
                <li><span id="total" style="width: 18%"></span></li>
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
    </div>
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" style="position: absolute;left: 1%;top: 12%;" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:60%">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">添加角色</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group" style="height: 100%;margin-top: 5%">
                            <label for="newGroupName" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">新增群组名:</label>
                            <input type="text" class="form-control" style="width:50%;" id="newGroupName"
                                   name="newGroupName">
                            <%--                            <button type="button" class="btn btn-primary">提交新增</button>--%>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                    <button type="button" class="btn btn-primary" onclick="addGroup()">保存</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 查询所有群组 -->
<script type="text/javascript">
    function reset() {
        $('#newGroupName').val('')
    }

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
                $('#li_1').addClass('active');
                $('#total').html(res.cnt + "条，共" + res.pageAll + "页");
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
            gp_id: "INT",
            gp_name: "STRING"
        };
        var fieldNamesStr = JSON.stringify(fieldNamestmp);
        var gpId = document.forms["query"]["gpId"].value;
        var gpName = document.forms["query"]["gpName"].value;
        var sqlStrtmp = "select gp_id,gp_name from gp where gp_status = 1 and gp_id like '%" + gpId + "%' and gp_name like '%" + gpName + "%';";
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
                    str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['gp_id'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['gp_name'] +
                        "</td><td class='tdStyle_body'>";
                    // 查询
                    str += "<a href='groupInfo.jsp?groupId=" + jsonobj[i]['gp_id'] + "&groupName=" + encodeURIComponent(jsonobj[i]['gp_name']) + "'>详情</a>"
                    str += "&nbsp &nbsp<a href='javascript:void(0);' onclick='deleteGroup(" + jsonobj[i]['gp_id'] + ")'>删除</a>"
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
                if (k === 0) {
                    $('#a_' + k).text(5);
                    continue;
                }
                if (k > pageAll) {
                    $('#a_' + k).text('.');
                } else {
                    $('#a_' + k).text(k);
                    $('#a_' + k).attr('onclick', 'jumpToNewPage1(' + k + ')');
                }
            }
            $('#li_' + newpage % 5).addClass('active');
            $('#li_' + pageCur % 5).removeClass('active');
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

    function addGroup() {
        if (!checkAuthority("新增角色群组")) {
            window.alert("您无新增角色群组的权限!")
            return;
        }
        var newGroupName = $("#newGroupName").val()
        var json = {
            groupName: newGroupName,
            id: sessionStorage.getItem("userId"),
            name: sessionStorage.getItem("userName")
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/AddGroup",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                updateTable(1);
                window.alert(res.message)
                $('#myModal').modal('hide')
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
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }
        var sqlStr = "update gp set gp_status = 0 where gp_id = " + gpid + ";";
        $.ajax({
            url: "${pageContext.request.contextPath}/ExecuteSQL",
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

