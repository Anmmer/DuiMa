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
        <button class="btn btn-primary" style="position: absolute;left:5%;top:5%;height: 32px" onclick="returnLastPage()">返回
        </button>
        <div style="height:100%;width:49%;float: left;margin-left: 10%">
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
        <div style="height:100%;width:2px;background-color:black;float: left"></div>
        <div style="height:100%;width:40.5%;top:0;background-color: rgb(224, 221, 221);float: left">
            <div id="draw" style="height:600px;width:400px;background-color: white;position:relative;"></div>
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
                let select2 = $("#itemNames")
                let item1 = $("<option value='" + jsonobj[i]['pi_key'] + "'>" + jsonobj[i]['pi_value'] + "</option>")
                let item2 = $("<option value='" + jsonobj[i]['pi_key'] + "'>" + jsonobj[i]['pi_value'] + "</option>")
                select1.append(item1)
                select2.append(item2)
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
            let drawelem = document.getElementById("draw" + id)
            drawelem.style.left = $("#" + elem.id).val() + "px"
        })
        let yspan = $("<span class='pStyle' style='margin-left: 5%;font-size:14px;font-weight: bolder'>Y坐标：</span>")
        let yvalue = $("<input type='text' style='width: 20%' value='0' id='yvalue" + cnt + "'>")
        yvalue.bind("blur", function (event) {
            let elem = event.target
            let id = elem.id.substring(6, elem.id.length)
            let drawelem = document.getElementById("draw" + id)
            drawelem.style.top = $("#" + elem.id).val() + "px"
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
            child = document.getElementById("draw" + id)
            fa.removeChild(child)

        })
        $("#item" + cnt).append(content, xspan, xvalue, yspan, yvalue, itemButton)
        // 画布上新增
        let drawItem = $("<span class='pStyle draw' style='position: absolute;font-size: 10px' draggable='true' id='draw" + cnt + "'></span>").text(itemValue + ":" + "TEST");
        $("#draw").append(drawItem);
        let drawElem = document.getElementById("draw" + cnt)
        drawElem.style.left = "0px"
        drawElem.style.top = "0px"
        // 添加事件
        $("#draw" + cnt).bind("dragstart", function (event) {
            oldxposition = event.pageX
            oldyposition = event.pageY
            let targetid = event.target.id
        })
        $("#draw" + cnt).bind("dragend", function (event) {
            let Xoffset = event.pageX - oldxposition
            let Yoffset = event.pageY - oldyposition
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
            let itemId = elem.id.substring(4, elem.id.length)
            // 设置输入框
            $("#xvalue" + itemId).val(xtmp)
            $("#yvalue" + itemId).val(ytmp)
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
        let divstr = $("<div style='width:100%;height:40px;float:left;' id='item" + cnt + "'><div>");
        $("#qr_code").append(divstr)
        $("#qr_code").append($("<div style='height:2px;width:95%;float:left;margin-bottom:10px;background-color: black;'></div>"))
        // 新增item中的元素
        let xspan = $("<div class='hiddenTDOverFlowContent pStyle' style='display: inline-table;font-size:14px;font-weight: bolder'>二维码，</div>")
        let xvalue = $("<label class='pStyle' style='font-size:14px;font-weight: bolder'>X坐标：</label><input type='text' style='width: 10%' value='15' id='xvalue" + cnt + "'>")
        xvalue.bind("blur", function (event) {
            // 修改内容则修改draw
            // 获取编号
            let elem = event.target
            let id = elem.id.substring(6, elem.id.length)
            let drawelem = document.getElementById("draw" + id)
            drawelem.style.left = $("#" + elem.id).val() + "px"
        })
        let yspan = $("<span class='pStyle' style='margin-left: 3%;font-size:14px;font-weight: bolder'></span>").text("Y坐标：")
        let yvalue = $("<input type='text' style='width: 10%' value='35' id='yvalue" + cnt + "'>")
        yvalue.bind("blur", function (event) {
            let elem = event.target
            let id = elem.id.substring(6, elem.id.length)
            let drawelem = document.getElementById("draw" + id)
            drawelem.style.top = $("#" + elem.id).val() + "px"
        })
        let qr_wh_span = $("<span class='pStyle' style='margin-left: 3%;font-size:14px;font-weight: bolder'></span>").text("宽高：")
        let qr_wh_value = $("<input type='text' style='width: 10%' value='100' id='qr_wh_value" + "'>")
        qr_wh_value.bind("blur", function (event) {
            $('#draw0').html('')
            new QRCode(document.getElementById("draw0"), {
                text: qRCode.qrcodeContent,
                width: $('#qr_wh_value').val(),
                height: $('#qr_wh_value').val(),
                colorDark: "#000000",
                colorLight: "#ffffff",
                correctLevel: QRCode.CorrectLevel.H
            })
        })
        let font_style_span = $("<span class='pStyle' style='margin-left: 3%;font-size:14px;font-weight: bolder'></span>").text("字体：")
        let font_style_value = $("<select style='width: 10%' value='0' onchange='selectOne()' id='font_style_value" + "'>" +
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
        $("#item" + cnt).append(xspan, xvalue, yspan, yvalue, qr_wh_span, qr_wh_value, font_style_span, font_style_value)
        // 画布上新增
        let drawItem = $("<div style='position: absolute;'  draggable='true' id='draw" + cnt + "' ></div>");
        $("#draw").append(drawItem);
        new QRCode(document.getElementById("draw" + cnt), {
            text: qRCode.qrcodeContent,
            width: qRCode.qr_wh_value,
            height: qRCode.qr_wh_value,
            colorDark: "#000000",
            colorLight: "#ffffff",
            correctLevel: QRCode.CorrectLevel.H
        })
        let drawElem = document.getElementById("draw" + cnt)
        drawElem.style.left = "0px"
        drawElem.style.top = "0px"
        // 添加事件
        $("#draw" + cnt).bind("dragstart", function (event) {
            oldxposition = event.pageX
            oldyposition = event.pageY
            let targetid = event.target.id
        })
        $("#draw" + cnt).bind("dragend", function (event) {
            let Xoffset = event.pageX - oldxposition
            let Yoffset = event.pageY - oldyposition
            // let elem = event.target
            let elem = document.getElementById("draw0");
            let xbd = elem.style.left
            let ybd = elem.style.top
            let xtmp = parseInt(xbd.substring(0, xbd.length - 2))
            let ytmp = parseInt(ybd.substring(0, ybd.length - 2))
            xtmp = xtmp + Xoffset
            ytmp = ytmp + Yoffset
            elem.style.top = ytmp + "px"
            elem.style.left = xtmp + "px"
            // 设置控制组内的
            let itemId = elem.id.substring(4, elem.id.length)
            // 设置输入框
            $("#xvalue" + itemId).val(xtmp)
            $("#yvalue" + itemId).val(ytmp)
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
        let drawItem_ = $("<span class='pStyle draw' style='position: absolute;font-size: 15px;font-weight: bold' draggable='true' id='draw_text'></span>").text(text);
        $("#draw").append(drawItem_);
        let drawElem_ = document.getElementById("draw_text")
        drawElem_.style.left = qRCode.textXsituation + "px"
        drawElem_.style.top = qRCode.textYsituation + "px"
        // 添加事件
        $("#draw_text").bind("dragstart", function (event) {
            oldxposition = event.pageX
            oldyposition = event.pageY
            let targetid = event.target.id
        })
        $("#draw_text").bind("dragend", function (event) {
            let Xoffset = event.pageX - oldxposition
            let Yoffset = event.pageY - oldyposition
            // let elem = event.target
            let elem = document.getElementById("draw_text");
            let xbd = elem.style.left
            let ybd = elem.style.top
            let xtmp = parseInt(xbd.substring(0, xbd.length - 2))
            let ytmp = parseInt(ybd.substring(0, ybd.length - 2))
            xtmp = xtmp + Xoffset
            ytmp = ytmp + Yoffset
            elem.style.top = ytmp + "px"
            elem.style.left = xtmp + "px"
            // 设置控制组内的
            let itemId = elem.id.substring(4, elem.id.length)
            // 设置输入框
            $("#text_x").val(xtmp)
            $("#text_y").val(ytmp)
        })
        document.getElementById("text").addEventListener("blur", () => {
            let text = document.getElementById("text").value;
            document.getElementById("draw_text").innerText = text;
        })
        // 设置二维码位置
        let drawtmp = document.getElementById("draw0")
        drawtmp.style.left = qRCode.xsituation + "px"
        drawtmp.style.top = qRCode.ysituation + "px"
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
                if (res == null) addQRcode({
                    qrcodeContent: 'TEST:TEST',
                    xsituation: '15',
                    ysituation: '35',
                    qr_wh_value: '100',
                    font_style_value: '10',
                    textYsituation: '5',
                    textXsituation: '75',
                    text: '标题内容',
                });
                else {
                    // res即最终的qrcodestyle
                    // 构建图画
                    // 设置画布
                    let draw = document.getElementById("draw")
                    draw.style.height = res.ysize + "px"
                    draw.style.width = res.xsize + "px"
                    $("#xsize").val(res.xsize)
                    $("#ysize").val(res.ysize)

                    // 设置二维码内容
                    if (res.qRCode.qRCodeContent === null || res.qRCode.qRCodeContent === undefined)
                        return
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
                    res.qRCode.qrcodeContent = qrcodeContent;
                    addQRcode(res.qRCode);

                    for (item of arr) {
                        $("#valuesFrom option[value = " + item + "]").remove();
                    }
                    // 设置控制面板二维码数值
                    $("#xvalue0").val(res.qRCode.xsituation)
                    $("#yvalue0").val(res.qRCode.ysituation)
                    $("#qr_wh_value").val(res.qRCode.qr_wh_value)

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
                                $("#xvalue" + cnttmp).val(res.items[i].xsituation)
                                $("#yvalue" + cnttmp).val(res.items[i].ysituation)
                            }
                        }
                    }
                }
            }
        })
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
            }
        })

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
</style>
