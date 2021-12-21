<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%">
    <div style="height: 10%;width: 100%">
        <button style="position:relative;top: 50%;left: 15%;font-family: Simsun;font-size:20px;" onclick="openPop()">
            上传文件
        </button>
    </div>
    <div style="width: 70%;margin: 0 auto">
        <h3 style="text-align: center;margin-top: 0;">已导入计划列表</h3>
        <div style="height: 480px;border: 1px solid #000">
            <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                <tr>
                    <td class='tdStyle_title'>计划名称</td>
                    <td class='tdStyle_title'>公司</td>
                    <td class='tdStyle_title'>工厂</td>
                    <td class='tdStyle_title'>操作</td>
                </tr>
                <tbody id="planTableText">
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
                <p id="planResultTip" style="margin-top: 0px;font-family: Simsun;font-size: 20px;text-align: center;">
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
        <div class="pop_title title_2">构件列表</div>
        <div class="close_btn"><img src="./img/close.png" onclick="closePop()"></div>
        <div style="width: 90%;height: 80%;margin: 0 auto">
            <div id="pop_print" style="width: 100%;height: 12%">
                <label class="label" style="position: relative;margin-top: 2%;" for="qrcodestyles">选择一个样式:</label>
                <select id="qrcodestyles" style="position: relative;margin-top: 2%;width: 15%"
                        onchange="getStyle()"></select>
                <button type="button" id="print_data" style="position: relative;margin-top: 2%;margin-left: 1%"
                        onclick="checkdata()">打印数据
                </button>
                <button type="button" id="print_datas" style="position: relative;margin-top: 2%; margin-left: 1%"
                        onclick="checkdata()">全部打印
                </button>
            </div>
            <div id="pop_input" style="width: 100%;height: 12%">
                <input type="file" id="excel-file"
                       accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel"
                       style="position: relative;margin-top: 2%;">
                <h3 id="inputDetail" style="position: absolute;left: 45%;top: 7%;">导入预览</h3>
            </div>
            <div style=" margin-bottom: 1%;">
                <label for="planname">计划名：</label><input id="planname" disabled>
                <label for="company" style="margin-left: 1%">公司：</label><input id="company" disabled>
                <label for="plant" style="margin-left: 1%">工厂：</label><input id="plant" disabled>
            </div>
            <div style="height: 70%;border: 1px solid #000">
                <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                    <tr>
                        <td class='tdStyle_title' style="width: 10%">物料编号</td>
                        <td class='tdStyle_title' style="width: 10%">项目名称</td>
                        <td class='tdStyle_title' style="width: 10%">楼栋楼层</td>
                        <td class='tdStyle_title' style="width: 10%">构件尺寸</td>
                        <td class='tdStyle_title' style="width: 10%">构件编号</td>
                        <td class='tdStyle_title' style="width: 10%">体积</td>
                        <td class='tdStyle_title' style="width: 10%">质量</td>
                        <td class='tdStyle_title' style="width: 10%">质检员</td>
                        <td class='tdStyle_title' style="width: 10%">日期</td>
                    </tr>
                    <tbody id="detailTableText">
                    </tbody>
                </table>
            </div>
            <div style="height:35px;margin-top: 15px">
                <div style="width:33%;float: left;">
                    <button id="pop_first" type="button" disabled style="font-family: Simsun;font-size:20px;"
                            onclick="jumpToNewPage(1,true)">第一页
                    </button>
                    <button id="pop_last" type="button" disabled style="font-family: Simsun;font-size:20px;"
                            onclick="jumpToNewPage(2,true)">最后一页
                    </button>
                </div>
                <div style="width:34%;float: left;">
                    <p id="detailResultTip"
                       style="margin-top: 0px;font-family: Simsun;font-size: 20px;text-align: center;">
                        1/1</p>
                </div>
                <div style="width:33%;float: left;">
                    <button id="pop_next" type="button" disabled
                            style="font-family: Simsun;font-size:20px;float:right;margin-left: 5px"
                            onclick="jumpToNewPage(4,true)">
                        后一页
                    </button>
                    <button id="pop_pre" type="button" disabled style="font-family: Simsun;font-size:20px;float:right;"
                            onclick="jumpToNewPage(3,true)">
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
    <!--打印主界面-->
    <div style="width:100%;height:70%;;margin:auto;float: left;">
        <div id="printArea" style="width:80%;height:100%;margin: auto;background-color: azure;overflow-y: auto;"></div>

    </div>
