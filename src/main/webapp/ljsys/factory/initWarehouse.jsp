<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%;">
    <form class="form-inline" style="width:85%;margin: 0 auto;height:15%;padding-top:2%">
        <div class="form-group" style="width: 20%">
            <label for="excel-file">文件上传</label>
            <input type="file" id="excel-file"
                   accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel"
                   style="height: 24px;width: 60%;font-size: 12px;margin-bottom: 5px">
        </div>
        <div class="form-group" style="width: 30%;">
            <label>堆场信息：</label>
            <input style="height:34%;width: 50%" name="factoryName"
                   id="factoryName"
                   onclick="openPop1()" class="form-control">
        </div>
        <div class="form-group" style="width: 30%;">
            <label>入库方式：</label>
            <select style="height:34%;width: 50%" name="select"
                    id="select" class="form-control"></select>
        </div>
    </form>
    <div style="width:85%;height: 75%;margin: 0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0" id="inputDetail"><small>导入预览</small></h3>
        </div>
        <table class="table table-hover" style="text-align: center;">
            <tr id="table_tr">
                <td class='tdStyle_title active' style="width: 14%">构件编码</td>
                <td class='tdStyle_title active' style="width: 14%">构件名称</td>
                <td class='tdStyle_title active' style="width: 10%">构件规格</td>
                <td class='tdStyle_title active' style="width: 10%">图号</td>
                <td class='tdStyle_title active' style="width: 10%">类型</td>
                <td class='tdStyle_title active' style="width: 10%">楼栋</td>
                <td class='table_tr_print tdStyle_title active' style="width: 10%">楼层</td>
                <td class='table_tr_print tdStyle_title active' style="width: 10%">方量</td>
            </tr>
            <tbody id="detailTableText">
            </tbody>
        </table>
    </div>
    <nav aria-label="Page navigation" style="margin-left:30%;width:70%;height:10%;" id="page">
        <ul class="pagination" style="margin-top: 0;width: 70%">
            <li><span id="total_d" style="width: 22%">0条，共0页</span></li>
            <li>
                <a href="#" onclick="jumpToNewPage_p(2)" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <li id="li_d1"><a id="a_d1" href="#">1</a></li>
            <li id="li_d2"><a id="a_d2" href="#">2</a></li>
            <li id="li_d3"><a id="a_d3" href="#">3</a></li>
            <li id="li_d4"><a id="a_d4" href="#">4</a></li>
            <li id="li_d0"><a id="a_d0" href="#">5</a></li>
            <li>
                <a href="#" onclick="jumpToNewPage_p(3)" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
            <li style="border: none"><span>跳转：</span></li>
            <li class="input-group">
                <input type="text" id="jump_to_d" class="form-control" style="width: 10%">
            </li>
            <li><a href="#" onclick="jumpToNewPage_d2()">go!</a></li>
        </ul>
    </nav>
    <div style="width: 100%;text-align: center">
        <button type="button" id="save"
                style="height: 28px;width:70px;font-size: 12px !important;padding: 0;"
                class="save-btn btn btn-primary" onclick="save()">保存
        </button>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" style="position: absolute;left: 15%;top: 12%;" role="dialog"
         data-backdrop="false"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:60%">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModal_title">选择货位信息</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group" style="margin-top: 5%">
                            <label for="myModal_name1" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">堆场信息:</label>
                            <select class="form-control" style="width:50%;" id="myModal_name1"
                                    name="myModal_name1" onchange="getRegionData()"></select><br>
                            <label for="myModal_name2" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">区域信息:</label>
                            <select class="form-control" style="width:50%;" id="myModal_name2"
                                    name="myModal_name2" onchange="getLocation()"></select><br>
                            <label for="location" style="width: 28%;text-align: left;padding-right: 0"
                                   class="col-sm-2 control-label">货位信息:</label>
                            <select type="text" class="form-control" style="width:50%;" id="location"
                                    name="location"></select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="reset()">重置</button>
                    <button type="button" id="myModal_save" onclick="saveFactory()" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>

