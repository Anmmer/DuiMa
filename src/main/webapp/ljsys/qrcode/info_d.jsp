<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    // 获取二维码编号
    function getQueryVariable(letiable) {
        let query = window.location.search.substring(1);
        let lets = query.split("&");
        for (let i = 0; i < lets.length; i++) {
            let pair = lets[i].split("=");
            if (pair[0] == letiable) return pair[1];
        }
        return (false);
    }

    function checkAuthority(au) {
        let authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for (let i = 0; i < authority.length; i++) {
            if (authority[i].fa_name == au) flag = true;
        }
        return flag;
    }

    let qrcodeId = getQueryVariable("qrcodeId");
    let qrcodeName = decodeURIComponent(getQueryVariable("qrcodeName"))

    function returnLastPage() {
        window.history.go(-1);
    }
</script>
<!--版面样式-->
<div style="height: 100%;width:100%;background-color:white;">
    <div style="height:100%;width: 100%;">
        <!--控制台-->
        <button class="btn btn-primary" style="position: absolute;left:1%;top:0%;height: 32px"
                onclick="returnLastPage()">返回
        </button>
        <div style="height:100%;width:54%;float: left;margin-left: 5%">
            <div style="height:4%;width:100%;"></div>
            <!--信息展示-->
            <div style="height:10%;width:100%;font-size:17px;font-weight: bolder">
                <span class="pStyle">二维码编号：</span><span class="pStyle" id="qrcodeId"></span><br/>
                <span class="pStyle">二维码名称：</span><span class="pStyle" id="qrcodeName"></span>
            </div>
            <!--控制台-->
            <div class="form-inline" style="height:150px;width:50%;">
                <div class="form-group" style="height: 100%">
                    <label for="text">标题：</label>
                    <input class="form-control" style="width: 50%" id="text" name="text"><br><br>
                    <label for="text">位置：</label>
                    <input class="form-control" style="width: 20%" id="text_x" name="text" placeholder="横坐标">
                    <input class="form-control" style="width: 20%" id="text_y" name="text" placeholder="纵坐标"><br><br>
                    <label for="xsize">画布：</label>
                    <input style="width: 20%" class="form-control" id="xsize" name="xsize" placeholder="宽">
                    <input class="form-control" style="width: 20%" id="ysize" placeholder="高">

                </div>
            </div>
            <div style="position:absolute;left:28%;top:80px;height:20%;width:30%;">
                <select class="panel panel-default" id="valuesFrom" size="4"
                        style="width:30%;height: 150px;overflow: auto;margin-bottom: 0">
                </select>
                <button type="button" class="btn btn-primary btn-sm" style="margin-left: 2%;margin-bottom: 20px"
                        onclick="addContent()">添加
                </button>
                <select class="panel panel-default" class="btn btn-primary btn-sm" id="valuesTo"
                        style="margin-left: 2%;width:30%;height: 150px;margin-bottom: 0;overflow: auto" size="4">
                </select>
                <button type="button" style="margin-left: 2%;margin-bottom: 20px" class="btn btn-primary btn-sm"
                        onclick="delContent()">删除
                </button>
            </div>
            <!--列表台-->
            <div id="qr_code"></div>
            <div style="height:45%;width: 100%;overflow: auto" id="ItemList">

            </div>
            <div style="margin-top: 2%;width: 100%">
                <div class="form-inline" style="width: 100%">
                    <div class="form-group" style="width: 100%">
                        <select id="itemNames" class="form-control" style="width: 20%"></select>
                        <button type="button" class="btn btn-primary" onclick="newItem()">新增</button>
                        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        <button type="button" class="btn btn-primary" onclick="submitQRcode()">提交</button>
                        <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        <button type="button" class="btn btn-primary" onclick="deleteStyle()">删除</button>
                    </div>
                </div>
            </div>
        </div>
        <div style="height:100%;width:2px;background-color:cornflowerblue;float: left"></div>
        <div style="height:100%;width:40.5%;top:0;background-color: rgb(224, 221, 221);float: left">
            <!--startprint-->
            <div id="draw" style="height:600px;width:400px;background-color: white;position:relative;">
            </div>
            <!--startprint-->
        </div>
    </div>
