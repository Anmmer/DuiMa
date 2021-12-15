<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!--查询所有群组-->
<script type="text/javascript">
    var pageCur = 1;
    var pageAll = 1;
    function checkAuthority(au){
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for(var i = 0; i < authority.length; i++){
            if(authority[i].fa_name == au) flag = true;
        }
        return flag;
    }
    if(!checkAuthority("查看货位详情")){
        window.alert("您无查看货位详情的权限")
        window.history.go(-1);
    }
</script>
<div style="height: 95%;width:100%;background-color:white;">
    <div style="width:100%;height:90%;">
        <div style="width:70%;height:220px;margin:0 auto;">
            <div style="width:100%;height:40px;float:left;"></div>
            <p style="padding: 0px;margin:0;width:50%;float: left;" class="pStyle" id="warehouseName">库房名:</p>
            <div style="width:50%;height:180px;float: left;">
                <p style="padding:0px;margin:0;" class="pStyle">库房二维码:</p>
                <div id="QRCode" style="width:150px;height:150px;">
                </div>
            </div>
        </div>
        <!--表格显示-->
        <div style="width:70%;height:90%;margin:0 auto;">
            <!--结果显示提示：一共有多少记录，共几页-->
            <div style="width:100%;height:30px;"></div>
            <p class="pStyle" id="resultTip"></p>
            <div style="width:100%;height:300px;overflow-y: auto;">
                <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="1">
                    <tr>
                        <td class='tdStyle'>入库时间</td>
                        <td class='tdStyle'>入库构件号</td>
                        <td class='tdStyle'>入库操作人</td>
                    </tr>
                    <tbody id="tableText">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- 查询所有群组 -->
    <script type="text/javascript">
        // 获取factoryId
        function getQueryVariable(variable){
            var query = window.location.search.substring(1);
            var vars = query.split("&");
            for(var i=0; i < vars.length; i++) {
                var pair = vars[i].split("=");
                if(pair[0] == variable) return pair[1];
            }
            return(false);
        }
        var warehouseId = getQueryVariable("warehouseId");
        var warehouseName = decodeURIComponent(getQueryVariable("warehouseName"));
        // 放置二维码
        // 读取库房名
        $("#warehouseName").text("库房名:"+warehouseName)
        new QRCode(document.getElementById("QRCode"),{
            text:"货位号:"+warehouseId+"\n货位名:"+warehouseName+"\n",
            width:150,
            height:150,
            colorDark:"#000000",
            colorLight:"#ffffff",
            correctLevel : QRCode.CorrectLevel.H
        })
        function updateTable(newpage) {
            let json = {
                warehouseId:warehouseId
            };
            $.ajax({
                url:"http://8.142.26.93:8989/DuiMa_war_exploded/GetWarehouseInfo",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    // 将结果输出到table
                    console.log(json)
                    console.log(res)
                    var str = "";
                    for( var i = 0; i < res.length; i++) {
                        str +="<tr><td class='tdStyle'>" + res[i]['wiTime'] + 
                            "</td><td class='tdStyle'>" + res[i]['productId'] + 
                            "</td><td class='tdStyle'>" + res[i]['userName'] +
                            "</td>";
                    }
                    $("#tableText").html(str);
                    $("#resultTip").text("库房中共有"+res.length+"个构件!")
                },
                error:function(message){
                    console.log(json)
                    console.log(message)
                }
            });
        }
        updateTable(1);
    </script>
</div>