<%@ page import="java.util.Map" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>相城绿建</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <script type="text/javascript" src="${pageContext.request.contextPath}/ljsys/js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/ljsys/dist/css/bootstrap.min.css" type="text/css"/>
    <style>
        @media screen and (min-width: 375px) {
            html {
                font-size: 12px;
            }
        }

        @media screen and (min-width: 414px) {
            html {
                font-size: 14px;
            }
        }

        @media screen and (min-width: 768px) {
            html {
                font-size: 16px;
            }
        }

        @media screen and (min-width: 1024px) {
            html {
                font-size: 18px;
            }
        }

        #tbody {
            text-align: center;
        }

        #information {
            background-image: -webkit-linear-gradient(left, rgb(54, 95, 147), rgb(54, 95, 147));
            color: rgb(255, 255, 255);
            letter-spacing: 1.5px;
            font-size: 1.5rem;
            text-align: center;
            line-height: 3.0rem;
            padding: 0rem 0.426667rem;
            font-weight: bold;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
<div class="main">
    <%
        String materialcode = request.getParameter("code");
        String warehouseId = request.getParameter("warehouseId");
        String qrcodeid = request.getParameter("id");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("materialcode", materialcode);
        jsonObject.put("qrcodeid", qrcodeid);
    %>
    <div id="information">构建信息</div>
    <table class="table table-bordered">
        <tbody id="tbody">
        </tbody>
    </table>
