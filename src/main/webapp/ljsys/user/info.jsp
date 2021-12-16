<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    function checkAuthority(au){
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for(var i = 0; i < authority.length; i++){
            if(authority[i].fa_name == au) flag = true;
        }
        return flag;
    }
    if(!checkAuthority("查询用户具体信息")){
        window.alert("您无查询用户具体信息的权限!");
        location.href = "index.jsp"
    }
    function getQueryVariable(variable){
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for(var i=0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            if(pair[0] == variable) return pair[1];
        }
        return(false);
    }
    var userId = getQueryVariable("userId");

    var userName = decodeURIComponent(getQueryVariable("userName"));

    let fieldNamestmp = {
        gp_id:"INT",
        gp_name:"STRING"
    }
    var fieldNamesStr = JSON.stringify(fieldNamestmp);
    var sqlStrtmp = "select gp.gp_id,gp_name from gp,user_gp where gp.gp_id = user_gp.gp_id and user_id="+userId+";";
    let json = {
        sqlStr:sqlStrtmp,
        fieldNames:fieldNamesStr,
        pageCur:1,
        pageMax:100
    };
    $.ajax({
        url:"http://localhost:8989/DuiMa_war_exploded/QuerySQL",
        type:'post',
        dataType:'json',
        contentType:'application/x-www-form-urlencoded;charset=utf-8',
        data:json,
        success:function(res){
            console.log(res)
            var jsonobj = JSON.parse(res.data);
            console.log(jsonobj)
            // 循环取角色分组编号和分组名
            var gpids = jsonobj[0].gp_id
            var gpnames = jsonobj[0].gp_name
            for(var i = 1; i < jsonobj.length; i++) {
                gpids += "," + jsonobj[i].gp_id
                gpnames += "," + jsonobj[i].gp_name
            }
            $("#groupId").text(gpids);
            $("#groupName").text(gpnames);
        },
        error:function(message){
            console.log(json)
            console.log(message)
        }
    });

</script>
<div style="height: 95%;width:100%;background-color:white;">
    <div style="width:70%;height:100%;margin: 0 auto;">
        <div style="width:100%;height:50px;"></div>
        <!--展示用户信息及其群组信息-->
        <div style="width:50%;height:250px;float: left;">
            </br>
            </br>
            <span style="font-size: 20px;font-family: Simsun;font-weight: bolder;">工号:</span><span id="userId" class="pStyle">userId</span></br></br>
            <span style="font-size: 20px;font-family: Simsun;font-weight: bolder;">姓名:</span><span id="userName" class="pStyle">userId</span></br></br>
            <span style="font-size: 20px;font-family: Simsun;font-weight: bolder;">所属群组角色编号:</span><span id="groupId" class="pStyle">userId</span></br></br>
            <span style="font-size: 20px;font-family: Simsun;font-weight: bolder;">所属群组角色名:</span><span id="groupName" class="pStyle">userId</span></br></br>
        </div>
        <!--头像图片-->
        <div style="width:50%;height:250px;float:left;">
            <img src="./pictures/avator.png" alt="头像" style="margin:0 auto;float: right;"/>
        </div>
        <div style="width:100%;height:3px;background-color: cornflowerblue;float:left;"></div>
        <div style="width:100%;height:30px;float:left;"></div>
        <!--权限信息-->
        <div style="width:50%;height:400px;float: left;overflow-y:auto;">
            <p style="font-size: 20px;font-family: Simsun;font-weight: bolder;">拥有功能权限如下:</p>
            <div id="function">
            </div>
        </div>
        <div style="width:50%;height:400px;float:left;overflow-y:auto;">
            <p style="font-size:20px;font-family: Simsun;font-weight: bolder;">拥有工序权限如下:</p>
            <div id="processContent">
            </div>
        </div>
        <div style="width:100%;height:50px;float:left;">
            <button type="button" style="font-family: Simsun;font-size:20px;float:right;">修改个人信息</button>
        </div>
    </div>
</div>
<script type="text/javascript">
    $("#userId").text(userId);
    $("#userName").text(userName);
        // 获取权限
        json = {
        userId:userId
    }
    $.ajax({
        url:"http://localhost:8989/DuiMa_war_exploded/GetAuthority",
        type:'post',
        dataType:'json',
        contentType:'application/x-www-form-urlencoded;charset=utf-8',
        data:json,
        success:function(res){
            console.log(res)
            var functionList = JSON.parse(res.function);
            var processContentList = JSON.parse(res.processContent);
            var strtmp = "";
            for(var i = 0; i < functionList.length; i++) {
                strtmp += "<p style='width:10%;height:20px;float:left;font-size:20px;font-family:Simsun;color:red;'>√</p><p class='pStyle' style='width:90%;height:20px;float:left;'>"+functionList[i].fa_name+"</p>";
            }
            $("#function").html(strtmp);
            var strtmp = "";
            for(var i = 0; i < processContentList.length; i++) {
                strtmp +="<p style='width:10%;height:20px;float:left;font-size:20px;font-family:Simsun;color:red;'>√</p><p class='pStyle' style='width:90%;height:20px;float:left;'>"+processContentList[i].pc_name+"</p>";
            }
            $("#processContent").html(strtmp);
        },
        error:function(message){
            console.log(json)
            console.log(message)
        }
    });
    console.log(userId)
</script>
