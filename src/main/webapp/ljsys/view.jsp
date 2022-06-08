<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <%--    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0">--%>
    <title>相城绿建</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ljsys/js/jquery-3.3.1.min.js"></script>
    <style>
        /*!* ⼩屏幕⼿机端 *!*/
        @media (min-width: 0px)and(max-width: 768px) {
            .main {
                width: 100px;
                height: 100px;
                background-color: red;
            }
        }

        /* 中等屏幕（桌⾯显⽰器，⼤于等于992px） */
        @media (min-width: 768px)and(max-width: 992px) {
            .main {
                width: 300px;
                height: 300px;
                background-color: blue;
            }
        }

        /* ⼤屏幕（⼤桌⾯显⽰器，⼤于等于 1200px） */
        @media (min-width: 992px) {
            .main {
                width: 500px;
                height: 500px;
                background-color: aqua;
            }
        }
    </style>
</head>
<body>
<div class="main">
    <%
        String materialcode = request.getParameter("materialcode");
        String qrcodeid = request.getParameter("qrcodeid");
    %>
    <div id="detail">

    </div>
</div>
<script>
    const materialcode = <%=materialcode%>;
    const qrcodeid = <%=qrcodeid%>;
    let qrstyle = {};
    let fieldmap = {};

    getStyle();

    // 获取样式
    function getStyle() {
        let fieldNames = {
            qrcode_content: "STRING"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                sqlStr: "select qrcode_content from qrcode where qrcode_id=" + qrcodeid + ";",
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
            getData();
        })
    }

    function getData() {
        $.post("${pageContext.request.contextPath}/GetPreProduct", {
                materialcode: materialcode,
            }, function (result) {
                result = JSON.parse(result);
                let obj = result.data[0];
                let tmp = qrstyle.qRCode.qRCodeContent
                for (let j = 0; j < tmp.length; j++) {
                    console.log(tmp[j])
                    let drawItem = $("<div>" + fieldmap[tmp[j]] + ":" + obj[tmp[j]] + "</div>");
                    $("#detail").append(drawItem);
                }

            }
        )
    }
</script>
</body>
</html>