</div>
<script>
    let num = 1;
    let count = 1;
    let pop_num = 1;
    let pop_count = 1;
    let excelData = {};
    let jsonObj = [];


    window.onload = getTableData();

    function openPop() {
        $(".pop_up").show();
        $(".title_1").show();
        $(".title_2").hide();
        $("#pop_print").hide();
        $("#pop_input").show();
        $(".pop_footer").show();
    }

    function closePop() {
        $(".pop_up").hide();
        reset();
    }

    function reset() {
        $("#planname").val('');
        $("#company").val('');
        $("#plant").val('');
        $('#excel-file').val('')
        $("#detailTableText").html('')
        $('#pop_next').attr('disabled', true);
        $('#pop_pre').attr('disabled', true);
        $('#fist').attr('disabled', true);
        $('#last').attr('disabled', true);
        pop_num = 1;
        pop_count = 1;
        excelData = {};
    }

    //保存
    $('.save-btn').click(function () {
        if (Object.keys(excelData).length !== 0) {
            $.post("http://localhost:8989/DuiMa_war_exploded/addPlan", {str: JSON.stringify(excelData)}, function (result) {
                let jsonObject = JSON.parse(result)
                alert(jsonObject.message);
                if (jsonObject.flag) {
                    closePop();
                    getTableData();
                }
            })
        } else {
            alert('请上传excel！');
        }
    })

    function getTableData() {
        $.ajax({
            url: "http://localhost:8989/DuiMa_war_exploded/GetPlan",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    jsonObj = res.data;
                    updateTable(false);
                }
            }
        })
    }

    function getDetailData(planid, i) {
        $.post("http://localhost:8989/DuiMa_war_exploded/GetPreProduct", {'planid': planid}, function (result) {
            result = JSON.parse(result);
            if (result.data.length !== 0) {
                excelData.preProduct = result.data;
                excelData.plan = jsonObj[i];
                $(".pop_up").show();
                $(".title_1").hide();
                $(".title_2").show();
                $("#pop_print").show();
                $("#pop_input").hide();
                $(".pop_footer").hide();
                getStyleList();
                updateTable(true);
            }
        })
    }

    function delTableData(planid) {

    }

    function updateTable(detail) {
        let preProductData = excelData.preProduct;
        let str = "";
        if (detail) {
            $("#planname").val(excelData.plan.planname);
            $("#company").val(excelData.plan.company);
            $("#plant").val(excelData.plan.plant);
            for (let i = (pop_num - 1) * 15; i < pop_num * 15 && i < preProductData.length; i++) {
                let time = preProductData[i]['time'] === undefined ? '' : preProductData[i]['time']
                str += "<tr><td class='tdStyle_body'>" + preProductData[i]['materialcode'] +
                    "</td><td class='tdStyle_body'>" + preProductData[i]['projectname'] +
                    "</td><td class='tdStyle_body'>" + preProductData[i]['build'] +
                    "</td><td class='tdStyle_body'>" + preProductData[i]['size'] +
                    "</td><td class='tdStyle_body'>" + preProductData[i]['preproductid'] +
                    "</td><td class='tdStyle_body'>" + preProductData[i]['volume'] +
                    "</td><td class='tdStyle_body'>" + parseFloat(preProductData[i]['weigh']).toFixed(2) +
                    "</td><td class='tdStyle_body'>" + preProductData[i]['qc'] +
                    "</td><td class='tdStyle_body'>" + time +
                    "</td></tr>";

                $("#detailTableText").html(str);
            }
        } else {
            for (let i = (num - 1) * 15; i < num * 15 && i < jsonObj.length; i++) {
                str += "<tr><td class='tdStyle_body'>" + jsonObj[i]['planname'] +
                    "</td><td class='tdStyle_body'>" + jsonObj[i]['company'] +
                    "</td><td class='tdStyle_body'>" + jsonObj[i]['plant'] +
                    "</td><td class='tdStyle_body'><a href='#' onclick='getDetailData(" + jsonObj[i]['planid'] + "," + i + ")'>详情</a><a href='#' onclick='delTableData(" + jsonObj[i]['planid'] + ")'>删除</a></tr>";
                $("#planTableText").html(str);
            }
        }
    }

    //给input标签绑定change事件，一上传选中的.xls文件就会触发该函数
    $('#excel-file').change(function (e) {
        let file = e.target.files[0];
        if (file === undefined) {
            return;
        }
        let name = file.name;
        //正则表达式，文件名为字母、数字或下划线，且不能为空。尾缀为.xls或.xlsx
        var pattern = /((\.xls)|(\.xlsx)){1}$/;
        if (!pattern.test(name)) {
            alert("请选择excel文件")
            return;
        }
        let reader = new FileReader();
        reader.onload = function (event) {
            let data = event.target.result;
            let workbook = XLSX.read(data, {type: 'binary'});
            excelData = outputWorkbook(workbook)
            pop_count = Math.ceil(excelData.preProduct.length / 15);
            updateTable(true);
            setFooter();
        }
        reader.readAsBinaryString(file);
    });

    function jumpToNewPage(index, detail) {
        if (detail) {
            if (index === 1) {
                pop_num = 1;
                setFooter();
                updateTable(detail)
            }
            if (index === 2) {
                pop_num = pop_count;
                setFooter();
                updateTable(detail)
            }
            if (index === 3) {
                pop_num--;
                setFooter();
                updateTable(detail)
            }
            if (index === 4) {
                pop_num++;
                setFooter();
                updateTable(detail)
            }
        } else {
            if (index === 1) {
                num = 1;
                setFooter();
                updateTable(detail)
            }
            if (index === 2) {
                num = pop_count;
                setFooter();
                updateTable(detail)
            }
            if (index === 3) {
                num--;
                setFooter();
                updateTable(detail)
            }
            if (index === 4) {
                num++;
                setFooter();
                updateTable(detail)
            }
        }


    }

    function setFooter() {
        let str = pop_num + '/' + pop_count;
        $('#detailResultTip').text(str);
        if (pop_count === pop_num) {
            $('#pop_next').attr('disabled', true);
            $('#pop_last').attr('disabled', true);
        } else {
            $('#pop_next').attr('disabled', false);
            $('#pop_last').attr('disabled', false);
        }
        if (pop_num === 1) {
            $('#pop_pre').attr('disabled', true);
            $('#pop_first').attr('disabled', true)
        } else {
            $('#pop_pre').attr('disabled', false);
            $('#pop_first').attr('disabled', false)
        }
        if (count === num) {
            $('#next').attr('disabled', true);
            $('#last').attr('disabled', true);
        } else {
            $('#next').attr('disabled', false);
            $('#last').attr('disabled', false);
        }
        if (pop_num === 1) {
            $('#_pre').attr('disabled', true);
            $('#first').attr('disabled', true)
        } else {
            $('#pre').attr('disabled', false);
            $('#first').attr('disabled', false)
        }
    }


    // 二维码样式
    var qrstyle = {}
    // 字段映射
    var fieldmap = {}

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

    function checkdata() {
        var preProductIds = []
        for (var i = 0; i < excelData.preProduct.length; i++) {
            preProductIds.push(excelData.preProduct[i].pid)
        }
        $.ajax({
            url: "http://localhost:8989/DuiMa_war_exploded/PrintPreProduct",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                productIds: JSON.stringify(preProductIds)
            },
            success: function (res) {
                // var jsonobj = JSON.parse(res.data)
                console.log(res)
                // 原来的data中去除已打印部分
                getStyle()
            },
        })
    }

    // 获取样式
    function getStyle() {
        // 把样式设定为目前选中的样式
        var qrcodeid = $("#qrcodestyles :selected").val()
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
                printData()
            },
            error: function (message) {
                console.log(message)
            }
        })

    }

    // 获取字段映射
    function getFieldMap() {
        var fieldNames = {
            pi_key: "STRING",
            pi_value: "STRING"
        }
        $.ajax({
            url: "http://localhost:8989/DuiMa_war_exploded/QuerySQL",
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
                var jsonobj = JSON.parse(res.data)
                fieldmap = {}
                for (var i = 0; i < jsonobj.length; i++) {
                    fieldmap[jsonobj[i].pi_key] = jsonobj[i].pi_value
                }
            }
        })
    }

    function printData() {
        var startStr = "<!--startprint-->"
        var endStr = "<!--endprint-->"
        // 获取样式中的长宽
        var xsize = qrstyle.xsize
        var ysize = qrstyle.ysize
        var startitem = $(startStr)
        $("#printArea").empty()
        $("#printArea").append(startitem)
        for (var i = 0; i < excelData.preProduct.length; i++) {
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
                var nodestr = fieldmap[nodevalue] + ":" + excelData.preProduct[i][nodevalue]
                item += "<span class='pStyle' style='position: absolute;left:" + xsituation + "px;top:" + ysituation + "px;'>" + nodestr + "</span>"
            }
            // end
            item += "</div>"
            var newItem = $(item)
            $("#printArea").append(newItem)
            // 设置二维码内容
            var qrcodeContent = ""
            var tmp = qrstyle.qRCode.qRCodeContent
            for (var j = 0; j < tmp.length; j++) {
                qrcodeContent += fieldmap[tmp[j]] + ":" + excelData.preProduct[i][tmp[j]] + "\n"
            }
            getQRCode(i, qrcodeContent)
        }
        var enditem = $(endStr)
        // $("#printArea").append(enditem)
    }

    function getQRCode(idx, str) {
        new QRCode(document.getElementById("qrcode_" + idx), {
            text: str,
            width: 150,
            height: 150,
            colorDark: "#000000",
            colorLight: "#ffffff",
            correctLevel: QRCode.CorrectLevel.H
        })
        printLabels();
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
</html>
