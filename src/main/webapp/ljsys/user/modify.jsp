<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    function getQueryVariable(variable){
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for(var i=0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            if(pair[0] == variable) return pair[1];
        }
        return(false);
    }
    function checkAuthority(au){
        var authority = JSON.parse(sessionStorage.getItem("authority"))
        flag = false;
        for(var i = 0; i < authority.length; i++){
            if(authority[i].fa_name == au) flag = true;
        }
        return flag;
    }
    if(!checkAuthority("修改用户信息")){
        window.alert("您无修改用户信息的权限")
        location.href = "index.jsp"
    }
    var userId = getQueryVariable("userId");
    var userName = decodeURIComponent(getQueryVariable("userName"));

    // 变量
    var oldgpids = []      // 旧角色群组的id
    var newgpids = []      // 新角色群组的id
</script>
<div style="height: 95%;width:100%;background-color:white;">
    <div style="width:40%;height:100%;margin: 0 auto;">
        <div style="width:100%;height:50px;"></div>
        <!--展示用户信息及其群组信息-->
        <p style="font-size: 16px;font-family: Simsun;font-weight: bolder;">原信息:</p>
        <div style="width:100%;height:220px;float: left;">
            </br>
            <span style="font-size: 16px;font-family: Simsun;font-weight: bolder;">工号:</span><span id="userId" class="pStyle">userId</span></br></br>
            <span style="font-size: 16px;font-family: Simsun;font-weight: bolder;">姓名:</span><span id="userName" class="pStyle">userId</span></br></br>
            <span style="font-size: 16px;font-family: Simsun;font-weight: bolder;">所属群组角色编号:</span><span id="groupId1" class="pStyle">userId</span></br></br>
            <span style="font-size: 16px;font-family: Simsun;font-weight: bolder;">所属群组角色名:</span><span id="groupName1" class="pStyle">userId</span></br></br>
        </div>
        <div style="width:100%;height:3px;background-color: cornflowerblue;float:left;"></div>
        <div style="width:100%;height:30px;float:left"></div>
        <p style="font-size: 16px;font-family: Simsun;font-weight: bolder;">在下方进行修改后点击提交</p>
        <div name="modify">
            <span class="pStyle" style="width:30%;height:30px;float:left;line-height: 30px;">姓名:</span>
            <input type="text" name="name" id="name" style="width:55%;height:27px;float:left;" class="FormInputStyle">
            <div style="width:100%;height:30px;float:left;"></div>
            <span class="pStyle" style="width:30%;height:30px;float:left;line-height: 30px;">角色群组:</span>
            <select id="groupNames" name="groupNames" size="1" style="width:35%;float:left;font-size:16px;font-family:Simsun;">
            </select>
            <button style="float:left" onclick="addGroup()">添加角色</button>
            <div style="width:100%;height:30px;float:left;"></div>
            <div style="width:100%;height:30px;float:left;">修改后所属分组：</div>
            <div id="newGroups" style="width:100%;height:150px;float:left;overflow-y: auto;"></div>
            <div style="width:100%;height:30px;float:left;"></div>
            <input type="button" value="提交修改" style="float:left;font-size:16px;font-family:Simsun;" onclick="modify1()">
        </div>
    </div>
