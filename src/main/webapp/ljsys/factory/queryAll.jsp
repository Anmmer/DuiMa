<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width:100%;background-color:white;">
    <form name="query" class="form-inline" style="width:70%;height:10%;margin-left: 14%;padding-top:2%">
        <div class="form-group">
            <label>堆场名称：</label><input type="text" name="query_planname" id="query_planname"
                                       style="" class="form-control">
        </div>
        <button type="button" class="btn btn-primary btn-sm" style="margin-left: 5%"
                onclick="getTableData(1)">
            查 询
        </button>
    </form>
    <div style="width:70%;height:80%;margin:0 auto;">
        <div class="page-header" style="margin-top: 0;margin-bottom: 1%">
            <h3 style="margin-bottom: 0;margin-top: 0"><small>堆场信息</small></h3>
            <button type="button" style="position: absolute;right: 15%;top:10%" class="btn btn-primary btn-sm"
                    data-toggle="modal"
                    onclick="getStyle()">
                打印
            </button>
        </div>
        <div style="height: 85%">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <td class='table_tr_print tdStyle_title active' style="width: 2%;"><input
                            id="detail_checkbok"
                            type="checkbox"></td>
                    <td class="tdStyle_title active" style="width: 25%">堆场</td>
                    <td class="tdStyle_title active" style="width: 25%">区域</td>
                    <td class="tdStyle_title active" style="width: 25%">货位</td>
                    <td class="tdStyle_title active" style="width: 25%;text-align: center">操作</td>
                </tr>
                <tbody id="archTableText">
                </tbody>
            </table>
        </div>
    </div>
    <div style="position: absolute;right:5%;top: 17%;">
        <div id="text">展示二维码：</div>
        <div id="qrcode" style="height: 99px;width: 99px;border: 1px solid #5bc0de"></div>
    </div>
    <!--打印主界面-->
    <div id="printArea" style="width:100%;height:100%;display: none">
    </div>
    <div class="gif" style="z-index: 999;">
        <img src="./img/loading.gif"/>
    </div>
