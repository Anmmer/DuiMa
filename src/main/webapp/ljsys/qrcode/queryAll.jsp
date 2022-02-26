<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    let pageCur = 1;
    let pageAll = 1;

    function checkAuthority(au) {
        let authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for (let i = 0; i < authority.length; i++) {
            if (authority[i].fa_name == au) flag = true;
        }
        return flag;
    }
</script>
<div style="height: 100%;width:100%;background-color:white;">
    <form name="query" class="form-inline" style="width:70%;height:13%;margin-left: 14%;padding-top:2%">
        <div class="form-group">
            <label>二维码编号：</label><input type="text" name="qrcodeId"
                                        style="height:10%;" class="form-control">
        </div>
        <div class="form-group" style="margin-left:5%;">
            <label>二维码名：</label><input type="text" name="qrcodeName"
                                       style="height:10%;" class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="updateTable(1)">
            查 询
        </button>
    </form>
    <div style="width:70%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>二维码信息</small></h3>
            <button type="button" style="position: absolute;right: 15%;top:11%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    data-target="#myModal">
                添加
            </button>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class="tdStyle_title active" style="width: 35%">二维码编号</td>
                    <td class="tdStyle_title active" style="width: 35%">二维码名称</td>
                    <td class="tdStyle_title active" style="width: 30%;text-align: center">查看详情</td>
                </tr>
                <tbody id="tableText">
                </tbody>
            </table>
        </div>
        <nav aria-label="Page navigation" style="margin-left:40%;width:80%;height:10%;">
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
    </div>
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" style="position: absolute;left: 15%;top: 12%;" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:60%">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">添加二维码</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group" style="height: 100%;margin-top: 5%">
                            <label for="newStyleName" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">二维码名称:</label>
                            <input type="text" class="form-control" style="width:50%;" id="newStyleName"
                                   name="newGroupName">
                            <%--                            <button type="button" class="btn btn-primary">提交新增</button>--%>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                    <button type="button" class="btn btn-primary" onclick="addQRCodeStyle()">保存</button>
                </div>
            </div>
        </div>
    </div>
    <%--    <div style="width:70%;height:5%;margin:auto;">--%>
    <%--        <form id="newQRCode">--%>
    <%--            <span class="pStyle">新样式名称</span>--%>
    <%--            <input type="text" id="newStyleName">--%>
    <%--            <button type="button" onclick="addQRCodeStyle()">新增</button>--%>
    <%--        </form>--%>
    <%--    </div>--%>