</div>
<script>
    let excelData = []
    let pop_pageCur = 1;    //分页当前页
    let pop_pageDate = []
    let pop_pageAll = 1;  //分页总页数

    window.onload = getYardData()

    function openPop1() {
        $('#myModal').modal('show')
    }

    function getYardData() {
        $.post("${pageContext.request.contextPath}/GetFactory", {
            type: '1',
            pageCur: '1',
            pageMax: '999'
        }, function (result) {
            getInWarehouseMethod('1')
            result = JSON.parse(result);
            let yard = result.data
            $('#myModal_name1').empty()
            $('#myModal_name1').append($("<option value=''></option>"))
            for (let o of yard) {
                let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                $('#myModal_name1').append(item)
            }
            $('#myModal3_name1').empty()
            $('#myModal3_name1').append($("<option value=''></option>"))
            for (let o of yard) {
                let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                $('#myModal3_name1').append(item)
            }
        })
    }

    function getRegionData() {
        let pid = $('#myModal_name1 option:selected').val()
        if (pid === "") {
            $('#myModal_name2').empty()
            $('#location').empty()
            return
        }
        $.post("${pageContext.request.contextPath}/GetFactory", {
            type: '2',
            pid: pid,
            pageCur: '1',
            pageMax: '999'
        }, function (result) {
            result = JSON.parse(result);
            let yard = result.data
            $('#myModal_name2').empty()
            $('#myModal_name2').append($("<option value=''></option>"))
            for (let o of yard) {
                let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                $('#myModal_name2').append(item)
            }
            $('#myModal3_name1').val(pid)
            $('#myModal3_name2').empty()
            $('#myModal3_name2').append($("<option value=''></option>"))
            for (let o of yard) {
                let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                $('#myModal3_name2').append(item)
            }
        })
    }

    function getLocation() {
        let pid = $('#myModal_name2 option:selected').val()
        $('#location').empty()
        $.post("${pageContext.request.contextPath}/GetFactory", {
            type: '3',
            pid: pid,
            pageCur: '1',
            pageMax: '999'
        }, function (result) {
            result = JSON.parse(result);
            let yard = result.data
            $('#location').empty()
            $('#location').append($("<option value=''></option>"))
            for (let o of yard) {
                let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                $('#location').append(item)
            }
            $('#myModal3_name3').empty()
            $('#myModal3_name3').append($("<option value=''></option>"))
            for (let o of yard) {
                let item = $("<option value='" + o['id'] + "'>" + o['name'] + "</option>")
                $('#myModal3_name3').append(item)
            }
            $('#myModal3_name2').val(pid)
        })
    }

    function getInWarehouseMethod(type) {
        $.post("${pageContext.request.contextPath}/GetInOutWarehouseMethod", {type: type}, function (result) {
            result = JSON.parse(result);
            let method = result.data
            $('#select').empty()
            $('#select').append($("<option value=''></option>"))
            for (let o of method) {
                let item = $("<option value='" + o['name'] + "'>" + o['name'] + "</option>")
                $('#select').append(item)
            }
        })
    }

    function saveFactory() {
        let myModal_name1 = $("#myModal_name1 option:selected").text() ? $("#myModal_name1 option:selected").text() + '/' : '../'
        let myModal_name2 = $("#myModal_name2 option:selected").text() ? $("#myModal_name2 option:selected").text() + '/' : '../'
        let myModal_name3 = $("#location option:selected").text() ? $("#location option:selected").text() : '..'
        let str
        if ($("#location option:selected").text() === '') {
            alert("请选择货位信息")
            return
        }
        if (myModal_name1 === '' && myModal_name2 === '' && myModal_name3 === '') {
            str = ''
        } else {
            str = myModal_name1 + myModal_name2 + myModal_name3
        }
        $("#factoryName").val(str)
        $('#myModal').modal('hide')
    }


    function save() {
        let location = $("#location").val()
        let method = $('#select option:selected').text()
        if (location == '' || location == undefined) {
            alert('请选择货位信息')
            return
        }
        if (method == '' || method == undefined) {
            alert('请选择入库方式信息')
            return
        }
        if (excelData.length == 0) {
            alert("请上传excel")
            return;
        }
        $.post("${pageContext.request.contextPath}/InOutWarehouse", {
            in_warehouse_id: $("#location").val(),
            type: "1",
            userName: sessionStorage.getItem("userName"),
            ids: JSON.stringify(excelData.map((val) => {
                return val.materialcode
            })),
            method: method,
            isInitInWarehouse: true
        }, function (result) {
            let jsonObject = JSON.parse(result)
            alert(jsonObject.msg);
            if (jsonObject.flag) {
                excelData = []
                pop_pageDate = []
                document.getElementsByClassName("save-btn").disabled = true;
            }
        })
    }

    function downloadFile() {
        $.post("${pageContext.request.contextPath}/DownloadFile", {}, function (result) {
        })
    }

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
        pop_pageDate = []
        reader.onload = function (event) {
            let data = event.target.result;
            let workbook = XLSX.read(data, {type: 'binary'});
            excelData = outputWorkbook3(workbook)
            if (!excelData) {
                return
            }
            $.post("${pageContext.request.contextPath}/GetPreproductByMaterialcode", {
                    materialcodes: JSON.stringify(excelData)
                }, function (result) {
                    result = JSON.parse(result);
                    if (!result.flag) {
                        alert(result.message)
                        return
                    }
                    document.getElementsByClassName("save-btn").disabled = false;
                    excelData = result.data
                    pop_count = Math.ceil(excelData.length / 10);
                    // 重置查询为第一页
                    pop_pageCur = 1;
                    for (let i = 10 * (pop_pageCur - 1); i < 10 * (pop_pageCur) && i < excelData.length; i++) {
                        pop_pageDate.push(excelData[i]);
                    }
                    updateTable();
                    $('#total_d').html(excelData.length + "条，共" + pop_count + "页");
                    $('#li_d1').addClass('active');
                    // 重置总页数
                    pop_pageAll = parseInt(pop_count);
                    for (let i = 1; i < 6; i++) {
                        let k = i % 5;
                        if (i > pop_pageAll) {
                            $('#a_d' + k).text('.');
                        } else {
                            if (k === 0) {
                                $('#a_d' + k).text(5);
                                $('#a_d' + k).attr('onclick', 'jumpToNewPage_d1(5)');
                                continue;
                            } else {
                                $('#a_d' + k).text(i);
                                $('#a_d' + k).attr('onclick', 'jumpToNewPage_d1(' + k + ')');
                            }
                        }
                    }
                }
            )

        }
        reader.readAsBinaryString(file);
    })

    //更新表格
    function updateTable() {
        let str = "";
        for (let i = 0; i < pop_pageDate.length; i++) {
            str += "<tr><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['materialcode'] + "'>" + pop_pageDate[i]['materialcode'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['materialname'] + "'>" + pop_pageDate[i]['materialname'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['standard'] + "'>" + pop_pageDate[i]['standard'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['drawing_no'] + "'>" + pop_pageDate[i]['drawing_no'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['build_type'] + "'>" + pop_pageDate[i]['build_type'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['building_no'] + "'>" + pop_pageDate[i]['building_no'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['floor_no'] + "'>" + pop_pageDate[i]['floor_no'] +
                "</td><td class='tdStyle_body' style='padding: 5px;' title='" + pop_pageDate[i]['fangliang'] + "'>" + pop_pageDate[i]['fangliang'] +
                "</td></tr>";

        }
        $("#detailTableText").html(str);
    }

    function jumpToNewPage_p(newPageCode) {
        pop_pageDate = []
        let newPage = 1;
        if (newPageCode === 1) newPage = 1;
        if (newPageCode === 2) {
            if (pop_pageCur == 1) {
                window.alert("已经在第一页!");
                return
            } else {
                newPage = pop_pageCur - 1;
                for (let i = 10 * (newPage - 1); i < excelData.length && i < 10 * newPage; i++) {
                    pop_pageDate.push(excelData[i]);
                }
            }
        }
        if (newPageCode === 3) {
            if (pop_pageCur == pop_pageAll) {
                window.alert("已经在最后一页!");
                return
            } else {
                newPage = pop_pageCur + 1;
                for (let i = 10 * (newPage - 1); i < excelData.length && i < 10 * newPage; i++) {
                    pop_pageDate.push(excelData[i]);
                }
            }
        }
        if (newPageCode === 3) {
            setFooter_d(3, pop_pageAll, pop_pageCur, newPage);
        }
        if (newPageCode === 2) {
            setFooter_d(2, pop_pageAll, pop_pageCur, newPage);
        }
        updateTable();
        pop_pageCur = newPage;
    }

    function jumpToNewPage_d1(newPage) {
        pop_pageDate = []
        for (let i = 10 * (newPage - 1); i < excelData.length && i < 10 * newPage; i++) {
            pop_pageDate.push(excelData[i]);
        }
        updateTable();
        $('#li_d' + newPage % 5).addClass('active');
        $('#li_d' + pop_pageCur % 5).removeClass('active');
        pop_pageCur = newPage;
    }

    function jumpToNewPage_d2() {
        pop_pageDate = []
        var newPage = $('#jump_to_d').val();
        if (newPage > pop_pageAll) {
            alert("超过最大页数")
            return
        }
        for (let i = 10 * (newPage - 1); i < excelData.length && i < 10 * newPage; i++) {
            pop_pageDate.push(excelData[i]);
        }
        updateTable();
        jump_d2(newPage, pop_pageAll);
        pop_pageCur = newPage;

    }

    function jump_d2(newPage, pageAll) {
        if (newPage <= 5) {
            for (let i = 1; i < 6; i++) {
                let k = i % 5;
                if (i > pageAll) {
                    $('#a_' + k).text('.');
                } else {
                    if (k === 0) {
                        $('#a_' + k).text(5);
                    } else {
                        $('#a_' + k).text(k);
                        $('#a_' + k).attr('onclick', 'jumpToNewPage_d1(' + k + ')');
                    }
                }
            }
            $('#li_d' + pop_pageCur % 5).removeClass('active');
            $('#li_d' + newPage % 5).addClass('active');
        } else {
            let j = Math.floor(newPage / 5);
            let m = j * 5;
            for (let i = 1; i < 6; i++) {
                let k = i % 5;
                if (++m > pageAll) {
                    $('#a_' + k).text('.');
                } else {
                    $('#a_' + k).text(m);
                    $('#a_' + k).attr('onclick', 'jumpToNewPage_d1(' + m + ')');
                }
            }
            $('#li_d' + pop_pageCur % 5).removeClass('active');
            $('#li_d' + newPage % 5).addClass('active');
        }
    }

    function setFooter_d(newPageCode, pageAll, pageCur, newPage) {
        if (newPageCode === 3) {
            if (pageCur % 5 === 0) {
                let j = Math.floor(newPage / 5);
                let m = j * 5;
                for (let i = 1; i < 6; i++) {
                    let k = i % 5;
                    if (++m > pageAll) {
                        $('#a_d' + k).text('.');
                    } else {
                        $('#a_d' + k).text(m);
                        $('#a_d' + k).attr('onclick', 'jumpToNewPage_d1(' + m + ')');
                    }
                }

            }
            $('#li_d' + newPage % 5).addClass('active');
            $('#li_d' + pageCur % 5).removeClass('active');
        } else {
            if (pageCur % 5 === 1) {
                let j = Math.floor(newPage / 5);
                let m
                if (j < 0) {
                    m = 5;    //5*1
                } else {
                    m = j * 5;
                }
                for (let i = 5; i > 0; i--) {
                    let k = i % 5;
                    if (m > pageAll) {
                        $('#a_d' + k).text('');
                        m--;
                    } else {
                        $('#a_d' + k).text(m);
                        $('#a_d' + k).attr('onclick', 'jumpToNewPage_d1(' + m-- + ')');
                    }
                }
            }
            $('#li_d' + newPage % 5).addClass('active');
            $('#li_d' + pageCur % 5).removeClass('active');
        }
    }
</script>
