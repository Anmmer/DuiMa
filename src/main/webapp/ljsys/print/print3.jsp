<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%">
    <div style="position:relative;top: 5%;left: 15%;height:10%;width:70%;font-family: Simsun;font-size:16px;">
        <label for="startDate">开始时间:</label><input id="startDate" type="date" style="width: 12%;">
        <label for="endDate">结束时间:</label><input id="endDate" type="date" style="width: 12%;">
        <label for="planname">项目名称:</label><input id="planname" style="width: 12%;">
        <label for="materialcode">物料编号:</label><input id="materialcode" style="width: 12%;">
        <button style="position: absolute;right: 0;width: 8%" onclick="getTableData()">查 询</button>
    </div>
    <div style="width: 70%;height:85%;margin: 0 auto">
        <div style="position:relative;top: 4%;width: 20%">
            <%--            <a href="./files/importTemplate.xlsx" download="importTemplate.xlsx">导入模板</a>--%>
            <button onclick="openPop()">
                上传文件
            </button>
        </div>
        <button style="position:relative;top: 0;left: 92%;width: 8%" onclick="delTableData()">批量删除</button>
        <h3 style="text-align: center;margin-top: 0;">已导入计划列表</h3>
        <div style="height: 70%;">
            <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                <tr>
                    <td class='tdStyle_title' style="width: 3%;"><input id="plan_checkbok" type="checkbox"></td>
                    <td class='tdStyle_title' style="width: 10%">计划编号</td>
                    <td class='tdStyle_title' style="width: 10%">项目名称</td>
                    <td class='tdStyle_title' style="width: 8%">打印状态</td>
                    <td class='tdStyle_title' style="width: 10%">工厂</td>
                    <td class='tdStyle_title' style="width: 8%">生产日期</td>
                    <td class='tdStyle_title' style="width: 8%">产线</td>
                    <td class='tdStyle_title' style="width: 8%">楼栋楼层</td>
                    <td class='tdStyle_title' style="width: 10%">构建数(个)</td>
                    <td class='tdStyle_title' style="width: 8%">合计方量</td>
                    <td class='tdStyle_title' style="width: 8%">操作</td>
                </tr>
                <tbody id="planTableText">
                </tbody>
            </table>
        </div>
        <div style="height:30px;margin-top: 2%">
            <div style="width:33%;float: left;">
                <button id="first" type="button" style="font-family: Simsun;font-size:16px;"
                        onclick="jumpToNewPage(1,false)">
                    第一页
                </button>
                <button id="last" type="button" style="font-family: Simsun;font-size:16px;"
                        onclick="jumpToNewPage(2,false)">
                    最后一页
                </button>
            </div>
            <div style="width:34%;float: left;">
                <p id="planResultTip" style="margin-top: 0px;font-family: Simsun;font-size: 16px;text-align: center;">
                    1/1</p>
            </div>
            <div style="width:33%;float: left;">
                <button id="next" type="button" style="font-family: Simsun;font-size:16px;float:right;margin-left: 5px"
                        onclick="jumpToNewPage(4,false)">
                    后一页
                </button>
                <button id="pre" type="button" style="font-family: Simsun;font-size:16px;float:right;"
                        onclick="jumpToNewPage(3,false)">
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
            <div id="pop_query" style="width: 100%;height: 23%">
                <label for="print_build">楼栋楼层：</label><input id="print_build" style="width: 15%;margin-top: 4%"
                                                             disabled>
                <label for="print_line" style="margin-left: 1%">产线：</label><input id="print_line" style="width: 15%"
                                                                                  disabled>
                <label for="updatedate" style="margin-left: 1%">最后修改时间：</label><input id="updatedate" style="width: 15%"
                                                                                      disabled>
                <label for="print_materialcode" style="margin-left: 1%">物料编码：</label><input id="print_materialcode"
                                                                                            style="width: 13%"><br>
                <label for="print_planname">项目名称：</label><input id="print_planname" style="width: 15%" disabled>
                <label for="print_liner" style="margin-left: 1%">线长：</label><input id="print_liner"
                                                                                   style="width: 15%;margin-top: 3%;"
                                                                                   disabled>
                <label for="print_plantime" style="margin-left: 1%">计划生产时间：</label><input id="print_plantime"
                                                                                          style="width: 15%" disabled>
                <button id="pop_query_button" onclick="query()" style="margin-left:15%;width: 8%">查&nbsp;&nbsp;询
                </button>

            </div>
            <div id="pop_input" style="width: 100%;height: 23%">
                <input type="file" id="excel-file"
                       accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel"
                       style="position: relative;margin-top: 2%;">
                <h3 id="inputDetail" style="position: absolute;left: 45%;top: 7%;">导入预览</h3>
                <div style="margin-top: 2%">
                    <label for="build">楼栋楼层：</label><input id="build" style="width: 15%">
                    <label for="pop_planname"
                           style="margin-left: 1%">项&nbsp;&nbsp;目&nbsp;&nbsp;名&nbsp;称&nbsp;&nbsp;：</label><input
                        id="pop_planname" style="width: 15%" disabled>
                    <label for="line" style="margin-left: 1%">产&nbsp;&nbsp;&nbsp;线：</label><input id="line"
                                                                                                  style="width: 15%"
                                                                                                  disabled><br>
                    <label for="liner">线&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;长：</label><input id="liner"
                                                                                                   style="width: 15%;margin-top: 2%;"
                                                                                                   disabled>
                    <label for="plantime" style="margin-left: 1%">计划生产时间：</label><input id="plantime" style="width: 15%"
                                                                                        disabled>
                    <label for="qc" style="margin-left: 1%">质检员：</label><select id="qc" style="width: 15%"></select>
                </div>
            </div>
            <div style="height: 62%;margin-top: 2%">
                <table class="hiddenTDOverFlowContent" cellspacing="0" cellpadding="0" width="100%" align="center"
                       border="1">
                    <tr id="table_tr">
                        <td class='table_tr_print tdStyle_title' style="width: 2%;"><input id="detail_checkbok"
                                                                                           type="checkbox"></td>
                        <td class='tdStyle_title' style="width: 14%">物料编号</td>
                        <td class='tdStyle_title' style="width: 20%">物料名称</td>
                        <td class='tdStyle_title' style="width: 10%">构建编号</td>
                        <td class='tdStyle_title' style="width: 10%">规格</td>
                        <td class='tdStyle_title' style="width: 6%">方量</td>
                        <td class='tdStyle_title' style="width: 6%">重量</td>
                        <td class='tdStyle_title' style="width: 6%">砼标号</td>
                        <td class='table_tr_print tdStyle_title' style="width: 6%">质检员</td>
                        <td class='table_tr_print tdStyle_title' style='width: 6%'>打印数</td>
                        <td class='table_tr_print tdStyle_title' style="width: 5%;">操作</td>
                    </tr>
                    <tbody id="detailTableText">
                    </tbody>
                </table>
            </div>
            <div style="height:4%;margin-top: 1%;">
                <div style="width:33%;float: left;">
                    <button id="pop_first" type="button" disabled style="font-family: Simsun;font-size:16px;"
                            onclick="jumpToNewPage(1,true)">第一页
                    </button>
                    <button id="pop_last" type="button" disabled style="font-family: Simsun;font-size:16px;"
                            onclick="jumpToNewPage(2,true)">最后一页
                    </button>
                </div>
                <div style="width:34%;float: left;">
                    <p id="detailResultTip"
                       style="margin-top: 0px;font-family: Simsun;font-size: 16px;text-align: center;">
                        1/1</p>
                </div>
                <div style="width:33%;float: left;">
                    <button id="pop_next" type="button" disabled
                            style="font-family: Simsun;font-size:16px;float:right;margin-left: 5px"
                            onclick="jumpToNewPage(4,true)">
                        后一页
                    </button>
                    <button id="pop_pre" type="button" disabled style="font-family: Simsun;font-size:16px;float:right;"
                            onclick="jumpToNewPage(3,true)">
                        前一页
                    </button>
                </div>
            </div>
        </div>
        <div id="pop_print" style="width: 90%;height: 10%;margin: 0 auto">
            <label class="label" style="position: relative;margin-top: 2%;" for="qrcodestyles">选择一个样式:</label>
            <select id="qrcodestyles" style="position: relative;margin-top: 2%;width: 15%;"></select>
            <button type="button" id="print_data"
                    style="position: relative;margin-top: 2%;margin-left: 1%"
                    onclick="checkdata(false)">打印数据
            </button>
            <button type="button" id="print_datas" style="position: relative;margin-top: 2%; margin-left: 1%"
                    onclick="checkdata(true)">全部打印
            </button>
            <button type="button" style="position: relative;margin-top: 2%; margin-left: 1%"
                    onclick="delDetailData()">批量删除
            </button>
        </div>
        <div class="pop_footer" style="height: 10%;display: flex;align-items: center;justify-content: center;">
            <button type="submit" class="saveo save-btn">保存</button>
            <button type="reset" class="recover-btn">重置</button>
        </div>
    </div>
    <!--打印主界面-->
    <div style="width:100%;height:70%;margin:auto;float: left;display: none">
        <div id="printArea" style="width:80%;height:100%;margin: auto;background-color: azure;overflow-y: auto;"></div>
    </div>
    <div class="gif">
        <img src="./img/loading.gif"/>
    </div>
