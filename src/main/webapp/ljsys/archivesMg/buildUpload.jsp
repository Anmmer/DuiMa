<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%;">
    <form class="form-inline" style="width:70%;margin: 0 auto;height:15%;padding-top:2%">
        <div class="form-group" style="width: 30%">
            <label for="excel-file">文件上传</label>
            <input type="file" id="excel-file"
                   accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel"
                   style="height: 24px;width: 60%;font-size: 12px;margin-bottom: 5px">
        </div>
        <div class="form-group" style="width: 30%">
            <label for="planname" style="margin-left: 1%">项目名称：</label><input id="planname" class="form-control"
                                                                              style="width: 50%;">
        </div>
    </form>
    <div style="width:70%;height: 75%;margin: 0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0" id="inputDetail"><small>导入预览</small></h3>
        </div>
        <table class="table table-hover" style="text-align: center;">
            <tr id="table_tr">
                <td class='tdStyle_title active' style="width: 14%">物料编号</td>
                <td class='tdStyle_title active' style="width: 14%">物料名称</td>
                <td class='tdStyle_title active' style="width: 10%">规格</td>
                <td class='tdStyle_title active' style="width: 10%">图号</td>
                <td class='tdStyle_title active' style="width: 10%">构建类型</td>
                <td class='tdStyle_title active' style="width: 10%">楼栋号</td>
                <td class='table_tr_print tdStyle_title active' style="width: 10%">楼层号</td>
            </tr>
            <tbody id="detailTableText">
            </tbody>
        </table>
    </div>
    <nav aria-label="Page navigation" style="margin-left:40%;width:55%;height:8%;" id="page">
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

</div>
<script>
    let excelData = []
    let pop_pageCur = 1;    //分页当前页
    let pop_pageDate = []
    let pop_pageAll = 1;  //分页总页数

    function save() {
        let planname = $('#planname').val()
        if (planname == '' || planname == undefined) {
            alert('项目名称不能为空')
            return
        }
        if (pop_pageDate.length == 0) {
            alert("请上传excel")
            return;
        }
        $.post("${pageContext.request.contextPath}/AddBuildUpload", {
            str: JSON.stringify(excelData),
            planname: planname,
            user_name: sessionStorage.getItem("userName")
        }, function (result) {
            let jsonObject = JSON.parse(result)
            alert(jsonObject.message);
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
        reader.onload = function (event) {
            let data = event.target.result;
            let workbook = XLSX.read(data, {type: 'binary'});
            excelData = outputWorkbook2(workbook)
            pop_count = Math.ceil(excelData.length / 10);
            // 重置查询为第一页
            pop_pageCur = 1;
            console.log(excelData)
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