</div>
<script type="text/javascript">
    if (sessionStorage.getItem("userName") == null) {
        location.href = "login.jsp"
        window.alert("您未登陆，请先登陆！")
    }

    let count = 1;      //分页总页数
    let jsonObj = [];   //档案信息
    let pageCur = 1;    //分页当前页
    let pageAll = 1;
    let pageMax = 10;   //一页多少条数据
    let planname_old = null;
    let printsData = [] //打印的数据
    // 二维码样式
    let qrstyle = {}
    // 字段映射
    let fieldmap = {}

    window.onload = getTableData(1);

    function getTableData(newPage) {
        getFieldMap();
        let query_planname = $('#query_planname').val();
        let obj = {
            'planname': query_planname,
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetFactory",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    jsonObj = [];
                    for (let o of res.data) {
                        for (let d of o.children) {
                            let obj = {
                                yard: o.name
                            }
                            obj.region = d.name
                            for (let e of d.children) {
                                obj.location = e.name
                                obj.id = e.id
                                jsonObj.push(obj)
                            }
                        }
                    }
                    updateTable();
                } else {
                    jsonObj = []
                    updateTable();
                }
            },
            error: function () {
                jsonObj = [];
                updateTable(false);
                alert("查询失败！")
            }
        })
    }


    function updateTable() {
        let str = '';
        for (let i = 0; i < jsonObj.length; i++) {
            str += "<tr><td class='tdStyle_body' style='padding: 5px;'><input type='checkbox' data-id=" + jsonObj[i]["id"] + "></td>" +
                "<td class='tdStyle_body'>" + jsonObj[i]['yard'] + "</td>" +
                "<td class='tdStyle_body'>" + jsonObj[i]['region'] + "</td>" +
                "<td class='tdStyle_body'>" + jsonObj[i]['location'] + "</td>";
            if (jsonObj[i]['location'] !== '') {
                str += "<td class='tdStyle_body'> <a href='#' onclick=openQrcode('" + jsonObj[i]['id'] + "','" + jsonObj[i]['location'] + "')>展码</a></td></tr>";
            } else {
                str += "<td class='tdStyle_body'></td></tr>";
            }
            // if (jsonObj[i]['yard'] !== '') {
            //     str += "<td class='tdStyle_body'><a href='#' onclick=openEditPop('" + jsonObj[i]['pid'] + "','" + 1 + "','" + jsonObj[i]['id'] + "','" + jsonObj[i]['yard'] + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "')>删除</a></td></tr>";
            // }
            // if (jsonObj[i]['region'] !== '') {
            //     str += "<td class='tdStyle_body'><a href='#' onclick=openEditPop('" + jsonObj[i]['pid'] + "','" + 2 + "','" + jsonObj[i]['id'] + "','" + jsonObj[i]['yard_d'] + "','" + jsonObj[i]['region'] + "')>修改</a> <a href='#' onclick=delTableData('" + jsonObj[i]['id'] + "')>删除</a></td></tr>";
            // }
        }
        $("#archTableText").html(str);
    }

    let det_i = 0;        //两个函数的绑定全选
    //全选
    $("#detail_checkbok").on("click", function () {
        if (det_i == 0) {
            //把所有复选框选中
            $("#archTableText td :checkbox").prop("checked", true);
            det_i = 1;
        } else {
            $("#archTableText td :checkbox").prop("checked", false);
            det_i = 0;
        }

    });

    function openQrcode(id, text) {
        document.getElementById("text").innerText = text + "："
        $("#qrcode").empty()
        //生成二维码
        jQuery('#qrcode').qrcode({
            // new QRCode(document.getElementById("qrcode_" + idx), {
            render: "canvas",
            text: 'https://mes.ljzggroup.com/DuiMaTest/ToView?warehouseId=' + id + '&id=2',
            width: 100,
            height: 100,
            colorDark: "#000000",
            colorLight: "#ffffff",
            src: './img/qr.jpg'
            // correctLevel: QRCode.CorrectLevel.H
        })
    }


    // 获取样式
    function getStyle() {
        let pids = []
        $('#archTableText').find('input:checked').each(function () {
            pids.push({id: $(this).attr('data-id')});   //找到对应checkbox中data-id属性值，然后push给空数组pids
        });
        if (pids.length === 0) {
            alert("请勾选！");
            return;
        }
        pids.forEach((val) => {
            printsData.push(jsonObj.find((item) => {
                return item.id == val.id;
            }));
        });
        // 把样式设定为目前选中的样式
        let qrcodeid = 1
        let fieldNames = {
            qrcode_content: "STRING"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/QuerySQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                sqlStr: "select qrcode_content from qrcode where qrcode_name = '仓库打印模板';",
                fieldNames: JSON.stringify(fieldNames),
                pageCur: 1,
                pageMax: 1000
            },
            success: function (res) {
                let datatmp = JSON.parse(res.data)[0]
                if (datatmp.qrcode_content == undefined) {
                    alert("请设置二维码内容");
                    return
                }
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
            //二维码设置
            let qrCode = {}
            qrCode.qr_wh_value = qrstyle.qRCode.qr_wh_value
            qrCode.qrcodeContent = 'https://mes.ljzggroup.com/DuiMaTest/ToView?warehouseId=' + printsData[i].id + '&id=2'
            // 已判断是否都已获取
            // 先填充内容，后设置位置
            let item_draw = "<div id='draw" + i + "' style='page-break-after:always;position:relative;width:" + xsize + "px;height:" + ysize + "px;'></div>"
            $("#printArea").append($(item_draw))
            $("#printArea").append($("<div class=\"gif\" style=\"z-index: 999;display: flex\">\n" +
                "            <img src=\"./img/loading.gif\"/>\n" +
                "        </div>"))
            // start
            // 放置二维码,后续需要往里面填充内容
            let xsituation = qrstyle.qRCode['xsituation']
            let ysituation = qrstyle.qRCode['ysituation']
            let qr_wh_value = qrstyle.qRCode['qr_wh_value']
            let horizontal_offset = qrstyle.qRCode['horizontal_offset']
            let transform = horizontal_offset !== "0" && horizontal_offset !== "" ? 'transform: rotate(180deg);' : ''
            let item_text = "<span class='pStyle draw' style='position: absolute;font-size: 21px;" + transform + "left:" + qrstyle.qRCode.textXsituation + "px;top: " + qrstyle.qRCode.textYsituation + "px;font-weight: bold' draggable='true' id='draw_text_" + i + "'>" + qrstyle.qRCode['text'] + "</span>";
            $("#draw" + i).append($(item_text))
            let item_qrcode = "<div id='qrcode_" + i + "' style='position: absolute;" + transform + "left:" + xsituation + "px;top:" + ysituation + "px;height:" + qr_wh_value + "px;'></div>"
            $("#draw" + i).append($(item_qrcode))
            // 放置其他各项
            for (let j = 0; j < qrstyle.items.length; j++) {
                let node = qrstyle.items[j]
                let nodevalue = node.content;
                let xsituation_item = node.xsituation
                let ysituation_item = node.ysituation
                let nodestr = fieldmap[nodevalue] + ":" + printsData[i][nodevalue]
                let item = $("<span class='pStyle' id = 'draw_" + i + "_" + (j + 1) + "' style='position: absolute;" + transform + "font-size: " + qrstyle.qRCode.font_style_value + ";left:" + xsituation_item + "px;top:" + ysituation_item + "px;'></span>").text(nodestr)
                $("#draw" + i).append(item)
            }
            //另一份二维码
            if (horizontal_offset !== "0" && horizontal_offset !== "") {
                let other = ''
                let textYsituation = parseInt(qrstyle.qRCode.textYsituation) + parseInt(horizontal_offset)
                let ysituation = parseInt(qrstyle.qRCode.ysituation) + parseInt(horizontal_offset)
                other += "<span class='pStyle draw' style='position: absolute;font-size: 21px;left:" + qrstyle.qRCode.textXsituation + "px;top: " + textYsituation + "px;font-weight: bold' draggable='true' id='draw_text_h'>" + qrstyle.qRCode['text'] + "</span>";
                other += "<div id='qrcode_h" + i + "' style='position: absolute;left:" + xsituation + "px;top:" + ysituation + "px;'></div>"
                // 放置其他各项
                for (let j = 0; j < qrstyle.items.length; j++) {
                    let node = qrstyle.items[j]
                    let nodevalue = node.content;
                    let xsituation_item = node.xsituation
                    let ysituation_item = parseInt(node.ysituation) + parseInt(horizontal_offset)
                    let nodestr = fieldmap[nodevalue] + ":" + printsData[i][nodevalue]
                    other += "<span class='pStyle' style='position: absolute;font-size: " + qrstyle.qRCode.font_style_value + ";left:" + xsituation_item + "px;top:" + ysituation_item + "px;'>" + nodestr + "</span>"
                }
                $("#draw" + i).append($(other))
            }
            // end
            // let newItem = $(item)
            // $("#printArea").append(newItem)
            // 设置二维码内容
            // let qrcodeContent = ""
            // let tmp = qrstyle.qRCode.qRCodeContent
            // for (let j = 0; j < tmp.length; j++) {
            //     qrcodeContent += fieldmap[tmp[j]] + ":" + printsData[i][tmp[j]] + "\n"
            // }

            // getQRCode(i, qrstyle.qRCode)
            QrCode.push({id: i, qRCode: qrCode})
            QrCode.push({id: 'h' + i, qRCode: qrCode})
            qrstyle.qr_wh_value = qr_wh_value
        }
        let enditem = $(endStr)
        $("#printArea").append(enditem)
        printLabels()
    }

    function set(j, length, qr_wh_value) {
        let bottom = 0
        let width = 0;
        let item_offsetWidth
        for (let i = 1; i <= length; i++) {
            let item = document.getElementById("draw_" + j + "_" + i);
            let offsetHeight = item.offsetHeight;
            let offsetWidth = item.offsetWidth
            let left = parseInt(item.style.left.match(/(\d+)px/)[1])
            let top = parseInt(item.style.top.match(/(\d+)px/)[1])
            //获取单个页面最下端
            if (top + offsetHeight > bottom) {
                bottom = top + offsetHeight
            }
            //获取单个页面最右端
            if (offsetWidth + left >= width) {
                width = offsetWidth + left
                item_offsetWidth = offsetWidth
            }
        }
        let draw0 = document.getElementById("qrcode_" + j);
        let draw0_left = parseInt(draw0.style.left.match(/(\d+)px/)[1])
        let draw0_width = parseInt(qr_wh_value)
        let draw0_top = parseInt(draw0.style.top.match(/(\d+)px/)[1])
        let draw0_offsetHeight = parseInt(draw0.style.height.match(/(\d+)px/)[1])
        if (draw0_top + draw0_offsetHeight > bottom) {
            bottom = draw0_top + draw0_offsetHeight
        }
        let draw_text = document.getElementById("draw_text_" + j);
        let draw_text_top = parseInt(draw_text.style.top.match(/(\d+)px/)[1])
        let draw_text_left = parseInt(draw_text.style.left.match(/(\d+)px/)[1])
        let draw_text_offsetHeight = draw_text.offsetHeight
        let draw_text_offsetWidth = draw_text.offsetWidth
        if (draw_text_left + draw_text_offsetWidth > width) {
            width = draw_text_offsetWidth + draw_text_left
        }
        let text_for_draw0_width = parseInt(draw_text.style.left.match(/(\d+)px/)[1]) - draw0_left //标题与二维码里最左边的距离
        //设置标题选择后的位置水平
        draw_text.style.left = width - text_for_draw0_width - draw_text.offsetWidth + "px"
        //设置标题高度用于旋转
        draw_text.style.height = bottom - draw_text_top + (draw0_top - draw_text_top - draw_text_offsetHeight) + draw_text_offsetHeight - 5 + "px"
        draw0.style.width = width - parseInt(draw0.style.left.match(/(\d+)px/)[1]) + "px"
        for (let i = 1; i <= length; i++) {
            let item = document.getElementById("draw_" + j + "_" + i)
            let item_left = parseInt(item.style.left.match(/(\d+)px/)[1])
            let item_top = parseInt(item.style.top.match(/(\d+)px/)[1])
            let item_height = item.offsetHeight
            let item_void = (item_left - draw0_left - draw0_width) //标签与二维码之间的空隙
            let item_t_void = item_top - draw_text_top - draw_text_offsetHeight //标签与标题的距离
            if (item_left > draw0_left + draw0_width) { //如果标签在二维码右侧，则标签向左平移
                item.style.left = width - draw0_width - item.offsetWidth - item_void + "px"
            } else { //否则标签宽度对于二维码宽度，用于选择
                item.style.width = draw0.style.width
            }
            //重新设置到标题的距离
            item.style.top = draw_text_top + parseInt(draw_text.style.height.match(/(\d+)px/)[1]) - item_t_void - draw_text_offsetHeight - item_height + "px"
        }
    }

    let QrCode = []

    //生成二维码
    function getQRCode(idx, qRCode) {
        jQuery('#qrcode_' + idx).qrcode({
            // new QRCode(document.getElementById("qrcode_" + idx), {
            render: "canvas",
            text: qRCode.qrcodeContent,
            width: qRCode.qr_wh_value,
            height: qRCode.qr_wh_value,
            colorDark: "#000000",
            colorLight: "#ffffff",
            src: './img/qr.jpg'
            // correctLevel: QRCode.CorrectLevel.H
        })
    }

    // 打印标签
    function printLabels() {
        let bdhtml = window.document.body.innerHTML;
        let sprnstr = "<!--startprint-->";
        let eprnstr = "<!--endprint-->";
        let prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
        prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML = prnhtml;
        for (let obj of QrCode) {
            getQRCode(obj.id, obj.qRCode)
        }
        if (qrstyle.qRCode['horizontal_offset'] !== '0' && qrstyle.qRCode['horizontal_offset'] !== '') {
            for (let i = 0; i < QrCode.length / 2; i++) {
                set(i, qrstyle.items.length, qrstyle.qr_wh_value)
            }
        }
        setTimeout(() => {
                for (let i = 0; i < printsData.length; i++) {
                    const holder = document.getElementById("draw" + i)
                    var opts = {
                        // dpi: window.devicePixelRatio * 2,
                        dpi: 96,
                        scale: 2.67,
                        logging: true,
                        width: holder.offsetWidth,
                        height: holder.offsetHeight
                    };
                    html2canvas(holder, opts).then(canvas => {
                        let url = canvas.toDataURL("image/jpg");
                        let a = document.createElement('a');
                        a.download = "相城绿建仓库" + printsData[i].id + ".jpg";
                        a.href = url;
                        a.click();
                    });
                }
            }, 500
        )
        setTimeout(() => {
                $(".gif").css("display", "none");
                window.document.body.innerHTML = bdhtml;
                location.reload();
            }, 1000
        )
    }

</script>
