<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="./css/pop_up.css">
    <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
    <script src="https://cdn.bootcss.com/xlsx/0.11.5/xlsx.core.min.js"></script>
    <script type="text/javascript" src="./js/util.js"></script>
</head>
<body>
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
                    <td class='tdStyle'>计划名称</td>
                    <td class='tdStyle'>公司</td>
                    <td class='tdStyle'>工厂</td>
                    <td class='tdStyle'>操作</td>
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
        <div class="pop_title title_2">详情</div>
        <div class="close_btn"><img src="./img/close.png" onclick="closePop()"></div>
        <div style="width: 90%;height: 80%;margin: 0 auto">
            <input type="file" id="excel-file"
                   accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel"
                   style="position: relative;top:3.5%">
            <button type="button" id="print" style="position: relative;top:3.5%">打印数据</button>
            <h3 id="inputDetail" style="position: absolute;left: 45%;top: 6%;">导入预览</h3>
            <h3 id="preProduct" style="position: absolute;left: 45%;top: 6%;">构件列表</h3>
            <div style="margin-top: 4%; margin-bottom: 1%;">
                <label for="planname">计划名：</label><input id="planname" disabled>
                <label for="company">公司：</label><input id="company" disabled>
                <label for="plant">工厂：</label><input id="plant" disabled>
            </div>
            <div style="height: 70%;border: 1px solid #000">
                <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                    <tr>
                        <td class='tdStyle'>物料编号</td>
                        <td class='tdStyle'>项目名称</td>
                        <td class='tdStyle'>楼栋楼层</td>
                        <td class='tdStyle'>构件尺寸</td>
                        <td class='tdStyle'>构件编号</td>
                        <td class='tdStyle'>体积</td>
                        <td class='tdStyle'>质量</td>
                        <td class='tdStyle'>质检员</td>
                        <td class='tdStyle'>日期</td>
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
</div>

</body>
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
        $("#excel-file").show();
        $("#print").hide();
        $("#inputDetail").show();
        $("#preProduct").hide();

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
                $("#excel-file").hide();
                $(".title_1").hide();
                $(".title_2").show();
                $("#print").show();
                $("#inputDetail").hide();
                $("#preProduct").show();
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
                str += "<tr><td class='tdStyle'>" + preProductData[i]['materialcode'] +
                    "</td><td class='tdStyle'>" + preProductData[i]['projectname'] +
                    "</td><td class='tdStyle'>" + preProductData[i]['build'] +
                    "</td><td class='tdStyle'>" + preProductData[i]['size'] +
                    "</td><td class='tdStyle'>" + preProductData[i]['preproductid'] +
                    "</td><td class='tdStyle'>" + preProductData[i]['volume'] +
                    "</td><td class='tdStyle'>" + parseFloat(preProductData[i]['weigh']).toFixed(2) +
                    "</td><td class='tdStyle'>" + preProductData[i]['qc'] +
                    "</td><td class='tdStyle'>" + preProductData[i]['time'] +
                    "</td></tr>";

                $("#detailTableText").html(str);
            }
        } else {
            for (let i = (num - 1) * 15; i < num * 15 && i < jsonObj.length; i++) {
                str += "<tr><td class='tdStyle'>" + jsonObj[i]['planname'] +
                    "</td><td class='tdStyle'>" + jsonObj[i]['company'] +
                    "</td><td class='tdStyle'>" + jsonObj[i]['plant'] +
                    "</td><td class='tdStyle'><a href='#' onclick='getDetailData(" + jsonObj[i]['planid'] + "," + i + ")'>详情</a><a href='#' onclick='delTableData(" + jsonObj[i]['planid'] + ")'>删除</a></tr>";
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

</script>
</html>