</div>
<script>
    const json = <%=jsonObject%>;
    let materialcode = <%=materialcode%>;
    let warehouseId = <%=warehouseId%>;
    if (typeof materialcode == 'number') {
        materialcode = json.materialcode
    }
    const qrcodeid = json.qrcodeid;
    let qrstyle = {};
    let fieldmap = {};
    let qrcode_name = '';

    getStyle();

    // 获取样式
    function getStyle() {
        let fieldNames = {
            qrcode_content: "STRING",
            qrcode_name: "STRING"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                sqlStr: "select qrcode_content,qrcode_name from qrcode where qrcode_id=" + qrcodeid + ";",
                fieldNames: JSON.stringify(fieldNames),
                pageCur: 1,
                pageMax: 1000
            },
            success: function (res) {
                let datatmp = JSON.parse(res.data)[0]
                if (datatmp.qrcode_content == undefined) {
                    alert("二维码内容为空");
                    return
                }
                qrcode_name = datatmp.qrcode_name
                qrstyle = JSON.parse(datatmp.qrcode_content)
            },
            error: function (message) {
            }
        }).then(() => {
            getFieldMap();
        })

    }

    // 获取字段映射
    function getFieldMap() {
        let fieldNames = {
            pi_key: "STRING",
            pi_value: "STRING"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                sqlStr: "select pi_key,pi_value from project_item;",
                fieldNames: JSON.stringify(fieldNames),
                pageCur: 1,
                pageMax: 1000
            },
            success: function (res) {
                let jsonobj = JSON.parse(res.data)
                for (let i = 0; i < jsonobj.length; i++) {
                    fieldmap[jsonobj[i].pi_key] = jsonobj[i].pi_value
                }
            }
        }).then(() => {
            if (warehouseId) {
                getWarehouseData
            } else {
                getData();
            }
        })
    }

    function getWarehouseData() {
        $.post("${pageContext.request.contextPath}/GetFactory", {
                id: warehouseId,
            }, function (result) {
                result = JSON.parse(result);
                let obj = result.data[0];
                let tmp = qrstyle.qRCode.qRCodeContent
                let str_body = ''
                for (let j = 0; j < tmp.length; j++) {
                    str_body += "<tr><td>" + fieldmap[tmp[j]] + "</td><td>" + obj[tmp[j]] + "</td></tr>"
                }
                $("#tbody").html(str_body);
            }
        )
    }

    function getData() {
        $.post("${pageContext.request.contextPath}/GetPreProduct", {
                materialcode: materialcode,
            }, function (result) {
                result = JSON.parse(result);
                let obj = result.data[0];
                let tmp = qrstyle.qRCode.qRCodeContent
                if (qrcode_name == '打印模板（上海）') {
                    getOtherData(obj)
                } else {
                    let str_body = ''
                    for (let j = 0; j < tmp.length; j++) {
                        str_body += "<tr><td>" + fieldmap[tmp[j]] + "</td><td>" + obj[tmp[j]] + "</td></tr>"
                    }
                    $("#tbody").html(str_body);
                }
            }
        )
    }

    function getOtherData(obj) {
        let fieldNames = {
            print_obj: "STRING",
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                sqlStr: "select print_obj from print_obj where `index` = (select qc_id from default_qc where id = 3);",
                fieldNames: JSON.stringify(fieldNames),
                pageCur: 1,
                pageMax: 1000
            },
            success: function (res) {
                let jsonobj = JSON.parse(res.data)
                jsonobj = JSON.parse(jsonobj[0].print_obj)
                Object.assign(obj, jsonobj)
                getComputeData(obj)
            }
        })
    }

    function getComputeData(obj) {
        let fieldNames = {
            build_type: "STRING",
            standard: "STRING",
            fangliang: "STRING",
            fangliang: "STRING",
            building_no: "STRING",
            floor_no: "STRING",
            plantime: "STRING",
            concretegrade: "STRING",
            unit_consumption: "STRING",
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                sqlStr: "select b.build_type,b.standard,b.fangliang,b.building_no,b.floor_no,DATE_ADD(c.plantime,INTERVAL 5 DAY) plantime,b.concretegrade,d.unit_consumption from preproduct b,plan c,planname d where  b.plannumber = c.plannumber and c.planname = d.planname  and b.materialcode = " + materialcode + ";",
                fieldNames: JSON.stringify(fieldNames),
                pageCur: 1,
                pageMax: 1000
            },
            success: function (res) {
                jsonobj = res.data0[0]
                let tmp = qrstyle.qRCode.qRCodeContent
                let str_body = ''
                for (let j = 0; j < tmp.length; j++) {
                    str_body += "<tr><td>" + fieldmap[tmp[j]] + "</td><td>" + obj[tmp[j]] + "</td></tr>"
                }
                str_body += "<tr><td>" + "构件种类" + "</td><td>" + jsonobj.build_type + "</td></tr>"
                str_body += "<tr><td>" + "构件尺寸(mm)" + "</td><td>" + jsonobj.standard + "</td></tr>"
                str_body += "<tr><td>" + "构件重量(T)" + "</td><td>" + jsonobj.fangliang * 2.4.toFixed(2) + "</td></tr>"
                str_body += "<tr><td>" + "使用部位" + "</td><td>" + jsonobj.building_no + jsonobj.floor_no + "</td></tr>"
                str_body += "<tr><td>" + "构件制作日期" + "</td><td>" + jsonobj.plantime + "</td></tr>"
                str_body += "<tr><td>" + "构件出厂检验日期" + "</td><td>" + jsonobj.plantime + "</td></tr>"
                str_body += "<tr><td>" + "构件出出厂日期" + "</td><td>" + jsonobj.plantime + "</td></tr>"
                str_body += "<tr><td>" + "钢筋用量(kg)" + "</td><td>" + (jsonobj.fangliang * jsonobj.unit_consumption).toFixed(2) + "</td></tr>"
                str_body += "<tr><td>" + "混凝土强度等级" + "</td><td>" + jsonobj.concretegrade + "</td></tr>"
                str_body += "<tr><td>" + "混凝土用砂量(T)" + "</td><td>" + (jsonobj.fangliang * 0.85).toFixed(2) + "</td></tr>"
                str_body += "<tr><td>" + "混凝土用石量(T)" + "</td><td>" + (jsonobj.fangliang * 1.0).toFixed(2) + "</td></tr>"
                $("#tbody").html(str_body);
            }
        })
    }
</script>
</body>
</html>