</div>
<!-- 查询所有用户 -->
<script type="text/javascript">
    function reset() {
        $('#newStyleName').val('')
    }

    function updateTable(newpage) {
        let fieldNamestmp = {
            qrcode_id: "INT",
            qrcode_name: "STRING"
        };
        let fieldNamesStr = JSON.stringify(fieldNamestmp);
        let qrcodeId = document.forms["query"]["qrcodeId"].value;
        let qrcodeName = document.forms["query"]["qrcodeName"].value;
        let sqlStrtmp = "select qrcode_id,qrcode_name from qrcode where qrcode_status = 1 and qrcode_id like '%" + qrcodeId + "%' and qrcode_name like '%" + qrcodeName + "%';";
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
                let str = "";
                let jsonobj = JSON.parse(res.data);
                for (let i = 0; i < jsonobj.length; i++) {
                    str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['qrcode_id'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['qrcode_name'] +
                        "</td><td class='tdStyle_body'>";
                    // 查询
                    str += "<a href='qrcodeInfo.jsp?qrcodeId=" + jsonobj[i]['qrcode_id'] + "&qrcodeName=" + encodeURIComponent(jsonobj[i]['qrcode_name']) + "'>详情</a>"
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
            }
        });
    }

    updateTable(1);

    function jumpToNewPage(newPageCode) {
        let newPage = 1;
        let fieldNamestmp = {
            qrcode_id: "INT",
            qrcode_name: "STRING"
        };
        let fieldNamesStr = JSON.stringify(fieldNamestmp);
        let qrcodeId = document.forms["query"]["qrcodeId"].value;
        let qrcodeName = document.forms["query"]["qrcodeName"].value;
        let sqlStrtmp = "select qrcode_id,qrcode_name from qrcode where qrcode_status = 1 and qrcode_id like '%" + qrcodeId + "%' and qrcode_name like '%" + qrcodeName + "%';";
        if (newPageCode === 1) newPage = 1;
        if (newPageCode === 2) {
            if (pageCur === 1) {
                window.alert("已经在第一页!");
                return
            } else {
                newPage = pageCur - 1;
            }
        }
        if (newPageCode === 3) {
            if (pageCur === pageAll) {
                window.alert("已经在最后一页!");
                return
            } else {
                newPage = pageCur + 1;
            }
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
                let str = "";
                let jsonobj = JSON.parse(res.data);
                for (let i = 0; i < jsonobj.length; i++) {
                    str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['qrcode_id'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['qrcode_name'] +
                        "</td><td class='tdStyle_body'>";
                    // 查询
                    str += "<a href='qrcodeInfo.jsp?qrcodeId=" + jsonobj[i]['qrcode_id'] + "&qrcodeName=" + encodeURIComponent(jsonobj[i]['qrcode_name']) + "'>详情</a>"
                    str += "</td></tr>"
                }
                $("#tableText").html(str);
                $('#li_' + newPage % 5).addClass('active');
                $('#li_' + pageCur % 5).removeClass('active');
                pageCur = newPage;
                // 重置总页数
                pageAll = parseInt(res.pageAll);
            },
            error: function (message) {
            }
        });
    }

    function jumpToNewPage1(newPage) {
        if (newPage == pageCur) {
            return;
        }
        let fieldNamestmp = {
            qrcode_id: "INT",
            qrcode_name: "STRING"
        };
        let fieldNamesStr = JSON.stringify(fieldNamestmp);
        let qrcodeId = document.forms["query"]["qrcodeId"].value;
        let qrcodeName = document.forms["query"]["qrcodeName"].value;
        let sqlStrtmp = "select qrcode_id,qrcode_name from qrcode where qrcode_status = 1 and qrcode_id like '%" + qrcodeId + "%' and qrcode_name like '%" + qrcodeName + "%';";
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
                let str = "";
                let jsonobj = JSON.parse(res.data);
                for (let i = 0; i < jsonobj.length; i++) {
                    str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['qrcode_id'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['qrcode_name'] +
                        "</td><td class='tdStyle_body'>";
                    // 查询
                    str += "<a href='qrcodeInfo.jsp?qrcodeId=" + jsonobj[i]['qrcode_id'] + "&qrcodeName=" + encodeURIComponent(jsonobj[i]['qrcode_name']) + "'>详情</a>"
                    str += "</td></tr>"
                }
                $("#tableText").html(str);
                $('#li_' + newPage % 5).addClass('active');
                $('#li_' + pageCur % 5).removeClass('active');
                pageCur = newPage;
                // 重置总页数
                pageAll = parseInt(res.pageAll);
            },
            error: function (message) {
            }
        });
    }

    function jumpToNewPage2() {
        let fieldNamestmp = {
            qrcode_id: "INT",
            qrcode_name: "STRING"
        };
        let fieldNamesStr = JSON.stringify(fieldNamestmp);
        let qrcodeId = document.forms["query"]["qrcodeId"].value;
        let qrcodeName = document.forms["query"]["qrcodeName"].value;
        let sqlStrtmp = "select qrcode_id,qrcode_name from qrcode where qrcode_status = 1 and qrcode_id like '%" + qrcodeId + "%' and qrcode_name like '%" + qrcodeName + "%';";
        let newpageStr = $('#jump_to').val();
        let newpage = parseInt(newpageStr)
        console.log(pageAll + " " + newpage);
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
                let str = "";
                let jsonobj = JSON.parse(res.data);
                for (let i = 0; i < jsonobj.length; i++) {
                    str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['qrcode_id'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['qrcode_name'] +
                        "</td><td class='tdStyle_body'>";
                    // 查询
                    str += "<a href='qrcodeInfo.jsp?qrcodeId=" + jsonobj[i]['qrcode_id'] + "&qrcodeName=" + encodeURIComponent(jsonobj[i]['qrcode_name']) + "'>详情</a>"
                    str += "</td></tr>"
                }
                $("#tableText").html(str);
                jump2(newpage, res.pageAll);
                pageCur = newpage;
                // 重置总页数
                pageAll = parseInt(res.pageAll);
            },
            error: function (message) {
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

    function addQRCodeStyle() {
        let newqrcodeName = $("#newStyleName").val()
        //去除首尾空格
        newqrcodeName = newqrcodeName.replace(/(^\s*)|(\s*$)/g, "");
        if (newqrcodeName === '' || newqrcodeName == null) {
            alert('二维码名称不能为空')
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/AddQRCodeStyle",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                qrcodeName: newqrcodeName,
                id: sessionStorage.getItem("userId"),
                name: sessionStorage.getItem("userName")
            },
            success: function (res) {
                window.alert(res.message)
                updateTable(pageAll)
                $('#myModal').modal('hide');
                reset();
            },
            error: function (message) {
            }
        })
    }
</script>

