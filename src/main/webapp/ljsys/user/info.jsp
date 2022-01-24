<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    function checkAuthority(au) {
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for (var i = 0; i < authority.length; i++) {
            if (authority[i].fa_name == au) flag = true;
        }
        return flag;
    }

    if (!checkAuthority("查询用户具体信息")) {
        window.alert("您无查询用户具体信息的权限!");
        location.href = "index.jsp"
    }

    function getQueryVariable(variable) {
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            if (pair[0] == variable) return pair[1];
        }
        return (false);
    }

    var userId = getQueryVariable("userId");

    var userName = decodeURIComponent(getQueryVariable("userName"));

    let fieldNamestmp = {
        gp_id: "INT",
        gp_name: "STRING"
    }
    var fieldNamesStr = JSON.stringify(fieldNamestmp);
    var sqlStrtmp = "select gp.gp_id,gp_name from gp,user_gp where gp.gp_id = user_gp.gp_id and user_id=" + userId + ";";
    let json = {
        sqlStr: sqlStrtmp,
        fieldNames: fieldNamesStr,
        pageCur: 1,
        pageMax: 100
    };
    $.ajax({
        url: "${pageContext.request.contextPath}/QuerySQL",
        type: 'post',
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: json,
        success: function (res) {
            var jsonobj = JSON.parse(res.data);
            // 循环取角色分组编号和分组名
            var gpids = jsonobj[0].gp_id
            var gpnames = jsonobj[0].gp_name
            for (var i = 1; i < jsonobj.length; i++) {
                gpids += "," + jsonobj[i].gp_id
                gpnames += "," + jsonobj[i].gp_name
            }
            $("#groupId").text(gpids);
            $("#groupName").text(gpnames);
        },
        error: function (message) {
        }
    });

</script>
<div style="width:70%;height:100%;margin: 0 auto;background-color:white;">
    <div style="width:100%;height:2%;"></div>
    <button style="position: absolute;left: 8%;top: 8%" onclick="returnLastPage()" class="btn btn-primary">返回</button>
    <!--展示用户信息及其群组信息-->
    <div style="width:100%;height:38%;">
        </br>
        </br>
        <!--头像图片-->
        <img style="margin-right: 5%;float: left;" class="img-rounded" src="./pictures/avator.png" alt="头像"/>
        <div style="width:52%;float: left">
            <span>工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</span><span id="userId"
                                                                                  class="pStyle">userId</span></br></br>
            <span>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</span><span id="userName"
                                                                                  class="pStyle">userId</span></br></br>
            <span>角&nbsp;&nbsp;色&nbsp;&nbsp;名：</span><span id="groupName" class="pStyle">userId</span></br></br>
            <span>角色编号：</span><span id="groupId" class="pStyle">userId</span></br></br>
        </div>
        <button style="float: right;" class="btn btn-primary" onclick="gotoModify()" type="button">
            修改个人信息
        </button>
    </div>
    <div style="width:100%;height:3px;background-color: cornflowerblue;"></div>
    <div style="width:100%;height:30px;"></div>
    <!--权限信息-->
    <div class="panel panel-default" style="width:50%;height:50%;float:left;overflow-y:hidden;">
        <div class="panel-heading">拥有功能权限如下:</div>
        <div id="function" class="panel-body" style="height:100%;overflow-y:scroll;">
        </div>
    </div>
    <div class="panel panel-default" style="width:50%;height:50%;float:left;overflow-y:hidden;">
        <div class="panel-heading">拥有工序权限如下:</div>
        <div id="processContent" class="panel-body" style="overflow-y:auto;">
        </div>
    </div>
</div>
<script type="text/javascript">
    $("#userId").text(userId);
    $("#userName").text(userName);

    function gotoModify() {
        window.location.href = "userModify.jsp?userId=" + userId + "&userName=" + userName;
    }

    // 获取权限
    json = {
        userId: userId
    }
    $.ajax({
        url: "${pageContext.request.contextPath}/GetAuthority",
        type: 'post',
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: json,
        success: function (res) {
            var functionList = JSON.parse(res.function);
            var processContentList = JSON.parse(res.processContent);
            var strtmp = "";
            for (var i = 0; i < functionList.length; i++) {
                strtmp += "<p class='pStyle' style='width:90%;height:20px;float:left;'>" + functionList[i].fa_name + "</p>" + "<p style='width:10%;height:20px;float:left;color:red;'>√</p>";
            }
            $("#function").html(strtmp);
            var strtmp = "";
            for (var i = 0; i < processContentList.length; i++) {
                strtmp += "<p class='pStyle' style='width:90%;height:20px;float:left;'>" + processContentList[i].pc_name + "</p>" + "<p style='width:10%;height:20px;float:left;color:red;'>√</p>";
            }
            $("#processContent").html(strtmp);
        },
        error: function (message) {
        }
    });

    function returnLastPage() {
        window.history.go(-1);
    }
</script>
