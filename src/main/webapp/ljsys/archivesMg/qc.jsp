<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%">
    <div style="position:relative;top: 5%;left: 15%;height:15%;width:70%;font-family: Simsun;font-size:16px;">
        <label for="query_qc">质检员名称:</label><input id="query_qc" style="width: 15%;">
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
        <div class="pop_up" style="width: 20%;left: 47%;top:23%;height: auto">
            <div class="pop_title title1">质检员信息新增</div>
            <div class="pop_title title2">质检员信息修改</div>
            <div class="close_btn"><img src="./img/close.png" onclick="closePop()"></div>
            <div style="position: relative;left: 15%">
                <label for="qc">
                    质检员信息:
                </label>
                <input name="qc" id="qc" style="margin-top: 5%"><br>
            </div>
            <div class="pop_footer" style="display: flex;align-items: center;justify-content: center;">
                <button id="save" class="saveo save-btn">保存</button>
                <button class="recover-btn">重置</button>
            </div>
        </div>
    </div>
</div>
