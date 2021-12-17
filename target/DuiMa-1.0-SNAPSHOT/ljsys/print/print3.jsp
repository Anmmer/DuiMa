<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="./css/pop_up.css">
    <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
</head>
<body>
<div style="height: 95%;width: 100%">
    <div style="height: 10%;width: 100%">
        <button style="position:relative;top: 40%;left: 10%;font-family: Simsun;font-size:20px;" onclick="openPop()">上传文件</button>
    </div>
    <div style="width: 80%;margin: 0 auto">
        <h3 style="text-align: center;margin-top: 0;">已导入计划列表</h3>
        <div style="height: 480px;border: 1px solid #000">
            <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                <tr>
                    <td class='tdStyle'>公司</td>
                    <td class='tdStyle'>工厂</td>
                    <td class='tdStyle'>班组</td>
                    <td class='tdStyle'>生产线</td>
                    <td class='tdStyle'>计划下达时间</td>
                    <td class='tdStyle'>浇捣计划完成时间</td>
                    <td class='tdStyle'>批准</td>
                    <td class='tdStyle'>审核</td>
                    <td class='tdStyle'>线长</td>
                    <td class='tdStyle'>计划</td>
                </tr>
                <tbody id="tableText">
                </tbody>
            </table>
        </div>
        <div style="height:30px;margin-top: 2%">
            <div style="width:33%;float: left;">
                <button type="button" style="font-family: Simsun;font-size:20px;" onclick="jumpToNewPage(1)">第一页
                </button>
                <button type="button" style="font-family: Simsun;font-size:20px;" onclick="jumpToNewPage(2)">最后一页
                </button>
            </div>
            <div style="width:34%;float: left;">
                <p id="resultTip2" style="margin-top: 0px;font-family: Simsun;font-size: 20px;text-align: center;">
                    1/1</p>
            </div>
            <div style="width:33%;float: left;">
                <button type="button" style="font-family: Simsun;font-size:20px;float:right;margin-left: 5px"
                        onclick="jumpToNewPage(4)">
                    后一页
                </button>
                <button type="button" style="font-family: Simsun;font-size:20px;float:right;"
                        onclick="jumpToNewPage(3)">
                    前一页
                </button>
            </div>
        </div>
    </div>
    <div class="pop_up">
        <div class="pop_title title_1">上传Excel</div>
        <div class="close_btn"><img src="./img/close.png" onclick="closePop()"></div>
        <div style="width: 90%;margin: 0 auto">
            <input type="file" id="file1" style="position: relative;top:10px">
            <h3 style="text-align: center;margin-top: 0;">导入预览</h3>
            <div style="height: 400px;border: 1px solid #000">
                <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                    <tr>
                        <td class='tdStyle'>公司</td>
                        <td class='tdStyle'>工厂</td>
                        <td class='tdStyle'>班组</td>
                        <td class='tdStyle'>生产线</td>
                        <td class='tdStyle'>计划下达时间</td>
                        <td class='tdStyle'>浇捣计划完成时间</td>
                        <td class='tdStyle'>批准</td>
                        <td class='tdStyle'>审核</td>
                        <td class='tdStyle'>线长</td>
                        <td class='tdStyle'>计划</td>
                        <td class='tdStyle'>提示</td>
                    </tr>
                    <tbody id="tableText">
                    </tbody>
                </table>
            </div>
            <div style="height:35px;margin-top: 1%">
                <div style="width:33%;float: left;">
                    <button type="button" style="font-family: Simsun;font-size:20px;" onclick="jumpToNewPage(1)">第一页
                    </button>
                    <button type="button" style="font-family: Simsun;font-size:20px;" onclick="jumpToNewPage(2)">最后一页
                    </button>
                </div>
                <div style="width:34%;float: left;">
                    <p id="resultTip2" style="margin-top: 0px;font-family: Simsun;font-size: 20px;text-align: center;">
                        1/1</p>
                </div>
                <div style="width:33%;float: left;">
                    <button type="button" style="font-family: Simsun;font-size:20px;float:right;margin-left: 5px"
                            onclick="jumpToNewPage(4)">
                        后一页
                    </button>
                    <button type="button" style="font-family: Simsun;font-size:20px;float:right;"
                            onclick="jumpToNewPage(3)">
                        前一页
                    </button>
                </div>
            </div>
        </div>
        <div class="pop_footer" style="align-content: center">
            <button type="submit" class="saveo save-btn">保存</button>
            <button type="reset" class="recover-btn">重置</button>
        </div>
    </div>
</div>

</body>
<script>
    var data = null;
    var pop_num = 1;
    function openPop() {
        $(".pop_up").show();
    }

    function closePop(){
        $(".pop_up").hide();
    }

    function getTableData() {
        $.ajax({
            url: "http://localhost:8989/DuiMa_war_exploded/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: json,
            success: function (res) {
                var jsonObj = JSON.parse(res.data);
                data = jsonObj
                updateTable(jsonObj, false);
            }
        })
    }

    function updateTable(jsonObj, detail, num) {
        var str = "";
        for (var i = num; i < jsonObj.length; i++) {
            str += "<tr><td class='tdStyle'>" + jsonObj[i]['qrcode_id'] +
                "</td><td class='tdStyle'>" + jsonObj[i]['qrcode_name'] +
                "</td><td class='tdStyle'>";
            // 查询
            if (detail) {
                str += "<a href='qrcodeInfo.jsp?qrcodeId=" + jsonObj[i]['qrcode_id'] + "&qrcodeName=" + encodeURIComponent(jsonObj[i]['qrcode_name']) + "'>详情</a>"
                str += "</td></tr>"
            }
        }
        $("#tableText").html(str);
    }
</script>
</html>