</div>
<script type="text/javascript">
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
            var gpids = jsonobj[0]['gp_id']
            var gpnames = jsonobj[0]['gp_name']
            for(var i = 1; i < jsonobj.length; i++) {
                gpids += "," + jsonobj[i].gp_id
                gpnames += "," + jsonobj[i].gp_name
            }
            $("#groupId1").text(gpids);
            $("#groupName1").text(gpnames);
        },
        error:function(message){
            console.log(json)
            console.log(message)
        }
    });
    $("#userId").text(userId);
    $("#userName").text(userName);
    // 设置SELECT组件
    var groupNames = document.getElementById("groupNames");
    fieldNamestmp = {
        gp_id:"INT",
        gp_name:"STRING"
    };
    fieldNamesStr = JSON.stringify(fieldNamestmp);
    sqlStrtmp = "select gp_id,gp_name from gp where gp_status = 1;";
    json = {
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
            var jsonobj = JSON.parse(res.data);
            console.log(jsonobj)
            for(var i = 0; i < jsonobj.length; i++) {
                groupNames.options.add(new Option(jsonobj[i].gp_name,jsonobj[i]['gp_id']));
            }
        },
        error:function(message){
            console.log(message)
        }
    });
    // 获取已有分组
    filedNamestmp = {
        gp_id : "INT",
        gp_name :"STRING"
    };
    fieldNamesStr = JSON.stringify(fieldNamestmp)
    sqlStrtmp = "select gp.gp_id, gp.gp_name from gp,user_gp where user_gp.gp_id = gp.gp_id and user_id = " +userId + ";";
    $.ajax({
        url:"http://localhost:8989/DuiMa_war_exploded/QuerySQL",
        type:'post',
        dataType:'json',
        contentType:'application/x-www-form-urlencoded;charset=utf-8',
        data:{
            sqlStr:sqlStrtmp,
            fieldNames:fieldNamesStr,
            pageCur:1,
            pageMax:100
        },
        success:function(res){
            var jsonobj = JSON.parse(res.data);
            console.log(console.log)
            // 循环放入div中并放入两个数组中
            var groupdiv = $("#newGroups")
            for(var i = 0; i < jsonobj.length; i++){
                oldgpids.push(jsonobj[i]['gp_id'])
                newgpids.push(jsonobj[i]['gp_id'])
                var newitem = $("<div id='gpname_"+jsonobj[i]['gp_id']+"'>"+jsonobj[i]['gp_name']+"&nbsp&nbsp&nbsp&nbsp<button onclick='removeGroup("+jsonobj[i]['gp_id']+")'>删除</button></ br></div>")
                groupdiv.append(newitem)
            }
        },
        error:function(message){
            console.log(message)
        }
    });
    function modify1(){
        if(!checkAuthority("修改用户信息")){
            window.alert("您无修改用户信息的权限")
            location.href = "index.jsp"
        }
        var newName = $("#name").val();
        var groupId = $("#groupNames").val();
        var sqlStr = ""
        if(newName !="") {
            sqlStr = "update user set user_name='"+newName+"' where user_id="+userId+";";
            json = {
                sqlStr:sqlStr,
                id:sessionStorage.getItem("userId"),
                name:sessionStorage.getItem("userName"),
                message:"修改了用户'"+userName+"'的姓名，新姓名为'"+newName+"'"
            }
            $.ajax({
                url:"http://localhost:8989/DuiMa_war_exploded/ExecuteSQL",
                type:'post',
                dataType:'json',
                contentType:'application/x-www-form-urlencoded;charset=utf-8',
                data:json,
                success:function(res){
                    console.log(res)
                },
                error:function(message){
                    console.log(message)
                }
            });
        }
        // 循环添加分组，比对oldgpids和newgpids，删除应该删除的，新增要新增的
        // 先增后删
        for(var i = 0; i < newgpids.length; i++){
            var flag = true
            for(var j = 0; j < oldgpids.length; j++){
                if(newgpids[i] == oldgpids[j]) flag = false
            }
            if(flag){
                // 需要新增
                $.ajax({
                    url:"http://localhost:8989/DuiMa_war_exploded/AddUserGp",
                    type:'post',
                    dataType:'json',
                    data:{
                        userId:userId,
                        groupId:newgpids[i],
                        id:sessionStorage.getItem("userId"),
                        name:sessionStorage.getItem("userName")
                    },
                    success:function(res){
                        console.log(res)
                    },
                    error:function(message){
                        console.log(message)
                    }
                })
                var start = (new Date()).getTime();
                while((new Date()).getTime() - start < 500){
                    continue;
                }
            }
        }
        // 需要删除
        for(var i = 0; i < oldgpids.length; i++){
            var flag = true
            for(var j = 0; j < newgpids.length; j++){
                if(newgpids[j] == oldgpids[i]) flag = false
            }
            if(flag){
                // 需要删除
                $.ajax({
                    url:"http://localhost:8989/DuiMa_war_exploded/ExecuteSQL",
                    type:'post',
                    dataType:'json',
                    contentType:'application/x-www-form-urlencoded;charset=utf-8',
                    data:{
                        sqlStr:"delete from user_gp where user_id="+userId+" and gp_id ="+oldgpids[i]+";",
                        id:sessionStorage.getItem("userId"),
                        name:sessionStorage.getItem("userName"),
                        message:"从群组(编号为"+oldgpids[i]+")中移除了用户(工号为"+userId+");"
                    },
                    success:function(res){
                        console.log(res)
                    },
                    error:function(message){
                        console.log(message)
                    }
                });
            }
        }
        // update
        //location.reload();
        var start = (new Date()).getTime();
        while((new Date()).getTime() - start < 1000){
            continue;
        }
        window.alert("修改完毕");
        location.reload();
    }
    function removeGroup(gpid){
        // 找到在newgpids中的下标
        var idx = 0;
        for(var i = 0; i < newgpids.length; i++){
            if(newgpids[i] == gpid){
                idx = i
            }
        }
        // 在newgpids中删除
        newgpids.splice(idx,1)
        $("#gpname_"+gpid).remove()
    }
    function addGroup(){
        // 新增select中被选中的值
        var id = $("#groupNames :selected").val()
        var name = $("#groupNames :selected").text()
        var flag = false
        for(var i = 0; i < newgpids.length; i++){
            if(newgpids[i] == id) flag = true;
        }
        if(!flag){
            var groupdiv = $("#newGroups")
            var newitem = $("<div id='gpname_"+id+"'>"+name+"&nbsp&nbsp&nbsp&nbsp<button onclick='removeGroup("+id+")'>删除</button></ br></div>")
            groupdiv.append(newitem)
            newgpids.push(id)
        }
    }

</script>