</div>
<script>
    let num = 1;        //分页当前页
    let count = 1;      //分页总页数
    let pop_num = 1;    //弹框分页当前页
    let pop_count = 1;  //弹框分页总页数
    let excelData = {}; //excel数据
    let jsonObj = [];   //plan数据
    let printsData = [] //打印的数据
    let print = false;  //是否显示打印勾选按钮
    let plannumber = null; //
    let plan_i = 0;       //两个函数的绑定全选
    let det_i = 0;        //两个函数的绑定全选

    window.onload = getTableData();

    //打开弹窗
    function openPop() {
        $(".pop_up").show();
        $(".title_1").show();
        $(".title_2").hide();
        $("#pop_print").hide();
        $("#pop_input").show();
        $(".pop_footer").show();
        $('.table_tr_print').hide();
        $('#pop_query').hide();
        getArchives();
        print = false;
    }

    //关闭弹窗
    function closePop() {
        $(".pop_up").hide();
        $("#detail_checkbok").prop("checked", false);
        $("#print_materialcode")
        $("#detailTableText td :checkbox").prop("checked", false);
        det_i = 0;
        reset();
    }

    //重置弹窗
    function reset() {
        $("#pop_planname").val('');
        $("#build").val('');
        $("#line").val('');
        $("#liner").val('');
        $("#plantime").val('');
        $('#excel-file').val('')
        $('#qc').val('')
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
        if ($('#build').val() === '') {
            alert("请输入楼栋楼层！")
            return;
        }
        if ($('#qc option:selected').val() == 0) {
            alert('请选择质检员！');
            return;
        }
        if (Object.keys(excelData).length !== 0) {
            excelData.plan.qc = $('#qc option:selected').val();
            excelData.plan.build = $('#build').val();
            $.post("${pageContext.request.contextPath}/AddPlan", {str: JSON.stringify(excelData)}, function (result) {
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

    $('.recover-btn').click(() => {
        reset();
    })

    //查询plan表数据
    function getTableData() {
        let startDate = $('#startDate').val();
        let endDate = $('#endDate').val();
        let planname = $('#planname').val();
        let materialcode = $('#materialcode').val();
        if (startDate !== '' && endDate !== '') {
            if (startDate > endDate) {
                alert("开始时间不能大于结束时间！");
                return;
            }
        }
        let obj = {
            'startDate': startDate,
            'endDate': endDate,
            'planname': planname,
            'materialcode': materialcode
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlan",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    jsonObj = res.data;
                    updateTable(false);
                    setFooter();
                } else {
                    jsonObj = []
                    updateTable(false);
                    setFooter();
                }
            },
            error: function () {
                jsonObj = [];
                updateTable(false);
                alert("查询失败！")
                setFooter();
            }
        })
    }

    //构建删除刷新页面
    function query() {
        let materialcode = $('#print_materialcode').val();
        $.post("${pageContext.request.contextPath}/GetPreProduct", {
            plannumber: plannumber,
            materialcode: materialcode
        }, function (result) {
            result = JSON.parse(result);
            excelData.preProduct = result.data;
            updateTable(true);
        });
    }


    //获取明细数据
    function getDetailData(plannumber_p) {
        plannumber = plannumber_p;
        $.post("${pageContext.request.contextPath}/GetPreProduct", {'plannumber': plannumber_p}, function (result) {
            result = JSON.parse(result);
            if (result.data !== undefined) {
                excelData.preProduct = result.data;
                excelData.plan = jsonObj.find((item) => {
                    return item.plannumber == plannumber_p;
                });
                if (excelData.preProduct.length === 0) {
                    pop_count = 1;
                } else {
                    pop_count = Math.ceil(excelData.preProduct.length / 10);
                }
                $('#print_build').val(excelData.plan.build);
                $('#print_line').val(excelData.plan.line);
                $('#print_liner').val(excelData.plan.liner);
                $('#updatedate').val(excelData.plan.updatedate);
                $('#print_plantime').val(excelData.plan.plantime);
                $('#print_planname').val(excelData.plan.planname);
                setFooter();
                $(".pop_up").show();
                $(".title_1").hide();
                $(".title_2").show();
                $("#pop_print").show();
                $("#pop_input").hide();
                $(".pop_footer").hide();
                getStyleList();
                $('.table_tr_print').show();
                $('#pop_query').show();
                print = true;
                updateTable(true);
                getFieldMap();
            }
        })
    }


    //全选
    $("#plan_checkbok").on("click", function () {
        if (plan_i == 0) {
            //把所有复选框选中
            $("#planTableText td :checkbox").prop("checked", true);
            plan_i = 1;
        } else {
            $("#planTableText td :checkbox").prop("checked", false);
            plan_i = 0;
        }

    });

    //全选
    $("#detail_checkbok").on("click", function () {
        if (det_i == 0) {
            //把所有复选框选中
            $("#detailTableText td :checkbox").prop("checked", true);
            det_i = 1;
        } else {
            $("#detailTableText td :checkbox").prop("checked", false);
            det_i = 0;
        }

    });

    function delDetailData(pid, fangliang) {
        let obj = [];
        if (pid === undefined) { //批量删除
            $('#detailTableText').find('input:checked').each(function () {
                obj.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，obj
            });
            if (obj.length === 0) {
                alert("请勾选！")
                return;
            }
            let preproduct = excelData.preProduct;
            fangliang = 0;
            preproduct.forEach((item)=>{
                obj.forEach((val)=>{
                    if(item.pid ==val ){
                        console.log()
                        fangliang+=item.fangliang;
                    }
                })
            })
        } else {
            obj.push(pid);
        }
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }
        $.post("${pageContext.request.contextPath}/DeletePreProduct", {
            pids: JSON.stringify(obj),
            plannumber: excelData.plan.plannumber,
            fangliang: fangliang
        }, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                query();
                getTableData();
            }
        });
    }

    //删除plan数据
    function delTableData(plannumber) {
        let obj = [];
        if (plannumber === undefined) { //批量删除
            $('#planTableText').find('input:checked').each(function () {
                obj.push($(this).attr('data-id'));   //找到对应checkbox中data-id属性值，然后push给空数组pids
            });
            if (obj.length === 0) {
                alert("请勾选！")
                return;
            }
        } else {
            obj.push(plannumber);
        }
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }

        $.post("${pageContext.request.contextPath}/DeletePlan", {plannumbers: JSON.stringify(obj)}, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                getTableData();
            }
        });
    }


    //更新表格
    function updateTable(detail) {
        let preProductData = excelData.preProduct;
        let str = "";
        if (detail) {
            for (let i = (pop_num - 1) * 10; i < pop_num * 10 && i < preProductData.length; i++) {
                let time = preProductData[i]['time'] === undefined ? '' : preProductData[i]['time']
                if (print) {
                    str += "<tr><td class='tdStyle_body'><input type='checkbox' data-id=" + preProductData[i]["pid"] + "></td>"
                } else {
                    str += "<tr>"
                }
                str += "<td class='tdStyle_body' title='" + preProductData[i]['materialcode'] + "'>" + preProductData[i]['materialcode'] +
                    "</td><td class='tdStyle_body' title='" + preProductData[i]['materialname'] + "'>" + preProductData[i]['materialname'] +
                    "</td><td class='tdStyle_body' title='" + preProductData[i]['preproductid'] + "'>" + preProductData[i]['preproductid'] +
                    "</td><td class='tdStyle_body' title='" + preProductData[i]['standard'] + "'>" + preProductData[i]['standard'] +
                    "</td><td class='tdStyle_body' title='" + preProductData[i]['fangliang'] + "'>" + preProductData[i]['fangliang'] +
                    "</td><td class='tdStyle_body' title='" + preProductData[i]['weigh'] + "'>" + preProductData[i]['weigh'] +
                    "</td><td class='tdStyle_body' title='" + preProductData[i]['concretegrade'] + "'>" + preProductData[i]['concretegrade'];
                if (print) {
                    str += "</td><td class='tdStyle_body' title='" + preProductData[i]['qc'] + "'>" + preProductData[i]['qc'] +
                        "</td><td class='tdStyle_body' title='" + preProductData[i]['print'] + "'>" + preProductData[i]['print'] +
                        "</td><td class='tdStyle_body'><a href='#' onclick='delDetailData(" + preProductData[i]['pid'] + "," + preProductData[i]['fangliang'] + ")'>删除</a>" +
                        "</td></tr>"
                } else {
                    str += "</td></tr>"
                }
            }
            $("#detailTableText").html(str);
        } else {
            for (let i = (num - 1) * 15; i < num * 15 && i < jsonObj.length; i++) {
                let style = ''
                let state = ''
                if (jsonObj[i]['printstate'] !== 0) {
                    state = '已打印'
                    style = "style='background-color: rgb(0,176,80);'"
                } else {
                    state = '打印中'
                    style = "style='background-color: red;'"
                }
                str += "<tr><td class='tdStyle_body'><input type='checkbox' data-id=" + jsonObj[i]["plannumber"] + ">" +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['plannumber'] + "'>" + jsonObj[i]['plannumber'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['plannumber'] + "'>" + jsonObj[i]['planname'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['state'] + "'" + style + ">" + state +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['plant'] + "'>" + jsonObj[i]['plant'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['plantime'] + "'>" + jsonObj[i]['plantime'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['line'] + "'>" + jsonObj[i]['line'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['build'] + "'>" + jsonObj[i]['build'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['tasknum'] + "'>" + jsonObj[i]['tasknum'] +
                    "</td><td class='tdStyle_body' title='" + jsonObj[i]['tasksqure'] + "'>" + jsonObj[i]['tasksqure'] +
                    "</td><td class='tdStyle_body'><a href='#' onclick='getDetailData(" + jsonObj[i]['plannumber'] + ")'>详情</a></td></tr>";
            }
            $("#planTableText").html(str);
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
        let pattern = /((\.xls)|(\.xlsx)){1}$/;
        if (!pattern.test(name)) {
            alert("请选择excel文件")
            return;
        }
        let reader = new FileReader();
        reader.onload = function (event) {
            let data = event.target.result;
            let workbook = XLSX.read(data, {type: 'binary'});
            excelData = outputWorkbook(workbook)
            if (excelData.preProduct.length === 0) {
                return
            }
            let str = '';
            let flag = excelData.preProduct.some((val, index) => {
                for (let i = index + 1; i < excelData.preProduct.length; i++) {
                    if (val.materialcode === excelData.preProduct[i].materialcode) {
                        return true;
                    }
                }
            })
            if (flag) {
                alert('物料编码：' + str + '重复');
                return;
            }
            $.post("${pageContext.request.contextPath}/GetPreProduct", null, function (result) {
                result = JSON.parse(result);
                excelData.preProduct.forEach((item) => {
                    result.data.forEach((res_item) => {
                        if (item.materialcode === res_item.materialcode) {
                            if (str === '') {
                                str += item.materialcode
                            } else {
                                str += '，' + item.materialcode;
                            }
                        }
                    })
                });
            }).then(function () {
                if (str !== '') {
                    excelData = {};
                    $('#excel-file').val('');
                    alert('物料编码：' + str + ']已存在');
                    return;
                }
                $('#pop_planname').val(excelData.plan.planname);
                $('#line').val(excelData.plan.line);
                $('#plantime').val(excelData.plan.plantime);
                $('#liner').val(excelData.plan.liner);
                pop_count = Math.ceil(excelData.preProduct.length / 10);
                updateTable(true);
                setFooter();
            });
        }
        reader.readAsBinaryString(file);
    });

    function getPlanName() {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetDefaultQc",
            type: 'post',
            dataType: 'json',
            data: null,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    let data = res.data;
                    $('#qc').find("option[value=" + data[0].qc + "]").attr('selected', true);
                } else {
                    alert("产线默认质检员不存在！，请先在基础档案管理设置默认质检员信息")
                }
            },
            error: function () {
                alert("查询失败！")
            }
        });
    }

    function getDefaultQc() {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetDefaultQc",
            type: 'post',
            dataType: 'json',
            data: null,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    let data = res.data;
                    $('#qc').find("option[value=" + data[0].qc + "]").attr('selected', true);
                } else {
                    alert("产线默认质检员不存在！，请先在基础档案管理设置默认质检员信息")
                }
            },
            error: function () {
                alert("查询失败！")
            }
        });
    }

    function getArchives() {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetQc",
            type: 'post',
            dataType: 'json',
            data: null,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    let data = res.data;
                    let qc = document.getElementById("qc");
                    $('#qc').empty();
                    // qc.options.add(new Option('', 0));
                    for (let i = 0; i < data.length; i++) {
                        qc.options.add(new Option(data[i].qc, data[i].qc))
                    }
                } else {
                    alert("产线质检员不存在！，请先在基础档案管理录入质检员信息")
                }
            },
            error: function () {
                alert("查询失败！")
            }
        }).then(() => {
            getDefaultQc();
        });
    }

    //上一页、下一页
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
        let pop_str = pop_num + '/' + pop_count;
        let str = num + '/' + count;
        $('#detailResultTip').text(pop_str);
        $('#planResultTip').text(str);
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
        if (num === 1) {
            $('#pre').attr('disabled', true);
            $('#first').attr('disabled', true)
        } else {
            $('#pre').attr('disabled', false);
            $('#first').attr('disabled', false)
        }
    }


    // 二维码样式
    let qrstyle = {}
    // 字段映射
    let fieldmap = {}

    // 获取所有样式并放入select
    function getStyleList() {
        let fieldNames = {
            qrcode_id: "INT",
            qrcode_name: "STRING"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
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
                let jsonobj = JSON.parse(res.data);
                let qrcodestyles = document.getElementById("qrcodestyles")
                $('#qrcodestyles').empty();
                qrcodestyles.options.add(new Option('', 0));
                for (let i = 0; i < jsonobj.length; i++) {
                    qrcodestyles.options.add(new Option(jsonobj[i].qrcode_name, jsonobj[i].qrcode_id))
                }
                // 测试
                //getStyle()
            },
            error: function (message) {
                (message)
            }
        })
    }

    //检查数据并打印
    function checkdata(isAll) {
        if ($("#qrcodestyles option:selected").val() === '0') {
            alert("请选择一个样式！");
            return;
        }
        let pids = []
        if (!isAll) {
            $('#detailTableText').find('input:checked').each(function () {
                pids.push({pid: $(this).attr('data-id')});   //找到对应checkbox中data-id属性值，然后push给空数组pids
            });
            if (pids.length === 0) {
                alert("请勾选！");
                return;
            }
            pids.forEach((val) => {
                printsData.push(excelData.preProduct.find((item) => {
                    return item.pid == val.pid;
                }));
            })
        } else {
            for (let i = 0; i < excelData.preProduct.length; i++) {
                pids.push({pid: excelData.preProduct[i].pid})
            }
            if (pids.length === 0) {
                alert("暂无打印数据");
                return;
            }
            printsData = excelData.preProduct;
        }
        let str = ''


        printsData.forEach((item) => {
            if (item.print > 0) {
                str += item.preproductid + '，';
            }
        })
        if (str !== '') {
            let r = confirm("亲，构建编号：" + str + " 已经打印过，确定重复打印？");
            if (r === false) {
                printsData = [];
                return;
            }
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/PrintPreProduct",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                productIds: JSON.stringify(pids),
                plannumber: printsData[0].plannumber,
                tasknum: printsData[0].tasknum
            },
            success: function (res) {
                if (res.flag) {
                    getStyle()
                } else {
                    alert("打印失败！")
                }
            },
        })
    }

    // 获取样式
    function getStyle() {
        // 把样式设定为目前选中的样式
        let qrcodeid = $("#qrcodestyles :selected").val()
        if (qrcodeid === '0') {
            return
        }
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
                qrstyle = JSON.parse(datatmp.qrcode_content)
                $(".gif").css("display", "flex");
                printData()
            },
            error: function (message) {
            }
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
        })
    }

    //设置打印内容
    function printData() {
        let startStr = "<!--startprint-->"
        let endStr = "<!--endprint-->"
        // 获取样式中的长宽
        let xsize = qrstyle.xsize
        let ysize = qrstyle.ysize
        let startitem = $(startStr)
        $("#printArea").empty()
        $("#printArea").append(startitem)
        for (let i = 0; i < printsData.length; i++) {
            // 已判断是否都已获取
            // 先填充内容，后设置位置
            let item = "<div style='page-break-after:always;position:relative;width:" + xsize + "px;height:" + ysize + "px;'>"
            // start
            // 放置二维码,后续需要往里面填充内容
            let xsituation = qrstyle.qRCode['xsituation']
            let ysituation = qrstyle.qRCode['ysituation']
            item += "<div id='qrcode_" + i + "' style='position: absolute;width:150px;height:150px;left:" + xsituation + "px;top:" + ysituation + "px;'></div>"
            // 放置其他各项
            for (let j = 0; j < qrstyle.items.length; j++) {
                let node = qrstyle.items[j]
                let nodevalue = node.content;
                xsituation = node.xsituation
                ysituation = node.ysituation
                let nodestr = fieldmap[nodevalue] + ":" + printsData[i][nodevalue]
                item += "<span class='pStyle' style='position: absolute;left:" + xsituation + "px;top:" + ysituation + "px;'>" + nodestr + "</span>"
            }
            // end
            item += "</div>"
            let newItem = $(item)
            $("#printArea").append(newItem)
            // 设置二维码内容
            let qrcodeContent = ""
            let tmp = qrstyle.qRCode.qRCodeContent
            for (let j = 0; j < tmp.length; j++) {
                qrcodeContent += fieldmap[tmp[j]] + ":" + printsData[i][tmp[j]] + "\n"
            }
            getQRCode(i, qrcodeContent)
        }
        let enditem = $(endStr)
        $("#printArea").append(enditem)
        setTimeout('printLabels()', 2000)

    }

    //生成二维码
    function getQRCode(idx, str) {
        new QRCode(document.getElementById("qrcode_" + idx), {
            text: str,
            width: 150,
            height: 150,
            colorDark: "#000000",
            colorLight: "#ffffff",
            correctLevel: QRCode.CorrectLevel.H
        })
    }

    // 打印标签
    function printLabels() {
        $(".gif").css("display", "none");
        let bdhtml = window.document.body.innerHTML;
        let sprnstr = "<!--startprint-->";
        let eprnstr = "<!--endprint-->";
        let prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
        prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML = prnhtml;
        window.print();
        window.document.body.innerHTML = bdhtml;
        location.reload();
        printsData = []
    }


</script>
