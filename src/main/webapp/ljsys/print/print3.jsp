<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="./css/pop_up.css">
    <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
    <script src="https://cdn.bootcss.com/xlsx/0.11.5/xlsx.core.min.js"></script>
</head>
<body>
<div style="height: 95%;width: 100%">
    <div style="height: 10%;width: 100%">
        <button style="position:relative;top: 40%;left: 15%;font-family: Simsun;font-size:20px;" onclick="openPop()">
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
            <input type="file" id="excel-file" style="position: relative;top:10px">
            <h3 style="text-align: center;margin-top: 0;">导入预览</h3>
            <div style="height: 400px;border: 1px solid #000">
                <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                    <tr>
                        <td class='tdStyle'>计划名称</td>
                        <td class='tdStyle'>公司</td>
                        <td class='tdStyle'>工厂</td>
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
    let excelData = [];
    let pop_num = 1;

    function openPop() {
        $(".pop_up").show();
    }

    function closePop() {
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
        let str = "";
        for (let i = num; i < jsonObj.length; i++) {
            str += "<tr><td class='tdStyle'>" + jsonObj[i]['projectname'] +
                "</td><td class='tdStyle'>" + jsonObj[i]['company'] +
                "</td><td class='tdStyle'>" + jsonObj[i]['plant'] +
                "</td><td class='tdStyle'>";
            // 查询
            if (detail) {
                str += "<a href='qrcodeInfo.jsp?qrcodeId=" + jsonObj[i]['qrcode_id'] + "&qrcodeName=" + encodeURIComponent(jsonObj[i]['qrcode_name']) + "'>详情</a>"
                str += "</td></tr>"
            }
        }
        $("#tableText").html(str);
    }

    //给input标签绑定change事件，一上传选中的.xls文件就会触发该函数
    $('#excel-file').change(function (e) {
        let file = e.target.files[0];
        let reader = new FileReader();
        reader.onload = function (event) {
            let data = event.target.result;
            let workbook = XLSX.read(data, {type: 'binary'});
            // outputWorkbook2(workbook)
            outputWorkbook(workbook)
        }
        reader.readAsBinaryString(file);
    });

    // 读取 excel文件
    function outputWorkbook(workbook) {
        let sheetNames = workbook.SheetNames; // 工作表名称集合
        let zn_title = ['物料编号', '项目名称', '楼栋楼层', '构件尺寸', '构件编号', '体积', '重量', '质检员', '日期'];
        let en_title = ['materialcode', 'projectname', 'build', 'size', 'preproductid', 'volume', 'weigh', 'qc', 'time'];
        sheetNames.forEach(name => {
            let worksheet = workbook.Sheets[name]; // 只能通过工作表名称来获取指定工作表
            //检测excel表格式
            if (worksheet['A1'].v !== undefined) {
                excelData.push({projectname: worksheet['A1'].v});
            } else {
                alert("计划名不能为空")
                return;
            }
            if (worksheet['B3'].v === '公司') {
                excelData.push({'company': worksheet['B4'].v})
            } else {
                alert("excel格式不正确")
                return;
            }
            if (worksheet['B3'].v === '工厂') {
                excelData.push({'plant': worksheet['B4'].v})
            } else {
                alert("excel格式不正确")
                return;
            }
            let row = 10;
            let col = 65;
            for (let i = 0; i < zn_title.length; i++) {
                let s = String.fromCharCode(col);
                if (worksheet[s + row].v !== zn_title[i]) {
                    alert("excel格式不正确")
                    return;
                }
                col++;
            }

            do {
                s = String.fromCharCode(col);
                let temp = en_title[i];
                excelData.push({temp: worksheet['A1'].v})

            } while ()
            console.log(key + "---" + worksheet[key] + "----" + worksheet[key].v);
            // v是读取单元格的原始值
        });
    }

    function outputWorkbook2(workbook) {
        var persons = []; // 存储获取到的数据
        // 遍历每张表读取
        // 表格的表格范围，可用于判断表头是否数量是否正确
        var fromTo = '';
        for (var sheet in workbook.Sheets) {
            if (workbook.Sheets.hasOwnProperty(sheet)) {
                fromTo = workbook.Sheets[sheet]['!ref'];
                console.log(fromTo);
                persons = persons.concat(XLSX.utils.sheet_to_json(workbook.Sheets[sheet]));
                // break; // 如果只取第一张表，就取消注释这行
            }
        }
        console.log(persons)

    }

</script>
</html>