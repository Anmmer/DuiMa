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

    function returnLastPage() {
        window.history.go(-1);
    }

</script>
<div style="height: 100%;width:100%;background-color:white;">
    <button onclick="returnLastPage()" style="position: relative;left: 10%;top: 5%" class="btn btn-primary btn-sm">返回
    </button>
    <div style="width:70%;height:20%;margin: 0 auto;">
        <p style="padding: 0;margin:0;width:50%;float: left;font-size:17px;font-weight: bolder" id="warehouseName">
            库房名:</p>
        <div style="width:50%;height:150px;float: left;">
            <p style="padding:0px;margin:0;" class="pStyle">库房二维码:</p>
            <div id="QRCode" style="width:100px;height:100px;">
            </div>
        </div>
    </div>
    <!--表格显示-->
    <div style="width:70%;height:75%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>入库信息</small></h3>
        </div>
        <div style="height: 75%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class="tdStyle_title active" style="width: 20%">构建编号</td>
                    <td class="tdStyle_title active" style="width: 20%">物料编码</td>
                    <td class="tdStyle_title active" style="width: 20%">物料名称</td>
                    <td class="tdStyle_title active" style="width: 20%;text-align: center">操作人</td>
                    <td class="tdStyle_title active" style="width: 20%">操作时间</td>
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

        <%--        <div style="width:70%;height:90%;margin:0 auto;">--%>
        <%--        <!--结果显示提示：一共有多少记录，共几页-->--%>
        <%--        <div style="width:100%;height:30px;"></div>--%>
        <%--        <p class="pStyle" id="resultTip"></p>--%>
        <%--        <div style="width:100%;height:300px;overflow-y: auto;">--%>
        <%--            <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">--%>
        <%--                <tr>--%>
        <%--                    <td class='tdStyle_title'>入库时间</td>--%>
        <%--                    <td class='tdStyle_title'>入库构件号</td>--%>
        <%--                    <td class='tdStyle_title'>入库操作人</td>--%>
        <%--                </tr>--%>
        <%--                <tbody id="tableText">--%>
        <%--                </tbody>--%>
        <%--            </table>--%>
        <%--        </div>--%>
    </div>
</div>
<!-- 查询所有群组 -->
<script type="text/javascript">

    // 获取factoryId
    function getQueryVariable(variable) {
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            if (pair[0] == variable) return pair[1];
        }
        return (false);
    }

    var warehouseId = getQueryVariable("warehouseId");
    var warehouseName = decodeURIComponent(getQueryVariable("warehouseName"));
    // 放置二维码
    // 读取库房名
    $("#warehouseName").text("库房名:" + warehouseName)
    new QRCode(document.getElementById("QRCode"), {
        text: "货位号:" + warehouseId + "\n货位名:" + warehouseName + "\n",
        width: 120,
        height: 120,
        colorDark: "#000000",
        colorLight: "#ffffff",
        correctLevel: QRCode.CorrectLevel.H
    })

    function updateTable(newpage) {
        let fieldNamestmp = {
            wiTime: "STRING",
            materialcode: "STRING",
            materialname: "STRING",
            preproductid: "STRING",
            userName: "STRING",
        };
        var fieldNamesStr = JSON.stringify(fieldNamestmp);
        var sqlStrtmp = "select distinct product_id as materialcode,preproduct.materialname,preproduct.preproductid,wi_time as wiTime,user_name as userName from preproduct, warehouse_info,user where  preproduct.materialcode = warehouse_info.product_id and warehouse_info.warehouse_id=" + warehouseId + " and warehouse_info.user_id = user.user_id and wi_type = 1 order by wi_time DESC;";
        let json = {
            sqlStr: sqlStrtmp,
            fieldNames: fieldNamesStr,
            pageCur: newpage,
            pageMax: 10
        };
        // let json = {
        //     warehouseId: warehouseId
        // };
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
                    str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['preproductid'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['materialcode'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['materialname'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['userName'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['wiTime'] +
                        "</td></tr>";
                }
                $("#tableText").html(str);
                $('#total').html(res.cnt + "条，共" + res.pageAll + "页");
                $('#li_1').addClass('active');
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

    function jumpToNewPage(newpageCode) {
        let fieldNamestmp = {
            wiTime: "STRING",
            materialcode: "STRING",
            materialname: "STRING",
            preproductid: "STRING",
            userName: "STRING",
        };
        var fieldNamesStr = JSON.stringify(fieldNamestmp);
        var sqlStrtmp = "select distinct product_id as materialcode,preproduct.materialname,preproduct.preproductid,wi_time as wiTime,user_name as userName from preproduct, warehouse_info,user where  preproduct.materialcode = warehouse_info.product_id and warehouse_info.warehouse_id=" + warehouseId + " and warehouse_info.user_id = user.user_id and wi_type = 1 order by wi_time DESC;";
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
                    str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['preproductid'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['materialcode'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['materialname'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['userName'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['wiTime'] +
                        "</td></tr>";
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
            wiTime: "STRING",
            materialcode: "STRING",
            materialname: "STRING",
            preproductid: "STRING",
            userName: "STRING",
        };
        var fieldNamesStr = JSON.stringify(fieldNamestmp);
        var sqlStrtmp = "select distinct product_id as materialcode,preproduct.materialname,preproduct.preproductid,wi_time as wiTime,user_name as userName from preproduct, warehouse_info,user where  preproduct.materialcode = warehouse_info.product_id and warehouse_info.warehouse_id=" + warehouseId + " and warehouse_info.user_id = user.user_id and wi_type = 1 order by wi_time DESC;";
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
                    str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['preproductid'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['materialcode'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['materialname'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['userName'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['wiTime'] +
                        "</td></tr>";
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
            wiTime: "STRING",
            materialcode: "STRING",
            materialname: "STRING",
            preproductid: "STRING",
            userName: "STRING",
        };
        var fieldNamesStr = JSON.stringify(fieldNamestmp);
        var sqlStrtmp = "select distinct product_id as materialcode,preproduct.materialname,preproduct.preproductid,wi_time as wiTime,user_name as userName from preproduct, warehouse_info,user where  preproduct.materialcode = warehouse_info.product_id and warehouse_info.warehouse_id=" + warehouseId + " and warehouse_info.user_id = user.user_id and wi_type = 1 order by wi_time DESC;";
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
                    str += "<tr><td class='tdStyle_body'>" + jsonobj[i]['preproductid'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['materialcode'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['materialname'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['userName'] +
                        "</td><td class='tdStyle_body'>" + jsonobj[i]['wiTime'] +
                        "</td></tr>";
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
</script>
