<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/12/21
  Time: 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div id="drawer">
    <button id="return">返回</button>
    <label class="pStyle" style="float:left" for="qrcodestyles">选择一个样式:</label>
    <select id="qrcodestyles" style="float:left" onchange="getStyle()"></select>
    <button style="float:left" onclick="printLabels()">打印</button>
<script>
    let styleReady = false;
    // 获取所有样式并放入select
    function getStyleList() {
        var fieldNames = {
            qrcode_id: "INT",
            qrcode_name: "STRING"
        }
        $.ajax({
            url: "http://localhost:8989/DuiMa_war_exploded/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                sqlStr: "select qrcode_id, qrcode_name from qrcode where qrcode_status=1;",
                fieldNames: JSON.stringify(fieldNames),
                pageCur: 1,
                pageMax: 1000
            },
            success: function (res) {
                var jsonobj = JSON.parse(res.data);
                var qrcodestyles = document.getElementById("qrcodestyles")
                for (var i = 0; i < jsonobj.length; i++) {
                    qrcodestyles.options.add(new Option(jsonobj[i].qrcode_name, jsonobj[i].qrcode_id))
                }
                // 测试
                //getStyle()
            },
            error: function (message) {
                console.log(message)
            }
        })
    }
    // 获取样式
    function getStyle() {
        // 把样式设定为目前选中的样式
        var qrcodeid = $("#qrcodestyles :selected").val()
        console.log(qrcodeid)
        var fieldNames = {
            qrcode_content: "STRING"
        }
        $.ajax({
            url: "http://localhost:8989/DuiMa_war_exploded/QuerySQL",
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
                var datatmp = JSON.parse(res.data)[0]
                qrstyle = JSON.parse(datatmp.qrcode_content)
                console.log(qrstyle)
                styleReady = true
                printData()
            },
            error: function (message) {
                console.log(message)
            }
        })

    }

    function printData() {
        if (!styleReady) {
            window.alert("加载中，请过几秒再尝试一次!")
            return
        }
        var startStr = "<!--startprint-->"
        var endStr = "<!--endprint-->"
        // 获取样式中的长宽
        var xsize = qrstyle.xsize
        var ysize = qrstyle.ysize
        var startitem = $(startStr)
        $("#printArea").empty()
        $("#printArea").append(startitem)
        console.log("data length:" + window.pdata.length)
        for (var i = 0; i < window.pdata.length; i++) {
            console.log("loop " + i)
            // 已判断是否都已获取
            // 先填充内容，后设置位置
            var item = "<div style='page-break-after:always;position:relative;width:" + xsize + "px;height:" + ysize + "px;'>"
            // start
            // 放置二维码,后续需要往里面填充内容
            var xsituation = qrstyle.qRCode['xsituation']
            var ysituation = qrstyle.qRCode['ysituation']
            item += "<div id='qrcode_" + i + "' style='position: absolute;width:150px;height:150px;left:" + xsituation + "px;top:" + ysituation + "px;'></div>"
            // 放置其他各项
            for (var j = 0; j < qrstyle.items.length; j++) {
                var node = qrstyle.items[j]
                var nodevalue = node.content;
                xsituation = node.xsituation
                ysituation = node.ysituation
                console.log(window.pdata[i])
                var nodestr = fieldmap[nodevalue] + ":" + window.pdata[i][nodevalue]
                item += "<span class='pStyle' style='position: absolute;left:" + xsituation + "px;top:" + ysituation + "px;'>" + nodestr + "</span>"
            }
            // end
            item += "</div>"
            var newItem = $(item)
            $("#printArea").append(newItem)
            // 设置二维码内容
            var qrcodeContent = ""
            console.log(qrstyle)
            console.log(qrstyle.qRCode.qRCodeContent)
            var tmp = qrstyle.qRCode.qRCodeContent
            for (var j = 0; j < tmp.length; j++) {
                qrcodeContent += fieldmap[tmp[j]] + ":" + window.pdata[i][tmp[j]] + "\n"
            }
            getQRCode(i, qrcodeContent)
        }
        var enditem = $(endStr)
        $("#printArea").append(enditem)
    }

    // 打印标签
    function printLabels() {
        var bdhtml = window.document.body.innerHTML;
        var sprnstr = "<!--startprint-->";
        var eprnstr = "<!--endprint-->";
        var prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
        prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML = prnhtml;
        window.print();
        window.document.body.innerHTML = bdhtml;
    }
</script>