</div>
<script type="text/javascript">
    let Aflag = false
    let fields = {
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
            fieldNames: JSON.stringify(fields),
            pageCur: 1,
            pageMax: 1000
        },
        success: function (res) {
            let jsonobj = JSON.parse(res.data)
            for (let i = 0; i < jsonobj.length; i++) {
                let select1 = $("#valuesFrom")
                let item1 = $("<option value='" + jsonobj[i]['pi_key'] + "'>" + jsonobj[i]['pi_value'] + "</option>")
                select1.append(item1)
                if (!jsonobj[i]['pi_key'].includes('name') || jsonobj[i]['pi_key'] === "planname" || jsonobj[i]['pi_key'] === "materialname") {
                    let select2 = $("#itemNames")
                    let item2 = $("<option value='" + jsonobj[i]['pi_key'] + "'>" + jsonobj[i]['pi_value'] + "</option>")
                    select2.append(item2)
                }

            }
            startpage()
        },
        error: function (message) {
        }
    })
    // 两个Select增加Option
    let itemlist = []                   // 放置编号
    let itemValues = []                 // 放置值
    $("#qrcodeId").text(qrcodeId)
    $("#qrcodeName").text(qrcodeName)
    $("#xsize").val("400")
    $("#ysize").val("600")
    // 新增设置宽高
    $("#xsize").bind("blur", function (event) {
        let elem = event.target
        let newXsize = $("#xsize").val()
        document.getElementById("draw").style.width = newXsize + "px"
    })
    $("#ysize").bind("blur", function (event) {
        let elem = event.target
        let newYsize = $("#ysize").val()
        document.getElementById("draw").style.height = newYsize + "px"
    })
    let cnt = 0;
    let oldxposition = 0;
    let oldyposition = 0;

    // 新增一项,写入其中文属性值以及其绑定的属性值
    function newItem() {
        // 获取新插入值的name和 value
        let itemValue = $("#itemNames option:checked").text()
        let itemName = $("#itemNames option:checked").val()
        let horizontal_offset = $("#horizontal_offset").val()
        //判断是否已经添加
        if (itemValues.find((val) => {
            return val == itemName
        })) {
            alert("该项已经添加")
            return
        }
        let id_b
        if (horizontal_offset !== '0' && horizontal_offset !== void 0) {
            id_b = 'draw_h'
        } else {
            horizontal_offset = '0'
            id_b = 'draw'
        }
        // 在ItemList中新增一项
        let divstr = $("<div style='width:100%;height:50px;float:left;' id='item" + cnt + "'><div>");
        $("#ItemList").append(divstr)
        // 新增item中的元素
        let content = $("<div class='hiddenTDOverFlowContent pStyle' style='width: 18%;display: inline-table;font-size:14px;font-weight: bolder' title='" + itemValue + "' id='content" + cnt + "'>" + itemValue + "，" + "</div>")
        let xspan = $("<label class='pStyle' style='font-size:14px;font-weight: bolder' for='xvalue'" + cnt + ">" + "X坐标：</label>")
        let xvalue = $("<input type='text' style='width: 20%' value='0' id='xvalue" + cnt + "'>")
        xvalue.bind("blur", function (event) {
            // 修改内容则修改draw
            // 获取编号
            let elem = event.target
            let id = elem.id.substring(6, elem.id.length)
            let drawelem = document.getElementById(id_b + id)
            drawelem.style.left = parseInt($("#" + elem.id).val()) + "px"
        })
        let yspan = $("<span class='pStyle' style='margin-left: 5%;font-size:14px;font-weight: bolder'>Y坐标：</span>")
        let yvalue = $("<input type='text' style='width: 20%' value='0' id='yvalue" + cnt + "'>")
        yvalue.bind("blur", function (event) {
            let elem = event.target
            let id = elem.id.substring(6, elem.id.length)
            let drawelem = document.getElementById(id_b + id)
            drawelem.style.top = parseInt($("#" + elem.id).val()) + parseInt(horizontal_offset) + "px"
        })
        let itemButton = $("<button type='button' style='margin-left: 4%' class='btn btn-primary btn-sm' id='button" + cnt + "'>删除</button>")
        // 删除事件
        itemButton.bind("click", function (event) {
            let targetid = event.target.id
            let id = targetid.substring(6, targetid.length)
            // 查找元素
            let idx = -1;
            for (let i = 0; i < itemlist.length; i++) {
                if (itemlist[i] == id) {
                    idx = i;
                    break;
                }
            }
            if (idx != -1) {
                itemlist.splice(idx, 1)
                itemValues.splice(idx, 1)
            }
            // 删除元素
            let fa = document.getElementById("ItemList")
            let child = document.getElementById("item" + id)
            fa.removeChild(child)
            fa = document.getElementById("draw")
            child = document.getElementById(id_b + id)
            fa.removeChild(child)

        })
        $("#item" + cnt).append(content, xspan, xvalue, yspan, yvalue, itemButton)
        // 画布上新增
        let drawItem = $("<span class='pStyle draw'  style='position: absolute;font-size: 10px' draggable='true' id='draw" + cnt + "'></span>").text(itemValue + ":" + "TEST");
        if (horizontal_offset !== '0' && horizontal_offset !== void 0) {
            drawItem.addClass('draw_h')
        }
        $("#draw").append(drawItem);
        let drawElem = document.getElementById("draw" + cnt)
        drawElem.style.left = "0px"
        drawElem.style.top = "0px"
        //另一份新增内容
        if (horizontal_offset !== '0' && horizontal_offset !== void 0) {
            let drawItemh = $("<span class='pStyle draw'  style='position: absolute;font-size: 10px' draggable='true' id='draw_h" + cnt + "'></span>").text(itemValue + ":" + "TEST");
            $("#draw").append(drawItemh);
            let drawElemh = document.getElementById("draw_h" + cnt)
            drawElemh.style.left = "0px"
            drawElemh.style.top = horizontal_offset + "px"
        }
        // 添加事件
        $('#' + id_b + cnt).bind("dragstart", function (event) {
            oldxposition = event.originalEvent.pageX
            oldyposition = event.originalEvent.pageY
            let targetid = event.target.id
        })
        $('#' + id_b + cnt).bind("dragend", function (event) {
            let Xoffset = event.originalEvent.pageX - oldxposition
            let Yoffset = event.originalEvent.pageY - oldyposition
            let elem = event.target
            let xbd = elem.style.left
            let ybd = elem.style.top
            let xtmp = parseInt(xbd.substring(0, xbd.length - 2))
            let ytmp = parseInt(ybd.substring(0, ybd.length - 2))
            xtmp = xtmp + Xoffset
            ytmp = ytmp + Yoffset
            elem.style.top = ytmp + "px"
            elem.style.left = xtmp + "px"
            // 设置控制组内的
            let itemId
            if (horizontal_offset !== '0' && horizontal_offset !== void 0) {
                itemId = elem.id.substring(6, elem.id.length)
            } else {
                itemId = elem.id.substring(4, elem.id.length)
            }
            // 设置输入框
            $("#xvalue" + itemId).val(xtmp)
            $("#yvalue" + itemId).val(ytmp - parseInt(horizontal_offset))
        })

        // 将编号写入itemlist中
        itemlist.push(cnt + "")
        itemValues.push(itemName)
        cnt = cnt + 1;
    }

    function selectOne() {
        $('.draw').css('fontSize', $('#font_style_value').val())
    }

    function addQRcode(qRCode) {
        // 新增QRCode的图片
        // 获取新插入值的name和 value
        // 在ItemList中新增一项
        let horizontal_offset_val = qRCode.horizontal_offset
        let id_b
        if (horizontal_offset_val !== '0' && horizontal_offset_val !== void 0) {
            id_b = 'draw_h'
        } else {
            horizontal_offset_val = '0'
            id_b = 'draw'
        }
        let divstr = $("<div style='width:100%;height:40px;float:left;' id='item" + cnt + "'><div>");
        $("#qr_code").append(divstr)
        $("#qr_code").append($("<div style='height:2px;width:95%;float:left;margin-bottom:10px;background-color: cornflowerblue;'></div>"))
        // 新增item中的元素
        let xspan = $("<div class='hiddenTDOverFlowContent pStyle' style='display: inline-table;font-size:14px;font-weight: bolder'>二维码，</div>")
        let xvalue = $("<label class='pStyle' style='font-size:14px;font-weight: bolder'>X坐标：</label><input type='text' style='width: 6%' value='15' id='xvalue" + cnt + "'>")
        xvalue.bind("blur", function (event) {
            // 修改内容则修改draw
            // 获取编号
            let elem = event.target
            let id = elem.id.substring(6, elem.id.length)
            let drawelem = document.getElementById(id_b + id)
            drawelem.style.left = $("#" + elem.id).val() + "px"
        })
        let yspan = $("<span class='pStyle' style='margin-left: 3%;font-size:14px;font-weight: bolder'></span>").text("Y坐标：")
        let yvalue = $("<input type='text' style='width: 6%' value='35' id='yvalue" + cnt + "'>")
        let horizontal_offset = $("<span class='pStyle' style='margin-left: 3%;font-size:14px;font-weight: bolder'>垂直偏移量：</span>" + "<input type='text' style='width: 7%' value='0' id='horizontal_offset'>")

        yvalue.bind("blur", function (event) {
            let elem = event.target
            let id = elem.id.substring(6, elem.id.length)
            let drawelem = document.getElementById(id_b + id)
            drawelem.style.top = parseInt($("#" + elem.id).val()) + parseInt(horizontal_offset_val) + "px"
        })
        let qr_wh_span = $("<span class='pStyle' style='margin-left: 3%;font-size:14px;font-weight: bolder'></span>").text("宽高：")
        let qr_wh_value = $("<input type='text' style='width: 6%' value='100' id='qr_wh_value" + "'>")
        qr_wh_value.bind("blur", function (event) {
            $('#draw0').html('')
            // new QRCode(document.getElementById("draw0"), {
            jQuery('#draw0').qrcode({
                render: "canvas",
                // text: qRCode.qrcodeContent,
                text: "https://mes.ljzggroup.com/DuiMa/ToView?code=050320105030281&id=4",
                width: $('#qr_wh_value').val(),
                height: $('#qr_wh_value').val(),
                colorDark: "#000000",
                colorLight: "#ffffff",
                // correctLevel: QRCode.CorrectLevel.H,
                src: './img/qr.jpg'
            })
            if (horizontal_offset_val !== '0' && horizontal_offset_val !== void 0) {
                $('#draw_h0').html('')
                // new QRCode(document.getElementById("draw0"), {
                jQuery('#draw_h0').qrcode({
                    render: "canvas",
                    // text: qRCode.qrcodeContent,
                    text: "https://mes.ljzggroup.com/DuiMa/ToView?code=050320105030281&id=4",
                    width: $('#qr_wh_value').val(),
                    height: $('#qr_wh_value').val(),
                    colorDark: "#000000",
                    colorLight: "#ffffff",
                    // correctLevel: QRCode.CorrectLevel.H,
                    src: './img/qr.jpg'
                })
            }
        })
        let font_style_span = $("<span class='pStyle' style='margin-left: 3%;font-size:14px;font-weight: bolder'></span>").text("字体：")
        let font_style_value = $("<select style='width: 7%' value='0' onchange='selectOne()' id='font_style_value" + "'>" +
            "<option value='10px'>10</option>" +
            "<option value='15px'>15</option>" +
            "<option value='20px'>20</option>" +
            "</div>")
        // font_style_value.bind("change", function (event) {
        //     let drawelem = document.getElementsByClassName("draw")
        //     console.log(21)
        //     for (item of drawelem) {
        //         item.style.fontSize = $('#font_style_value').val();
        //     }
        // })
        $("#item" + cnt).append(xspan, xvalue, yspan, yvalue, horizontal_offset, qr_wh_span, qr_wh_value, font_style_span, font_style_value)
        // 画布上新增
        let drawItem = $("<div style='position: absolute;'  draggable='true' id='draw" + cnt + "' ></div>");
        if (qRCode.horizontal_offset !== '0' && qRCode.horizontal_offset !== void 0) {
            drawItem.addClass('draw_h')
        }
        $("#draw").append(drawItem);
        // new QRCode(document.getElementById("draw" + cnt), {
        jQuery('#draw0').qrcode({
            render: "canvas",
            // text: qRCode.qrcodeContent,
            text: "https://mes.ljzggroup.com/DuiMa/ToView?code=050320105030281&id=4",
            width: qRCode.qr_wh_value,
            height: qRCode.qr_wh_value,
            colorDark: "#000000",
            colorLight: "#ffffff",
            // correctLevel: QRCode.CorrectLevel.H,
            src: './img/qr.jpg'
        })
        // 设置二维码位置
        let drawtmp = document.getElementById("draw0")
        drawtmp.style.left = qRCode.xsituation + "px"
        drawtmp.style.top = qRCode.ysituation + "px"
        if (qRCode.horizontal_offset !== '0' && qRCode.horizontal_offset !== void 0) {
            //另一份二维码
            let drawItem_h = $("<div style='position: absolute;'  draggable='true' id='draw_h" + cnt + "' ></div>");
            $("#draw").append(drawItem_h);
            // new QRCode(document.getElementById("draw" + cnt), {
            jQuery('#draw_h0').qrcode({
                render: "canvas",
                // text: qRCode.qrcodeContent,
                text: "https://mes.ljzggroup.com/DuiMa/ToView?code=050320105030281&id=4",
                width: qRCode.qr_wh_value,
                height: qRCode.qr_wh_value,
                colorDark: "#000000",
                colorLight: "#ffffff",
                // correctLevel: QRCode.CorrectLevel.H,
                src: './img/qr.jpg'
            })
            let drawtmp_h = document.getElementById("draw_h0")
            drawtmp_h.style.left = qRCode.xsituation + "px"
            drawtmp_h.style.top = parseInt(qRCode.ysituation) + parseInt(qRCode.horizontal_offset) + "px"
        }

        // let drawElem = document.getElementById("draw" + cnt)
        // drawElem.style.left = "0px"
        // drawElem.style.top = "0px"
        // 二维码添加事件
        $("#" + id_b + cnt).bind("dragstart", function (event) {
            oldxposition = event.originalEvent.pageX
            oldyposition = event.originalEvent.pageY
            let targetid = event.target.id
        })
        $("#" + id_b + cnt).bind("dragend", function (event) {
            let Xoffset = event.originalEvent.pageX - oldxposition
            let Yoffset = event.originalEvent.pageY - oldyposition
            let elem = event.target
            // let elem = document.getElementById(id_b + 0);
            let xbd = elem.style.left
            let ybd = elem.style.top
            let xtmp = parseInt(xbd.substring(0, xbd.length - 2))
            let ytmp = parseInt(ybd.substring(0, ybd.length - 2))
            xtmp = xtmp + Xoffset
            ytmp = ytmp + Yoffset
            elem.style.top = ytmp + "px"
            elem.style.left = xtmp + "px"
            // 设置控制组内的
            let itemId
            if (qRCode.horizontal_offset !== '0' && qRCode.horizontal_offset !== void 0) {
                itemId = elem.id.substring(6, elem.id.length)
            } else {
                itemId = elem.id.substring(4, elem.id.length)
            }
            // 设置输入框
            $("#xvalue" + itemId).val(xtmp)
            $("#yvalue" + itemId).val(ytmp - parseInt(horizontal_offset_val))
        })
        $('.draw').css('fontSize', qRCode.font_style_value)
        let text;
        if (qRCode.text === undefined) {
            text = '标题内容';
            $("#text").val('标题内容')
        } else {
            text = qRCode.text;
            $("#text").val(qRCode.text)
        }
        if (qRCode.textXsituation === undefined) {
            qRCode.textXsituation = '0';
            $("#text_x").val(0)
        } else {
            $("#text_x").val(qRCode.textXsituation)
        }
        if (qRCode.textYsituation === undefined) {
            qRCode.textYsituation = '0';
            $("#text_y").val(0)
        } else {
            $("#text_y").val(qRCode.textYsituation)
        }
        //另一份标题
        if (qRCode.horizontal_offset !== '0' && qRCode.horizontal_offset !== void 0) {
            let drawItemh_ = $("<span class='pStyle' style='position: absolute;font-size: 21px;font-weight: bold' draggable='true' id='draw_text_h'></span>").text(text);
            $("#draw").append(drawItemh_);
            let drawElemh_ = document.getElementById("draw_text_h")
            drawElemh_.style.left = qRCode.textXsituation + "px"
            drawElemh_.style.top = parseInt(qRCode.textYsituation) + parseInt(qRCode.horizontal_offset) + "px"
        }
        //标题
        let drawItem_ = $("<span class='pStyle' style='position: absolute;font-size: 21px;font-weight: bold' draggable='true' id='draw_text'></span>").text(text);
        if (qRCode.horizontal_offset !== '0' && qRCode.horizontal_offset !== void 0) {
            drawItem_.addClass('draw_h')
        }
        $("#draw").append(drawItem_);
        let drawElem_ = document.getElementById("draw_text")
        drawElem_.style.left = qRCode.textXsituation + "px"
        drawElem_.style.top = qRCode.textYsituation + "px"
        // 添加事件
        let h
        if (horizontal_offset_val !== '0' && horizontal_offset_val !== void 0) {
            h = '_h'
        } else {
            h = ''
        }
        $("#draw_text" + h).bind("dragstart", function (event) {
            oldxposition = event.originalEvent.pageX
            oldyposition = event.originalEvent.pageY
            let targetid = event.target.id
        })
        $("#draw_text" + h).bind("dragend", function (event) {
            let Xoffset = event.originalEvent.pageX - oldxposition
            let Yoffset = event.originalEvent.pageY - oldyposition
            // let elem = event.target
            let elem = document.getElementById("draw_text" + h);
            let xbd = elem.style.left
            let ybd = elem.style.top
            let xtmp = parseInt(xbd.substring(0, xbd.length - 2))
            let ytmp = parseInt(ybd.substring(0, ybd.length - 2))
            xtmp = xtmp + Xoffset
            ytmp = ytmp + Yoffset
            elem.style.top = ytmp + "px"
            elem.style.left = xtmp + "px"
            // 设置输入框
            $("#text_x").val(xtmp)
            $("#text_y").val(ytmp - parseInt(horizontal_offset_val))
        })
        document.getElementById("text").addEventListener("blur", () => {
            let text = document.getElementById("text").value;
            document.getElementById("draw_text" + h).innerText = text;
        })


        // 将编号写入itemlist中
        itemlist.push(cnt + "")
        itemValues.push("qrcode")
        cnt = cnt + 1;
    }

    // 面板设置ajax读取,如果qrcode_content有数据则根据数据来，否则直接增加二维码
    function startpage() {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetQRCode",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                qrcodeId: qrcodeId
            },
            success: function (res) {
                if (res == null) {
                    addQRcode({
                        qrcodeContent: 'TEST:TEST',
                        xsituation: '15',
                        ysituation: '35',
                        qr_wh_value: '100',
                        font_style_value: '10',
                        textYsituation: '5',
                        textXsituation: '75',
                        text: '标题内容',
                    })
                } else {
                    // res即最终的qrcodestyle
                    // 构建图画
                    // 设置画布
                    let draw = document.getElementById("draw")
                    draw.style.height = res.ysize + "px"
                    draw.style.width = res.xsize + "px"
                    $("#xsize").val(res.xsize)
                    $("#ysize").val(res.ysize)

                    // 设置二维码内容
                    let valuestmp = document.getElementById("valuesFrom")
                    let valueslen = valuestmp.length
                    let arr = [];
                    let qrcodeContent = '';
                    for (let i = 0; i < res.qRCode.qRCodeContent.length; i++) {
                        for (let j = 0; j < valueslen; j++) {
                            if (valuestmp.options[j].value === res.qRCode.qRCodeContent[i]) {
                                // 值相等
                                let newOption = $("<option></option>").attr("value", valuestmp.options[j].value)
                                newOption.text(valuestmp.options[j].text)
                                $("#valuesTo").append(newOption)
                                arr.push(valuestmp.options[j].value);
                            }
                        }
                        qrcodeContent += res.qRCode.qRCodeContent[i] + ": TEST" + "\n"
                    }
                    // 设置二维码
                    if (res.qRCode.qRCodeContent === null || res.qRCode.qRCodeContent === undefined || res.qRCode.qRCodeContent.length == 0) {
                        qrcodeContent = 'TEST:TEST'
                    }
                    res.qRCode.qrcodeContent = qrcodeContent;
                    addQRcode(res.qRCode);

                    for (item of arr) {
                        $("#valuesFrom option[value = " + item + "]").remove();
                    }
                    // 设置控制面板二维码数值
                    $("#xvalue0").val(res.qRCode.xsituation)
                    $("#yvalue0").val(res.qRCode.ysituation)
                    $("#qr_wh_value").val(res.qRCode.qr_wh_value)
                    if (res.qRCode.horizontal_offset === '')
                        res.qRCode.horizontal_offset = 0
                    $("#horizontal_offset").val(res.qRCode.horizontal_offset)
                    $("#font_style_value").val(res.qRCode.font_style_value)

                    // 设置子项
                    for (let i = 0; i < res.items.length; i++) {
                        let valuestmp = document.getElementById("itemNames")
                        let valueslen = valuestmp.length
                        for (let j = 0; j < valueslen; j++) {
                            if (valuestmp.options[j].value == res.items[i].content) {
                                valuestmp.options[j].selected = true
                                newItem()
                                // 设置新项的位置
                                let cnttmp = cnt - 1
                                let drawtmp = document.getElementById("draw" + cnttmp)
                                drawtmp.style.left = res.items[i].xsituation + "px"
                                drawtmp.style.top = res.items[i].ysituation + "px"
                                if (res.qRCode.horizontal_offset !== '0' && res.qRCode.horizontal_offset !== '') {
                                    let drawtmph = document.getElementById("draw_h" + cnttmp)
                                    drawtmph.style.left = res.items[i].xsituation + "px"
                                    drawtmph.style.top = parseInt(res.items[i].ysituation) + parseInt(res.qRCode.horizontal_offset) + "px"
                                    drawtmph.style.fontSize = res.qRCode.font_style_value
                                }
                                drawtmp.style.fontSize = res.qRCode.font_style_value
                                $("#xvalue" + cnttmp).val(res.items[i].xsituation)
                                $("#yvalue" + cnttmp).val(res.items[i].ysituation)
                            }
                        }
                    }
                    if (res.qRCode.horizontal_offset !== '0' && res.qRCode.horizontal_offset !== '') {
                        set()
                    }
                }
            }
        })
    }

    function set() {
        let bottom = 0
        let width = 0;
        for (let i = 1; i < itemlist.length; i++) {
            let item = document.getElementById("draw" + itemlist[i])
            let offsetHeight = item.offsetHeight
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
            }
        }
        let draw0 = document.getElementById("draw0");
        let draw0_left = parseInt(draw0.style.left.match(/(\d+)px/)[1])
        let draw0_width = draw0.offsetWidth
        let draw0_top = parseInt(draw0.style.top.match(/(\d+)px/)[1])
        let draw0_offsetHeight = draw0.offsetHeight
        if (draw0_top + draw0_offsetHeight > bottom) {
            bottom = draw0_top + draw0_offsetHeight
        }
        let draw_text = document.getElementById("draw_text");
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
        // draw_text.style.width = width - parseInt(draw0.style.left.match(/(\d+)px/)[1]) + "px"
        draw0.style.width = width - parseInt(draw0.style.left.match(/(\d+)px/)[1]) + "px"
        for (let i = 1; i < itemlist.length; i++) {
            let item = document.getElementById("draw" + itemlist[i])
            let item_left = parseInt(item.style.left.match(/(\d+)px/)[1])
            let item_top = parseInt(item.style.top.match(/(\d+)px/)[1])
            let item_height = item.offsetHeight
            let item_void = item_left - draw0_left - draw0_width //标签与二维码之间的空隙
            let item_t_void = item_top - draw_text_top - draw_text_offsetHeight //标签与标题的距离
            if (item_left > draw0_left + draw0_width) {
                item.style.left = width - draw0_width - item.offsetWidth - item_void + "px"
            } else {
                item.style.width = draw0.style.width
            }
            item.style.top = draw_text_top + parseInt(draw_text.style.height.match(/(\d+)px/)[1]) - item_t_void - draw_text_offsetHeight - item_height + "px"
        }
    }

    function submitQRcode() {
        // 点击提交的事件
        let qrcodestyle = {}
        qrcodestyle['xsize'] = $("#xsize").val()
        qrcodestyle['ysize'] = $("#ysize").val()

        let qRCode = {}
        let contentlist = qRCode['qRCodeContent'] = []
        let len = document.getElementById("valuesTo").length
        for (let i = 0; i < len; i++) {
            qRCode['qRCodeContent'].push(document.getElementById("valuesTo").options[i].value)
        }
        qRCode['xsituation'] = $("#xvalue0").val()
        qRCode['ysituation'] = $("#yvalue0").val()
        qRCode['qr_wh_value'] = $("#qr_wh_value").val()
        qRCode['horizontal_offset'] = $("#horizontal_offset").val()
        qRCode['font_style_value'] = $("#font_style_value").val()
        qRCode['textXsituation'] = $("#text_x").val()
        qRCode['textYsituation'] = $("#text_y").val()
        qRCode['text'] = $("#text").val()
        qrcodestyle['qRCode'] = qRCode
        // 设置items
        let items = []
        for (let i = 1; i < itemlist.length; i++) {  // 从1开始
            let item = {}
            let idxtmp = parseInt(itemlist[i])
            item['content'] = itemValues[i]
            item['xsituation'] = $("#xvalue" + idxtmp).val()
            item['ysituation'] = $("#yvalue" + idxtmp).val()
            items.push(item)
        }
        qrcodestyle['items'] = items;
        let qrcodestylestr = JSON.stringify(qrcodestyle)
        $.ajax({
            url: "${pageContext.request.contextPath}/SetQRCode",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                qrcodeId: qrcodeId,
                qrcodestyle: qrcodestylestr
            },
            success: function (res) {
                alert("保存成功！")
                location.reload();
            }
        })

    }

    function print() {
        let bdhtml = window.document.body.innerHTML;
        let sprnstr = "<!--startprint-->";
        let eprnstr = "<!--endprint-->";
        let prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
        prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML = prnhtml;
        window.print()
        window.document.body.innerHTML = bdhtml;
    }

    function addContent() {
        // 添加内容
        let selectedValue = $("#valuesFrom").val();
        if (selectedValue !== null) {
            let selectedContent = $("#valuesFrom option:selected").text();
            let newOption = $("<option></option>").attr("value", selectedValue)
            newOption.text(selectedContent)
            $("#valuesFrom option[value = " + selectedValue + "]").remove();
            $("#valuesTo").append(newOption);
        } else {
            alert("请选择！")
        }
    }

    function delContent() {
        let selectedValue = $("#valuesTo").val();
        if (selectedValue !== null) {
            let selectedContent = $("#valuesTo option:selected").text();
            $("#valuesTo option[value = " + selectedValue + "]").remove();
            let newOption = $("<option></option>").attr("value", selectedValue)
            newOption.text(selectedContent)
            $("#valuesFrom").append(newOption);
        } else {
            alert("请选择！")
        }
    }

    function printLabel() {
        data1 = {
            qrcodeId: 1,
            list: [
                {
                    productId: "product1",
                    projectName: "扬子津改造项目",
                    produceTime: "2021-05-30 12:28:38",
                    storey: "1楼",
                    title: "相城绿建"

                },
                {
                    productId: "product2",
                    projectName: "扬子津改造项目",
                    produceTime: "2021-05-30 13:21:12",
                    storey: "2楼",
                    title: "相城绿建"
                }
            ],
            mymap: {
                productId: "构件号",
                projectName: "项目名",
                produceTime: "生产时间",
                storey: "楼层号",
                title: "公司名"
            },
            turnover: 0,
            userid: 1,
            taskname: "test"
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/PrintLabel",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                data: JSON.stringify(data1)
            },
            success: function (res) {
            },
            error: function (message) {
            }
        })
    }

    function deleteStyle() {

        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/ExecuteSQL",
            type: 'post',
            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            data: {
                sqlStr: "update qrcode set qrcode_status = 0 where qrcode_id = " + qrcodeId + ";",
                id: sessionStorage.getItem("userId"),
                name: sessionStorage.getItem("userName"),
                message: "删除了二维码样式'" + qrcodeName + "'(编号为" + qrcodeId + ")"
            },
            success: function (res) {
                window.alert("删除成功!")
                location.href = "qrcodeQueryAll.jsp"
            },
            error: function (message) {
            }
        });
    }
</script>
<style>
    .hiddenTDOverFlowContent {
        padding-left: 3px;
        padding-right: 3px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        font-size: 16px;
        /*font-family: Simsun;*/
    }

    .draw_h {
        width: fit-content;
        transform: rotate(180deg)
    }
</style>
