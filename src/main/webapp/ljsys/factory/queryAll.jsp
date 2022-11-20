<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width:100%;background-color:white;">
    <form name="query" class="form-inline" style="width:70%;height:10%;margin-left: 14%;padding-top:2%">
        <div class="form-group">
            <label>堆场名称：</label><input type="text" name="query_planname" id="query_planname"
                                       style="" class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:70%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>堆场信息</small></h3>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class="tdStyle_title active" style="width: 25%">堆场</td>
                    <td class="tdStyle_title active" style="width: 25%">区域</td>
                    <td class="tdStyle_title active" style="width: 25%">货位</td>
                    <td class="tdStyle_title active" style="width: 25%;text-align: center">操作</td>
                </tr>
                <tbody id="archTableText">
                </tbody>
            </table>
        </div>
    </div>
    <div style="position: absolute;right:5%;top: 17%;">
        <div id="text">展示二维码：</div>
        <div id="qrcode" style="height: 99px;width: 99px;border: 1px solid #5bc0de"></div>
    </div>
</div>
<script type="text/javascript">
    if (sessionStorage.getItem("userName") == null) {
        location.href = "login.jsp"
        window.alert("您未登陆，请先登陆！")
    }

    let count = 1;      //分页总页数
    let jsonObj = [];   //档案信息
    let pageCur = 1;    //分页当前页
    let pageAll = 1;
    let pageMax = 10;   //一页多少条数据
    let planname_old = null;

    window.onload = getTableData(1);

    function getTableData(newPage) {
        let query_planname = $('#query_planname').val();
        let obj = {
            'planname': query_planname,
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetFactory",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    jsonObj = [];
                    for (let o of res.data) {
                        jsonObj.push({id: o.id, yard: o.name, region: '', location: '', pid: o.pid})
                        for (let d of o.children) {
                            jsonObj.push({
                                id: d.id,
                                pid: d.pid,
                                yard: '',
                                yard_d: o.name,
                                location: '',
                                region: d.name,
                            })
                            for (let e of d.children) {
                                jsonObj.push({
                                    id: e.id,
                                    pid: e.pid,
                                    yard: '',
                                    yard_d: o.name,
                                    location: e.name,
                                    region: '',
                                    region_d: d.name,
                                })
                            }
                        }
                    }
                    updateTable();
                } else {
                    jsonObj = []
                    updateTable();
                }
            },
            error: function () {
                jsonObj = [];
                updateTable(false);
                alert("查询失败！")
            }
        })
    }


    function updateTable() {
        let str = '';
        for (let i = 0; i < jsonObj.length; i++) {
            str += "<tr><td class='tdStyle_body'>" + jsonObj[i]['yard'] + "</td>" +
                "<td class='tdStyle_body'>" + jsonObj[i]['region'] + "</td>" +
                "<td class='tdStyle_body'>" + jsonObj[i]['location'] + "</td>";
            if (jsonObj[i]['location'] !== '') {
                str += "<td class='tdStyle_body'> <a href='#' onclick=openQrcode('" + jsonObj[i]['id'] + "','" + jsonObj[i]['location'] + "')>展码</a></td></tr>";
            } else {
                str += "<td class='tdStyle_body'></td></tr>";
            }
            // if (jsonObj[i]['yard'] !== '') {
            //     str += "<td class='tdStyle_body'><a href='#' onclick=openEditPop('" + jsonObj[i]['pid'] + "','" + 1 + "','" + jsonObj[i]['id'] + "','" + jsonObj[i]['yard'] + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "')>删除</a></td></tr>";
            // }
            // if (jsonObj[i]['region'] !== '') {
            //     str += "<td class='tdStyle_body'><a href='#' onclick=openEditPop('" + jsonObj[i]['pid'] + "','" + 2 + "','" + jsonObj[i]['id'] + "','" + jsonObj[i]['yard_d'] + "','" + jsonObj[i]['region'] + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "')>删除</a></td></tr>";
            // }
        }
        $("#archTableText").html(str);
    }

    function openQrcode(id, text) {
        document.getElementById("text").innerText = text + "："
        $("#qrcode").empty()
        //生成二维码
        jQuery('#qrcode').qrcode({
            // new QRCode(document.getElementById("qrcode_" + idx), {
            render: "canvas",
            text: id,
            width: 100,
            height: 100,
            colorDark: "#000000",
            colorLight: "#ffffff",
            src: './img/qr.jpg'
            // correctLevel: QRCode.CorrectLevel.H
        })
    }

</script>
