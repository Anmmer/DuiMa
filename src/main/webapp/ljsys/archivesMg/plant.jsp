<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%">
    <div style="position:relative;top: 5%;left: 15%;height:15%;width:70%;font-family: Simsun;font-size:16px;">
        <label for="query_plant">工厂名称:</label><input id="query_plant" style="width: 15%;">
        <button style="width: 8%;margin-left: 5%" onclick="getTableData()">查 询</button>

    </div>
    <div style="width: 70%;height:85%;margin: 0 auto">
        <button style="position:absolute;top: 19%;width: 5%" onclick="openAddPop()">新 增</button>
        <h3 style="text-align: center;margin-top: 0;">工厂列表</h3>
        <div style="height: 70%;">
            <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                <tr>
                    <td class='tdStyle_title'>工厂信息</td>
                    <td class='tdStyle_title' style="width: 20%">操作</td>
                </tr>
                <tbody id="archTableText">
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
                <p id="planResultTip"
                   style="margin-top: 0px;font-family: Simsun;font-size: 16px;text-align: center;">
                    1/1</p>
            </div>
            <div style="width:33%;float: left;">
                <button id="next" type="button"
                        style="font-family: Simsun;font-size:16px;float:right;margin-left: 5px"
                        onclick="jumpToNewPage(4,false)">
                    后一页
                </button>
                <button id="pre" type="button" style="font-family: Simsun;font-size:16px;float:right;"
                        onclick="jumpToNewPage(3,false)">
                    前一页
                </button>
            </div>
        </div>
        <div class="pop_up" style="width: 25%;left: 47%;top:23%;height: 25%">
            <div class="pop_title title1">工厂信息新增</div>
            <div class="pop_title title2">工厂信息修改</div>
            <div class="close_btn"><img src="./img/close.png" onclick="closePop()"></div>
            <div style="position: relative;left: 15%;height: 40%;margin: 0 auto">
                <label for="pop_plant">
                    工厂信息:
                </label>
                <input name="pop_plant" id="pop_plant" style="margin-top: 6%;margin-bottom: 5%"><br>
            </div>
            <div class="pop_footer" style="display: flex;align-items: center;justify-content: center;">
                <button id="save" class="saveo save-btn">保存</button>
                <button class="recover-btn">重置</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    if (sessionStorage.getItem("userName") == null) {
        location.href = "login.jsp"
        window.alert("您未登陆，请先登陆！")
    } else {
        var userInfo = document.getElementById("userInfo");
        userInfo.innerHTML = sessionStorage.getItem("userName").toString() + ",您好,欢迎使用相城绿建堆码后台管理系统!<a href='login.jsp'>点击登出</a>";
    }

    let num = 1;        //分页当前页
    let count = 1;      //分页总页数
    let jsonObj = [];   //档案信息

    window.onload = getTableData();

    //打开新增弹窗
    function openAddPop() {
        $(".pop_up").show();
        $(".title1").show();
        $(".title2").hide();
        $("#save").attr('onclick', 'save()');
    }

    //打开修改弹窗
    function openEditPop(id) {
        queryData(id);
        $(".pop_up").show();
        $(".title1").hide();
        $(".title2").show();
        $("#save").attr('onclick', 'edit(' + id + ')');
    }

    //关闭弹窗
    function closePop() {
        $(".pop_up").hide();
        pop_id = 0;
        reset();
    }

    //重置弹窗
    function reset() {
        $('#pop_plant').val('');
    }

    function getTableData() {
        let query_plant = $('#query_plant').val();
        let obj = {
            plant: query_plant,
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlant",
            type: 'post',
            dataType: 'json',
            data: obj,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    jsonObj = res.data;
                    updateTable();
                    setFooter();
                } else {
                    jsonObj = []
                    updateTable();
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

    function updateTable() {
        let str = '';
        for (let i = (num - 1) * 15; i < num * 15 && i < jsonObj.length; i++) {
            str += "<tr><td class='tdStyle_body'>" + jsonObj[i]['plant'] +
                "</td><td class='tdStyle_body'><a href='#' onclick='openEditPop(" + jsonObj[i]['id'] + ")'>修改</a> <a href='#' onclick='delTableData(" + jsonObj[i]['id'] + ")'>删除</a></td></tr>";
        }
        $("#archTableText").html(str);
    }

    function queryData(id) {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlant",
            type: 'post',
            dataType: 'json',
            data: {id: id},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data.length !== 0) {
                    $('#pop_plant').val(res.data[0].plant);
                }
            },
            error: function () {
                alert("查询失败！")
            }
        })
    }

    function delTableData(id) {
        let r = confirm("亲，确认删除！");
        if (r === false) {
            return;
        }
        $.post("${pageContext.request.contextPath}/DeletePlant", {id: id}, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                closePop();
                getTableData();
            }
        });
    }

    function save() {
        let obj = {
            plant: $('#pop_plant').val(),
        }
        if (obj.plant === '') {
            alert("请输入！");
            return;
        }
        $.post("${pageContext.request.contextPath}/AddPlant", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                closePop();
                getTableData();
            }
        })
    }

    function edit(id) {
        let obj = {
            plant: $('#pop_plant').val(),
            id: id
        }
        if (obj.plant === '') {
            alert("请输入！");
            return;
        }
        $.post("${pageContext.request.contextPath}/UpdatePlant", obj, function (result) {
            result = JSON.parse(result);
            alert(result.message);
            if (result.flag) {
                closePop();
                getTableData();
            }
        });
    }

    $('.recover-btn').click(function () {
        reset();
    })

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
        let str = num + '/' + count;
        $('#planResultTip').text(str);
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
</script>