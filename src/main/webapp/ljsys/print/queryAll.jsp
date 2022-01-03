<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    var pageCur = 1;
    var pageAll = 1;
    var userId = sessionStorage.getItem("userId")
</script>
<div style="height: 95%;width:100%;background-color:white;">
    <div style="width:100%;height:10%;">
        <form name="query" style="font-family: Simsun;font-size:16px;">
            <div style="width:100%;height: 16px;float: left;"></div>
            <div style="width:70%;margin:0 auto;">
                <div style="width:40%;float: left;">
                    <span>任务编号:</span><input type="text" name="ptId" class="FormInputStyle">
                </div>
                <div style="width:40%;float: left;">
                    <span>任务名:</span><input type="text" name="ptName" class="FormInputStyle">
                </div>
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="updateTable(1)">模糊查询</button>
            </div>
        </form>
    </div>
    <div style="width:100%;height:80%;">
        <!--表格显示-->
        <div style="width:70%;height:90%;margin:0 auto;">
            <!--结果显示提示：一共有多少记录，共几页-->
            <p id="resultTip" style="margin-top: 0px;font-family: Simsun;font-size: 16px">请在上方输入框内输入相应信息并点击“模糊查询按钮”</p>
            <form name="jumpPage"  style="font-family: Simsun;font-size:16px;" onsubmit="return false;">
                <span>输入页码进行跳转:</span><input type="text" name="page" class="FormInputStyle">
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage2()">跳转</button>
            </form>
            <div style="width:100%;height:30px;"></div>
            <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                <tr>
                    <td class='tdStyle_title'>任务编号</td>
                    <td class='tdStyle_title'>任务名</td>
                    <td class='tdStyle_title'>任务进展</td>
                    <td class='tdStyle_title'>任务开始时间</td>
                    <td class='tdStyle_title'>下载</td>
                </tr>
                <tbody id="tableText">
                </tbody>
            </table>
            <div style="width:100%;height:30px;"></div>
            <div style="width:33%;float: left;">
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage(1)">第一页</button>
                <button type="button" style="font-family: Simsun;font-size:16px;" onclick="jumpToNewPage(2)">前一页</button>
            </div>
            <div style="width:33%;float: left;">
                <p id="resultTip2" style="margin-top: 0px;font-family: Simsun;font-size: 16px;text-align: center;">1/1</p>
            </div>
            <div style="width:33%;float: left;">
                <button type="button" style="font-family: Simsun;font-size:16px;float:right;" onclick="jumpToNewPage(4)">最后一页</button>
                <button type="button" style="font-family: Simsun;font-size:16px;float:right;" onclick="jumpToNewPage(3)">后一页</button>
            </div>
        </div>
    </div>
    <div style="width:100%;height:10%">
        <form style="margin:auto;">
            <span class="pStyle">选择一个二维码样式:</span>
            <select id="qrcodestyles">
            </select>
            <span class="pStyle">选择是否翻转:</span>
            <select id="isturnover">
                <option value="1">翻转</option>
                <option value="0">不翻转</option>
            </select>
            <span class="pStyle">任务备注名</span>
            <input type="text" id="newtaskname">
            <button type="button" onclick="printLabels()">打印</button>
        </form>
    </div>
    <!-- 查询所有用户 -->
    <script type="text/javascript">
        function updateTable(newpage) {
            let fieldNamestmp = {
                pt_id:"INT",
                pt_name:"STRING",
                pt_time:"STRING",
                pt_status:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var ptId = document.forms["query"]["ptId"].value;
            var ptName = document.forms["query"]["ptName"].value;
            var sqlStrtmp = "select pt_id,pt_name,pt_status,pt_time from printtask where pt_id like '%"+ptId+"%' and pt_name like '%"+ptName+"%' and pt_user_id="+userId+";";
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames:fieldNamesStr,
                pageCur:newpage,
                pageMax:15
            };
            $.ajax({
                url:"http://101.132.73.7:8989/DuiMa_war_exploded/QuerySQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    // 将结果输出到table
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    for( var i = 0; i < jsonobj.length; i++) {
                        str +="<tr><td class='tdStyle_body'>" + jsonobj[i]['pt_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['pt_name'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['pt_status'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['pt_time'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "<a href='/ljsys/pictures/zips/"+jsonobj[i]['pt_id']+".zip' download='"+jsonobj[i]['pt_id']+"'>下载</a>"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    // 提示语
                    var tipStr = "共查询到"+res.cnt+"条记录,结果共有"+res.pageAll+"页!"
                    $("#resultTip").html(tipStr);
                    // 重置查询为第一页
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    var tipStr2 = pageCur+"/"+pageAll;
                    $("#resultTip2").html(tipStr2)
                },
                error:function(message){
                }
            });
        }
        updateTable(1);
        function jumpToNewPage(newpageCode) {
            let fieldNamestmp = {
                pt_id:"INT",
                pt_name:"STRING",
                pt_time:"STRING",
                pt_status:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var ptId = document.forms["query"]["ptId"].value;
            var ptName = document.forms["query"]["ptName"].value;
            var sqlStrtmp = "select pt_id,pt_name,pt_status,pt_time from printtask where pt_id like '%"+ptId+"%' and pt_name like '%"+ptName+"%' and pt_user_id="+userId+";";
            var newpage = 1;
            if(newpageCode == 1) newpage = 1;
            if(newpageCode == 2){
                if(pageCur == 1) {
                    window.alert("已经在第一页!");
                    return
                }
                else{
                    newpage = pageCur-1;
                }
            }
            if(newpageCode == 3){
                if(pageCur == pageAll) {
                    window.alert("已经在最后一页!");
                    return
                }
                else{
                    newpage = pageCur+1;
                }
            }
            if(newpageCode == 4) newpage = pageAll;
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames:fieldNamesStr,
                pageCur:newpage,
                pageMax:15
            };
            $.ajax({
                url:"http://101.132.73.7:8989/DuiMa_war_exploded/QuerySQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    // 将结果输出到table
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    for( var i = 0; i < jsonobj.length; i++) {
                        str +="<tr><td class='tdStyle_body'>" + jsonobj[i]['pt_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['pt_name'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['pt_status'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['pt_time'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "详情"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    // 提示语
                    var tipStr = "共查询到"+res.cnt+"条记录,结果共有"+res.pageAll+"页!"
                    $("#resultTip").html(tipStr);
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    var tipStr2 = pageCur+"/"+pageAll;
                    $("#resultTip2").html(tipStr2)
                },
                error:function(message){
                }
            });
        }
        function jumpToNewPage2() {
            let fieldNamestmp = {
                pt_id:"INT",
                pt_name:"STRING",
                pt_time:"STRING",
                pt_status:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var ptId = document.forms["query"]["ptId"].value;
            var ptName = document.forms["query"]["ptName"].value;
            var sqlStrtmp = "select pt_id,pt_name,pt_status,pt_time from printtask where pt_id like '%"+ptId+"%' and pt_name like '%"+ptName+"%' and pt_user_id="+userId+";";
            var newpageStr = document.forms["jumpPage"]["page"].value;
            var newpage = parseInt(newpageStr)
            if(newpage <= 0 || newpage > pageAll || isNaN(newpage)) {
                window.alert("请输入一个在范围内的正确页码数字!")
                return
            }
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames:fieldNamesStr,
                pageCur:newpage,
                pageMax:15
            };
            $.ajax({
                url:"http://101.132.73.7:8989/DuiMa_war_exploded/QuerySQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    // 将结果输出到table
                    var str = "";
                    var jsonobj = JSON.parse(res.data);
                    for( var i = 0; i < jsonobj.length; i++) {
                        str +="<tr><td class='tdStyle_body'>" + jsonobj[i]['pt_id'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['pt_name'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['pt_status'] +
                            "</td><td class='tdStyle_body'>" + jsonobj[i]['pt_time'] +
                            "</td><td class='tdStyle_body'>";
                        // 查询
                        str += "详情"
                        str += "</td></tr>"
                    }
                    $("#tableText").html(str);
                    // 提示语
                    var tipStr = "共查询到"+res.cnt+"条记录,结果共有"+res.pageAll+"页!"
                    $("#resultTip").html(tipStr);
                    pageCur = newpage;
                    // 重置总页数
                    pageAll = parseInt(res.pageAll);
                    var tipStr2 = pageCur+"/"+pageAll;
                    $("#resultTip2").html(tipStr2)
                },
                error:function(message){
                }
            });
        }
        function downloadZip(taskId){
            $.ajax({
                url:"http://101.132.73.7:8989/DuiMa_war_exploded/DownloadZip",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:{
                    ptId:taskId
                },
                success:function(res){
                },
                error:function(message){
                }
            })
        }
        // 获取所有样式并填充select
        function getAllStyles(){
            let fieldNamestmp = {
                qrcode_id:"INT",
                qrcode_name:"STRING"
            };
            var fieldNamesStr = JSON.stringify(fieldNamestmp);
            var sqlStrtmp = "select qrcode_id,qrcode_name from qrcode where qrcode_status = 1;";
            let json = {
                sqlStr: sqlStrtmp,
                fieldNames:fieldNamesStr,
                pageCur:1,
                pageMax:1000
            };
            $.ajax({
                url:"http://101.132.73.7:8989/DuiMa_war_exploded/QuerySQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    var jsonobj = JSON.parse(res.data);
                    $("#qrcodestyles").empty();
                    for( var i = 0; i < jsonobj.length; i++) {
                        var tmp = $("<option></option>")
                        tmp.val(jsonobj[i]['qrcode_id'])
                        tmp.text(jsonobj[i]['qrcode_id']+"."+jsonobj[i]['qrcode_name'])
                        $("#qrcodestyles").append(tmp)
                    }
                },
                error:function(message){
                }
            });
        }
        getAllStyles();
        function printLabels(){
            data1 = {
                list:[
                    {
                        productId : "product1",
                        projectName : "扬子津改造项目",
                        produceTime : "2021-05-30 12:28:38",
                        storey : "1楼",
                        title : "相城绿建"

                    },
                    {
                        productId : "product2",
                        projectName : "扬子津改造项目",
                        produceTime : "2021-05-30 13:21:12",
                        storey : "2楼",
                        title : "相城绿建"
                    }
                ],
                mymap:{
                    productId : "构件号",
                    projectName : "项目名",
                    produceTime : "生产时间",
                    storey : "楼层号",
                    title : "公司名"
                }
            }
            data1['qrcodeId'] = $("#qrcodestyles option:selected").val()
            data1['turnover'] = parseInt($("#isturnover option:selected").val())
            data1['userid'] = userId
            data1['taskname'] = $("#newtaskname").val()
            $.ajax({
                url:"http://101.132.73.7:8989/DuiMa_war_exploded/PrintLabel",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:{
                    data:JSON.stringify(data1)
                },
                success:function(res){
                },
                error:function(message){
                }
            })
        }
    </script>
</div>
